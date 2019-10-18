////////////////////////////////////////////////////////////////////////////////
//
//  Jump to Tournament Center
//  ors_tourney
//  By Don Anderson
//
//  Place this script in the Sign OnUsed Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC      = GetPCSpeaker();

  object oWP = GetObjectByTag("WP_BQT_Tourney");
  location lWP = GetLocation(oWP);

  effect ePerm    = EffectVisualEffect(VFX_IMP_DEATH_L);
  effect eFX1     = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
  effect eFX2     = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eFX3     = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
  effect eFX4     = EffectVisualEffect(VFX_IMP_UNSUMMON);
  effect eFX5     = EffectVisualEffect(VFX_IMP_GOOD_HELP);
  effect eFX6     = EffectVisualEffect(VFX_IMP_EVIL_HELP);

  float fDelay = 1.5;

  //Jump to Tourney Location
  AssignCommand(oPC, ClearAllActions(TRUE));
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
  DelayCommand(fDelay - 0.1, SetCommandable(TRUE, oPC));
  DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lWP)));
  DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
  DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
  DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, ePerm, lWP));
  DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3, lWP));
  DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
  DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1, lWP));
  DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2, lWP));
  DelayCommand(fDelay + 9.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX5, lWP));
  DelayCommand(fDelay + 10.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX6, lWP));
}
