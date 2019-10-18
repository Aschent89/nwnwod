////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_chk_buyt4
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Salesman Convo.
//
//  Checks for Enough Gold.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  string sPrice = "PRICE4";
  string sWP = "PackAnimalShop";

  //Price
  int nPrice = GetLocalInt(oNPC,sPrice);

  //Get the Shop Waypoint
  object oWP = GetNearestObjectByTag(sWP,oNPC,1);

  //Check for Enough Gold and Maximum Animals
  int nGP = GetGold(oPC);
  int nSTotal = GetLocalInt(oPC,"OPA_ANIMALTOTAL");
  if(nSTotal > 0) return FALSE;

  //All Checks
  if(nSTotal < 1
    && nPrice > 0
    && GetIsObjectValid(oWP) == TRUE)
  {
    return TRUE;
  }
  else return FALSE;
}
