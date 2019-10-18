////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_horse_remove
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the On Death Event.
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oHorse = OBJECT_SELF;

  object oPC = GetLocalObject(oHorse,"OHO_OWNER");
  object oItem = GetItemPossessedBy(oPC,"HorseControl");

  //Remove this Horse from PC
  OHODismissHorse(oPC, oHorse);

  //Remove this Animal from PC
  SetLocalInt(oPC,"OHO_ANIMALTOTAL",0);

  //Remove Animal Control
  DestroyObject(oItem);

  //Tell Player What the Horse Total is
  SendMessageToPC(oPC,"Your Horse Has Died.");
}
