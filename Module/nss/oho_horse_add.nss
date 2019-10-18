////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_horse_add
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Salesman Convo.
//
//  Thia adds the Horse to the Player.
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  if(GetIsPC(oPC) == FALSE || oPC == OBJECT_INVALID) return;

  ///Which Type Was Chosen
  string sWP = GetLocalString(oPC,"OHO_CHOOSE_WP");
  string sHorse = GetLocalString(oPC,"OHO_CHOOSE_TYPE");
  int nCost = GetLocalInt(oPC,"OHO_CHOOSE_PRICE");

  //Take Gold and Create the Horse
  TakeGoldFromCreature(nCost,oPC,TRUE);
  object oSpawn = GetNearestObjectByTag(sWP);
  location lSpawn = GetLocation(oSpawn);
  object oHorse = CreateObject(OBJECT_TYPE_CREATURE,sHorse,lSpawn,FALSE);

  //Now Assign the Horse and make it Persistent
  OHOHighLightObject(oHorse);
  OHOHorseAssign(oPC, oHorse);

  object oItem = GetItemPossessedBy(oPC,"HorseControl");

  //50% Resale Fee
  int nSell = nCost - (nCost/2);
  SetLocalInt(oItem,"OHO_SALEPRICE",nSell);
}
