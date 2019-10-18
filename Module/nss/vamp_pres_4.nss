void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

effect eEffect;
eEffect = EffectSummonCreature("vamp_pres_4");

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 300.0);

}
