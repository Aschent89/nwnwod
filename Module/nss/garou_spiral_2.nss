void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING, 15);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_PIERCING, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectDamageResistance(DAMAGE_TYPE_SLASHING, 10);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

}
