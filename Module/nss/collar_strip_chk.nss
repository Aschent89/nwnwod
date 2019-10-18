int StartingConditional()
{
    object oMaster = GetPCSpeaker();
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");
    object oClothing = GetItemInSlot(INVENTORY_SLOT_CHEST, oSlave);

    if (GetIsObjectValid(oClothing)) return TRUE;
    return FALSE;

}
