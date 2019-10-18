////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default5
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnPhysicalAttacked
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_ai"

void main()
{
    object oAttacker = GetLastAttacker();

    //If Commoners and Merchants....Reset Reputations
    object oCommoner = GetObjectByTag("FACTION_1001");
    object oMerchant = GetObjectByTag("FACTION_1002");
    if(GetFactionEqual(OBJECT_SELF,oCommoner) || GetFactionEqual(OBJECT_SELF,oMerchant))
    {
      SetLocalString(OBJECT_SELF,OAI_FACTION,NEUTRAL);
      ClearPersonalReputation(oAttacker, OBJECT_SELF);
      ClearAllActions(TRUE);
    }

    // Ignore this attack if already engaged in combat
    if (GetIsObjectValid(GetAttemptedAttackTarget()) ||
        GetIsObjectValid(GetAttackTarget()) ||
        GetIsObjectValid(GetAttemptedSpellTarget()))
      return;

/******************************************************************************/
//: CUSTOM ATTACKED ADDITONS BELOW HERE


    //Custom Scripts you Need to Execute
    ExecuteScript("oai_cust_atck", OBJECT_SELF);


//: CUSTOM ATTACKED ADDITONS ABOVE HERE
/******************************************************************************/

    if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) || GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
    {
      OAI_DetermineSpecialBehavior(oAttacker);
    }
    else if(GetIsObjectValid(oAttacker)
      && !GetFactionEqual(oAttacker)
      && !GetIsDM(oAttacker))
    {
      if(OAI_GetIsAlly(oAttacker, TRUE))
      {
        if(GetIsPC(oAttacker) && OAI_GetIsNeutral(oAttacker))
        {
          // When PCs attack Neutral, lets have the neutral care for a little while
          //SetIsTemporaryEnemy(oAttacker, OBJECT_SELF, TRUE, 24.0);
        }
        else
        {
          ClearPersonalReputation(oAttacker, OBJECT_SELF);
          ClearAllActions(TRUE);
          SetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT",0);
          DelayCommand(1.2, ActionDoCommand(OAI_DetermineCombatRound()));
        }
      }
      else
      {
        OAI_DetermineCombatRound(oAttacker);

        SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
        SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
      }
    }

    if(GetSpawnInCondition(NW_FLAG_ATTACK_EVENT))
    {
      SignalEvent(OBJECT_SELF, EventUserDefined(1005));
    }
}
