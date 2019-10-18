#include "NW_I0_GENERIC"

void hispoShift(object oPC,int appearance){
    int nLocked=FALSE;
    string sSound = "as_an_wolfhowl2";
    PlaySound(sSound);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW ,2.0, 3.0);
    PlayVoiceChat(VOICE_CHAT_PAIN1, oPC);
    string s1 =  "Use the wolf head in your inventory, and select howls to learn about the howls you have, and what they do.";
    string s2 = "You feel your bones shift as you change into Hispo form.";

    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BELT, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));
//    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_NECK, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
    ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC));

    SetLocalInt(oPC, "shifted", 1);
    SetLocalInt(oPC, "wolf_form", 1);

    DelayCommand(3.0, SetCreatureAppearanceType(oPC, appearance));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectPolymorph(VFX_NONE, nLocked)), oPC);
//    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED), oPC);
//    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), oPC));
//    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), oPC, 3.0);
    FloatingTextStringOnCreature(s2, oPC);

    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL){
        CreateItemOnObject("howl6", oPC, 1);
    }
    else{
        CreateItemOnObject("howl2", oPC, 1);
    }

    int oLevel = GetCharacterLevel(oPC);
    effect shiftEffect;
    effect tempHPEffect;

if ((GetLevelByClass(CLASS_TYPE_MONK, oPC)>0))
   {
        shiftEffect=EffectAbilityIncrease(ABILITY_STRENGTH, 6);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectAbilityIncrease(ABILITY_DEXTERITY, 4));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectAbilityIncrease(ABILITY_CONSTITUTION, 4));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectRegenerate(5, 8.0));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectMovementSpeedIncrease(40));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectDamageIncrease(DAMAGE_BONUS_2d8,DAMAGE_TYPE_POSITIVE));
//        tempHPEffect=EffectTemporaryHitpoints(Random(20));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_LISTEN, 30));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_SPOT, 30));
        shiftEffect=EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_WILL, 10, SAVING_THROW_TYPE_MIND_SPELLS),shiftEffect);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillDecrease(SKILL_HIDE, 30));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillDecrease(SKILL_MOVE_SILENTLY, 30));

    shiftEffect=SupernaturalEffect(shiftEffect);
//    tempHPEffect=SupernaturalEffect(tempHPEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,shiftEffect,oPC);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT,tempHPEffect,oPC);
    }

else
   {
        shiftEffect=EffectAbilityIncrease(ABILITY_STRENGTH, 6);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectAbilityIncrease(ABILITY_DEXTERITY, 4));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectAbilityIncrease(ABILITY_CONSTITUTION, 4));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectRegenerate(6, 8.0));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectMovementSpeedIncrease(70));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectDamageIncrease(DAMAGE_BONUS_2d10,DAMAGE_TYPE_POSITIVE));
//        tempHPEffect=EffectTemporaryHitpoints(Random(20));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_LISTEN, 30));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_SPOT, 30));
        shiftEffect=EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_WILL, 10, SAVING_THROW_TYPE_MIND_SPELLS),shiftEffect);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillDecrease(SKILL_HIDE, 30));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillDecrease(SKILL_MOVE_SILENTLY, 30));

    shiftEffect=SupernaturalEffect(shiftEffect);
//    tempHPEffect=SupernaturalEffect(tempHPEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,shiftEffect,oPC);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT,tempHPEffect,oPC);
    }
}
