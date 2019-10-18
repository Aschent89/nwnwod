////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_horse_hitch
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
//  This Saves the Horse DB For the Player.
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;
  object oMod = GetModule();

  if(GetIsPC(oPC) == FALSE || oPC == OBJECT_INVALID) return;

  //OHO Waypoint Hitching Post Check First.....Good for Outside Caves and Such.
  string sHitchWP = "OHO_HitchingPost";
  object oHitchWP = GetNearestObjectByTag(sHitchWP,oHorse,1);
  if(GetIsObjectValid(oHitchWP))
  {
    HorseHitchHorses(oHitchWP,oPC,GetLocation(oHitchWP));
    return;
  }

  //X3 Hitching Post Placeable
  string sHitchX3 = "x3_plc_hpost";
  object oHitchX3 = GetNearestObjectByTag(sHitchX3,oHorse,1);
  if(GetIsObjectValid(oHitchX3))
  {
    HorseHitchHorses(oHitchX3,oPC,GetLocation(oHitchX3));
    return;
  }
}
