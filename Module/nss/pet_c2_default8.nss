////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default8
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnDisturbed
//  Original Script by Bioware
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_ai"

void main()
{
    object oTarget = GetLastDisturbed();

    // If we've been disturbed and are not already fighting,
    // attack our disturber.
    if (GetIsObjectValid(oTarget) && !GetIsFighting(OBJECT_SELF))
    {
      if(OAI_GetIsAlly(oTarget))
      {
        if (GetIsPC(oTarget)) {
          //SetIsTemporaryEnemy(oTarget, OBJECT_SELF, TRUE, 24.0);
          OAI_DetermineCombatRound(oTarget);
        }
        else
        {
          ClearAllActions(TRUE);
          OAI_DetermineCombatRound();
        }
      } else
       OAI_DetermineCombatRound(oTarget);
    }

    // Send the disturbed flag if appropriate.
    if(GetSpawnInCondition(NW_FLAG_DISTURBED_EVENT))
    {
      SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DISTURBED));
    }
}
