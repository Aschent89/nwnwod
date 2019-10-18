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
eEffect = EffectDamageReduction(60, DAMAGE_POWER_NORMAL);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_PIERCING, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_SLASHING, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_ACID, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_COLD, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_FIRE, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_SONIC, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 270.0f);

}
