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
eEffect = EffectAbilityIncrease(ABILITY_STRENGTH, 12);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION, 6);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 123.0f);

}
