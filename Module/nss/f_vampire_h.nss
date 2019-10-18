#include "f_vampire_spls_h"
#include "f_vampirebite_h"
#include "f_vampire_persis"

//This resets the blood hunger system
void Vampire_Fresh_Blood(object oPC = OBJECT_SELF);

void Vampire_Remove_Stats(object oPC = OBJECT_SELF)
{
effect eE = GetFirstEffect(oPC);
while(GetIsEffectValid(eE))
    {
    if(GetEffectDurationType(eE) == DURATION_TYPE_PERMANENT &&
       GetEffectSubType(eE) == SUBTYPE_SUPERNATURAL)
         RemoveEffect(oPC, eE);
    eE = GetNextEffect(oPC);
    }
}

void Vampire_Apply_Aura(object oPC = OBJECT_SELF)
{
effect eAuraSmall = SupernaturalEffect(EffectAreaOfEffect(SmallAuraType, "f_vampireaura", "****", "****"));
effect eAuraLarge = SupernaturalEffect(EffectAreaOfEffect(LargeAuraType, "f_vampireaura", "****", "****"));
int iHD = Determine_Vampire_Level(oPC);
if(iHD >= LargeAuraLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAuraLarge, oPC);
if(iHD >= SmallAuraLevel)ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAuraSmall, oPC);
}

int Vampire_Remove_Aura(object oPC = OBJECT_SELF)
{
effect eE = GetFirstEffect(oPC);
int iReturn = FALSE;
while(GetIsEffectValid(eE))
    {
    if(GetEffectDurationType(eE) == DURATION_TYPE_PERMANENT &&
       GetEffectSubType(eE) == SUBTYPE_SUPERNATURAL &&
       GetEffectType(eE) == EFFECT_TYPE_AREA_OF_EFFECT)
        {
        RemoveEffect(oPC, eE);
        iReturn = TRUE;
        }
    eE = GetNextEffect(oPC);
    }
return iReturn;
}


void Vampire_Apply_Stats(object oPC = OBJECT_SELF)
{
int iHD = Determine_Vampire_Level(oPC);
int iStatMod = (iHD / 10) + 1;
effect eStr = SupernaturalEffect(EffectAbilityIncrease(ABILITY_STRENGTH, iStatMod));
effect eChr = SupernaturalEffect(EffectRegenerate(4, 8.0f));
effect eSpeedUp = SupernaturalEffect(EffectMovementSpeedIncrease((iHD * 2)));
effect eVision = SupernaturalEffect(EffectUltravision());

effect eIDisease = SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_DISEASE));
effect eIPoison = SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_POISON));
effect eIDeathSpells = SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_DEATH));
effect eISneakAttack = SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK));
effect eINegative = SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL));
effect eICriticalHit = SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT));

effect eFireWeakness = SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, (70 - iHD)));
effect eDivineWeakness = SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE, (90 - iHD)));
effect ePositiveWeakness = SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_POSITIVE, (90 - iHD)));

effect eColdResist = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, (50 + iHD)));
effect eNegativeResist = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, (80 + iHD)));

effect eNegDamage;
effect eDamageResist = SupernaturalEffect(EffectDamageReduction(10, DAMAGE_POWER_NORMAL));
effect eTemp; //for epic and other effects

Vampire_Remove_Stats(oPC);
Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_MIST");

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFireWeakness, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDivineWeakness, oPC);
if(iHD > 0)
    { //no strengths if you are at a negative vampire level!
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eColdResist, oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNegativeResist, oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStr, oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChr, oPC);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedUp, oPC);
    }
//if(iHD >= UltravisionLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVision, oPC);
if(iHD >= ImmuneDeathLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eIDeathSpells, oPC);
if(iHD >= ImmuneNegLvlLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eINegative, oPC);
if(iHD >= ImmuneDiseaseLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eIDisease, oPC);
if(iHD >= ImmunePoisonLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eIPoison, oPC);
if(iHD >= ImmuneSnkAttkLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eISneakAttack, oPC);
if(iHD >= ImmuneCrtHitLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eICriticalHit, oPC);
if(iHD >= ImmuneDmgResistLevel) ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDamageResist, oPC);
///////////// Epic
if(iHD > 20 || !BloodNeedAffectEpics)
    {
    if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, oPC))
        {
        if(iHD < 0)
            {
            eTemp = SupernaturalEffect(EffectRegenerate(0, 6.0));
            }
        else if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND2, oPC))
            {
            eTemp = SupernaturalEffect(EffectRegenerate((iHD / 0) + 0, 3.0));
            }
        else
            {
            eTemp = SupernaturalEffect(EffectRegenerate((iHD / 0) + 0, 6.0));
            }
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTemp, oPC);
        }
    if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_SUNPROOF, oPC))
        {
        eTemp = SupernaturalEffect(EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTemp, oPC);
        }
    }
////////////// End Epic
if(!UseAuraItem) Vampire_Apply_Aura(oPC);

if(iHD >= NegDmg2d12Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_2d12, DAMAGE_TYPE_NEGATIVE));
  else if(iHD >= NegDmg2d10Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_2d10, DAMAGE_TYPE_NEGATIVE));
    else if(iHD >= NegDmg2d8Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_2d8, DAMAGE_TYPE_NEGATIVE));
      else if(iHD >= NegDmg2d6Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_2d6, DAMAGE_TYPE_NEGATIVE));
        else if(iHD >= NegDmg1d10Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_1d10, DAMAGE_TYPE_NEGATIVE));
          else if(iHD >= NegDmg1d8Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_1d8, DAMAGE_TYPE_NEGATIVE));
            else if(iHD >= NegDmg1d6Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_NEGATIVE));
              else if(iHD >= NegDmg1d4Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_1d4, DAMAGE_TYPE_NEGATIVE));
                else if(iHD >= NegDmg2Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_NEGATIVE));
                  else if(iHD >= NegDmg1Level) eNegDamage = SupernaturalEffect(EffectDamageIncrease(DAMAGE_BONUS_1, DAMAGE_TYPE_NEGATIVE));
                    else return; //nothing to apply...
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNegDamage, oPC);
}

void Vampire_Equipment_Removal_By_Level(object oPC = OBJECT_SELF)
{
int iHD = Determine_Vampire_Level(oPC);
//object oItem = GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_MIST_ABILITY");
//if(iHD < MistLevel && GetIsObjectValid(oItem)) DestroyObject(oItem);
//oItem = GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_WOLF_ABILITY");
//if(iHD < WolfLevel && GetIsObjectValid(oItem)) DestroyObject(oItem);
//oItem = GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_BAT_ABILITY");
//if(iHD < BatLevel && GetIsObjectValid(oItem)) DestroyObject(oItem);
//oItem = GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_SUNSTONE");
//if(iHD < SunstoneLevel && GetIsObjectValid(oItem)) DestroyObject(oItem);
//oItem = GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_AURA_ABILITY");
//if((!UseAuraItem || (iHD < LargeAuraLevel && iHD < SmallAuraLevel)) && GetIsObjectValid(oItem)) DestroyObject(oItem);
/*if(iHD < 21 && BloodNeedAffectEpics)
    {
    GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_SUMMON");
    if(GetIsObjectValid(oItem)) DestroyObject(oItem);
    GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_REFUGE");
    if(GetIsObjectValid(oItem)) DestroyObject(oItem);
    GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_LOOK_HUNGER");
    if(GetIsObjectValid(oItem)) DestroyObject(oItem);
    }
    */
}

void Vampire_Equipment_Removal(object oPC = OBJECT_SELF, int iDropCoffin = TRUE)
{
object oO = GetFirstItemInInventory(oPC);
string sS;
while(GetIsObjectValid(oO))
    {
    sS = GetTag(oO);
    if(sS == "FALLEN_VAMPIRE_FANGS"|| sS == "FALLEN_VAMPIRE_SUNSTONE") DestroyObject(oO); //|| sS == "FALLEN_VAMPIRE_MIST_ABILITY"
      // || sS == "FALLEN_VAMPIRE_WOLF_ABILITY" || sS == "FALLEN_VAMPIRE_BAT_ABILITY"
        //|| sS == "FALLEN_VAMPIRE_AURA_ABILITY"
      // || sS == "FALLEN_VAMPIRE_SUMMON" || sS == "FALLEN_VAMPIRE_REFUGE"
     /*  || sS == "FALLEN_VAMPIRE_LOOK_HUNGER" || sS == "FALLEN_VAMPIRE_BITE_TOKEN")*/
      else if(sS == "yourcoffin" && iDropCoffin)
        {
        DestroyObject(oO);
        SendMessageToPC(oPC, "As your body weakens you drop the coffin.");
        CreateObject(OBJECT_TYPE_PLACEABLE, "vampirecoffin", GetLocation(oPC));
        }
    oO = GetNextItemInInventory(oPC);
    }
}

void Vampire_Equipment_Creation(object oPC = OBJECT_SELF)
{
int iHD = Determine_Vampire_Level(oPC);
if(!GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_FANGS"))) CreateItemOnObject("vampirefangs", oPC);
//if(iHD >= MistLevel && !GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_MIST_ABILITY"))) CreateItemOnObject("vampiremistform", oPC);
//if(iHD >= WolfLevel && !GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_WOLF_ABILITY"))) CreateItemOnObject("vampirewolfform", oPC);
//if(iHD >= BatLevel && !GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_BAT_ABILITY"))) CreateItemOnObject("vampirebatform", oPC);
if(iHD >= SunstoneLevel && !GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_SUNSTONE"))) CreateItemOnObject("vampiresunstone", oPC);
//if(UseAuraItem && (iHD >= LargeAuraLevel || iHD >= SmallAuraLevel) && !GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_AURA_ABILITY"))) CreateItemOnObject("vampireaura", oPC);
if(iHD > 20 || !BloodNeedAffectEpics)
    { //epic
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_SUMMON"))
       && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, oPC))
         CreateItemOnObject("vampiresummon", oPC);
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_REFUGE"))
       && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_REFUGE, oPC))
         CreateItemOnObject("vampirerefuge", oPC);
    object oItem = GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_LOOK_HUNGER");
    if(GetIsObjectValid(oItem))
        {
        if(GetResRef(oItem) == "vampirelookhunge" && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2, oPC))
            {
            DestroyObject(oItem);
            CreateItemOnObject("vampiredrainingg", oPC);
            }
        }
    else
        {
        if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2, oPC))
         CreateItemOnObject("vampiredrainingg", oPC);
        else if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER, oPC))
         CreateItemOnObject("vampirelookhunge", oPC);
        }
    }
}

void Vampire_Remove_Advancement_Books(object oPC = OBJECT_SELF)
{
object oO = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oO))
    {
    if(GetTag(oO) == "fv_BookofElderVampireAdvancement") DestroyObject(oO);
    oO = GetNextItemInInventory(oPC);
    }
}

void SetIsVampire(int isVampire = TRUE, object oPC = OBJECT_SELF)
{
if(GetIsVampire(oPC) == isVampire) return;
if(isVampire)
    {
    Vampire_Apply_Stats(oPC);
    Vampire_Equipment_Creation(oPC);
    Vampire_Set_Int(oPC, "FALLEN_SUBRACE", 1);
    Vampire_Set_Location(oPC, "FALLEN_VAMPIRE_MARK", GetLocation(oPC));
    Vampire_Set_String(oPC, "FALLEN_VAMPIRE_ORIGINAL_SUBRACE", GetSubRace(oPC));
    if(AlterSubRaceField) SetSubRace(oPC, "Vampire");
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_MIST");
    int iVLevel = VampireStartLevel;
    int iHD = GetHitDice(oPC);
    if(UseCharacterLevel) iVLevel = iHD;
      else if(CapVampireLevel && iVLevel > iHD) iVLevel = iHD;
    if(iVLevel > 40) iVLevel = 40;
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_LEVEL", iVLevel);
    if(iVLevel > 41) CreateItemOnObject("bookofepicvampir", oPC);
    if(iVLevel > 41) CreateItemOnObject("bookofepicvampir", oPC);
    if(iVLevel > 41) CreateItemOnObject("bookofepicvampir", oPC);
    if(iVLevel > 41) CreateItemOnObject("bookofepicvampir", oPC);
    if(iVLevel > 41) CreateItemOnObject("bookofepicvampir", oPC);
    }
else
    {
    Vampire_Equipment_Removal(oPC);
    Vampire_Remove_Stats(oPC);
    Vampire_Remove_Advancement_Books(oPC);
    Vampire_Delete_Int(oPC, "FALLEN_SUBRACE");
    Vampire_Delete_Location(oPC, "FALLEN_VAMPIRE_MARK");
    if(AlterSubRaceField)
        {
        Vampire_Read_String(oPC, "FALLEN_VAMPIRE_ORIGINAL_SUBRACE");
        SetSubRace(oPC, GetLocalString(oPC, "FALLEN_VAMPIRE_ORIGINAL_SUBRACE"));
        }
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_MIST");
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_LEVEL");
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_EPIC");
    }
}

void Vampire_Penalty_Expired(object oPC = OBJECT_SELF)
{ //starvation sucks!
if(GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM") > 0 || GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, oPC)) return;
int iMark = GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER") - 1;
//FloatingTextStringOnCreature("Vampire_Penalty_Expired called: mark is " + IntToString(iMark) + ".", oPC);
if(iMark <= 0)
    {
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", BloodNeedPenalty);
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY", GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY") + 1);
    Vampire_Apply_Stats(oPC);
    Vampire_Equipment_Removal_By_Level(oPC);
    FloatingTextStringOnCreature("Your starvation for blood has damaged your vampiric abilities!", oPC, FALSE);
    }
else Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", iMark);
DelayCommand(HoursToSeconds(1), Vampire_Penalty_Expired(oPC));
}

void Vampire_Delay_Expired(object oPC = OBJECT_SELF)
{ //give a warning that they are getting hungry
if(GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER") > 0 || GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, oPC)) return;
int iMark = GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM") - 1;
//FloatingTextStringOnCreature("Vampire_Delay_Expired called: mark is " + IntToString(iMark) + ".", oPC);
if(iMark <= 0)
    {
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM", 0);
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", BloodNeedPenalty);
    FloatingTextStringOnCreature("Your body hungers for blood.", oPC, FALSE);
    DelayCommand(HoursToSeconds(1), Vampire_Penalty_Expired(oPC));
    }
else
    {
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM", iMark);
    DelayCommand(HoursToSeconds(1), Vampire_Delay_Expired(oPC));
    }
}

void Vampire_Fresh_Blood(object oPC = OBJECT_SELF)
{ //This will just update the blood need timestamp and remove any penalties you had
if(!UseBloodNeedSystem || GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, oPC)) return;
int isPenalized = (GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY") > 0);
int iCurrent = GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM");
Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM", BloodNeedDelay);
Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", 0);
if(iCurrent == 0) DelayCommand(HoursToSeconds(1), Vampire_Delay_Expired(oPC));
//FloatingTextStringOnCreature("Vampire_Fresh_Blood called.", oPC);
if(isPenalized)
    {
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY");
    Vampire_Apply_Stats(oPC);
    Vampire_Equipment_Creation(oPC);
    FloatingTextStringOnCreature("The blood restores your lost strength.", oPC, FALSE);
    }
}

void SetHasEpicAbility(int iAbility, object oPC)
{
object oItem = GetFirstItemInInventory(oPC);
while (GetIsObjectValid(oItem) && GetTag(oItem) != "fv_BookofElderVampireAdvancement") oItem = GetNextItemInInventory(oPC);
if(!GetIsObjectValid(oItem) || GetTag(oItem) != "fv_BookofElderVampireAdvancement")
    {
    SendMessageToAllDMs("Fallen Vampire Subrace System Warning: " + GetName(oPC) + " has made a call to SetEpicAbility without having the proper item in inventory.");
    return;
    }
DestroyObject(oItem);
Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_EPIC_ABILITIES", (GetLocalInt(oPC, "FALLEN_VAMPIRE_EPIC_ABILITIES") | iAbility));
if((iAbility & FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND) == FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND)
    {
 //   Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM", BloodNeedDelay);
//    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", 0);
//    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY");
    }
Vampire_Apply_Stats(oPC);
Vampire_Equipment_Creation(oPC);
}

