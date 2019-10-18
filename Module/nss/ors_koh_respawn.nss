////////////////////////////////////////////////////////////////////////////////
//  King of the Hill Arena Respawn
//  ors_koh_respawn
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc_koh"

void main()
{
  object oPC  = OBJECT_SELF;
  object oMod = GetModule();

  effect ePerm    = EffectVisualEffect(VFX_IMP_DEATH_L);
  effect eFX1     = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
  effect eFX2     = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eFX3     = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
  effect eFX4     = EffectVisualEffect(VFX_IMP_UNSUMMON);
  effect eFX5     = EffectVisualEffect(VFX_IMP_GOOD_HELP);
  effect eFX6     = EffectVisualEffect(VFX_IMP_EVIL_HELP);

  float fDelay = 1.5;

  //King of Hill Waypoints
  object oBlue = GetObjectByTag("WP_KOHBLUESIDE_HOME");
  location lBlue = GetLocation(oBlue);

  object oRed = GetObjectByTag("WP_KOHREDSIDE_HOME");
  location lRed = GetLocation(oRed);

  //Check Team Info Blue = 1, Red = 2
  int nTeam = KoH_TeamNumber(oPC);

  //Blue Team
  if(nTeam == 1)
  {
    ClearAllActions(TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
    DelayCommand(fDelay - 0.1, SetCommandable(TRUE, oPC));
    DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lBlue)));
    DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
    DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
    DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, ePerm, lBlue));
    DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3, lBlue));
    DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
    DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1, lBlue));
    DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2, lBlue));
    DelayCommand(fDelay + 9.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX5, lBlue));
    DelayCommand(fDelay + 10.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX6, lBlue));
  }

  //Red Team
  if(nTeam == 2)
  {
    ClearAllActions(TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
    DelayCommand(fDelay - 0.1, SetCommandable(TRUE, oPC));
    DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lRed)));
    DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
    DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
    DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, ePerm, lRed));
    DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3, lRed));
    DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
    DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1, lRed));
    DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2, lRed));
    DelayCommand(fDelay + 9.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX5, lRed));
    DelayCommand(fDelay + 10.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX6, lRed));
  }
}
