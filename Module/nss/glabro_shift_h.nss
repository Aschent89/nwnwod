#include "NW_I0_GENERIC"

void glabroShift(object oPC){
    int nLocked=FALSE;
    string sSound = "as_an_wolfhowl2";
    PlaySound(sSound);
    ActionPlayAnimation(ANIMATION_LOOPING_SPASM ,1.0, 2.0);
    PlayVoiceChat(VOICE_CHAT_PAIN1, oPC);
    string s1 =  GetPCPlayerName(oPC);
    string s2 = "You feel your bones shift as you change into Glabro form.";
    SetLocalInt(oPC, "Glabro", 1);
    SetLocalInt(oPC, "glabro_form", 1);
    SetLocalInt(oPC, "shifted", 1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED), oPC);
    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oPC));
//    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), oPC, 3.0);

    FloatingTextStringOnCreature(s2, oPC);

    int oLevel = GetCharacterLevel(oPC);
    effect shiftEffect;
    effect tempHPEffect;

    if ((GetLevelByClass(CLASS_TYPE_MONK, oPC)>0))
   {
   //     shiftEffect=EffectDamageIncrease(DAMAGE_BONUS_1d6,DAMAGE_TYPE_POSITIVE);
  //      shiftEffect=EffectLinkEffects(EffectACIncrease(5),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectRegenerate(2,8.0),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_STRENGTH,4),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityDecrease(ABILITY_CHARISMA,4),shiftEffect);
     //   shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_DEXTERITY,4),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_CONSTITUTION,4),shiftEffect);
    //    shiftEffect=EffectLinkEffects(EffectMovementSpeedIncrease(15),shiftEffect);
//                tempHPEffect=EffectTemporaryHitpoints(Random(30));
                shiftEffect=EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_MIND_SPELLS),shiftEffect);

    shiftEffect=SupernaturalEffect(shiftEffect);
//    tempHPEffect=SupernaturalEffect(tempHPEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,shiftEffect,oPC);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT,tempHPEffect,oPC);

    }

else
   {
        shiftEffect=EffectDamageIncrease(DAMAGE_BONUS_1d6,DAMAGE_TYPE_POSITIVE);
  //      shiftEffect=EffectLinkEffects(EffectACIncrease(5),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectRegenerate(2,8.0),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_STRENGTH,4),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityDecrease(ABILITY_CHARISMA,4),shiftEffect);
     //   shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_DEXTERITY,4),shiftEffect);
        shiftEffect=EffectLinkEffects(EffectAbilityIncrease(ABILITY_CONSTITUTION,4),shiftEffect);
    //    shiftEffect=EffectLinkEffects(EffectMovementSpeedIncrease(15),shiftEffect);
//                tempHPEffect=EffectTemporaryHitpoints(Random(30));
                shiftEffect=EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_MIND_SPELLS),shiftEffect);

    shiftEffect=SupernaturalEffect(shiftEffect);
//    tempHPEffect=SupernaturalEffect(tempHPEffect);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,shiftEffect,oPC);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT,tempHPEffect,oPC);

    }
}
