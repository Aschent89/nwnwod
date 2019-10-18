#include "toy_source"
int StartingConditional()
{
    object oMaster = GetPCSpeaker();
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");

    if (!COLLAR_UNEQUIPABLE) return FALSE;
    if (!GetLocalInt(oSlave, "MR_COLLAR_OFF")) return TRUE;
    return FALSE;


}
