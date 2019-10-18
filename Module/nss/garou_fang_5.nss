
void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectDamageResistance(DAMAGE_TYPE_ACID, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_COLD, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_FIRE, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_SONIC, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);


eEffect = EffectDamageResistance(DAMAGE_TYPE_SLASHING, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_PIERCING, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);
}
