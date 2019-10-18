////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default6
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnDamaged
//  Original Script by Bioware
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_ai"

void main()
{
    object oDamager = GetLastDamager();

    //Trolls
    if(GetBattleCondition(OAI_ROLE_TROLL)) OAI_TrollDamaged();

    //OAI Critical System
    int nDDW = GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);
    if(nDDW > 0)
    {
      //Track Damage Done For Weapon Wear and Breakage
      if(GetIsPC(oDamager))
      {
        //Amount of Damage in One Round Tracked
        int nPDDW = GetLocalInt(oDamager,"WEAPON_DAMAGE_CURRENT");
        int nNDDW = nDDW + nPDDW;
        SetLocalInt(oDamager,"WEAPON_DAMAGE_CURRENT",nNDDW);
      }

      if(OAI_IsRidingHorse(oDamager))
      {
        OAI_Trample(oDamager,OBJECT_SELF);
      }
      else
      {
        OAI_Crits(oDamager,OBJECT_SELF);
      }
    }

    //FIGHT_OR_FLIGHT Addition
    if(GetLocalInt(OBJECT_SELF,"FIGHT_OR_FLIGHT") == 1 && GetLocalInt(OBJECT_SELF,"RETREATED") == 0)
    {
      FOF_Execute();
    }

    //Splitting for All manner of Oozes, Puddings, Jellys, Slimes, and Slithering Trackers
    if(GetBattleCondition(OAI_ROLE_OOZE))
    {
      if(GetDamageDealtByType(DAMAGE_TYPE_SLASHING) > 0
       || GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL) > 0)
      {
        OAI_DoOozeSplit(OBJECT_SELF);
      }
    }

    if(GetIsObjectValid(oDamager) && !GetIsDM(oDamager))
    {
      //Blink Ability
      if(GetBattleCondition(OAI_BLINK_SELF))
      {
        if(Random(100) >= GetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE"))
        {
          OAI_BlinkMove();
        }
      }

      //Illusionary Creatures
      if(GetLocalInt(OBJECT_SELF, "OAI_ILLUSION_DC") > 0)
      {
        if(OAI_BreakIllusion(oDamager)) {}
      }

      if(!GetIsFighting(OBJECT_SELF))
      {
        // If we're not fighting, determine combat round
        if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) || GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
        {
          OAI_DetermineSpecialBehavior(oDamager);
        }
        else
        {
          //We don't see our attacker, go find them
          float fIDist = GetDistanceBetween(OBJECT_SELF,oDamager);
          if(!GetObjectSeen(oDamager) && GetArea(OBJECT_SELF) == GetArea(oDamager) && fIDist > 15.0)
          {
            ActionMoveToObject(oDamager,TRUE,10.0);
            ActionDoCommand(OAI_DetermineCombatRound(oDamager));
          }
          else
          {
            if(OAI_GetIsAlly(oDamager, TRUE))
            {
              if(GetIsPC(oDamager))
              {
                //SetIsTemporaryEnemy(oDamager, OBJECT_SELF, TRUE, 24.0);
                OAI_DetermineCombatRound(oDamager);
              }
              else
              {
                ClearPersonalReputation(oDamager, OBJECT_SELF);
                ClearAllActions(TRUE);
                SetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT",0);
                DelayCommand(1.2, ActionDoCommand(OAI_DetermineCombatRound()));
              }
            }
            else OAI_DetermineCombatRound(oDamager);
          }
        }
      }

      else
      {
        // We are fighting already -- consider switching if we've been
        // attacked by a more powerful enemy
        object oTarget = GetAttackTarget();
        if(!GetIsObjectValid(oTarget)) oTarget = GetAttemptedAttackTarget();
        if(!GetIsObjectValid(oTarget)) oTarget = GetAttemptedSpellTarget();

        // If our target isn't valid
        // or our damager has just dealt us 25% or more
        //    of our hp in damager
        // or our damager is more than 2HD more powerful than our target
        // switch to attack the damager.
        if(!GetIsObjectValid(oTarget)
          || (oTarget != oDamager
          && (GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4)
          || (GetHitDice(oDamager) - 2) > GetHitDice(oTarget))))
        {
          if(OAI_GetIsAlly(oDamager, TRUE))
          {
            if(GetIsPC(oDamager))
            {
              //SetIsTemporaryEnemy(oDamager, OBJECT_SELF, TRUE, 12.0);
              OAI_DetermineCombatRound(oDamager);
            }
            else
            {
              ClearPersonalReputation(oDamager, OBJECT_SELF);
              ClearAllActions(TRUE);
              SetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT",0);
              DelayCommand(1.2, ActionDoCommand(OAI_DetermineCombatRound()));
            }
          }

          // Switch targets
          else
          {
            SetLocalInt(OBJECT_SELF,"OAI_SWITCHLOCK",1);
            OAI_DetermineCombatRound(oDamager);
          }
        }
      }

      SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
      SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
    }

    // Send the user-defined event signal
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DAMAGED));
    }
}
