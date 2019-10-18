////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_pet_add
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pet Salesman Convo.
//
//  Thia adds the Pet to the Player.
//
////////////////////////////////////////////////////////////////////////////////

#include "ope_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  if(GetIsPC(oPC) == FALSE || oPC == OBJECT_INVALID) return;

  //Which Type Was Chosen
  string sWP = "PetShop";
  string sAnimal = GetLocalString(oPC,"OPE_CHOOSE_TYPE");
  int nCost = GetLocalInt(oPC,"OPE_CHOOSE_PRICE");

  //Take Gold and Create the Pack Animal
  TakeGoldFromCreature(nCost,oPC,TRUE);
  object oSpawn = GetNearestObjectByTag(sWP);
  location lSpawn = GetLocation(oSpawn);
  object oAnimal = CreateObject(OBJECT_TYPE_CREATURE,sAnimal,lSpawn,FALSE);

  //Now Assign the Animal and make it Persistent
  OPEHighLightObject(oAnimal);
  AnimalAssign(oPC, oAnimal);

  object oItem = GetItemPossessedBy(oPC,"PetControl");

  //50% Resale Fee
  int nSell = nCost/2;
  SetLocalInt(oItem,"OPE_SALEPRICE",nSell);
}
