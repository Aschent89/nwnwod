////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_chk_buyt1
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Salesman Convo.
//
//  Checks for Enough Gold.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  string sPrice = "PRICE1";
  string sWP = "HorseShop";

  //Price
  int nPrice = GetLocalInt(oNPC,sPrice);

  //Get the Shop Waypoint
  object oWP = GetNearestObjectByTag(sWP,oNPC,1);

  //Check for a Horse Already
  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  if(GetIsObjectValid(oItem)) return FALSE;

  //Checks
  if(nPrice > 0 && GetIsObjectValid(oWP) == TRUE)
  {
    return TRUE;
  }
  else return FALSE;
}
