////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Gear Status
//  ocr_conv_gear
//  by Don Anderson
//
//  Called from Rest Menu to receive Gear Status
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    //Color set up for Changing Repair Text
    string sColor   = GetName(GetObjectByTag("COLORS"));
    string sBlue    = GetSubString(sColor, 36, 6);
    string sYellow  = GetSubString(sColor, 6, 6);

    int nType;

    //Check Equipped Gear
    object oArmor  = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    object oLHand  = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    object oHelm   = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    object oCloak  = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
    object oArms   = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    object oBelt   = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
    object oBoots  = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
    object oBracer; object oGloves; object oShield;

    //Check Armor
    nType = GetBaseItemType(oArmor);
    if(nType == BASE_ITEM_ARMOR)
    {
      int nNewHP = GetLocalInt(oArmor,"ARMORHP");
      int nOldHP = GetLocalInt(oArmor,"ARMOROLDHP");
      int nArmorType = GetLocalInt(oArmor,"ARMORTYPE");

      if(nArmorType == 0 && nNewHP == 1)
      {
        SendMessageToPC(oPC,sBlue + "Your Clothing is in good condition.");
      }
      else
      {
        SendMessageToPC(oPC,sBlue + "Your New Armor's HP: " + sYellow + IntToString(nNewHP));
        SendMessageToPC(oPC,sBlue + "Your Current Armor's HP: " + sYellow + IntToString(nOldHP));
      }
    }

    //Check Helm
    nType = GetBaseItemType(oHelm);
    if(nType == BASE_ITEM_HELMET)
    {
      int nNewHP = GetLocalInt(oHelm,"HELMHP");
      int nOldHP = GetLocalInt(oHelm,"HELMOLDHP");

      SendMessageToPC(oPC,sBlue + "Your New Helm's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Current Helm's HP: " + sYellow + IntToString(nOldHP));
    }

    //Check Cloak
    nType = GetBaseItemType(oCloak);
    if(nType == BASE_ITEM_CLOAK)
    {
      int nNewHP = GetLocalInt(oCloak,"CLOAKHP");
      int nOldHP = GetLocalInt(oCloak,"CLOAKOLDHP");

      SendMessageToPC(oPC,sBlue + "Your New Cloak's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Current Cloak's HP: " + sYellow + IntToString(nOldHP));
    }

    //Check Belt
    nType = GetBaseItemType(oBelt);
    if(nType == BASE_ITEM_BELT)
    {
      int nNewHP = GetLocalInt(oBelt,"BELTHP");
      int nOldHP = GetLocalInt(oBelt,"BELTOLDHP");

      SendMessageToPC(oPC,sBlue + "Your New Belt's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Current Belt's HP: " + sYellow + IntToString(nOldHP));
    }

    //Check Gloves
    nType = GetBaseItemType(oArms);
    if(nType == BASE_ITEM_GLOVES)
    {
      int nNewHP = GetLocalInt(oArms,"WEAPONHP");
      int nOldHP = GetLocalInt(oArms,"WEAPONOLDHP");

      SendMessageToPC(oPC,sBlue + "Your New Glove's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Current Glove's HP: " + sYellow + IntToString(nOldHP));
    }

    //Check Bracers
    nType = GetBaseItemType(oArms);
    if(nType == BASE_ITEM_BRACER)
    {
      int nNewHP = GetLocalInt(oArms,"BRACERSHP");
      int nOldHP = GetLocalInt(oArms,"BRACERSOLDHP");

      SendMessageToPC(oPC,sBlue + "Your New Bracer's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Current Bracer's HP: " + sYellow + IntToString(nOldHP));
    }

    //Check Boots
    nType = GetBaseItemType(oBoots);
    if(nType == BASE_ITEM_BOOTS)
    {
      int nNewHP = GetLocalInt(oBoots,"BOOTSHP");
      int nOldHP = GetLocalInt(oBoots,"BOOTSOLDHP");

      SendMessageToPC(oPC,sBlue + "Your New Boots's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Current Boots's HP: " + sYellow + IntToString(nOldHP));
    }

    //Check Shield
    nType = GetBaseItemType(oLHand);
    if(nType == BASE_ITEM_SMALLSHIELD
      || nType == BASE_ITEM_LARGESHIELD
      || nType == BASE_ITEM_TOWERSHIELD)
    {
      int nNewHP = GetLocalInt(oLHand,"SHIELDHP");
      int nOldHP = GetLocalInt(oLHand,"SHIELDOLDHP");

      SendMessageToPC(oPC,sBlue + "Your New Shield's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Current Shield's HP: " + sYellow + IntToString(nOldHP));
    }

    //Check Weapon and Off Hand Weapon
    int nWType = GetLocalInt(oWeapon,"WEAPONTYPE");
    int nLType = GetLocalInt(oLHand,"WEAPONTYPE");
    if(nWType > 0)
    {
      int nNewHP = GetLocalInt(oWeapon,"WEAPONHP");
      int nOldHP = GetLocalInt(oWeapon,"WEAPONOLDHP");

      SendMessageToPC(oPC,sBlue + "Your New Weapon's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Current Weapon's HP: " + sYellow + IntToString(nOldHP));
    }
    if(nLType > 0)
    {
      int nNewHP = GetLocalInt(oLHand,"WEAPONHP");
      int nOldHP = GetLocalInt(oLHand,"WEAPONOLDHP");

      SendMessageToPC(oPC,sBlue + "Your Off Hand New Weapon's HP: " + sYellow + IntToString(nNewHP));
      SendMessageToPC(oPC,sBlue + "Your Off Hand Current Weapon's HP: " + sYellow + IntToString(nOldHP));
    }
}
