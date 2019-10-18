////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_pack_add
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Salesman Convo.
//
//  Thia adds the Animal to the Player.
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  if(GetIsPC(oPC) == FALSE || oPC == OBJECT_INVALID) return;

  //Which Type Was Chosen
  string sWP = GetLocalString(oPC,"OPA_CHOOSE_WP");
  string sAnimal = GetLocalString(oPC,"OPA_CHOOSE_TYPE");
  int nCost = GetLocalInt(oPC,"OPA_CHOOSE_PRICE");

  //Take Gold and Create the Pack Animal
  TakeGoldFromCreature(nCost,oPC,TRUE);
  object oSpawn = GetNearestObjectByTag(sWP);
  location lSpawn = GetLocation(oSpawn);
  object oAnimal = CreateObject(OBJECT_TYPE_CREATURE,sAnimal,lSpawn,FALSE);

  //Now Assign the Animal and make it Persistent
  OPAHighLightObject(oAnimal);
  OPA_PackAssign(oPC, oAnimal);

  object oItem = GetItemPossessedBy(oPC,"AnimalControl");

  //50% Resale Fee
  int nSell = nCost - (nCost/2);
  SetLocalInt(oItem,"OPA_SALEPRICE",nSell);
}
