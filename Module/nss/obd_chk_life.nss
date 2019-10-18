////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_chk_life
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSoulRune = GetItemPossessedBy(oPC, "SoulRune");
    if(GetIsObjectValid(oSoulRune)) return TRUE;
    else return FALSE;
}
