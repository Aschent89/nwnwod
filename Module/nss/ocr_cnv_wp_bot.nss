////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_wp_bot
//  By Don Anderson
//  dandersonru@msn.com
//
//  Remake Weapon - Set Weapon Bottom
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
  object oPC = GetPCSpeaker();
  SetLocalInt(oPC, "CR_PART", ITEM_APPR_WEAPON_MODEL_BOTTOM);
}
