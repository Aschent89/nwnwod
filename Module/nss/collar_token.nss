#include "toy_source"
int StartingConditional()
{

    object oPC = GetPCSpeaker();
    object oDom = GetLocalObject(oPC, "MR_TOY_OWNER");
    string sName = GetName(oDom);
    SetCustomToken(9984, sName);
    return TRUE;



}
