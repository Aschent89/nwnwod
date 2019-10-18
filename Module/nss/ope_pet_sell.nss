////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_pet_sell
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Salesman Convo.
//
//  Thia Sells the Animal to the Merchant.
//
////////////////////////////////////////////////////////////////////////////////

#include "ope_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  if(GetIsPC(oPC) == FALSE) return;

  object oItem = GetItemPossessedBy(oPC,"PetControl");
  int nCost = GetLocalInt(oItem,"OPE_SALEPRICE");

  //Give Gold and Remove the Pack Animal
  GiveGoldToCreature(oPC,nCost);
  object oAnimal = GetLocalObject(oPC,"OPE_OWNER");
  if(GetIsObjectValid(oAnimal)) DismissAnimal(oPC, oAnimal);

  //Remove this Animal from PC
  SetLocalInt(oPC,"OPE_PETTOTAL",0);

  //Remove Animal Control
  DestroyObject(oItem);
}
