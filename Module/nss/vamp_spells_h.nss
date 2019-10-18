#include "vamp_define_h"

//new constants for the epic abilities
/*const int FALLEN_VAMPIRE_EPIC_IMP_THRALL     = 0x00000001;
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
const int FALLEN_VAMPIRE_EPIC_TURNPROOF      = 0x00002000;*/

const int FALLEN_VAMPIRE_EPIC_IMP_THRALL     = 1;
const int FALLEN_VAMPIRE_EPIC_UNH_THRALL     = 2;
const int FALLEN_VAMPIRE_EPIC_IMP_UNH_THRALL = 4;
const int FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT = 8;
const int FALLEN_VAMPIRE_EPIC_KIN_DAMNED     = 16;
const int FALLEN_VAMPIRE_EPIC_TWIN_ABYSS     = 32;
const int FALLEN_VAMPIRE_EPIC_SUNPROOF       = 64;
const int FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND  = 128;
const int FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND2 = 256;
const int FALLEN_VAMPIRE_EPIC_HOLY_VAMPIRE   = 512;
const int FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER = 1024;
const int FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2= 2048;
const int FALLEN_VAMPIRE_EPIC_REFUGE         = 4096;
const int FALLEN_VAMPIRE_EPIC_TURNPROOF      = 8192;

// Sitrius - New Epic Abilities.
const int FALLEN_VAMPIRE_EPIC_AUSPEX1       =  65536;
const int FALLEN_VAMPIRE_EPIC_AUSPEX2       =  131072;
const int FALLEN_VAMPIRE_EPIC_CELERITY      =  262144;
const int FALLEN_VAMPIRE_EPIC_CHIMESTRY1    =  524288;
const int FALLEN_VAMPIRE_EPIC_CHIMESTRY2    =  1048576;
const int FALLEN_VAMPIRE_EPIC_DEMENTATION1  =  2097152;
const int FALLEN_VAMPIRE_EPIC_DOMINATE1     =  4194304;
const int FALLEN_VAMPIRE_EPIC_DOMINATE2     =  8388608;
const int FALLEN_VAMPIRE_EPIC_FORTITUDE1    =  16777216;
const int FALLEN_VAMPIRE_EPIC_OBFUSCATE1    =  33554432;
const int FALLEN_VAMPIRE_EPIC_OBFUSCATE2    =  67108864;
const int FALLEN_VAMPIRE_EPIC_POTENCE       =  134217728;
const int FALLEN_VAMPIRE_EPIC_TGARGOYLE     =  268435456;
const int FALLEN_VAMPIRE_EPIC_TMINION       =  536870912;
// Sitrius - End of New Epic Abilities.

int GetHasEpicAbility(int iAbility, object oPC){
    if((GetLocalInt(oPC, "FALLEN_VAMPIRE_EPIC_ABILITIES") & iAbility) == iAbility){
        switch(iAbility){
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
            // Sitrius - Start of New Epic Abilities.
            case FALLEN_VAMPIRE_EPIC_AUSPEX1: return UseAuspex1;
            case FALLEN_VAMPIRE_EPIC_AUSPEX2: return UseAuspex2;
            case FALLEN_VAMPIRE_EPIC_CELERITY: return UseCelerity;
            case FALLEN_VAMPIRE_EPIC_CHIMESTRY1: return UseChimestry1;
            case FALLEN_VAMPIRE_EPIC_CHIMESTRY2: return UseChimestry2;
            case FALLEN_VAMPIRE_EPIC_DEMENTATION1: return UseDementation1;
            case FALLEN_VAMPIRE_EPIC_DOMINATE1: return UseDominate1;
            case FALLEN_VAMPIRE_EPIC_DOMINATE2: return UseDominate2;
            case FALLEN_VAMPIRE_EPIC_FORTITUDE1: return UseFortitude1;
            case FALLEN_VAMPIRE_EPIC_OBFUSCATE1: return UseObfuscate1;
            case FALLEN_VAMPIRE_EPIC_OBFUSCATE2: return UseObfuscate2;
            case FALLEN_VAMPIRE_EPIC_POTENCE: return UsePotence;
            case FALLEN_VAMPIRE_EPIC_TGARGOYLE: return UseTGargoyle;
            case FALLEN_VAMPIRE_EPIC_TMINION: return UseTMinion;
            // Sitrius - End of New Epic Abilities.
        }
    }
    return FALSE;
}


