////////////////////////////////////////////////////////////////////////////////
//
//  King of the Hill Arena Leave
//  ors_koh_jstart
//  By Don Anderson
//
//  Called from a Conversation
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc_koh"

void main()
{
  object oPC = GetPCSpeaker();
  location lStart = GetStartingLocation();

  effect ePerm    = EffectVisualEffect(VFX_IMP_DEATH_L);
  effect eFX1     = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
  effect eFX2     = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eFX3     = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
  effect eFX4     = EffectVisualEffect(VFX_IMP_UNSUMMON);
  effect eFX5     = EffectVisualEffect(VFX_IMP_GOOD_HELP);
  effect eFX6     = EffectVisualEffect(VFX_IMP_EVIL_HELP);

  float fDelay = 1.5;

  //Remove Team Items
  KoH_RemovePCTeam(oPC);

  //Jump to Start Location
  AssignCommand(oPC, ClearAllActions(TRUE));
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
  DelayCommand(fDelay - 0.1, SetCommandable(TRUE, oPC));
  DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lStart)));
  DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
  DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
  DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, ePerm, lStart));
  DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3, lStart));
  DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
  DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1, lStart));
  DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2, lStart));
  DelayCommand(fDelay + 9.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX5, lStart));
  DelayCommand(fDelay + 10.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX6, lStart));
}
