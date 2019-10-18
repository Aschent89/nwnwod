void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

effect eEffect;
eEffect = EffectSummonCreature("garou_sasquatch", VFX_FNF_NATURES_BALANCE, 1.0);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 120.0);

}

