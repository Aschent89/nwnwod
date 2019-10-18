void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
//eEffect = EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);

//eEffect = ExtraordinaryEffect(eEffect);

//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

eEffect = EffectImmunity(IMMUNITY_TYPE_ABILITY_DECREASE);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

}
