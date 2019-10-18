#include "f_vampire_spls_h"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult = GetIsVampire(oPC);
    object oTemp = GetAreaFromLocation(GetLocalLocation(oPC, "FALLEN_VAMPIRE_MARK"));
    SetCustomToken(666, GetName(oTemp));
    oTemp = GetLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN");
    if(GetIsObjectValid(oTemp)) SetCustomToken(667, GetName(GetArea(oTemp)));
    return iResult;
}
