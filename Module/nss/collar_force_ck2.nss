int StartingConditional()
{
    object oMaster = GetPCSpeaker();
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");

    if (GetLocalInt(oSlave, "MR_COLLAR_FROZEN")) return TRUE;
    return FALSE;


}
