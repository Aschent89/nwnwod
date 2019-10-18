////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Education/Crafting System - Defaults File
//  ocr_dm_plc_grst
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Placeable On Closed Event
//
//  This Tool will reset all the Wear and Tear variables on all equiped gear
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
    object oPC = GetLastClosedBy();
    string sPCName = GetName(oPC);

    object oTool = OBJECT_SELF;

    //Don't bother going through the script if inventory is empty
    object oItem = GetFirstItemInInventory(oTool);
    if(oItem == OBJECT_INVALID) return;

    //Now we start resetting each item found in the inventory
    int nCount = 0;
    while(GetIsObjectValid(oItem))
    {
      int nType = GetBaseItemType(oItem);

      //Check the Armor
      if(nType == BASE_ITEM_ARMOR)
      {
        DeleteLocalInt(oItem,"ARMORHP");
        DeleteLocalInt(oItem,"ARMOROLDHP");
        DeleteLocalInt(oItem,"ARMORTYPE");
        DeleteLocalInt(oItem,"ARMORNEW");
        DeleteLocalInt(oItem,"ARMOREQUIP");
        DeleteLocalInt(oItem,"ARMORDAMAGE");
        DeleteLocalInt(oItem,"ARMORDESTROY");
      }

      //Check the Main Weapon
      int nMelee = IsMeleeWeapon(oItem);
      int nRanged = IsRangedWeapon(oItem);
      if(nMelee == TRUE || nRanged == TRUE)
      {
        DeleteLocalInt(oItem,"WEAPONHP");
        DeleteLocalInt(oItem,"WEAPONOLDHP");
        DeleteLocalInt(oItem,"WEAPONTYPE");
        DeleteLocalInt(oItem,"WEAPONNEW");
        DeleteLocalInt(oItem,"WEAPONEQUIP");
        DeleteLocalInt(oItem,"WEAPONDAMAGE");
        DeleteLocalInt(oItem,"WEAPONDESTROY");
      }

      //Check the Shield
      if(nType == BASE_ITEM_SMALLSHIELD
          || nType == BASE_ITEM_LARGESHIELD
          || nType == BASE_ITEM_TOWERSHIELD)
      {
        DeleteLocalInt(oItem,"SHIELDHP");
        DeleteLocalInt(oItem,"SHIELDOLDHP");
        DeleteLocalInt(oItem,"SHIELDTYPE");
        DeleteLocalInt(oItem,"SHIELDNEW");
        DeleteLocalInt(oItem,"SHIELDEQUIP");
        DeleteLocalInt(oItem,"SHIELDDAMAGE");
        DeleteLocalInt(oItem,"SHIELDDESTROY");
      }

      //Check the Helm
      if(nType == BASE_ITEM_HELMET)
      {
        DeleteLocalInt(oItem,"HELMHP");
        DeleteLocalInt(oItem,"HELMOLDHP");
        DeleteLocalInt(oItem,"HELMTYPE");
        DeleteLocalInt(oItem,"HELMNEW");
        DeleteLocalInt(oItem,"HELMEQUIP");
        DeleteLocalInt(oItem,"HELMDAMAGE");
        DeleteLocalInt(oItem,"HELMDESTROY");
        AssignCommand(oPC,ActionUnequipItem(oItem));
      }

      //Check the Cloak
      if(nType == BASE_ITEM_CLOAK)
      {
        DeleteLocalInt(oItem,"CLOAKHP");
        DeleteLocalInt(oItem,"CLOAKOLDHP");
        DeleteLocalInt(oItem,"CLOAKTYPE");
        DeleteLocalInt(oItem,"CLOAKNEW");
        DeleteLocalInt(oItem,"CLOAKEQUIP");
        DeleteLocalInt(oItem,"CLOAKDAMAGE");
        DeleteLocalInt(oItem,"CLOAKDESTROY");
      }

      //Check the Gloves
      if(nType == BASE_ITEM_GLOVES)
      {
        DeleteLocalInt(oItem,"WEAPONHP");
        DeleteLocalInt(oItem,"WEAPONOLDHP");
        DeleteLocalInt(oItem,"WEAPONTYPE");
        DeleteLocalInt(oItem,"WEAPONNEW");
        DeleteLocalInt(oItem,"WEAPONEQUIP");
        DeleteLocalInt(oItem,"WEAPONDAMAGE");
        DeleteLocalInt(oItem,"WEAPONDESTROY");
      }

      //Check the Bracer
      if(nType == BASE_ITEM_BRACER)
      {
        DeleteLocalInt(oItem,"BRACERHP");
        DeleteLocalInt(oItem,"BRACEROLDHP");
        DeleteLocalInt(oItem,"BRACERTYPE");
        DeleteLocalInt(oItem,"BRACERNEW");
        DeleteLocalInt(oItem,"BRACEREQUIP");
        DeleteLocalInt(oItem,"BRACERDAMAGE");
        DeleteLocalInt(oItem,"BRACERDESTROY");
      }

      //Check the Belt
      if(nType == BASE_ITEM_BELT)
      {
        DeleteLocalInt(oItem,"BELTHP");
        DeleteLocalInt(oItem,"BELTOLDHP");
        DeleteLocalInt(oItem,"BELTTYPE");
        DeleteLocalInt(oItem,"BELTNEW");
        DeleteLocalInt(oItem,"BELTEQUIP");
        DeleteLocalInt(oItem,"BELTDAMAGE");
        DeleteLocalInt(oItem,"BELTDESTROY");
      }

      //Check the Boots
      if(nType == BASE_ITEM_BOOTS)
      {
        DeleteLocalInt(oItem,"BOOTSHP");
        DeleteLocalInt(oItem,"BOOTSOLDHP");
        DeleteLocalInt(oItem,"BOOTSTYPE");
        DeleteLocalInt(oItem,"BOOTSNEW");
        DeleteLocalInt(oItem,"BOOTSEQUIP");
        DeleteLocalInt(oItem,"BOOTSDAMAGE");
        DeleteLocalInt(oItem,"BOOTSDESTROY");
      }
      nCount++;
      if(nCount > 30) break;
      oItem = GetNextItemInInventory(oTool);
    }

    //Now Play Some Effects
    location lLoc = GetLocation(oTool);
    effect eFX1 = EffectVisualEffect(VFX_IMP_BREACH);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX1, lLoc);
    SendMessageToPC(oPC,"Your Gear has been Reset.");
    SendMessageToAllDMs(sPCName + "'s Gear has been Reset.");
}
