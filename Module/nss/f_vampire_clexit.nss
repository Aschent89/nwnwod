#include "f_vampire_defs"
#include "f_vampire_spls_h"
#include "f_vampire_persis"

void Vampire_Client_Exit(object oPC)
{
object oCoffin = GetLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN");
location lL;
if(GetIsVampire(oPC) && GetLocalInt(oPC, "FALLEN_VAMPIRE_COFFIN_VALID") && GetIsObjectValid(oCoffin))
    {
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_GARLIC", GetLocalInt(oCoffin, "FALLEN_VAMPIRE_GARLIC"));
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_HWATER", GetLocalInt(oCoffin, "FALLEN_VAMPIRE_HOLYWATER"));
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_ROSE", GetLocalInt(oCoffin, "FALLEN_VAMPIRE_ROSEWARD"));
    if(WhatToDoWithTheCoffin < 4 || WhatToDoWithTheCoffin > 5) DestroyObject(oCoffin);
      else
        {
        DeleteLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN");
        DeleteLocalObject(oCoffin, "FALLEN_VAMPIRE_COFFIN");
        }
    }
}
