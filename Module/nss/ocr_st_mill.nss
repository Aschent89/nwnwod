////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Milling Wood Crafting
//  ocr_st_mill
//  by Don Anderson
//
//  Place this on the On Closed Event of the Wood Mill
//
//  Thanks to Robert Olsen for the Crafting Gloves
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC      = GetLastClosedBy();
    object oMod     = GetModule();

    //From Master Configuration opw_mod_onload
    int nCRAFTGLOBAL = GetLocalInt(oMod,"CRAFTGLOBAL");
    if(nCRAFTGLOBAL == 0) return;

    object oMill    = OBJECT_SELF;

    int nIWoodDC    = GetLocalInt(oMod,"IWOODDC");
    int nIWoodQTY   = GetLocalInt(oMod,"IWOODQTY");
    int nOakDC      = GetLocalInt(oMod,"OAKDC");
    int nOakQTY     = GetLocalInt(oMod,"OAKQTY");
    int nElmDC      = GetLocalInt(oMod,"ELMDC");
    int nElmQTY     = GetLocalInt(oMod,"ELMQTY");

    string sIWood   = "IronWood";
    string sOak     = "OakWood";
    string sElm     = "ElmWood";

    //Don't bother going through the script if inventory is empty
    object oItem = GetFirstItemInInventory(oMill);
    if(oItem == OBJECT_INVALID) return;

    //We need to get the Skill Level of the Player
    int nSkill = d20(1);
    int nArmor = GetSkillRank(SKILL_CRAFT_ARMOR, oPC);
    int nWeapon = GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
    if(nArmor > nWeapon) nSkill = nSkill + nArmor;
    if(nWeapon > nArmor) nSkill = nSkill + nWeapon;
    if(nWeapon == nArmor) nSkill = nSkill + nArmor;

    //Now we check out the Inventory of the Smelting Forge for Mixed Ores
    object oMCheck = GetFirstItemInInventory(oMill);
    while(GetIsObjectValid(oMCheck))
    {
      if (GetTag(oMCheck) == sIWood)
      {
        SetLocalInt(oMill,sIWood,1);
      }
      if (GetTag(oMCheck) == sOak)
      {
        SetLocalInt(oMill,sOak,1);
      }
      if (GetTag(oMCheck) == sElm)
      {
        SetLocalInt(oMill,sElm,1);
      }
      oMCheck = GetNextItemInInventory(oMill);
    }
    int nIWCHK = GetLocalInt(oMill,sIWood);
    int nOCHK = GetLocalInt(oMill,sOak);
    int nECHK = GetLocalInt(oMill,sElm);
    if((nIWCHK + nOCHK + nECHK) > 1)
    {
      SendMessageToPC(oPC,"You may only Mill 1 type of Wood at a time.");
      SetLocalInt(oMill,sIWood,0);
      SetLocalInt(oMill,sOak,0);
      SetLocalInt(oMill,sElm,0);
      return;
    }

    //Now we check the inventory again and count the number of Ore in the Smelting Forge
    int nIWood = 0;
    int nOak = 0;
    int nElm = 0;

    object oQCheck = GetFirstItemInInventory(oMill);
    while (GetIsObjectValid(oQCheck))
    {
      string sQCheckTag = GetTag(oQCheck);
      if (sQCheckTag == sIWood) nIWood = nIWood + 1;
      if (sQCheckTag == sOak) nOak = nOak + 1;
      if (sQCheckTag == sElm) nElm = nElm + 1;
      oQCheck = GetNextItemInInventory(oMill);
    }

    //Now we check the Capacity of the Wood Mill
    if(nIWood > nIWoodQTY)
    {
      SendMessageToPC(oPC,"The Capacity of the Wood Mill is " +IntToString(nIWoodQTY)+ " Ironwood.");
      SendMessageToPC(oPC,"You have " +IntToString(nIWood)+ " Ironwood in the Wood Mill.");
      SendMessageToPC(oPC,"Please remove " +IntToString(nIWood - nIWoodQTY)+ " Ironwood from the Wood Mill.");
      return;
    }
    if(nOak > nOakQTY)
    {
      SendMessageToPC(oPC,"The Capacity of the Wood Mill is " +IntToString(nOakQTY)+ " Oak.");
      SendMessageToPC(oPC,"You have " +IntToString(nOak)+ " Oak in the Wood Mill.");
      SendMessageToPC(oPC,"Please remove " +IntToString(nOak - nOakQTY)+ " Oak from the Wood Mill.");
      return;
    }
    if(nElm > nElmQTY)
    {
      SendMessageToPC(oPC,"The Capacity of the Wood Mill is " +IntToString(nElmQTY)+ " Elm.");
      SendMessageToPC(oPC,"You have " +IntToString(nElm)+ " Elm in the Wood Mill.");
      SendMessageToPC(oPC,"Please remove " +IntToString(nElm - nElmQTY)+ " Elm from the Wood Mill.");
      return;
    }

    //Now we Mill the Ironwood into Planks
    if(nIWood > 0 && nIWood < nIWoodQTY)
    {
      SendMessageToPC(oPC,"1 set of planks require " +IntToString(nIWoodQTY)+ " Ironwood in the Wood Mill.");
      return;
    }
    else if (nIWood == nIWoodQTY)
    {
      //Now we Destroy the Required Number of Items in Inventory
      int nCount = nIWood;
      object oDestroy = GetFirstItemInInventory(oMill);
      while(GetIsObjectValid(oDestroy))
      {
        if (GetTag(oDestroy) == sIWood)
        {
          DestroyObject(oDestroy);
          oDestroy = GetNextItemInInventory(oMill);
        }
        else oDestroy = GetNextItemInInventory(oMill);
      }

      //Now Give the Correct Text and Item
      if(nSkill >= nIWoodDC)
      {
        SendMessageToPC(oPC,"Nice work. you have made planks of Ironwood from the Raw Ironwood.");
        CreateItemOnObject("x2_it_cmat_ironw", oMill);
      }
      else
      {
        SendMessageToPC(oPC,"Well, try again. You made the planks useless because of your your carelessness.");
      }
    }

    //Now we Mill the Oak into a Bar
    if(nOak > 0 && nOak < nOakQTY)
    {
      SendMessageToPC(oPC,"1 set of planks require " +IntToString(nOakQTY)+ " Oak in the Wood Mill.");
      return;
    }
    else if (nOak == nOakQTY)
    {
      //Now we Destroy the Required Number of Items in Inventory
      int nCount = nOak;
      object oDestroy = GetFirstItemInInventory(oMill);
      while(GetIsObjectValid(oDestroy))
      {
        if (GetTag(oDestroy) == sOak)
        {
          DestroyObject(oDestroy);
          oDestroy = GetNextItemInInventory(oMill);
        }
        else oDestroy = GetNextItemInInventory(oMill);
      }

      //Now Give the Correct Text and Item
      if(nSkill >= nOakDC)
      {
        SendMessageToPC(oPC,"Nice work. you have made planks of Oak from the Raw Oak.");
        CreateItemOnObject("x2_it_cmat_oakw", oMill);
      }
      else
      {
        SendMessageToPC(oPC,"Well, try again. You made the planks useless because of your your carelessness.");
      }
    }

    //Now we Smelt the Elm into a Bar
    if(nElm > 0 && nElm < nElmQTY)
    {
      SendMessageToPC(oPC,"1 set of planks require " +IntToString(nElmQTY)+ " Elm in the Wood Mill.");
      return;
    }
    else if (nElm == nElmQTY)
    {
      //Now we Destroy the Required Number of Items in Inventory
      int nCount = nElm;
      object oDestroy = GetFirstItemInInventory(oMill);
      while(GetIsObjectValid(oDestroy))
      {
        if (GetTag(oDestroy) == sElm)
        {
          DestroyObject(oDestroy);
          oDestroy = GetNextItemInInventory(oMill);
        }
        else oDestroy = GetNextItemInInventory(oMill);
      }

      //Now Give the Correct Text and Item
      if(nSkill >= nElmDC)
      {
        SendMessageToPC(oPC,"Nice work. you have made planks of Elm from the Raw Elm.");
        CreateItemOnObject("x2_it_cmat_elmw", oMill);
      }
      else
      {
        SendMessageToPC(oPC,"Well, try again. You made the planks useless because of your your carelessness.");
      }
    }

    //Lock for 1 Round
    SetLocked(oMill,TRUE);
    DelayCommand(10.0,AssignCommand(oMill,SetLocked(oMill,FALSE)));
    SendMessageToPC(oPC,"The Wood Mill will be locked for 1 Round while processing.");

}
