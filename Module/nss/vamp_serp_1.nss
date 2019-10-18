
void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectCutsceneParalyze();

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 20.0f);

}
