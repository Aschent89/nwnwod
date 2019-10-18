////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_chk_contract
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Rest Menu Convo
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();

  //Contract Valid
  object oContract = GetItemPossessedBy(oPC,"QuestContract");

  //Color set up for Changing Repair Text
  string sColor   = GetName(GetObjectByTag("COLORS"));
  string sBlue    = GetSubString(sColor, 36, 6);
  string sYellow  = GetSubString(sColor, 6, 6);

  //First Check to See if the Minimum Number Of Contract Items Are on PC
  if(GetIsObjectValid(oContract) == TRUE)
  {
    //Set Variables to Contract
    string sCNPC = GetLocalString(oContract,"CONTRACT_NPC");
    int nPrice = GetLocalInt(oContract,"CONTRACT_BULKPRICE");
    int nQty = GetLocalInt(oContract,"CONTRACT_QUANTITY");
    string sIName = GetLocalString(oContract,"CONTRACT_ITEMNAME");
    string sITag = GetLocalString(oContract,"CONTRACT_ITEMTAG");

    SendMessageToPC(oPC,sBlue + "Your Contract is with : " + sYellow + sCNPC);
    SendMessageToPC(oPC,sBlue + "Your Contract price is : " + sYellow + IntToString(nPrice) + sBlue + " for "
      + sYellow + IntToString(nQty)+ " " + sBlue + sIName);
  }
}
