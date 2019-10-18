void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

effect eEffect;
eEffect = EffectSummonCreature("vamp_obte_shad", VFX_FNF_HORRID_WILTING, 1.0);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 180.0);

}
