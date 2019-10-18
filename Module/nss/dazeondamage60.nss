void main()
{

object oPC = GetLastHostileActor();

if (!GetIsPC(oPC)) return;

if (!(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL))
   return;

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectDazed();

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

}
