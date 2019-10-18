#include "NW_I0_GENERIC"
#include "x0_i0_petrify"

void homidShift(object oPC){
    RemoveEffectOfType(oPC, EFFECT_TYPE_ABILITY_INCREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_ABILITY_DECREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_REGENERATE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_DAMAGE_INCREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_DAMAGE_DECREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_SKILL_INCREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_SKILL_DECREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_POLYMORPH);
    RemoveEffectOfType(oPC, EFFECT_TYPE_MOVEMENT_SPEED_INCREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_MOVEMENT_SPEED_DECREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_DAMAGE_REDUCTION);
    RemoveEffectOfType(oPC, EFFECT_TYPE_SAVING_THROW_DECREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_SAVING_THROW_INCREASE);
    RemoveEffectOfType(oPC, EFFECT_TYPE_AC_INCREASE);

    int i;
    for(i=1;i<=8;i++){
        object aItem = GetItemPossessedBy(oPC, "howl"+IntToString(i));
        if (GetIsObjectValid(aItem)){
            DestroyObject(aItem);
        }
    }

    SetLocalInt(oPC, "Glabro", 0);
    SetLocalInt(oPC, "Crinos", 0);
    PlayVoiceChat(VOICE_CHAT_PAIN1, oPC);
    SetLocalInt(oPC, "shifted", 0);
    SetLocalInt(oPC, "wolf_form", 0);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oPC);
    if (GetRacialType(oPC)==RACIAL_TYPE_HUMAN){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HUMAN);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_ELF){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ELF);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_HALFELF){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ELF);
    }
    else if(GetRacialType(oPC)==RACIAL_TYPE_HALFORC){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ORC);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_HALFLING){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALFLING);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_DWARF){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DWARF);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_GNOME){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_GNOME);
    }
    else if (GetRacialType(oPC)==51){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HUMAN);
    }
}
