#include "f_vampire_h"

void VampireItemDrop()
{
object oDrop = GetModuleItemLost();
object oPC = GetModuleItemLostBy();
string sS = GetTag(oDrop);
if(sS == "FALLEN_VAMPIRE_COFFIN")
    {
    location lL = GetLocation(oDrop);
    DestroyObject(oDrop);
    object oO = CreateObject(OBJECT_TYPE_PLACEABLE, "vampirecoffin", lL);
    SetLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN", oO);
    SetLocalObject(oO, "FALLEN_VAMPIRE_COFFIN", oPC);
    Vampire_Set_Location(oPC, "FALLEN_VAMPIRE_COFFIN_LOC", lL);
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_COFFIN_VALID", TRUE);
    }
}


