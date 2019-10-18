void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectAbilityIncrease(ABILITY_STRENGTH, 6);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY, 6);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION, 6);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

eEffect = EffectDamageIncrease(DAMAGE_BONUS_2d8, DAMAGE_TYPE_SLASHING);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

eEffect = EffectSavingThrowDecrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_ALL);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

eEffect = EffectAbilityDecrease(ABILITY_WISDOM, 4);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

}
