////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Realistic Armor and Weapon Rules
//  ocr_cleaner
//  By Don Anderson
//  dandersonru@msn.com
//
//  Cleaner Script for when the Item is new but strange things with the item
//  values in the item make it unequip straight away.
//
//  This is called from cr_onequip
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
    object oItem = OBJECT_SELF;
    int nType = GetBaseItemType(oItem);

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

    if(nType == BASE_ITEM_HELMET)
    {
      DeleteLocalInt(oItem,"HELMHP");
      DeleteLocalInt(oItem,"HELMOLDHP");
      DeleteLocalInt(oItem,"HELMTYPE");
      DeleteLocalInt(oItem,"HELMNEW");
      DeleteLocalInt(oItem,"HELMEQUIP");
      DeleteLocalInt(oItem,"HELMDAMAGE");
      DeleteLocalInt(oItem,"HELMDESTROY");
    }

    if(IsMeleeWeapon(oItem) || IsRangedWeapon(oItem))
    {
      DeleteLocalInt(oItem,"WEAPONHP");
      DeleteLocalInt(oItem,"WEAPONOLDHP");
      DeleteLocalInt(oItem,"WEAPONTYPE");
      DeleteLocalInt(oItem,"WEAPONNEW");
      DeleteLocalInt(oItem,"WEAPONEQUIP");
      DeleteLocalInt(oItem,"WEAPONDAMAGE");
      DeleteLocalInt(oItem,"WEAPONDESTROY");
    }

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
}
