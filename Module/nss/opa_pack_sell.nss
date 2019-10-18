////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_pack_sell
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Salesman Convo.
//
//  Thia Sells the Animal to the Merchant.
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  if(GetIsPC(oPC) == FALSE) return;

  object oItem = GetItemPossessedBy(oPC,"AnimalControl");
  int nCost = GetLocalInt(oItem,"OPA_SALEPRICE");

  //Give Gold and Remove the Pack Animal
  GiveGoldToCreature(oPC,nCost);
  object oAnimal = GetLocalObject(oPC,"OPA_OWNER");
  if(GetIsObjectValid(oAnimal)) OPA_DismissPack(oPC, oAnimal);

  //Remove this Animal from PC
  SetLocalInt(oPC,"OPA_ANIMALTOTAL",0);

  //Remove Animal Control
  DestroyObject(oItem);
}
