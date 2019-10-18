#include "vamp_spells_h"
#include "vamp_persistent"

//This resets the blood hunger system
void Vampire_Fresh_Blood(object oPC = OBJECT_SELF);

void RemoveBothersomeEffects(){
  //these effect can mess up the cutscene invis that is needed to make stuff look
  //right. So they are removed.
    effect eE = GetFirstEffect(OBJECT_SELF);
    int iType;
    while(GetIsEffectValid(eE)){
        iType = GetEffectType(eE);
        if(iType == EFFECT_TYPE_ETHEREAL || iType == EFFECT_TYPE_IMPROVEDINVISIBILITY || iType == EFFECT_TYPE_INVISIBILITY || iType == EFFECT_TYPE_CONCEALMENT || iType == EFFECT_TYPE_SANCTUARY){
            RemoveEffect(OBJECT_SELF, eE);
        }
        eE = GetNextEffect(OBJECT_SELF);
    }
}

int GetIsVampire(object oPC = OBJECT_SELF){
    return (GetLocalInt(oPC, "FALLEN_SUBRACE") == 1);
}

int Determine_Vampire_Level(object oPC = OBJECT_SELF){
    int iVLevel = GetLocalInt(oPC, "FALLEN_VAMPIRE_LEVEL");
    int iHD = GetHitDice(oPC);
    if(!UseCharacterLevel){
        if(!CapVampireLevel || iHD > iVLevel){
            iHD = iVLevel;
        }
    }
    if(iHD > 40){
        iHD = 40;
    }
    if(UseBloodNeedSystem){
        iHD -= GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY");
    }
    SetLocalInt(oPC, "FALLEN_VAMPIRE_LEVEL", iHD);
    return iHD;
}

void Vampire_Remove_Stats(object oPC = OBJECT_SELF){
    effect eE = GetFirstEffect(oPC);
    while(GetIsEffectValid(eE)){
        if(GetEffectDurationType(eE) == DURATION_TYPE_PERMANENT && GetEffectSubType(eE) == SUBTYPE_SUPERNATURAL){
            RemoveEffect(oPC, eE);
        }
        eE = GetNextEffect(oPC);
    }
    Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_MIST");
}

void Vampire_Apply_Stats(object oPC = OBJECT_SELF){
    Vampire_Remove_Stats(oPC);
    int iHD = Determine_Vampire_Level(oPC);
    int iStatMod = (iHD / 5) + 1;

    effect vampEffect=EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, (70 - iHD));
    vampEffect=EffectLinkEffects(EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE, (90 - iHD)),vampEffect);

    if(iHD > 0){ //no strengths if you are at a negative vampire level!
        vampEffect=EffectLinkEffects(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, (50 + iHD)), vampEffect);
        vampEffect=EffectLinkEffects(EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, (80 + iHD)), vampEffect);
        vampEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_STRENGTH, iStatMod), vampEffect);
        vampEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_CHARISMA, iStatMod), vampEffect);
        vampEffect=EffectLinkEffects(EffectMovementSpeedIncrease(iHD * 2), vampEffect);
    }
    if(iHD >= UltravisionLevel){
        vampEffect=EffectLinkEffects(EffectUltravision(), vampEffect);
    }
    if(iHD >= ImmuneDeathLevel){
        vampEffect=EffectLinkEffects(EffectImmunity(IMMUNITY_TYPE_DEATH), vampEffect);
    }
    if(iHD >= ImmuneNegLvlLevel){
        vampEffect=EffectLinkEffects(EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL), vampEffect);
    }
    if(iHD >= ImmuneDiseaseLevel){
        vampEffect=EffectLinkEffects(EffectImmunity(IMMUNITY_TYPE_DISEASE), vampEffect);
    }
    if(iHD >= ImmunePoisonLevel){
        vampEffect=EffectLinkEffects(EffectImmunity(IMMUNITY_TYPE_POISON), vampEffect);
    }
   if(iHD >= ImmuneSnkAttkLevel){
      vampEffect=EffectLinkEffects(EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK), vampEffect);
  }
   if(iHD >= ImmuneCrtHitLevel){
     vampEffect=EffectLinkEffects(EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT), vampEffect);
    }
    if(iHD >= ImmuneDmgResistLevel){
        vampEffect=EffectLinkEffects(EffectDamageReduction(5, DAMAGE_POWER_NORMAL), vampEffect);
    }
///////////// Epic
    if(iHD > 20 || !BloodNeedAffectEpics){
        effect eTemp;
        if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, oPC)){
            if(iHD < 0){
                eTemp = SupernaturalEffect(EffectRegenerate(1, 6.0));
            }
            else if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND2, oPC)){
                eTemp = SupernaturalEffect(EffectRegenerate((iHD / 6) + 1, 3.0));
            }
            else{
                eTemp = SupernaturalEffect(EffectRegenerate((iHD / 6) + 1, 6.0));
            }
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTemp, oPC);
        }
        if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_SUNPROOF, oPC)){
            eTemp = SupernaturalEffect(EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTemp, oPC);
        }
    }
////////////// End Epic
// Sitrius - Start of Natural Regen Addon.
    if ( iHD >= sm_NaturalRegen4 ){
        vampEffect=EffectLinkEffects(EffectRegenerate(4, 6.0),vampEffect);
    }
    else if ( iHD >= sm_NaturalRegen3 ){
        vampEffect=EffectLinkEffects(EffectRegenerate(3, 6.0),vampEffect);
    }
    else if ( iHD >= sm_NaturalRegen2 ){
        vampEffect=EffectLinkEffects(EffectRegenerate(2, 6.0),vampEffect);
    }
    else if ( iHD >= sm_NaturalRegen1 ){
        vampEffect=EffectLinkEffects(EffectRegenerate(1, 6.0),vampEffect);
    }
// Sitrius - End of Natural Regen Addon.

    if(iHD >= NegDmg2d12Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_2d12, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg2d10Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_2d10, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg2d8Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_2d8, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg2d6Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_2d6, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg1d10Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_1d10, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg1d8Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_1d8, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg1d6Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg1d4Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_1d4, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg2Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    else if(iHD >= NegDmg1Level){
        vampEffect=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_1, DAMAGE_TYPE_NEGATIVE),vampEffect);
    }
    vampEffect=SupernaturalEffect(vampEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, vampEffect, oPC);
}

void Vampire_Equipment_Removal(object oPC = OBJECT_SELF, int iDropCoffin = TRUE){
    object oO = GetFirstItemInInventory(oPC);
    string sS;
    while(GetIsObjectValid(oO)){
        sS = GetTag(oO);
        // Sitrius - Below if changed to use new epic ability tags also
        if(sS == "vamp_fangs"
        || sS == "vamp_mist"
        || sS == "vamp_wolf"
        || sS == "vamp_bat"
        || sS == "vamp_sunstone"
        || sS == "vamp_aura"
        || sS == "vamp_refuge"
        || sS == "FALLEN_VAMPIRE_SUMMON"
        || sS == "FALLEN_VAMPIRE_BAT_ABILITY"
        || sS == "FALLEN_VAMPIRE_MIST_ABILITY"
        || sS == "FALLEN_VAMPIRE_WOLF_ABILITY"
        || sS == "FALLEN_VAMPIRE_SUNSTONE"
        || sS == "FALLEN_VAMPIRE_REFUGE"
        || sS == "FALLEN_VAMPIRE_FANGS"
        || sS == "FALLEN_VAMPIRE_AURA_ABILITY"
        || sS == "FALLEN_VAMPIRE_LOOK_HUNGER" || sS == "FALLEN_VAMPIRE_BITE_TOKEN"
        || sS == "auspex1" || sS == "auspex2" || sS == "celerity" || sS == "chimestry1"
        || sS == "chimestry2" || sS == "dementation1" || sS == "dominate1" || sS == "dominate2"
        || sS == "fort1" || sS == "obfuscate1" || sS == "obfuscate2" || sS == "potence"
        || sS == "tgargoyle" || sS == "tminion"){
            DestroyObject(oO);
        }
        else if(sS == "yourcoffin" && iDropCoffin){
            DestroyObject(oO);
            SendMessageToPC(oPC, "As your body weakens you drop the coffin.");
            CreateObject(OBJECT_TYPE_PLACEABLE, "vampirecoffin", GetLocation(oPC));
        }
        oO = GetNextItemInInventory(oPC);
    }
}

void Vampire_Equipment_Removal_By_Level(object oPC = OBJECT_SELF){
    int iHD = Determine_Vampire_Level(oPC);

    object oItem = GetItemPossessedBy(oPC, "vamp_mist");
    if(iHD < MistLevel && GetIsObjectValid(oItem)){
        DestroyObject(oItem);
    }
    oItem = GetItemPossessedBy(oPC, "vamp_wolf");
    if(iHD < WolfLevel && GetIsObjectValid(oItem)){
        DestroyObject(oItem);
    }
    oItem = GetItemPossessedBy(oPC, "vamp_bat");
    if(iHD < BatLevel && GetIsObjectValid(oItem)){
        DestroyObject(oItem);
    }
    oItem = GetItemPossessedBy(oPC, "vamp_sunstone");
    if(iHD < SunstoneLevel && GetIsObjectValid(oItem)){
        DestroyObject(oItem);
    }
    oItem = GetItemPossessedBy(oPC, "vamp_aura");
    if((!UseAuraItem || (iHD < LargeAuraLevel && iHD < SmallAuraLevel))&& GetIsObjectValid(oItem)){
        DestroyObject(oItem);
    }
    if(iHD < 21 && BloodNeedAffectEpics){
        GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_SUMMON");
        if(GetIsObjectValid(oItem)){
            DestroyObject(oItem);
        }
        GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_REFUGE");
        if(GetIsObjectValid(oItem)){
            DestroyObject(oItem);
        }
        GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_LOOK_HUNGER");
        if(GetIsObjectValid(oItem)){
            DestroyObject(oItem);
        }
    // Sitrius - Start new Epic Abilities delete section
    // Auspex1
        object oTmp = GetItemPossessedBy(oPC, "auspex1");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Auspex2
        oTmp = GetItemPossessedBy(oPC, "auspex2");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Celerity
        oTmp = GetItemPossessedBy(oPC, "celerity");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Chimestry1
        oTmp = GetItemPossessedBy(oPC, "chimestry1");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Chimestry2
        oTmp = GetItemPossessedBy(oPC, "chimestry2");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Dominate1
        oTmp = GetItemPossessedBy(oPC, "dominate1");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Dominate2
        oTmp = GetItemPossessedBy(oPC, "dominate2");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Dementation1
        oTmp = GetItemPossessedBy(oPC, "dementation1");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Fortitude1
        oTmp = GetItemPossessedBy(oPC, "fort1");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Obfuscate1
        oTmp = GetItemPossessedBy(oPC, "obfuscate1");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Obfuscate2
        oTmp = GetItemPossessedBy(oPC, "obfuscate2");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // Potence
        oTmp = GetItemPossessedBy(oPC, "potence");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // TGargoyle
        oTmp = GetItemPossessedBy(oPC, "tgargoyle");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }

    // TMinion
        oTmp = GetItemPossessedBy(oPC, "tminion");
        if ( GetIsObjectValid(oTmp) ){
            DestroyObject(oTmp);
        }
    // Sitrius - End new Epic Abilities delete section
    }
}

void Vampire_Equipment_Creation(object oPC = OBJECT_SELF){
    int iHD = Determine_Vampire_Level(oPC);
    CreateItemOnObject("vampirefangs", oPC);
    if(iHD>=MistLevel){
        CreateItemOnObject("vampiremistform", oPC);
    }
    if(iHD>=WolfLevel || iHD>=DireWolfLevel){
        CreateItemOnObject("vampirewolfform", oPC);
    }
    if(iHD>=BatLevel){
        CreateItemOnObject("vampirebatform", oPC);
    }
    if(iHD>=SunstoneLevel){
        CreateItemOnObject("vampiresunstone", oPC);
    }
    if(iHD>=SmallAuraLevel || iHD>=LargeAuraLevel){
        CreateItemOnObject("vampireaura", oPC);
    }
    if(iHD > 20 || !BloodNeedAffectEpics){ //epic
        if(!GetIsObjectValid(GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_SUMMON")) && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, oPC)){
            CreateItemOnObject("vampiresummon", oPC);
        }
        if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_REFUGE, oPC)){
            CreateItemOnObject("vampirerefuge", oPC);
        }
        object oItem = GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_LOOK_HUNGER");
        if(GetIsObjectValid(oItem)){
            if(GetResRef(oItem) == "vampirelookhunge" && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2, oPC)){
                DestroyObject(oItem);
                CreateItemOnObject("vampiredrainingg", oPC);
            }
        }
        else{
            if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2, oPC)){
                CreateItemOnObject("vampiredrainingg", oPC);
            }
            else if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER, oPC)){
                CreateItemOnObject("vampirelookhunge", oPC);
            }
        }
    }

    // Sitrius - New Epic items Addon.
    // Celerity
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CELERITY, oPC)){
        CreateItemOnObject("celerity", oPC);
    }

    // Dementation
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_DEMENTATION1, oPC)){
        CreateItemOnObject("dementation1", oPC);
    }

    // Fortitude
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_FORTITUDE1, oPC)){
        CreateItemOnObject("fort1", oPC);
    }

    // Potence
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_POTENCE, oPC)){
        CreateItemOnObject("potence", oPC);
    }

    // TGargoyle
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_TGARGOYLE, oPC)){
        CreateItemOnObject("tgargoyle", oPC);
    }

    // TMinion
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_TMINION, oPC)){
        CreateItemOnObject("tminion", oPC);
    }

    // Auspex1
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_AUSPEX1, oPC)){
        CreateItemOnObject("auspex1", oPC);
    }

    // Auxpex2
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_AUSPEX2, oPC)){
        CreateItemOnObject("auspex2", oPC);
    }

    // Chimestry1
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHIMESTRY1, oPC)){
        CreateItemOnObject("chimestry1", oPC);
    }

    // Chimestry2
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHIMESTRY2, oPC)){
        CreateItemOnObject("chimestry2", oPC);
    }

    // Dominate1
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_DOMINATE1, oPC)){
        CreateItemOnObject("dominate1", oPC);
    }

    // Dominate2
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_DOMINATE2, oPC)){
        CreateItemOnObject("dominate2", oPC);
    }

    // Obfuscate1
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_OBFUSCATE1, oPC)){
        CreateItemOnObject("obfuscate1", oPC);
    }

    // Obfuscate2
    if (GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_OBFUSCATE2, oPC)){
        CreateItemOnObject("obfuscate2", oPC);
    }

    // Sitrius - End of New Epic items Addon.
}

void Vampire_Remove_Advancement_Books(object oPC = OBJECT_SELF){
    object oO = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oO)){
        if(GetTag(oO) == "fv_BookofElderVampireAdvancement"){
            DestroyObject(oO);
        }
        oO = GetNextItemInInventory(oPC);
    }
}

void SetIsVampire(int isVampire = TRUE, object oPC = OBJECT_SELF){
    if(GetIsVampire(oPC) == isVampire){
        return;
    }
    if(isVampire){
        Vampire_Apply_Stats(oPC);
        Vampire_Equipment_Removal(oPC);
        Vampire_Equipment_Creation(oPC);
        Vampire_Set_Int(oPC, "FALLEN_SUBRACE", 1);
        Vampire_Set_Location(oPC, "FALLEN_VAMPIRE_MARK", GetLocation(oPC));
        Vampire_Set_String(oPC, "FALLEN_VAMPIRE_ORIGINAL_SUBRACE", GetSubRace(oPC));
        if(AlterSubRaceField){
            SetSubRace(oPC, "Vampire");
        }
        Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_MIST");
        int iVLevel = VampireStartLevel;
        int iHD = GetHitDice(oPC);
        if(UseCharacterLevel){
            iVLevel = iHD;
        }
        else if(CapVampireLevel && iVLevel > iHD){
            iVLevel = iHD;
        }
        if(iVLevel > 40){
            iVLevel = 40;
        }
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_LEVEL", iVLevel);
        if(iVLevel > 20){
            CreateItemOnObject("bookofepicvampir", oPC);
        }
        if(iVLevel > 24){
            CreateItemOnObject("bookofepicvampir", oPC);
        }
        if(iVLevel > 28){
            CreateItemOnObject("bookofepicvampir", oPC);
        }
        if(iVLevel > 32){
            CreateItemOnObject("bookofepicvampir", oPC);
        }
        if(iVLevel > 36){
            CreateItemOnObject("bookofepicvampir", oPC);
        }
    }
    else{
        Vampire_Equipment_Removal(oPC);
        Vampire_Remove_Stats(oPC);
        Vampire_Remove_Advancement_Books(oPC);
        Vampire_Delete_Int(oPC, "FALLEN_SUBRACE");
        Vampire_Delete_Location(oPC, "FALLEN_VAMPIRE_MARK");
        if(AlterSubRaceField){
            Vampire_Read_String(oPC, "FALLEN_VAMPIRE_ORIGINAL_SUBRACE");
            SetSubRace(oPC, GetLocalString(oPC, "FALLEN_VAMPIRE_ORIGINAL_SUBRACE"));
        }
        Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_MIST");
        Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_LEVEL");
        Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_EPIC");
    }
}

void Vampire_Penalty_Expired(object oPC = OBJECT_SELF){ //starvation sucks!
    if(GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM") > 0 || GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, oPC)){
        return;
    }
    int iMark = GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER") - 1;
    if(iMark <= 0){
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", BloodNeedPenalty);
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY", GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY") + 1);
        Vampire_Apply_Stats(oPC);
        Vampire_Equipment_Removal_By_Level(oPC);
        FloatingTextStringOnCreature("Your starvation for blood has damaged your vampiric abilities!", oPC, FALSE);
    }
    else{
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", iMark);
    }
    DelayCommand(HoursToSeconds(1), Vampire_Penalty_Expired(oPC));
}

void Vampire_Delay_Expired(object oPC = OBJECT_SELF){ //give a warning that they are getting hungry
    if(GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER") > 0 || GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, oPC)) return;
    int iMark = GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM") - 1;
    if(iMark <= 0){
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM", 0);
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", BloodNeedPenalty);
        FloatingTextStringOnCreature("Your body hungers for blood.", oPC, FALSE);
        DelayCommand(HoursToSeconds(1), Vampire_Penalty_Expired(oPC));
    }
    else{
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM", iMark);
        DelayCommand(HoursToSeconds(1), Vampire_Delay_Expired(oPC));
    }
}

void Vampire_Fresh_Blood(object oPC = OBJECT_SELF){ //This will just update the blood need timestamp and remove any penalties you had
    if(!UseBloodNeedSystem || GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, oPC)){
        return;
    }
    int isPenalized = (GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY") > 0);
    int iCurrent = GetLocalInt(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM");
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM", BloodNeedDelay);
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", 0);
    if(iCurrent == 0){
        DelayCommand(HoursToSeconds(1), Vampire_Delay_Expired(oPC));
    }
    if(isPenalized){
        Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY");
        Vampire_Apply_Stats(oPC);
        Vampire_Equipment_Removal(oPC,FALSE);
        Vampire_Equipment_Creation(oPC);
        FloatingTextStringOnCreature("The blood restores your lost strength.", oPC, FALSE);
    }
}

void SetHasEpicAbility(int iAbility, object oPC){
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem) && GetTag(oItem) != "fv_BookofElderVampireAdvancement"){
        oItem = GetNextItemInInventory(oPC);
    }
    if(!GetIsObjectValid(oItem) || GetTag(oItem) != "fv_BookofElderVampireAdvancement"){
        SendMessageToAllDMs("Fallen Vampire Subrace System Warning: " + GetName(oPC) + " has made a call to SetEpicAbility without having the proper item in inventory.");
        return;
    }
    DestroyObject(oItem);
    Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_EPIC_ABILITIES", (GetLocalInt(oPC, "FALLEN_VAMPIRE_EPIC_ABILITIES") | iAbility));
    if((iAbility & FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND) == FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND){
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_SYSTEM", BloodNeedDelay);
        Vampire_Set_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER", 0);
        Vampire_Delete_Int(oPC, "FALLEN_VAMPIRE_BLOOD_PENALTY");
    }
    Vampire_Apply_Stats(oPC);
    Vampire_Equipment_Removal(oPC,FALSE);
    Vampire_Equipment_Creation(oPC);
}
