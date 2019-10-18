////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Gem Cutting Crafting
//  ocr_st_gem
//  by Don Anderson
//
//  Place this on the On Closed Event of the Gem Cutting Table
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC      = GetLastClosedBy();
    object oMod     = GetModule();

    //From Master Configuration opw_mod_onload
    int nCRAFTGLOBAL = GetLocalInt(oMod,"CRAFTGLOBAL");
    if(nCRAFTGLOBAL == 0) return;

    object oSelf    = OBJECT_SELF;

    //Don't bother going through the script if inventory is empty
    object oItem = GetFirstItemInInventory(oSelf);
    if(oItem == OBJECT_INVALID) return;

    //DC of Gem Cutting
    int nDC = GetLocalInt(oMod,"GEMDC");;

    //Player's Lore Skill
    int nPLore = GetSkillRank(SKILL_LORE,oPC);

    //Skill Roll
    int nSkill = d20() + nPLore;

    //Now we check out the Inventory of the Gem Cutting Table for Mixed Ores
    object oMCheck = GetFirstItemInInventory(oSelf);
    string sMTag = GetTag(oMCheck);
    while(GetIsObjectValid(oMCheck))
    {
      if(GetTag(oMCheck) != sMTag)
      {
        SendMessageToPC(oPC,"You may only Gem Cut 1 type of Ore at a time.");
        return;
      }

      oMCheck = GetNextItemInInventory(oSelf);
    }

    //Now we check the inventory again and count the number of Ore on the Gem Cutting Table
    int nTotal = 0;

    object oQCheck = GetFirstItemInInventory(oSelf);
    while(GetIsObjectValid(oQCheck))
    {
      nTotal++;
      if(nTotal > 1)
      {
        SendMessageToPC(oPC,"You may only cut 1 Gem Ore at a time.");
        return;
      }
      oQCheck = GetNextItemInInventory(oSelf);
    }

    //Now Destroy the Ore
    object oDestroy = GetFirstItemInInventory(oSelf);
    string sDestroy = GetTag(oDestroy);
    int nL = GetStringLength(sDestroy);
    string sGem = GetStringLowerCase(GetStringLeft(sDestroy,(nL - 3)));
    while(GetIsObjectValid(oDestroy))
    {
      DestroyObject(oDestroy);
      oDestroy = GetNextItemInInventory(oSelf);
    }

    //Now Give the Correct Text and Item
    if(nSkill >= nDC)
    {
      SendMessageToPC(oPC,"Nice work. You have had success.");
      CreateItemOnObject(sGem, oSelf);

      //Discover an Ioun Stone 5% of the time
      int nIS = d100(1);
      if(nIS < 11)
      {
        int nRand = Random(7)+1;
        if(nRand == 1) CreateItemOnObject("x2_is_drose", oSelf);
        if(nRand == 2) CreateItemOnObject("x2_is_paleblue", oSelf);
        if(nRand == 3) CreateItemOnObject("x2_is_deepred", oSelf);
        if(nRand == 4) CreateItemOnObject("x2_is_pink", oSelf);
        if(nRand == 5) CreateItemOnObject("x2_is_sandblue", oSelf);
        if(nRand == 6) CreateItemOnObject("x2_is_blue", oSelf);
        if(nRand == 7) CreateItemOnObject("x2_is_pandgreen", oSelf);
      }
    }
    else
    {
      SendMessageToPC(oPC,"Well, try again. You made the ore useless because of your your carelessness.");
    }

    //Lock for 3 Rounds
    SetLocked(oSelf,TRUE);
    DelayCommand(18.0,AssignCommand(oSelf,SetLocked(oSelf,FALSE)));
    SendMessageToPC(oPC,"The Gem Cutting Table will be locked for 3 Rounds while processing.");
}
