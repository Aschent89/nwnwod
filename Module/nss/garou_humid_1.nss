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
eEffect = EffectDamageResistance(DAMAGE_TYPE_FIRE, 15);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

}
