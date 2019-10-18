////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_nfin_contrac
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the NPC Commodity Convo
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oNPC = OBJECT_SELF;
  string sNPC = GetTag(oNPC);
  object oPC = GetPCSpeaker();

  //Contract Valid
  object oContract = GetItemPossessedBy(oPC,"QuestContract");

  //Set Variables to Contract
  string sCNPC = GetLocalString(oContract,"CONTRACT_NPC");
  int nPrice = GetLocalInt(oContract,"CONTRACT_BULKPRICE");
  int nQty = GetLocalInt(oContract,"CONTRACT_QUANTITY");
  string sIName = GetLocalString(oContract,"CONTRACT_ITEMNAME");
  string sITag = GetLocalString(oContract,"CONTRACT_ITEMTAG");

  //First Check to See if the Minimum Number Of Contract Items Are on PC
  int nTotal = 0; string sCheck; int nStack = 0;
  object oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem) == TRUE)
  {
    sCheck = GetTag(oItem);
    if(sITag == sCheck)
    {
      nStack = GetItemStackSize(oItem);
      if(nStack > 1) nTotal = nTotal + nStack;
      else nTotal++;
    }

    oItem = GetNextItemInInventory(oPC);
  }

  if(nTotal > 0 && nTotal < nQty) return TRUE;
  else return FALSE;
}
