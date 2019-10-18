void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = OBJECT_SELF;

effect eEffect;
eEffect = EffectDeath();

eEffect = SupernaturalEffect(eEffect);

DelayCommand(500.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f));

}
