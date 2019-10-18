
void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_HOLD_PERSON, oTarget, METAMAGIC_ANY, TRUE, 16, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oTarget = oPC;

effect eEffect;
eEffect = EffectSavingThrowIncrease(SAVING_THROW_WILL, 2, SAVING_THROW_TYPE_ALL);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);

}
