////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_chk_herb
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC      = GetPCSpeaker();
    object oHBook   = GetItemPossessedBy(oPC,"BookofHerbology");
    int nHLevel     = GetLocalInt(oHBook,"HERBOLOGY_LVL");

    if(nHLevel > 0) return TRUE;
    else return FALSE;
}
