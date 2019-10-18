////////////////////////////////////////////////////////////////////////////////
//  Teleport to Tournament Waypoint
//  ors_tel_tourn
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in a Conversation
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  //Turn off Lights
  object oSelf = OBJECT_SELF;
  PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
  DelayCommand(0.4,SetPlaceableIllumination(oSelf, FALSE));
  SetLocalInt(OBJECT_SELF,"NW_L_AMION",0);
  DelayCommand(0.9,RecomputeStaticLighting(GetArea(oSelf)));

  effect eEffect = GetFirstEffect(oSelf);

  while (GetIsEffectValid(eEffect) == TRUE)
  {
    if (GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT) RemoveEffect(oSelf, eEffect);
    eEffect = GetNextEffect(oSelf);
  }

  //Player Stuff
  object oPC = GetPCSpeaker();

  //Tournament Arena
  object oT = GetObjectByTag("WP_TOURNAMENT");

  //Rest Reset
  SetLocalInt(oPC,"REST_MENU",0);
  SetLocalInt(oPC,"REST_ALLOWED", FALSE);

  effect eFX1 = EffectVisualEffect(VFX_IMP_BREACH);
  effect eFX2 = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
  effect eFX3 = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
  effect eFX4 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);

  float fDelay = 1.5;

  //Jump to Tournament
  AssignCommand(oPC, ClearAllActions());
  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX1, oPC));
  DelayCommand(fDelay + 1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX2, oPC));
  AssignCommand(oPC,DelayCommand(fDelay + 2.0,JumpToObject(oT)));
  DelayCommand(fDelay + 3.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
  DelayCommand(fDelay + 4.0, ApplyEffectToObject (DURATION_TYPE_INSTANT, eFX3, oPC));
  DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
  DelayCommand(fDelay + 6.0, ApplyEffectToObject (DURATION_TYPE_INSTANT, eFX4, oPC));
}
