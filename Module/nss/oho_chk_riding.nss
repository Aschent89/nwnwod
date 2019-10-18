////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_chk_riding
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Animal Merchant Convo.
//
//  Checks to see if player is riding when trading/selling the horse
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

int StartingConditional()
{
  object oPC = GetPCSpeaker();

  if(OHOPCRidingHorse(oPC)) return TRUE;
  else return FALSE;
}
