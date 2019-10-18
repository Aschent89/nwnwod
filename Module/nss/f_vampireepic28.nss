#include "f_vampire_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_IMP_THRALL, GetPCSpeaker())
   && CanMakeThralls
   && MakeThrallLevel <= Determine_Vampire_Level(GetPCSpeaker())
   && UseImprovedThrall) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_HOLY_VAMPIRE, GetPCSpeaker())
   && GetAlignmentGoodEvil(GetPCSpeaker()) == ALIGNMENT_GOOD
   && UseHolyVampire) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER, GetPCSpeaker())
   && UseLookOfHunger) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER, GetPCSpeaker())
   && UseLookOfHunger
   && UseLookOfHungerLevel2) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_REFUGE, GetPCSpeaker())
   && UseRefuge) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_UNH_THRALL, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_IMP_THRALL, GetPCSpeaker())
   && CanMakeThralls
   && MakeThrallLevel <= Determine_Vampire_Level(GetPCSpeaker())
   && UseImprovedThrall
   && UseUnholyThrall) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND2, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, GetPCSpeaker())
   && UseBloodOfTheLand
   && UseBloodOfTheLandLevel2) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, GetPCSpeaker())
   && UseBloodOfTheLand) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_SUNPROOF, GetPCSpeaker())
   && UseSunproof) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_TWIN_ABYSS, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_KIN_DAMNED, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, GetPCSpeaker())
   && UseChildrenOfTheNight
   && UseKinOfTheDamned
   && UseTwinOfTheAbyss) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_KIN_DAMNED, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, GetPCSpeaker())
   && UseChildrenOfTheNight
   && UseKinOfTheDamned) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, GetPCSpeaker())
   && UseChildrenOfTheNight) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_IMP_UNH_THRALL, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_UNH_THRALL, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_IMP_THRALL, GetPCSpeaker())
   && CanMakeThralls
   && MakeThrallLevel <= Determine_Vampire_Level(GetPCSpeaker())
   && UseImprovedThrall
   && UseUnholyThrall
   && UseUnholyThrallLevel2) return FALSE;
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_TURNPROOF, GetPCSpeaker())
   && UseTurnProof) return FALSE;

object oItem = GetFirstItemInInventory(GetPCSpeaker());
while (GetIsObjectValid(oItem) && GetTag(oItem) != "fv_BookofElderVampireAdvancement") oItem = GetNextItemInInventory(GetPCSpeaker());
if(!GetIsObjectValid(oItem) || GetTag(oItem) != "fv_BookofElderVampireAdvancement") return TRUE;
DestroyObject(oItem);
return TRUE;
}
