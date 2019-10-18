////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_chk_buyp8
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pet Salesman Convo.
//
//  Checks for Enough Gold.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  string sPrice = "PRICE8";
  string sWP = "PetShop";

  //Price
  int nPrice = GetLocalInt(oNPC,sPrice);

  //Get the Shop Waypoint
  object oWP = GetNearestObjectByTag(sWP,oNPC,1);

  //Check for Enough Gold and Maximum Animals
  int nGP = GetGold(oPC);
  int nSTotal = GetLocalInt(oPC,"OPE_PETTOTAL");
  if(nSTotal > 0) return FALSE;

  //All Checks
  if(nGP >= nPrice
    && nSTotal == 0
    && nPrice > 0
    && GetIsObjectValid(oWP) == TRUE)
  {
    return TRUE;
  }
  else return FALSE;
}
