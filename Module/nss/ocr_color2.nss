////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Crafting
//  ocr_color2
//  By Don Anderson
//
//  Called from Appearance Mirror Conversation
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "ColorToDye", 2);
    ColorItem(oPC);
}