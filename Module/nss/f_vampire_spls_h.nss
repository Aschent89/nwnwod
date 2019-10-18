#include "f_vampire_defs"

//new constants for the epic abilities
const int FALLEN_VAMPIRE_EPIC_IMP_THRALL     = 0x00000001;
const int FALLEN_VAMPIRE_EPIC_UNH_THRALL     = 0x00000003;
const int FALLEN_VAMPIRE_EPIC_IMP_UNH_THRALL = 0x00000007;
const int FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT = 0x00000008;
const int FALLEN_VAMPIRE_EPIC_KIN_DAMNED     = 0x00000018;
const int FALLEN_VAMPIRE_EPIC_TWIN_ABYSS     = 0x00000038;
const int FALLEN_VAMPIRE_EPIC_SUNPROOF       = 0x00000040;
const int FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND  = 0x00000080;
const int FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND2 = 0x00000180;
const int FALLEN_VAMPIRE_EPIC_HOLY_VAMPIRE   = 0x00000200;
const int FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER = 0x00000400;
const int FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2= 0x00000C00;
const int FALLEN_VAMPIRE_EPIC_REFUGE         = 0x00001000;
const int FALLEN_VAMPIRE_EPIC_TURNPROOF      = 0x00002000;

int GetHasEpicAbility(int iAbility, object oPC)
{
if((GetLocalInt(oPC, "FALLEN_VAMPIRE_EPIC_ABILITIES") & iAbility) == iAbility)
    {
    switch(iAbility)
        {
        case FALLEN_VAMPIRE_EPIC_IMP_THRALL: return UseImprovedThrall;
        case FALLEN_VAMPIRE_EPIC_UNH_THRALL: return UseUnholyThrall;
        case FALLEN_VAMPIRE_EPIC_IMP_UNH_THRALL: return UseUnholyThrallLevel2;
        case FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT: return UseChildrenOfTheNight;
        case FALLEN_VAMPIRE_EPIC_KIN_DAMNED: return UseKinOfTheDamned;
        case FALLEN_VAMPIRE_EPIC_TWIN_ABYSS: return UseTwinOfTheAbyss;
        case FALLEN_VAMPIRE_EPIC_SUNPROOF: return UseSunproof;
        case FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND: return UseBloodOfTheLand;
        case FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND2: return UseBloodOfTheLandLevel2;
        case FALLEN_VAMPIRE_EPIC_HOLY_VAMPIRE: return (UseHolyVampire && GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD);
        case FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER: return UseLookOfHunger;
        case FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2: return UseLookOfHungerLevel2;
        case FALLEN_VAMPIRE_EPIC_REFUGE: return UseRefuge;
        case FALLEN_VAMPIRE_EPIC_TURNPROOF: return UseTurnProof;
        }
    }
return FALSE;
}

int GetIsVampire(object oPC = OBJECT_SELF)
{
return (GetLocalInt(oPC, "FALLEN_SUBRACE") == 1);
}
