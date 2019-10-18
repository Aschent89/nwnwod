////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default2
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnPerception
//  Original script by Bioware
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_ai"

object NearestAdjoiningDoorTo(object oTarget)
{
    object oArea = GetArea(oTarget);
    object oDoor;
    int nClosest = 1;

    // Target may not have arrived yet
    if (!GetIsObjectValid(oArea))
        return OBJECT_INVALID;

    // Search for nearest adjoining door/trigger
    while (GetIsObjectValid(oDoor = GetNearestObject(OBJECT_TYPE_DOOR|OBJECT_TYPE_TRIGGER, OBJECT_SELF, nClosest))) {
        if (GetArea(GetTransitionTarget(oDoor)) == oArea)
            return oDoor;

        nClosest++;
    }

    return OBJECT_INVALID;
}

// Pursue a area changing enemy
void OAI_Pursue(object oTarget, int nPursueCnt=20)
{
    object oDoor;

    //Is target valid
    if (!GetIsObjectValid(oTarget)) return;

    //Can only do this if no enemy nearby
    if(GetIsObjectValid(oDoor = GetNearestSeenEnemy()))
    {
      if(GetDistanceToObject(oDoor) < 20.0) return;
    }

    //If target area is available then find the correct trigger/door
    if(GetIsObjectValid(oDoor = NearestAdjoiningDoorTo(oTarget)))
    {
      //Get the distance to the door and delay arrival 1 second for every 8m
      DelayCommand(GetDistanceToObject(oDoor) / 8.0, JumpToObject(GetTransitionTarget(oDoor)));
      return;
    }

    //Here we haven't found the target yet, try again later
    if(nPursueCnt > 0) DelayCommand(0.5, OAI_Pursue(oTarget, nPursueCnt - 1));
}

void main()
{
/******************************************************************************/
//: CUSTOM PERCEIVED ADDITONS BELOW HERE
  // dk: 25-May-2006 Skip many things if busy doing something special
  int bBusy = GetAIOff();

  //Custom Scripts you Need to Execute
  ExecuteScript("oai_cust_pcv", OBJECT_SELF);

  //Olander's Pack Animals
  int nPA = GetLocalInt(OBJECT_SELF,"PACKANIMAL");
  if(nPA == 1) return;

  //Olander's Horses
  int nHorse = GetLocalInt(OBJECT_SELF,"HORSE");
  if(nHorse == 1) return;


//: CUSTOM PERCEIVED ADDITONS ABOVE HERE
/******************************************************************************/

    object oPerceived = GetLastPerceived();
    if(!GetIsObjectValid(oPerceived)) return;

    //Don't want to know about opponents that suddenly go silent
    if(GetLastPerceptionInaudible()) return;

    //Get some useful details here once
    object oMyTarget = GetLocalObject(OBJECT_SELF,"OAI_ATTACK_TARGET");
    int bEnemy = OAI_GetIsEnemy(oPerceived);
    location oLoc;

/******************************************************************************/
//: SPECIAL CAN NOT SEE CONDITIONS

    // dk: 29-Dec-2005 Chase my enemy if leaving the map
    // Note: Fleeing creatures should be uncommandable and not need to be considered here
    // Um... what about special effects like sleep, confusion etc
    //
    // My Enemy has vanished go have a look around
    if(bEnemy && GetLastPerceptionVanished())
    {
      //Reset Searching State If Enemies are Near....No Need to Worry
      if(GetIsObjectValid(GetNearestSeenEnemy()))
      {
        DeleteLocalInt(OBJECT_SELF, "OAI_SEARCHING");
        DeleteLocalLocation(OBJECT_SELF, "OAI_SEARCH_LOC");
        ClearAllActions();
        ActionDoCommand(OAI_DetermineCombatRound());
        return;
      }


      //Don't care is not a problem to us
      if((oMyTarget != oPerceived && GetIsObjectValid(oMyTarget) && GetObjectSeen(oMyTarget))
        || (GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE && d4() > 1)) // Omnivores usually give up
        || GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
      {
        return;
      }

      //They have changed areas, then try to follow them
      if(GetArea(oPerceived) != GetArea(OBJECT_SELF))
      {
        ClearAllActions(TRUE);
        OAI_Pursue(oPerceived);
      }

      //Our (living) target vanished, go look in last location and retarget someone
      else if(!GetIsDead(oPerceived))
      {
        ClearAllActions();
        ActionMoveToLocation(oLoc = GetLocation(oPerceived), TRUE);
        ActionDoCommand(OAI_DetermineCombatRound());

        //Denote we are chasing someone for a while (convinces heartbeat to continue chase)
        SetLocalInt(OBJECT_SELF, "OAI_SEARCHING", 20); // search > 10 means run
        SetLocalLocation(OBJECT_SELF, "OAI_SEARCH_LOC", oLoc);
      }
      return;
    }

    //Did I hear someone I can not see (and I am not currently in combat
    if(bEnemy && GetLastPerceptionHeard()
      && !GetObjectSeen(oPerceived)
      && !GetIsInCombat()
      && !IsInConversation(OBJECT_SELF)
      && (GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
           || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
           || GetIsEncounterCreature()))
    {
      // dk: 25-May-2006 Skip if AI is off
      if (bBusy) return;

      //Goto location of noise
      ClearAllActions();
      ActionMoveToLocation(oLoc = GetLocation(oPerceived), FALSE);
      ActionDoCommand(OAI_DetermineCombatRound());

      //Denote we are searching (used in hearbeat, cleared in on perceive enemy)
      SetLocalInt(OBJECT_SELF, "OAI_SEARCHING", 10);  // Serch 10 or less means walk there
      SetLocalLocation(OBJECT_SELF, "OAI_SEARCH_LOC", oLoc);

      //Some nice semi-random sounds
      switch (d4())
      {
        case 1:  ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LOOKHERE)); break;
        case 2:  ActionDoCommand(PlayVoiceChat(VOICE_CHAT_ENEMIES)); break;
        default: ActionDoCommand(PlayVoiceChat(VOICE_CHAT_SEARCH));
      }

      return;
    }

    //If I can not see anything here we have no more to consider
    //We could just be here de to a noise stopping
    if(!GetLastPerceptionSeen()) return;

/******************************************************************************/
//: CAN SEE PERCEIVED CONDITIONS


    // What do we do if we see dead people
    //
    // We will either ignore it OR
    // stopwhat we are doing and add a whole bunch of actions to go look and recontinue walking
    // waypoints (if we have them). This relys on any serious combat things will clear all these
    // actions and react properly. Also we go into SEARCH mode to ignore other carcasses and stuff.
    if (GetIsDead(oPerceived))
    {
      //Ignore if in combat of any kind
      // dk: 25-May-2006 or AI is off
      if(GetIsInCombat()
        || oMyTarget != OBJECT_INVALID
        || GetIsObjectValid(GetNearestSeenEnemy())
        || bBusy)
      {
        return;
      }

      //We have noticed a carcass, how often do we ignore it?
      if(GetLocalInt(OBJECT_SELF, "OAI_SEARCHING")  // Already searching for something
        || (!bEnemy && d4() != 1)   // Friendly carcass, ignore 3 in 4 chance
        || (bEnemy && d3() == 1))    // Enemy carcass, ignore 1 in 3 chance
      {
        return;
      }

      // Am I a species that cares not about carcasses
      // Later might allow Carnivores to eat carcasses
      switch (GetRacialType(OBJECT_SELF)) {
        case RACIAL_TYPE_ABERRATION:
        case RACIAL_TYPE_ANIMAL:
        case RACIAL_TYPE_BEAST:
        case RACIAL_TYPE_CONSTRUCT:
        case RACIAL_TYPE_INVALID:
        case RACIAL_TYPE_OOZE:
          return;
      }

      //Otherwise stop what we are doing and go have a look
      ClearAllActions();
      ActionMoveToLocation(oLoc = GetLocation(oPerceived));
      SetLocalInt(OBJECT_SELF, "OAI_SEARCHING", 6);  // Search 10 or less means walk there
      SetLocalLocation(OBJECT_SELF, "OAI_SEARCH_LOC", GetLocation(oPerceived));
      return;
    }

    // dk: 11-Feb-2006 Big don't care group when I am in conversation at the moment
    if ((IsInConversation(OBJECT_SELF) || GetLocalInt(OBJECT_SELF, "NrSpeakings")) && !bEnemy)
    {
        if (GetLocalInt(GetModule(), "DEBUG")) SpeakString("Ignoring perception event as am busy talking!");
        return;
    }

    //This is the equivalent of a force conversation bubble, should only be used if you want an NPC
    //to say something while he is already engaged in combat.
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION) && GetIsPC(oPerceived))
    {
      SpeakOneLinerConversation();
    }

    //Linked up to the special conversation check to initiate a special one-off conversation
    //to get the PCs attention
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION) && GetIsPC(oPerceived))
    {
      if (!bBusy)
        ActionStartConversation(OBJECT_SELF);
    }

    if(bEnemy)
    {
      if(GetLocalInt(oPerceived, "OAI_ILLUSION_DC") > 0)
      {
        if(OAI_BreakIllusion(oPerceived)) {}
      }
    }

    //If I am not involved in fighting right now
    if(!GetIsInCombat(OBJECT_SELF))
    {
      if(bEnemy)
      {
        if(!GetHasEffect(EFFECT_TYPE_SLEEP)
          && !GetHasEffect(EFFECT_TYPE_BLINDNESS)
          && !GetHasEffect(EFFECT_TYPE_CONFUSED)
          && !GetHasEffect(EFFECT_TYPE_DAZED)
          && !GetHasEffect(EFFECT_TYPE_DOMINATED)
          && !GetHasEffect(EFFECT_TYPE_FRIGHTENED)
          && !GetHasEffect(EFFECT_TYPE_PARALYZE)
          && !GetHasEffect(EFFECT_TYPE_PETRIFY)
          && !GetHasEffect(EFFECT_TYPE_STUNNED)
          && !GetHasEffect(EFFECT_TYPE_TURNED))
        {
          if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) || GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
          {
            OAI_DetermineSpecialBehavior();
          }
          else
          {
            SetFacingPoint(GetPosition(oPerceived));
            SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
            OAI_DetermineCombatRound();
          }
        }
      }
      else
      {
        if (bBusy) return;
        if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) || GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
        {
          OAI_DetermineSpecialBehavior();
        }
        else if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION) && GetIsPC(oPerceived))
        {
          ActionStartConversation(OBJECT_SELF);
        }

        //Activate ambient animations or walk waypoints if appropriate
        if(!IsInConversation(OBJECT_SELF))
        {
          if(GetIsPostOrWalking())
          {
            WalkWayPoints();
          }
          else if(GetIsPC(oPerceived) && (GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
            || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
            || GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS)
            || GetIsEncounterCreature()))
          {
            SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);
          }
        }
      }
    }

    if(!bBusy && GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT))
    {
      SignalEvent(OBJECT_SELF, EventUserDefined(1002));
    }
}
