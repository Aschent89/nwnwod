////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_conv_tokens
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

  //Get the Buying Chest
  string sBChest = sNPC;
  int nNth = 0;
  object oBChest = GetObjectByTag(sBChest,nNth);
  while(GetIsObjectValid(oBChest))
  {
    if(GetHasInventory(oBChest))
    {
      if(GetObjectType(oBChest) == OBJECT_TYPE_PLACEABLE) break;
    }
    nNth++;
    oBChest = GetObjectByTag(sBChest,nNth);
  }

  //Now Get Pricing Info
  int nBHP = GetMaxHitPoints(oBChest);//Price Percentage
  if(nBHP < 11) nBHP = 11;
  int nBFS = GetFortitudeSavingThrow(oBChest);//Low Price Season
  int nBRS = GetReflexSavingThrow(oBChest);//Bulk Percentage
  int nBWS = GetWillSavingThrow(oBChest);//Bulk Min Qty
  int nXP = GetLocalInt(oBChest,"OQS_XPREWARD");
  if(nXP < 20) nXP = 20;

  //Gem Bulk Sales Cap
  int nGBS = 800;

  //Seasonal Pricing
  int nMonth = GetCalendarMonth();
  int nSeason = 4;
  int nDiscount = 0;
  if(nMonth < 3 || nMonth == 12) nSeason = 1;
  if(nMonth >= 3 && nMonth < 6) nSeason = 2;
  if(nMonth >= 6 && nMonth < 9) nSeason = 3;
  if(nMonth >= 9 && nMonth < 11) nSeason = 4;
  if(nBFS != 0)
  {
    //We are in the Current Season
    if(nBFS == nSeason) nDiscount = 10;
  }

  //Set the Bulk Quantity Minimum
  SetCustomToken(10031,IntToString(nBWS));
  SetLocalInt(oNPC,"BUY_BULKQTY",nBWS);

  //Now Get the Items in the Buy Chest
  if(oBChest != OBJECT_INVALID)
  {
    int nBNth = 1;
    object oBItem = GetFirstItemInInventory(oBChest);
    while(nBNth <= 10 && GetIsObjectValid(oBItem) == TRUE)
    {
      //Indentify Item
      SetIdentified(oBItem,TRUE);

      //Set Name of Item
      string sName = GetName(oBItem);
      SetCustomToken(10010 + nBNth,sName);
      SetCustomToken(10110 + nBNth,sName);
      SetLocalString(oNPC,"NAME" + sNPC + IntToString(nBNth),sName);

      //Set Local String for Easy Access to NPC
      string sTag = GetTag(oBItem);
      string sResRef = GetResRef(oBItem);
      SetLocalString(oNPC,"TAG" + sNPC + IntToString(nBNth),sTag);
      SetLocalString(oNPC,"RESREF" + sNPC + IntToString(nBNth),sTag);

      //Set the Buy Price of the Item
      int nPrice = GetGoldPieceValue(oBItem);
      float fCalc = IntToFloat(nBHP - nDiscount)* 0.01;
      int nTPrice = FloatToInt(IntToFloat(nPrice) * fCalc);
      if(nTPrice < 1) nTPrice = 1;

      //Gem and Ioun Bulk Sales
      int nGem = FindSubString(sNPC,"Gem");
      int nIoun = FindSubString(sNPC,"Ioun");
      if(nGem != -1 || nIoun != -1)
      {
        if(nPrice > nGBS) nTPrice = nGBS;
      }

      SetCustomToken(10020 + nBNth,IntToString(nTPrice));
      SetLocalInt(oNPC,"BUY_NORMPRICE" + IntToString(nBNth),nTPrice);

      //Set Contract Quantity for this Item
      int nD20 = d20(1);
      if(nD20 < 8) nD20 = 8;
      SetCustomToken(10130 + nBNth,IntToString(nD20));
      SetLocalInt(oNPC,"QUEST_QUANTITY" + IntToString(nBNth),nD20);

      //Set the Bulk Quantity and Contract Price
      float fBCalc = IntToFloat(nBHP + nBRS) * 0.01;
      int nBulkPrice = FloatToInt(IntToFloat(nPrice) * fBCalc);
      if(nBulkPrice <= nPrice) nBulkPrice = nPrice + 1;

      //Gem and Ioun Bulk Sales
      nGem = FindSubString(sNPC,"Gem");
      nIoun = FindSubString(sNPC,"Ioun");
      if(nGem != -1 || nIoun != -1)
      {
        if(nBulkPrice > nGBS) nBulkPrice = FloatToInt(IntToFloat(nGBS) * fBCalc);
      }

      SetCustomToken(10040 + nBNth,IntToString(nBulkPrice));
      SetCustomToken(10120 + nBNth,IntToString(nBulkPrice));
      SetLocalInt(oNPC,"BUY_BULKPRICE" + IntToString(nBNth),nBulkPrice);

      SetCustomToken(10150 + nBNth,IntToString(nXP));
      SetLocalInt(oNPC,"QUEST_XP" + IntToString(nBNth),nXP);

      //Next Item
      SetLocalInt(oNPC,"BUY_TOTALITEMS",nBNth);
      nBNth++;
      oBItem = GetNextItemInInventory(oBChest);
    }
  }
}
