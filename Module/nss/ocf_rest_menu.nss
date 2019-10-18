////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_rest_menu
//  By Don Anderson
//  dandersonru@msn.com
//
//  Used in Rest Menu Conversation
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nRAllow = GetLocalInt(oPC,"REST_ALLOWED");

    if(nRAllow == TRUE) return TRUE;
    else return FALSE;
}
