////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting System
//  ocr_exchange
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the OnClosed Event of Placeable
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetLastClosedBy();
  object oExchanger = OBJECT_SELF;
  object oMod = GetModule();

  object oItem; object oBaseItem; object oSquad;
  string sItemTag; string sResRef; string sGuild;
  int nLoop = 1;

  //Exchange Crafting Books
  int nENC = GetLocalInt(oMod,"AUTOBOOK_ENC");
  object oEBook = GetItemPossessedBy(oExchanger,"BookofEnchanting");
  if(GetIsObjectValid(oEBook))
  {
    sResRef = GetResRef(oEBook);
    object oNEBook = CreateItemOnObject(sResRef,oPC);
    SetLocalInt(oNEBook,"ENCHANTING_LVL",nENC);
    DestroyObject(oEBook);
  }

  int nHER = GetLocalInt(oMod,"AUTOBOOK_HER");
  object oHBook = GetItemPossessedBy(oExchanger,"BookofHerbology");
  if(GetIsObjectValid(oHBook))
  {
    sResRef = GetResRef(oHBook);
    object oNHBook = CreateItemOnObject(sResRef,oPC);
    SetLocalInt(oNHBook,"HERBOLOGY_LVL",nHER);
    DestroyObject(oHBook);
  }

  int nBLK = GetLocalInt(oMod,"AUTOBOOK_BLK");
  object oSBook = GetItemPossessedBy(oExchanger,"BookofSmithing");
  if(GetIsObjectValid(oSBook))
  {
    sResRef = GetResRef(oSBook);
    object oNSBook = CreateItemOnObject(sResRef,oPC);
    SetLocalInt(oNSBook,"SMITHING_LVL",nBLK);
    DestroyObject(oSBook);
  }

  int nWDW = GetLocalInt(oMod,"AUTOBOOK_WDW");
  object oWBook = GetItemPossessedBy(oExchanger,"BookofWoodworking");
  if(GetIsObjectValid(oWBook))
  {
    sResRef = GetResRef(oWBook);
    object oNWBook = CreateItemOnObject(sResRef,oPC);
    SetLocalInt(oNWBook,"WOODWORKING_LVL",nWDW);
    DestroyObject(oWBook);
  }
}
