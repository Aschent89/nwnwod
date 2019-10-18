////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_sell_i8
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
  int nNPrice = GetLocalInt(oNPC,"BUY_NORMPRICE" + IntToString(8));
  int nBPrice = GetLocalInt(oNPC,"BUY_BULKPRICE" + IntToString(8));

  //PC is Selling these
  string sTag = GetLocalString(oNPC,"TAG" + sNPC + IntToString(8));
  int nTotal = 0; string sCheck; int nStack = 0;
  object oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem) == TRUE)
  {
    sCheck = GetTag(oItem);
    if(sTag == sCheck)
    {
      nStack = GetItemStackSize(oItem);
      if(nStack > 1) nTotal = nTotal + nStack;
      else nTotal++;

      DestroyObject(oItem);
    }

    oItem = GetNextItemInInventory(oPC);
  }

  if(nTotal == 0) SendMessageToPC(oPC,"You have nothing to sell!");

  //Normal Pricing
  if(nTotal > 0 && nTotal <= 9)
  {
    int nTPrice = nTotal * nNPrice;
    GiveGoldToCreature(oPC,nTPrice);
  }

  //Bulk Pricing
  if(nTotal >= 10)
  {
    int nTPrice = nTotal * nBPrice;
    GiveGoldToCreature(oPC,nTPrice);
  }
}
