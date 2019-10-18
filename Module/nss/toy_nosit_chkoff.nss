#include "bdsm_controls"
int StartingConditional()
{
    object oDom = GetPCSpeaker();
    object oSlave = GetLocalObject(oDom, "MR_COLLAR_SLAVE");

    if (!COLLAR_NO_SIT_ON) return FALSE;
    if (!GetLocalInt(oSlave, "COLLAR_NO_SIT")) return TRUE;
    return FALSE;
}
