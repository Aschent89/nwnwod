void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

effect eEffect;
eEffect = EffectSummonCreature("mage_entr_5");

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 120.0);

}
