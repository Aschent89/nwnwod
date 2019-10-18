
void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_CONFUSION, oTarget, METAMAGIC_ANY, TRUE, 24, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oTarget = oPC;

effect eEffect;
eEffect = EffectSavingThrowIncrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_ALL);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);

}
