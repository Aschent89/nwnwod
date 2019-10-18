////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Conversation Tokens Crafting
//  ocr_tokens
//  by Don Anderson
//  dandersonru@msn.com
//
//  Sets up all Tokens for the College Registrar
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC      = GetPCSpeaker();
    object oMod     = GetModule();
    object oHBook   = GetItemPossessedBy(oPC,"BookofHerbology");
    object oBBook   = GetItemPossessedBy(oPC,"BookofSmithing");
    object oEBook   = GetItemPossessedBy(oPC,"BookofEnchanting");
    object oWBook   = GetItemPossessedBy(oPC,"BookofWoodworking");

    int nHLevel     = GetLocalInt(oHBook,"HERBOLOGY_LVL");
    int nHCost      = GetLocalInt(oMod,"HERBGP");
    int nHSC        = (nHLevel + 4) * nHCost;//Cost of next Class

    int nBLevel     = GetLocalInt(oBBook,"SMITHING_LVL");
    int nBCost      = GetLocalInt(oMod,"BLKGP");
    int nBSC        = (nBLevel + 4) * nBCost;//Cost of next Class

    int nELevel     = GetLocalInt(oBBook,"ENCHANTING_LVL");
    int nECost      = GetLocalInt(oMod,"ENCGP");
    int nESC        = (nELevel + 4) * nECost;//Cost of next Class

    int nWLevel     = GetLocalInt(oBBook,"WOODWORKING_LVL");
    int nWCost      = GetLocalInt(oMod,"WDWGP");
    int nWSC        = (nWLevel + 4) * nWCost;//Cost of next Class

    //Herbology
    SetCustomToken(2000,IntToString(nHLevel));
    SetCustomToken(2001,IntToString(nHSC));
    SetLocalInt(oPC,"HERB_COST",nHSC);

    //Smithing
    SetCustomToken(2002,IntToString(nBLevel));
    SetCustomToken(2003,IntToString(nBSC));
    SetLocalInt(oPC,"BLK_COST",nBSC);

    //Enchanting
    SetCustomToken(2004,IntToString(nELevel));
    SetCustomToken(2005,IntToString(nESC));
    SetLocalInt(oPC,"ENC_COST",nESC);

    //Woodworking
    SetCustomToken(2006,IntToString(nWLevel));
    SetCustomToken(2007,IntToString(nWSC));
    SetLocalInt(oPC,"WDW_COST",nWSC);
}
