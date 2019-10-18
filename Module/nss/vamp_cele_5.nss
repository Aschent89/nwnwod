void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;


effect eEffect;


AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_IMPROVED_INVISIBILITY, oTarget, METAMAGIC_ANY, TRUE, 18, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));


eEffect = EffectHaste();

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 180.0f);

eEffect = EffectAttackIncrease(3);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 180.0f);

eEffect = EffectMovementSpeedIncrease(25);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 180.0f);

}
