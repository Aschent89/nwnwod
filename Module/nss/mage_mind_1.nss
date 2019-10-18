void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectSavingThrowIncrease(SAVING_THROW_WILL, 3, SAVING_THROW_TYPE_ALL);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

}
