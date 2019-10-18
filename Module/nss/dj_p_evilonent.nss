void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (!(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL))
   return;

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectParalyze();

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}
