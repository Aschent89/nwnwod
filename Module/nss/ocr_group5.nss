////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Crafting
//  ocr_group5
//  By Don Anderson
//
//  Called from Appearance Mirror Conversation
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "ColorGroup", 5);
}