int StartingConditional()
{
    object oDom = GetPCSpeaker();
    object oSlave = GetLocalObject(oDom, "MR_COLLAR_SLAVE");

    if (!GetLocalInt(oSlave, "COLLAR_NO_WEAPONS")) return TRUE;
    return FALSE;
}
