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
eEffect = EffectDamageIncrease(DAMAGE_BONUS_12, DAMAGE_TYPE_SLASHING);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 93.0f);

}
