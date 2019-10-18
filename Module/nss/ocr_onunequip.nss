////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Realistic Armor and Weapon Rules
//  ocr_onunequip
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Module OnUnequip Event
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_spells"
#include "ocr_include"

void main()
{
    object oPC      = GetPCItemLastUnequippedBy();
    object oMod     = GetModule();

    //From Master Configuration ors_mod_onload
    int nCRAFTGLOBAL = GetLocalInt(oMod,"CRAFTGLOBAL");
    if(nCRAFTGLOBAL == 0) return;

    object oItem    = GetPCItemLastUnequipped();
    int nType       = GetBaseItemType(oItem);
    effect eBad;

    //Don't go further if this is a DM
    if(GetIsDM(oPC) || GetIsDMPossessed(oPC) == TRUE) return;
    if(GetIsPC(oPC) == FALSE) return;

    int nARMORRULES = GetLocalInt(oMod,"ARMORRULES");//See ors_mod_onload

    if(GetLocalInt(oPC, "CRAFTING_CONVO") == 1) return;//Kicks out if Crafting
    if(nARMORRULES == 0) return;//Armor Rules is OFF

    //Removes the Armor Speed Decrease and Sets as Unequipped
    if(nType == BASE_ITEM_ARMOR)
    {
      RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oPC);

      //Racial Movement Rates
      int nRacial = GetLocalInt(oMod,"RACIALMOVE");
      if(nRacial == 1)
      {
        SetLocalInt(oPC, "RACIAL_MOVEMENT", 0);
        SetRacialMovementRate(oPC);
      }

      SetLocalInt(oItem,"ARMOREQUIP",0);
    }

    //Now we check and set the Shield Status
    if(nType == BASE_ITEM_SMALLSHIELD
      || nType == BASE_ITEM_LARGESHIELD
      || nType == BASE_ITEM_TOWERSHIELD)
    {
      SetLocalInt(oItem,"SHIELDEQUIP",0);
    }

    //Now we check and set the Helm Status
    if(nType == BASE_ITEM_HELMET)
    {
      SetLocalInt(oItem,"HELMEQUIP",0);
    }

    //Now we check and set the Cloak Status
    if(nType == BASE_ITEM_CLOAK)
    {
      SetLocalInt(oItem,"CLOAKEQUIP",0);
    }

    //Now we check and set the Bracer Status
    if(nType == BASE_ITEM_BRACER)
    {
      SetLocalInt(oItem,"BRACEREQUIP",0);
    }

    //Now we check and set the Belt Status
    if(nType == BASE_ITEM_BELT)
    {
      SetLocalInt(oItem,"BELTEQUIP",0);
    }

    //Now we check and set the Boots Status
    if(nType == BASE_ITEM_BOOTS)
    {
      SetLocalInt(oItem,"BOOTSEQUIP",0);
    }

    //Now we check and set the Weapon Status
    if(IsMeleeWeapon(oItem) || IsRangedWeapon(oItem))
    {
      SetLocalInt(oItem,"WEAPONEQUIP",0);
    }

}
