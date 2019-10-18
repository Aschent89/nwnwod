////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Licensing On
//  ocr_chk_onlicen
//  by Don Anderson
//  dandersonru@msn.com
//
//  Used in Registrar Conversation to check to see if Licensing is Required
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC      = GetPCSpeaker();
    object oMod     = GetModule();
    int nLicense    = GetLocalInt(oMod,"CRAFTINGLICENSE");

    if(nLicense == 1) return TRUE;
    else return FALSE;
}
