////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_chk_jdis
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////

int StartingConditional()
{
    object oMod = GetModule();

    // Check to see if Binding Stone Jump to Leader is Enabled
    if(GetLocalInt(oMod, "BSJUMP") == 1) return TRUE;
    else return FALSE;
}
