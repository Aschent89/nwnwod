#include "NW_I0_GENERIC"

void lupisShift(object oPC,int appearance){
    int nLocked=FALSE;
    string sSound = "as_an_wolfhowl2";
    PlaySound(sSound);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW ,2.0, 3.0);
    string s1 =  GetPCPlayerName(oPC);
    string s2 = "You feel your bones shift as you change into Lupis form.";
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

    SetLocalInt(oPC, "wolf_form", 1);
    SetLocalInt(oPC, "shifted", 1);

    DelayCommand(3.0, SetCreatureAppearanceType(oPC, appearance));
    PlayVoiceChat(VOICE_CHAT_PAIN1, oPC);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectPolymorph(VFX_NONE, nLocked)), oPC);
//    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED), oPC);
//    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), oPC));
//    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), oPC, 3.0);

    FloatingTextStringOnCreature(s2, oPC);

    int oLevel = GetCharacterLevel(oPC);
    effect shiftEffect;

if ((GetLevelByClass(CLASS_TYPE_MONK, oPC)>0))
   {
        shiftEffect=EffectRegenerate(4, 12.0);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_SPOT, 12));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_LISTEN, 12));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_MOVE_SILENTLY, 12));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_HIDE, 12));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectAbilityIncrease(ABILITY_DEXTERITY, 4));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectAbilityIncrease(ABILITY_STRENGTH, 2));
        shiftEffect=EffectLinkEffects(EffectMovementSpeedIncrease(10),shiftEffect);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectDamageIncrease(DAMAGE_BONUS_1d8,DAMAGE_TYPE_POSITIVE));
        shiftEffect=EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_MIND_SPELLS),shiftEffect);

    shiftEffect=SupernaturalEffect(shiftEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,shiftEffect,oPC);
    }

else
   {
        shiftEffect=EffectRegenerate(4, 12.0);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_SPOT, 18));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_LISTEN, 18));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_MOVE_SILENTLY, 18));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectSkillIncrease(SKILL_HIDE, 18));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectAbilityIncrease(ABILITY_DEXTERITY, 4));
        shiftEffect=EffectLinkEffects(shiftEffect,EffectAbilityIncrease(ABILITY_STRENGTH, 2));
        shiftEffect=EffectLinkEffects(EffectMovementSpeedIncrease(20),shiftEffect);
        shiftEffect=EffectLinkEffects(shiftEffect,EffectDamageIncrease(DAMAGE_BONUS_1d12,DAMAGE_TYPE_POSITIVE));
        shiftEffect=EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_MIND_SPELLS),shiftEffect);

    shiftEffect=SupernaturalEffect(shiftEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,shiftEffect,oPC);
    }
}
