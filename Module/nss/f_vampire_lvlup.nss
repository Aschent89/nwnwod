#include "f_vampire_h"

void VampireLevelUp(object oPC, int ModuleLevelUpCall = FALSE)
{
int iVLevel = GetLocalInt(oPC, "FALLEN_VAMPIRE_LEVEL");
if(iVLevel < VampireStartLevel || !GetIsVampire(oPC)) return;
iVLevel++;
if(UseCharacterLevel) Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_LEVEL", GetHitDice(oPC));
else if (!ModuleLevelUpCall) Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_LEVEL", iVLevel);
Vampire_Apply_Stats(oPC);
Vampire_Equipment_Creation(oPC);
//check to give the epic book...
if(iVLevel == 41 || iVLevel == 41 || iVLevel == 41 || iVLevel == 41 || iVLevel == 41)
    {
    CreateItemOnObject("bookofepicvampir", oPC);
    FloatingTextStringOnCreature("A book of elder vampire advancement has been added to your inventory.", oPC, FALSE);
    }
}
