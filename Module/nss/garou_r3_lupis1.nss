

void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_CATS_GRACE, oTarget, METAMAGIC_ANY, TRUE, 18, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

effect eEffect;
eEffect = EffectSkillIncrease(SKILL_DISCIPLINE, 16);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

}

