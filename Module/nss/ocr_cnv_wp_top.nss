////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_wp_top
//  By Don Anderson
//  dandersonru@msn.com
//
//  Remake Weapon - Set Weapon Top
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
  object oPC = GetPCSpeaker();
  SetLocalInt(oPC, "CR_PART", ITEM_APPR_WEAPON_MODEL_TOP);
}
