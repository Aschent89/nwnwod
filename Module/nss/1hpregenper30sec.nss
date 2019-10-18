void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectRegenerate(1, 30.0f);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}
