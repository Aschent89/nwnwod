////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Check Keen Weapon in Right Hand
//  ocr_chk_keen
//  by Don Anderson
//  dandersonru@msn.com
//
//  Used in Crafting Conversation to Add Mass Criticals to a Weapon
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

int StartingConditional()
{
    object oPC      = GetPCSpeaker();
    object oMod     = GetModule();

    object oWeapon  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    if(GetIsKeen(oWeapon) || IsRangedWeapon(oWeapon)) return TRUE;
    else return FALSE;
}
