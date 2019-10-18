////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_choose_c3
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the NPC Commodity Convo
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oNPC = OBJECT_SELF;
  string sNPC = GetTag(oNPC);
  object oPC = GetPCSpeaker();

  //Normal and Bulk Prices
  string sNum = IntToString(3);
  int nBPrice = GetLocalInt(oNPC,"BUY_BULKPRICE" + sNum);
  int nQty = GetLocalInt(oNPC,"QUEST_QUANTITY" + sNum);
  int nXP = GetLocalInt(oNPC,"QUEST_XP" + sNum);
  string sTag = GetLocalString(oNPC,"TAG" + sNPC + sNum);
  string sName = GetLocalString(oNPC,"NAME" + sNPC + sNum);

  object oContract = CreateItemOnObject("questcontract",oPC,1);

  //Set Variables to Contract
  SetLocalString(oContract,"CONTRACT_NPC",sNPC);
  SetLocalInt(oContract,"CONTRACT_BULKPRICE",nBPrice);
  SetLocalInt(oContract,"CONTRACT_QUANTITY",nQty);
  SetLocalInt(oContract,"CONTRACT_XP",nXP);
  SetLocalString(oContract,"CONTRACT_ITEMTAG",sTag);
  SetLocalString(oContract,"CONTRACT_ITEMNAME",sName);
}
