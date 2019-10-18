////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_chk_disabled
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////

int StartingConditional()
{
    object oMod = GetModule();

    // Check to see if Binding Stones is Enabled
    if(GetLocalInt(oMod, "BS_ENABLE") == 0) return TRUE;
    else return FALSE;
}
