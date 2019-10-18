////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_fin_contract
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
  int nXP = GetLocalInt(oContract,"CONTRACT_XP");
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
  if(nTotal < nQty) return FALSE;

  //Now We Check for a Contract
  if(GetIsObjectValid(oContract) == TRUE)
  {
    //Correct NPC
    if(sNPC == sCNPC)
    {
      //Gold
      int nTPrice = nQty * nPrice;
      GiveGoldToCreature(oPC,nTPrice);

      //XP
      int nTXP = nQty * nXP;
      GiveXPToCreature(oPC,nTXP);

      //Now Destroy Contract Quantity of Items
      int nTotal = 0; string sCheck; int nStack = 0;
      object oItem = GetFirstItemInInventory(oPC);
      while(GetIsObjectValid(oItem) == TRUE)
      {
        sCheck = GetTag(oItem);
        if(sITag == sCheck)
        {
          nStack = GetItemStackSize(oItem);
          if(nStack > 1)
          {
            int nTemp = nQty - nTotal;

            //Stack Bigger Than Current Total
            if(nStack > nTemp)
            {
              int nNew = nStack - nTemp;
              SetItemStackSize(oItem,nNew);
              nTotal = nQty;
              break;
            }

            //Stack Same As Current Total
            else if(nStack == nTemp)
            {
              nTotal = nQty;
              DestroyObject(oItem);
              break;
            }

            //Stack Smaller Than Current Total
            else if(nStack < nTemp)
            {
              nTotal = nTotal + nStack;
              DestroyObject(oItem);
            }
          }
          else
          {
            nTotal++;
            DestroyObject(oItem);
          }
        }

        if(nTotal == nQty) break;

        oItem = GetNextItemInInventory(oPC);
      }

      //Now Destroy Contract
      DestroyObject(oContract);

      return TRUE;
    }
    else return FALSE;
  }
  else return FALSE;

}
