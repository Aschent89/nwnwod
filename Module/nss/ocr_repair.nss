////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Realistic Armor and Weapon Rules
//  ocr_repair
//  By Don Anderson
//  dandersonru@msn.com
//
//  Repair Script for the Anvil
//
//  NEW! If the Item is above 90% it CAN NOT be repaired....Idiot proofed =). Also
//  now if the Armor Rules System is off the repair function will not work.
//
//  Place this script in the Module On Equip Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
    //From Master Configuration opw_mod_onload
    int nCRAFTGLOBAL = GetLocalInt(GetModule(),"CRAFTGLOBAL");
    if(nCRAFTGLOBAL == 0) return;

    object oPC      = GetLastClosedBy();
    object oMod     = GetModule();
    object oAnvil   = OBJECT_SELF;
    string sAnvil   = GetTag(oAnvil);//This Also works on the Wood Crafting Allowed Placeable

    //Color set up for Changing Repair Text
    string sBlue    = BLUE;
    string sYellow  = YELLOW;

    //Don't bother going through the script if inventory is empty
    object oItem = GetFirstItemInInventory(oAnvil);
    if(oItem == OBJECT_INVALID) return;

    //Also don't bother with repairs if the Armor Rules are off
    int nARMORRULES = GetLocalInt(oMod,"ARMORRULES");//See cr_mod_onload
    if(nARMORRULES == 0) return;//Armor Rules is OFF

    //Now We Check the Inventory for more than 1 thing in Anvil
    int nCount = 0;
    while(GetIsObjectValid(oItem))
    {
      nCount++;
      if(nCount > 1)
      {
        SendMessageToPC(oPC,"You can not repair more than one item at a time!");
        return;
      }
      oItem = GetNextItemInInventory(oAnvil);
    }

    object oBBook   = GetItemPossessedBy(oPC,"BookofSmithing");
    int nBBook      = GetLocalInt(oBBook, "SMITHING_LVL") + GetLocalInt(oPC,"SMITHING_BONUS");

    object oWBook   = GetItemPossessedBy(oPC,"BookofWoodworking");
    int nWBook      = GetLocalInt(oWBook, "WOODWORKING_LVL") + GetLocalInt(oPC,"WOODWORKING_BONUS");

    int nCollege = 0;
    if(nBBook > nWBook) nCollege = nBBook;
    if(nWBook > nBBook) nCollege = nWBook;

    //We need to get the Skill Level of the Player
    int nArmor = GetSkillRank(SKILL_CRAFT_ARMOR, oPC);
    int nWeapon = GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
    if(nArmor > nWeapon) nCollege = nCollege + nArmor;
    if(nWeapon > nArmor) nCollege = nCollege + nWeapon;
    if(nWeapon == nArmor) nCollege = nCollege + nArmor;
    int nSkillCheck = 10 + nCollege;//Take 10 here

    oItem = GetFirstItemInInventory(oAnvil);
    int nRepairPrep = GetLocalInt(oItem,"REPAIRPREP");
    if(nRepairPrep == 0)
    {
      //We make sure that only Combat Gear is being repaired
      int nType = GetBaseItemType(oItem);
      string sItem = GetName(oItem);
      if(nType == BASE_ITEM_ARMOR
        || nType == BASE_ITEM_HELMET
        || nType == BASE_ITEM_SMALLSHIELD
        || nType == BASE_ITEM_LARGESHIELD
        || nType == BASE_ITEM_TOWERSHIELD
        || nType == BASE_ITEM_CLOAK
        || nType == BASE_ITEM_BRACER
        || nType == BASE_ITEM_BELT
        || nType == BASE_ITEM_BOOTS
        || IsMeleeWeapon(oItem)
        || IsRangedWeapon(oItem))
      {
        //Now we check to see if the Item is less than 90% Total Capacity
        //If the Item is an Armor
        if(nType == BASE_ITEM_ARMOR)
        {
          object oArmor = oItem;
          int nNewHP = GetLocalInt(oArmor,"ARMORHP");
          int nOldHP = GetLocalInt(oArmor,"ARMOROLDHP");

          if(nNewHP == 0){ nNewHP = 1; nOldHP = 1;}

          float fPercent = 100 * (IntToFloat(nOldHP)/IntToFloat(nNewHP));

          if(fPercent == 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is new and will not be repaired.");
            return;
          }
          if(fPercent >= 90.0 && fPercent < 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is almost new and will not be repaired.");
            return;
          }
        }

        //If the Item is a Helm
        if(nType == BASE_ITEM_HELMET)
        {
          object oHelm = oItem;
          int nNewHP = GetLocalInt(oHelm,"HELMHP");
          int nOldHP = GetLocalInt(oHelm,"HELMOLDHP");

          if(nNewHP == 0){ nNewHP = 1; nOldHP = 1;}

          float fPercent = 100 * (IntToFloat(nOldHP)/IntToFloat(nNewHP));

          if(fPercent == 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is new and will not be repaired.");
            return;
          }
          if(fPercent >= 90.0 && fPercent < 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is almost new and will not be repaired.");
            return;
          }
        }

        //If the Item is a Shield
        if(nType == BASE_ITEM_SMALLSHIELD
          || nType == BASE_ITEM_LARGESHIELD
          || nType == BASE_ITEM_TOWERSHIELD)
        {
          object oShield = oItem;
          int nNewHP = GetLocalInt(oShield,"SHIELDHP");
          int nOldHP = GetLocalInt(oShield,"SHIELDOLDHP");

          if(nNewHP == 0){ nNewHP = 1; nOldHP = 1;}

          float fPercent = 100 * (IntToFloat(nOldHP)/IntToFloat(nNewHP));

          if(fPercent == 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is new and will not be repaired.");
            return;
          }
          if(fPercent >= 90.0 && fPercent < 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is almost new and will not be repaired.");
            return;
          }
        }

        //If the Item is a Bracer
        if(nType == BASE_ITEM_BRACER)
        {
          object oBracer = oItem;
          int nNewHP = GetLocalInt(oBracer,"BRACERHP");
          int nOldHP = GetLocalInt(oBracer,"BRACEROLDHP");

          if(nNewHP == 0){ nNewHP = 1; nOldHP = 1;}

          float fPercent = 100 * (IntToFloat(nOldHP)/IntToFloat(nNewHP));

          if(fPercent == 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is new and will not be repaired.");
            return;
          }
          if(fPercent >= 90.0 && fPercent < 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is almost new and will not be repaired.");
            return;
          }
        }

        //If the Item is a Cloak
        if(nType == BASE_ITEM_CLOAK)
        {
          object oCloak = oItem;

          //Refresh Cloak (v1.68 Dynamic Cloak Compatibility)
          object oNCloak = CopyItem(oCloak,oAnvil,TRUE);
          SetIdentified(oNCloak,TRUE);
          DestroyObject(oCloak);


          int nNewHP = GetLocalInt(oNCloak,"CLOAKHP");
          int nOldHP = GetLocalInt(oNCloak,"CLOAKOLDHP");

          if(nNewHP == 0){ nNewHP = 1; nOldHP = 1;}

          float fPercent = 100 * (IntToFloat(nOldHP)/IntToFloat(nNewHP));

          if(fPercent == 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is new and will not be repaired.");
            return;
          }
          if(fPercent >= 90.0 && fPercent < 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is almost new and will not be repaired.");
            return;
          }
        }

        //If the Item is a Belt
        if(nType == BASE_ITEM_BELT)
        {
          object oBelt = oItem;
          int nNewHP = GetLocalInt(oBelt,"BELTHP");
          int nOldHP = GetLocalInt(oBelt,"BELTOLDHP");

          if(nNewHP == 0){ nNewHP = 1; nOldHP = 1;}

          float fPercent = 100 * (IntToFloat(nOldHP)/IntToFloat(nNewHP));

          if(fPercent == 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is new and will not be repaired.");
            return;
          }
          if(fPercent >= 90.0 && fPercent < 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is almost new and will not be repaired.");
            return;
          }
        }

        //If the Item are Boots
        if(nType == BASE_ITEM_BOOTS)
        {
          object oBoots = oItem;
          int nNewHP = GetLocalInt(oBoots,"BOOTSHP");
          int nOldHP = GetLocalInt(oBoots,"BOOTSOLDHP");

          if(nNewHP == 0){ nNewHP = 1; nOldHP = 1;}

          float fPercent = 100 * (IntToFloat(nOldHP)/IntToFloat(nNewHP));

          if(fPercent == 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is new and will not be repaired.");
            return;
          }
          if(fPercent >= 90.0 && fPercent < 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is almost new and will not be repaired.");
            return;
          }
        }

        //If the Item is a Weapon
        if(IsMeleeWeapon(oItem) || IsRangedWeapon(oItem))
        {
          object oWeapon = oItem;
          int nNewHP = GetLocalInt(oWeapon,"WEAPONHP");
          int nOldHP = GetLocalInt(oWeapon,"WEAPONOLDHP");

          if(nNewHP == 0){ nNewHP = 1; nOldHP = 1;}

          float fPercent = 100 * (IntToFloat(nOldHP)/IntToFloat(nNewHP));

          if(fPercent == 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is new and will not be repaired.");
            return;
          }
          if(fPercent >= 90.0 && fPercent < 100.0)
          {
            SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is almost new and will not be repaired.");
            return;
          }
        }

        //Now we need how much Gold is required for repair
        int nCost = GetGoldPieceValue(oItem);
        int nRepairCost = (nCost * 1)/100;

        //Check the Max DC the Player can Repair
        string sMaxValue = Get2DAString("SkillVsItemCost", "DeviceCostMax", nSkillCheck);
        int nMaxValue = StringToInt(sMaxValue);

        if(sMaxValue == "") nMaxValue = 120000000;
        if(nSkillCheck < 1) return;

        int nPCGP = GetGold(oPC);
        if(nRepairCost > nPCGP)
        {
          SendMessageToPC(oPC,sBlue + "You can not afford to repair this!");
          SendMessageToPC(oPC,sBlue + "This repair will cost: "+ sYellow +IntToString(nRepairCost)+"GP");
          return;
        }

        if(nCost > nMaxValue)
        {
          SendMessageToPC(oPC,sBlue + "You do not have the skill to repair this!");
          SendMessageToPC(oPC,sBlue + "The maximum value you may repair is: "+ sYellow +IntToString(nMaxValue)+"GP");
          return;
        }

        if(nMaxValue >= nCost)
        {
          SetLocalInt(oItem,"REPAIRPREP",1);
          SendMessageToPC(oPC,sBlue + "Your repair will cost: "+ sYellow +IntToString(nRepairCost)+"GP");
          SendMessageToPC(oPC,sBlue + "Your " +sItem+ " is ready and prepared for repairing! Just Open ME and close me again to repair the gear!");
        }
      }
    }
    //Prepared and Ready
    if(nRepairPrep == 1)
    {
      //Now We Check the Inventory for more than 1 thing in Anvil
      int nCount = 0;
      object oItem = GetFirstItemInInventory(oAnvil);
      while(GetIsObjectValid(oItem))
      {
        nCount++;
        if(nCount > 1)
        {
          SendMessageToPC(oPC,"You can not repair more than one item at a time!");
          return;
        }
        oItem = GetNextItemInInventory(oAnvil);
      }

      //Now we need how much Gold is required for repair
      oItem = GetFirstItemInInventory(oAnvil);
      string sItem = GetName(oItem);
      int nCost = GetGoldPieceValue(oItem);
      int nRepairCost = (nCost * 1)/100;

      //Check the Max DC the Player can Repair
      string sMaxValue = Get2DAString("SkillVsItemCost", "DeviceCostMax", nSkillCheck);
      int nMaxValue = StringToInt(sMaxValue);

      if(sMaxValue == "") nMaxValue = 120000000;
      if(nSkillCheck < 1) return;

      int nPCGP = GetGold(oPC);
      if(nRepairCost > nPCGP)
      {
        SendMessageToPC(oPC,sBlue + "You can not afford to repair this!");
        SendMessageToPC(oPC,sBlue + "This repair will cost: "+ sYellow +IntToString(nRepairCost)+"GP");
        return;
      }

      if(nCost > nMaxValue)
      {
        SendMessageToPC(oPC,sBlue + "You do not have the skill to repair this!");
        SendMessageToPC(oPC,sBlue + "The maximum value you may repair is: "+ sYellow +IntToString(nMaxValue)+"GP");
        return;
      }

      if(nMaxValue >= nCost && nPCGP > nRepairCost)
      {
        SetLocalInt(oItem,"REPAIRPREP",0);

        //Repair Armor
        if(GetLocalInt(oItem,"ARMORNEW") == 1)
        {
          int nItem = GetLocalInt(oItem,"ARMORHP");
          SetLocalInt(oItem,"ARMOROLDHP",nItem);
        }
        //Repair Shield
        if(GetLocalInt(oItem,"SHIELDNEW") == 1)
        {
          int nItem = GetLocalInt(oItem,"SHIELDHP");
          SetLocalInt(oItem,"SHIELDOLDHP",nItem);
        }
        //Set Helm as New
        if(GetLocalInt(oItem,"HELMNEW") == 1)
        {
          int nItem = GetLocalInt(oItem,"HELMHP");
          SetLocalInt(oItem,"HELMOLDHP",nItem);
        }
        //Set Cloak as New
        if(GetLocalInt(oItem,"CLOAKNEW") == 1)
        {
          int nItem = GetLocalInt(oItem,"CLOAKHP");
          SetLocalInt(oItem,"CLOAKOLDHP",nItem);
        }
        //Set Bracer as New
        if(GetLocalInt(oItem,"BRACERNEW") == 1)
        {
          int nItem = GetLocalInt(oItem,"BRACERHP");
          SetLocalInt(oItem,"BRACEROLDHP",nItem);
        }
        //Set Belt as New
        if(GetLocalInt(oItem,"BELTNEW") == 1)
        {
          int nItem = GetLocalInt(oItem,"BELTHP");
          SetLocalInt(oItem,"BELTOLDHP",nItem);
        }
        //Set Boots as New
        if(GetLocalInt(oItem,"BOOTSNEW") == 1)
        {
          int nItem = GetLocalInt(oItem,"BOOTSHP");
          SetLocalInt(oItem,"BOOTSOLDHP",nItem);
        }
        //Repair Weapon
        if(GetLocalInt(oItem,"WEAPONNEW") == 1)
        {
          int nItem = GetLocalInt(oItem,"WEAPONHP");
          SetLocalInt(oItem,"WEAPONOLDHP",nItem);

          int nKeen = GetLocalInt(oItem,"WEAPONKEEN");
          if(nKeen == 1)
          {
            IPSafeAddItemProperty(oItem, ItemPropertyKeen(), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
          }
          DeleteLocalInt(oItem,"WEAPONKEEN");
        }

        //Now Play Some Effects
        location lLoc = GetLocation(oAnvil);
        effect eFX1 = EffectVisualEffect(VFX_IMP_BREACH);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX1, lLoc);

        //Take the Gold
        TakeGoldFromCreature(nRepairCost,oPC,TRUE);

        SendMessageToPC(oPC,sBlue + "Your " +sItem+ " has been repaired!");
      }
    }
}
