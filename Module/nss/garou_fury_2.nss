void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectDamageIncrease(DAMAGE_BONUS_1d8, DAMAGE_TYPE_PIERCING);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

}
