
void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_IMPROVED_INVISIBILITY, oTarget, METAMAGIC_ANY, TRUE, 18, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_IMPROVED_INVISIBILITY, oTarget, METAMAGIC_ANY, TRUE, 18, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_INVISIBILITY_SPHERE, oTarget, METAMAGIC_ANY, TRUE, 24, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_INVISIBILITY_SPHERE, oTarget, METAMAGIC_ANY, TRUE, 24, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

effect eEffect;
eEffect = EffectSkillIncrease(SKILL_HIDE, 12);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);

eEffect = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 12);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);

}
