////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Smelting Ore Crafting
//  ocr_st_smelt
//  by Don Anderson
//
//  Place this on the On Closed Event of the Smelting Forge
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

    object oForge   = OBJECT_SELF;

    int nAdamDC     = GetLocalInt(oMod,"ADAMDC");
    int nAdamQTY    = GetLocalInt(oMod,"ADAMQTY");
    int nMithDC     = GetLocalInt(oMod,"MITHDC");
    int nMithQTY    = GetLocalInt(oMod,"MITHQTY");
    int nSteelDC    = GetLocalInt(oMod,"STEELDC");
    int nSteelQTY   = GetLocalInt(oMod,"STEELQTY");
    int nIronDC     = GetLocalInt(oMod,"IRONDC");
    int nIronQTY    = GetLocalInt(oMod,"IRONQTY");
    int nSilDC     = GetLocalInt(oMod,"SILDC");
    int nSilQTY    = GetLocalInt(oMod,"SILQTY");

    string sAOre    = "AdamantineOre";
    string sMOre    = "MithrilOre";
    string sSOre    = "SteelOre";
    string sIOre    = "IronOre";
    string sVOre    = "SilverOre";

    //Don't bother going through the script if inventory is empty
    object oItem = GetFirstItemInInventory(oForge);
    if(oItem == OBJECT_INVALID) return;

    //We need to get the Skill Level of the Player
    int nSkill = d20(1);
    int nArmor = GetSkillRank(SKILL_CRAFT_ARMOR, oPC);
    int nWeapon = GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
    if(nArmor > nWeapon) nSkill = nSkill + nArmor;
    if(nWeapon > nArmor) nSkill = nSkill + nWeapon;
    if(nWeapon == nArmor) nSkill = nSkill + nArmor;

    //Now we check out the Inventory of the Smelting Forge for Mixed Ores
    object oMCheck = GetFirstItemInInventory(oForge);
    while(GetIsObjectValid(oMCheck))
    {
      if (GetTag(oMCheck) == sAOre)
      {
        SetLocalInt(oForge,sAOre,1);
      }
      if (GetTag(oMCheck) == sMOre)
      {
        SetLocalInt(oForge,sMOre,1);
      }
      if (GetTag(oMCheck) == sSOre)
      {
        SetLocalInt(oForge,sSOre,1);
      }
      if (GetTag(oMCheck) == sIOre)
      {
        SetLocalInt(oForge,sIOre,1);
      }
      if (GetTag(oMCheck) == sVOre)
      {
        SetLocalInt(oForge,sVOre,1);
      }
      oMCheck = GetNextItemInInventory(oForge);
    }
    int nACHK = GetLocalInt(oForge,sAOre);
    int nMCHK = GetLocalInt(oForge,sMOre);
    int nSCHK = GetLocalInt(oForge,sSOre);
    int nICHK = GetLocalInt(oForge,sIOre);
    int nVCHK = GetLocalInt(oForge,sVOre);
    if((nACHK + nMCHK + nSCHK + nICHK) > 1)
    {
      SendMessageToPC(oPC,"You may only Smelt 1 type of Ore at a time.");
      SetLocalInt(oForge,sAOre,0);
      SetLocalInt(oForge,sMOre,0);
      SetLocalInt(oForge,sSOre,0);
      SetLocalInt(oForge,sIOre,0);
      SetLocalInt(oForge,sVOre,0);
      return;
    }

    //Now we check the inventory again and count the number of Ore in the Smelting Forge
    int nAdam = 0;
    int nMith = 0;
    int nSteel = 0;
    int nIron = 0;
    int nSilver = 0;

    object oQCheck = GetFirstItemInInventory(oForge);
    while (GetIsObjectValid(oQCheck))
    {
      string sQCheckTag = GetTag(oQCheck);
      if (sQCheckTag == sAOre) nAdam = nAdam + 1;
      if (sQCheckTag == sMOre) nMith = nMith + 1;
      if (sQCheckTag == sSOre) nSteel = nSteel + 1;
      if (sQCheckTag == sIOre) nIron = nIron + 1;
      if (sQCheckTag == sSOre) nSilver = nSilver + 1;
      oQCheck = GetNextItemInInventory(oForge);
    }

    //Now we check the Capacity of the Smelting Forge
    if(nAdam > nAdamQTY)
    {
      SendMessageToPC(oPC,"The Capacity of the Smelting Forge is " +IntToString(nAdamQTY)+ " Adamantine Ore.");
      SendMessageToPC(oPC,"You have " +IntToString(nAdam)+ " Adamantine Ore in the Smelting Forge.");
      SendMessageToPC(oPC,"Please remove " +IntToString(nAdam - nAdamQTY)+ " Adamantine Ore from the Smelting Forge.");
      return;
    }
    if(nMith > nMithQTY)
    {
      SendMessageToPC(oPC,"The Capacity of the Smelting Forge is " +IntToString(nMithQTY)+ " Mithril Ore.");
      SendMessageToPC(oPC,"You have " +IntToString(nMith)+ " Mithril Ore in the Smelting Forge.");
      SendMessageToPC(oPC,"Please remove " +IntToString(nMith - nMithQTY)+ " Mithril Ore from the Smelting Forge.");
      return;
    }
    if(nSteel > nSteelQTY)
    {
      SendMessageToPC(oPC,"The Capacity of the Smelting Forge is " +IntToString(nSteelQTY)+ " Steel Ore.");
      SendMessageToPC(oPC,"You have " +IntToString(nSteel)+ " Steel Ore in the Smelting Forge.");
      SendMessageToPC(oPC,"Please remove " +IntToString(nSteel - nSteelQTY)+ " Steel Ore from the Smelting Forge.");
      return;
    }
    if(nIron > nIronQTY)
    {
      SendMessageToPC(oPC,"The Capacity of the Smelting Forge is " +IntToString(nIronQTY)+ " Iron Ore.");
      SendMessageToPC(oPC,"You have " +IntToString(nIron)+ " Iron Ore in the Smelting Forge.");
      SendMessageToPC(oPC,"Please remove " +IntToString(nIron - nIronQTY)+ " Iron Ore from the Smelting Forge.");
      return;
    }
    if(nSilver > nSilQTY)
    {
      SendMessageToPC(oPC,"The Capacity of the Smelting Forge is " +IntToString(nIronQTY)+ " Silver Ore.");
      SendMessageToPC(oPC,"You have " +IntToString(nIron)+ " Silver Ore in the Smelting Forge.");
      SendMessageToPC(oPC,"Please remove " +IntToString(nIron - nIronQTY)+ " Silver Ore from the Smelting Forge.");
      return;
    }

    //Now we Smelt the Adamantine Ore into a Bar
    if(nAdam > 0 && nAdam < nAdamQTY)
    {
      SendMessageToPC(oPC,"1 bar of Adamantine requires " +IntToString(nAdamQTY)+ " Adamantine Ore in the Smelting Forge.");
      return;
    }
    else if (nAdam == nAdamQTY)
    {
      //Now we Destroy the Required Number of Items in Inventory
      int nCount = nAdam;
      object oDestroy = GetFirstItemInInventory(oForge);
      while(GetIsObjectValid(oDestroy))
      {
        if (GetTag(oDestroy) == sAOre)
        {
          DestroyObject(oDestroy);
          oDestroy = GetNextItemInInventory(oForge);
        }
        else oDestroy = GetNextItemInInventory(oForge);
      }

      //Now Give the Correct Text and Item
      if(nSkill >= nAdamDC)
      {
        SendMessageToPC(oPC,"Nice work. you have made a bar of Adamantine from the Ore");
        CreateItemOnObject("x2_it_cmat_adam", oForge);
      }
      else
      {
        SendMessageToPC(oPC,"Well, try again. No Adamantine could be extracted from the Ore.");
      }
    }

    //Now we Smelt the Mithril Ore into a Bar
    if(nMith > 0 && nMith < nMithQTY)
    {
      SendMessageToPC(oPC,"1 bar of Mithril requires " +IntToString(nMithQTY)+ " Mithril Ore in the Smelting Forge.");
      return;
    }
    else if (nMith == nMithQTY)
    {
      //Now we Destroy the Required Number of Items in Inventory
      int nCount = nMith;
      object oDestroy = GetFirstItemInInventory(oForge);
      while(GetIsObjectValid(oDestroy))
      {
        if (GetTag(oDestroy) == sMOre)
        {
          DestroyObject(oDestroy);
          oDestroy = GetNextItemInInventory(oForge);
        }
        else oDestroy = GetNextItemInInventory(oForge);
      }

      //Now Give the Correct Text and Item
      if(nSkill >= nMithDC)
      {
        SendMessageToPC(oPC,"Nice work. you have made a bar of Mithril from the Ore");
        CreateItemOnObject("x2_it_cmat_mith", oForge);
      }
      else
      {
        SendMessageToPC(oPC,"Well, try again. No Mithril could be extracted from the Ore.");
      }
    }

    //Now we Smelt the Steel Ore into a Bar
    if(nSteel > 0 && nSteel < nSteelQTY)
    {
      SendMessageToPC(oPC,"1 bar of Steel requires " +IntToString(nSteelQTY)+ " Steel Ore in the Smelting Forge.");
      return;
    }
    else if (nSteel == nSteelQTY)
    {
      //Now we Destroy the Required Number of Items in Inventory
      int nCount = nSteel;
      object oDestroy = GetFirstItemInInventory(oForge);
      while(GetIsObjectValid(oDestroy))
      {
        if (GetTag(oDestroy) == sSOre)
        {
          DestroyObject(oDestroy);
          oDestroy = GetNextItemInInventory(oForge);
        }
        else oDestroy = GetNextItemInInventory(oForge);
      }

      //Now Give the Correct Text and Item
      if(nSkill >= nSteelDC)
      {
        SendMessageToPC(oPC,"Nice work. you have made a bar of Steel from the Ore");
        CreateItemOnObject("x2_it_cmat_steel", oForge);
      }
      else
      {
        SendMessageToPC(oPC,"Well, try again. No Steel could be extracted from the Ore.");
      }
    }

    //Now we Smelt the Iron Ore into a Bar
    if(nIron > 0 && nIron < nIronQTY)
    {
      SendMessageToPC(oPC,"1 bar of Iron requires " +IntToString(nIronQTY)+ " Iron Ore in the Smelting Forge.");
      return;
    }
    else if (nIron == nIronQTY)
    {
      //Now we Destroy the Required Number of Items in Inventory
      int nCount = nIron;
      object oDestroy = GetFirstItemInInventory(oForge);
      while(GetIsObjectValid(oDestroy))
      {
        if (GetTag(oDestroy) == sIOre)
        {
          DestroyObject(oDestroy);
          oDestroy = GetNextItemInInventory(oForge);
        }
        else oDestroy = GetNextItemInInventory(oForge);
      }

      //Now Give the Correct Text and Item
      if(nSkill >= nIronDC)
      {
        SendMessageToPC(oPC,"Nice work. you have made a bar of Iron from the Ore");
        CreateItemOnObject("x2_it_cmat_iron", oForge);
      }
      else
      {
        SendMessageToPC(oPC,"Well, try again. No Iron could be extracted from the Ore.");
      }
    }

    //Now we Smelt the Silver Ore into a Bar
    if(nSilver > 0 && nSilver < nSilQTY)
    {
      SendMessageToPC(oPC,"1 bar of Silver requires " +IntToString(nMithQTY)+ " Silver Ore in the Smelting Forge.");
      return;
    }
    else if (nSilver == nSilQTY)
    {
      //Now we Destroy the Required Number of Items in Inventory
      int nCount = nSilver;
      object oDestroy = GetFirstItemInInventory(oForge);
      while(GetIsObjectValid(oDestroy))
      {
        if (GetTag(oDestroy) == sMOre)
        {
          DestroyObject(oDestroy);
          oDestroy = GetNextItemInInventory(oForge);
        }
        else oDestroy = GetNextItemInInventory(oForge);
      }

      //Now Give the Correct Text and Item
      if(nSkill >= nSilDC)
      {
        SendMessageToPC(oPC,"Nice work. you have made a bar of Silver from the Ore");
        CreateItemOnObject("x2_it_cmat_silv", oForge);
      }
      else
      {
        SendMessageToPC(oPC,"Well, try again. No Silver could be extracted from the Ore.");
      }
    }

    //Lock for 1 Round
    SetLocked(oForge,TRUE);
    DelayCommand(6.0,AssignCommand(oForge,SetLocked(oForge,FALSE)));
    SendMessageToPC(oPC,"The Smelting Forge will be locked for 1 Round while processing.");
}
