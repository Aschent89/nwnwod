void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectDamageReduction(15, DAMAGE_POWER_PLUS_ONE);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_FIRE, 15);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);


eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, 90);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 90);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageReduction(30, DAMAGE_POWER_NORMAL);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING, 15);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_PIERCING, 15);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_SLASHING, 15);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_ACID, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_COLD, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_FIRE, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_SONIC, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

}
