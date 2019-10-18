void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectSavingThrowIncrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_ALL);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

}
