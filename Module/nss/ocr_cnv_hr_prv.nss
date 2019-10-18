////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_hr_prv
//  By Don Anderson
//  dandersonru@msn.com
//
//  Color PC Hair - Previous Mode
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
  object oPC = GetPCSpeaker();
  ColorPC(oPC,1,COLOR_CHANNEL_HAIR);
}
