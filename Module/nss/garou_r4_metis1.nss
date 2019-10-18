void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectConcealment(50);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

object oCaster;
oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_IMPROVED_INVISIBILITY, oTarget, METAMAGIC_ANY, TRUE, 6, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
