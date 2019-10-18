////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_wp_mid
//  By Don Anderson
//  dandersonru@msn.com
//
//  Remake Weapon - Set Weapon Middle
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
  object oPC = GetPCSpeaker();
  SetLocalInt(oPC, "CR_PART", ITEM_APPR_WEAPON_MODEL_MIDDLE);
}
