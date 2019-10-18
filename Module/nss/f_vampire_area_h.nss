#include "f_vampire_spls_h"

void Vampire_Enter(object oPC = OBJECT_SELF, int bOutdoors = FALSE)
{  //for some reason regular aura's disapear when you enter an area =/
if(GetIsVampire(oPC))
    {
    SetLocalInt(oPC, "FALLEN_VAMPIRE_OUTDOORS", bOutdoors);
    if(GetLocalInt(oPC, "FALLEN_VAMPIRE_MIST")) ExecuteScript("f_vampiremist7", oPC);
    else if (!GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_BAT")) ExecuteScript("f_vampire_oearea", oPC);
    if(bOutdoors) ExecuteScript("f_vampire_sun", oPC);
    }
}

