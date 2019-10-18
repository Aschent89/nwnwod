int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nWalk = GetLocalInt(oPC, "MR_WALKING");

    if (nWalk) return TRUE;
    return FALSE;

}
