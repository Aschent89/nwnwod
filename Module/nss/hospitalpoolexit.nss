void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectRegenerate(1, 10.0f);

//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 3600.0f);
RemoveEffect(oTarget, eEffect);
}
