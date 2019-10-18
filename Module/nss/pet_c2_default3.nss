////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default4
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnCombatRoundEnd
//  Original script by Bioware
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_ai"

void main()
{
  if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) || GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
  {
    OAI_DetermineSpecialBehavior();
  }
  else OAI_DetermineCombatRound();

  if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
  {
    SignalEvent(OBJECT_SELF, EventUserDefined(1003));
  }
}
