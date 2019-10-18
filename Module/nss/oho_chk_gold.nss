////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_chk_gold
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

  //Price
  int nPrice = GetLocalInt(oPC,"OHO_CHOOSE_PRICE");

  //Player Gold
  int nGP = GetGold(oPC);

  //Enough Gold
  if(nPrice < nGP)
  {
    return TRUE;
  }

  //Remove Chosen Info
  else
  {
    DeleteLocalString(oPC,"OHO_CHOOSE_WP");
    DeleteLocalString(oPC,"OHO_CHOOSE_TYPE");
    DeleteLocalInt(oPC,"OHO_CHOOSE_PRICE");

    return FALSE;
  }
}
