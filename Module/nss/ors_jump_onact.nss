////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Jumping/Climbing Rope
//  ors_jump_onact
//  By Don Anderson
//  dandersonru@msn.com
//
//  Allows Jumping and Climbing from a Climbing Rope in an Outdoor Area
//
//  Place this script in the Module On Activate Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"
//#include "oho_inc"

void main()
{
  object oRope = GetItemActivated();
  string sRope = GetTag(oRope);
  if(sRope != "ClimbingRope") return;

  object oPC = GetItemActivator();
  location lPC = GetLocation(oPC);

  int nNoJump = FALSE;

  //Under Not Jumping or Climbing Effects
  effect ePar = GetFirstEffect(oPC);
  while(GetIsEffectValid(ePar))
  {
    if(GetEffectType(ePar) == EFFECT_TYPE_PARALYZE
      || GetEffectType(ePar) == EFFECT_TYPE_CUTSCENE_PARALYZE
      || GetEffectType(ePar) == EFFECT_TYPE_BLINDNESS
      || GetEffectType(ePar) == EFFECT_TYPE_FRIGHTENED
      || GetEffectType(ePar) == EFFECT_TYPE_DAZED
      || GetEffectType(ePar) == EFFECT_TYPE_CONFUSED)
    {
      nNoJump = TRUE;
      break;
    }

    ePar = GetNextEffect(oPC);
  }

  //Riding a Horse
  /*
  if(OHOPCRidingHorse(oPC))
  {
    nNoJump = TRUE;
  }
  */

  //Hostiles Closer than 10 Meters
  if(IsEnemyInRange(oPC, 10.0))
  {
    nNoJump = TRUE;
  }

  object oTarget = GetItemActivatedTarget();
  location lTarget = GetItemActivatedTargetLocation();
  float fFace = GetFacingFromLocation(lTarget);

  //Now Check to See if we are allowed to jump and climb
  int nAllow = GetLocalInt(oPC,"ALLOWJUMP");
  if(nAllow == 0 || nNoJump == TRUE)
  {
    SendMessageToPC(oPC,"You can not Jump or Climb right now.");
    return;
  }

  //Check for Targetted Something
  if(GetIsObjectValid(oTarget) == TRUE)
  {
    SendMessageToPC(oPC,"You must target the ground to jump or climb.");
    return;
  }

  if(nAllow == 1)
  {
    effect eFly = EffectDisappearAppear(lTarget);
    effect eFlyWind = EffectVisualEffect(VFX_IMP_PULSE_WIND);

    //Duration MUST be 3.0 or higher. Higher for busy areas.
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFly, oPC, 4.0);

    //Gust of wind effect for takeoff! Experimental.
    DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFlyWind, lPC));

    //Jump all the Extra Creatures
    JumpAssociates(oPC);
  }
}
