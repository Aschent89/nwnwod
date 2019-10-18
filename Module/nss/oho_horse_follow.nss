////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_horse_follow
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

  HorseSetOwner(oHorse,oPC,TRUE);
}
