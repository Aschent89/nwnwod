#include "NW_I0_GENERIC"

void crinosShift(object oPC,int appearance){
    int nLocked=FALSE;
    string sSound = "as_an_wolfhowl2";
    PlaySound(sSound);
    ActionPlayAnimation(ANIMATION_LOOPING_SPASM ,1.0, 2.0);
    string s1 =  GetPCPlayerName(oPC);
    string s2 = "You feel your bones shift as you change into Crinos form.";
//    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
//    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
//    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC));
//    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BELT, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));
//    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_NECK, oPC));
//    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
//    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC));

    SetLocalInt(oPC, "wolf_form", 1);
    SetLocalInt(oPC, "shifted", 1);

    DelayCommand(3.0, SetCreatureAppearanceType(oPC, appearance));
    PlayVoiceChat(VOICE_CHAT_PAIN1, oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectPolymorph(VFX_NONE, nLocked)), oPC);
//    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED), oPC);
//    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), oPC));
//    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), oPC, 3.0);

    FloatingTextStringOnCreature(s2, oPC);

    int oLevel = GetCharacterLevel(oPC);
    effect shiftEffect;
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL){
        CreateItemOnObject("howl6", oPC, 1);
    }
    else{
        CreateItemOnObject("howl2", oPC, 1);
    }

if ((GetLevelByClass(CLASS_TYPE_MONK, oPC)>0))
   {
        shiftEffect=EffectDamageIncrease(DAMAGE_BONUS_2d10,DAMAGE_TYPE_POSITIVE);
        shiftEffect=EffectLinkEffects(EffectACIncrease(5),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectRegenerate(4,3.0),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_STRENGTH,8),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityDecrease(ABILITY_CHARISMA,6),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_DEXTERITY,4),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_CONSTITUTION,6),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectMovementSpeedIncrease(15),shiftEffect);
//                tempHPEffect=EffectTemporaryHitpoints(Random(30));
                shiftEffect=EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_MIND_SPELLS),shiftEffect);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillDecrease(SKILL_HIDE, 30));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillDecrease(SKILL_MOVE_SILENTLY, 30));

    shiftEffect=SupernaturalEffect(shiftEffect);
//    tempHPEffect=SupernaturalEffect(tempHPEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,shiftEffect,oPC);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT,tempHPEffect,oPC);
    }

else
   {
        shiftEffect=EffectDamageIncrease(DAMAGE_BONUS_2d12,DAMAGE_TYPE_POSITIVE);
        shiftEffect=EffectLinkEffects(EffectACIncrease(7),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectRegenerate(5,3.0),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_STRENGTH,8),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityDecrease(ABILITY_CHARISMA,6),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_DEXTERITY,4),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_CONSTITUTION,6),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectMovementSpeedIncrease(15),shiftEffect);
//                tempHPEffect=EffectTemporaryHitpoints(Random(30));
                shiftEffect=EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_MIND_SPELLS),shiftEffect);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillDecrease(SKILL_HIDE, 30));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillDecrease(SKILL_MOVE_SILENTLY, 30));

    shiftEffect=SupernaturalEffect(shiftEffect);
//    tempHPEffect=SupernaturalEffect(tempHPEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,shiftEffect,oPC);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT,tempHPEffect,oPC);
    }
}
