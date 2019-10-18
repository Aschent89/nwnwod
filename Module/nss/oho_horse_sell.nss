////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_horse_sell
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Animal Salesman Convo.
//
//  Thia Sells the Animal to the Merchant.
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  if(GetIsPC(oPC) == FALSE) return;

  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  int nCost = GetLocalInt(oItem,"OHO_SALEPRICE");

  //Give Gold and Remove the Horse
  GiveGoldToCreature(oPC,nCost);
  object oAnimal = GetLocalObject(oPC,"OHO_OWNER");
  if(GetIsObjectValid(oAnimal)) OHODismissHorse(oPC, oAnimal);

  //Remove this Animal from PC
  SetLocalInt(oPC,"OHO_ANIMALTOTAL",0);

  //Remove Animal Control
  DestroyObject(oItem);
}
