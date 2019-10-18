////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default4
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnConversation
//  Original script by Bioware
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_ai"

void main()
{
    // * if incapacitated, jump out
    if(GetHasEffect(EFFECT_TYPE_SLEEP)
      || GetHasEffect(EFFECT_TYPE_BLINDNESS)
      || GetHasEffect(EFFECT_TYPE_CONFUSED)
      || GetHasEffect(EFFECT_TYPE_DAZED)
      || GetHasEffect(EFFECT_TYPE_DOMINATED)
      || GetHasEffect(EFFECT_TYPE_FRIGHTENED)
      || GetHasEffect(EFFECT_TYPE_PARALYZE)
      || GetHasEffect(EFFECT_TYPE_PETRIFY)
      || GetHasEffect(EFFECT_TYPE_STUNNED)
      || GetHasEffect(EFFECT_TYPE_TURNED))
      return;

    // * If dead, exit directly.
    if (GetIsDead(OBJECT_SELF) == TRUE) return;

    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();

    //DMFI CODE ADDITIONS BEGIN HERE
    if(GetIsPC(oShouter)) ExecuteScript("dmfi_voice_exe", OBJECT_SELF);

    if(nMatch == -1 && GetIsPC(oShouter) &&(GetLocalInt(GetModule(), "dmfi_AllMute") || GetLocalInt(OBJECT_SELF, "dmfi_Mute")))
    {
      SendMessageToAllDMs(GetName(oShouter) + " is trying to speak to a muted NPC, " + GetName(OBJECT_SELF) + ", in area " + GetName(GetArea(OBJECT_SELF)));
      SendMessageToPC(oShouter, "This NPC is muted. A DM will be here shortly.");
      return;
    }
    //DMFI CODE ADDITIONS END HERE

    if (nMatch == -1)
    {
      // Not a match -- start an ordinary conversation
      if (GetCommandable(OBJECT_SELF))
      {
        ClearActions(CLEAR_NW_C2_DEFAULT4_29);
        if(GetIsPC(oShouter) || GetIsDM(oShouter) || GetIsDMPossessed(oShouter))
        {
          ActionStartConversation(oShouter,"",TRUE,FALSE);
        }
      }
      else
      // * July 31 2004
      // * If only charmed then allow conversation
      // * so you can have a better chance of convincing
      // * people of lowering prices
      if (GetHasEffect(EFFECT_TYPE_CHARMED) == TRUE)
      {
        ClearActions(CLEAR_NW_C2_DEFAULT4_29);
        if(GetIsPC(oShouter) || GetIsDM(oShouter) || GetIsDMPossessed(oShouter))
        {
          ActionStartConversation(oShouter,"",TRUE,FALSE);
        }
      }
    }
    // Respond to shouts from friendly non-PCs only
    else if (GetIsObjectValid(oShouter)
               && !GetIsPC(oShouter)
               && (OAI_GetIsAlly(oShouter) || GetIsFriend(oShouter)))
    {
        object oIntruder = GetLastHostileActor(oShouter);
        object oHostileActor = GetLocalObject(OBJECT_SELF, "OAI_ATTACK_TARGET");

        //
        // Overiding rule:
        //  If we have a valid last target and still locked into atacking it for a number of rounds
        //  we can ignore shouts of I_WAS_ATTACKED and ATTACK_MY_TARGET
        int nCheck = GetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT")
            && GetIsObjectValid(oHostileActor) && !GetIsDead(oHostileActor);

        oHostileActor = oIntruder;  // Default this to Intruder

        // Determine the intruder if any
        switch (nMatch)
        {
            case 1: // I_WAS_ATTACKED
                if (nCheck) return;// Busy fighting someone else
                else if(d4() == 1)
                {
                  ClearAllActions();
                  ActionMoveToObject(oHostileActor,FALSE,1.0);
                  break;
                }
            case 4: // BLOCKER_BLK
              oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
              break;
            case 3: // I_AM_DEAD
              if(GetStatusCondition(OAI_I_CAN_RAISE_DEAD)) SetLocalObject(OBJECT_SELF, "OAI_RAISE_TARGET", oShouter);
              break;
            case 5:
              if (nCheck) return;   // Busy fighting someone else
              if(!GetIsObjectValid(oIntruder) || GetLocalInt(OBJECT_SELF, "OAI_ROUNDCOUNT"))
              {
                oIntruder = GetAttemptedAttackTarget();
                if(!GetIsObjectValid(oIntruder))
                {
                  oIntruder = GetAttemptedSpellTarget();
                  if(!GetIsObjectValid(oIntruder))
                  {
                    oIntruder = OBJECT_INVALID;
                  }
                }
              }
              break;
            case 5000:
              SetLocalInt(OBJECT_SELF,"HEARD_THE_CALL",1);
              FOF_Execute();
              return;
            case 5001:
              nCheck = GetLocalInt(OBJECT_SELF,"RETREATED");
              if (nCheck != 1)
              {
                ClearAllActions();
                OAI_DetermineCombatRound(oIntruder);
                return;
              }
        }

        // dk: 21-Jul-2007
        // Here we must really guard against passing over to RespondToShout in the
        // case of ATTACK_MY_TARGET as this adjusts the entire faction reputation to hatred
        // immediately.
        // Also Guard against RespondToShout often uses GetLastHostileActor which will possibly
        // ignore our oIntruder assignment (in cases I_WAS_ATTACKED, MOB_ATTACK and I_AM_DEAD
        // Therefore:
        //      - if not an enemy LHActor then don't call RespondToshout
        //      - if an enemy oIntruder  and not equal LHActor call DetermineCombatRound

        int bLHActor = OAI_GetIsEnemy(oHostileActor);
        // Some check if we have an intruder
        if(GetIsObjectValid(oIntruder))
        {
          // If we have been asked to handle an Ally then pull out
          if (OAI_GetIsEnemy(oIntruder))
          {
            if (bLHActor)
              RespondToShout(oShouter, nMatch, oIntruder);
            else
              OAI_DetermineCombatRound(oIntruder);
          }
          // I won't attack who you told me, maybe I can help on the LHActor
          else if (bLHActor)
            RespondToShout(oShouter, nMatch, oHostileActor);
        }
        else if (bLHActor)
          RespondToShout(oShouter, nMatch, oHostileActor);
    }

    // Send the user-defined event if appropriate
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
      SignalEvent(OBJECT_SELF, EventUserDefined(1004));
    }
}
