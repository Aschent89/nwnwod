void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_TRUE_SEEING, oTarget, METAMAGIC_ANY, TRUE, 24, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oTarget, METAMAGIC_ANY, TRUE, 24, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_ETHEREAL_VISAGE, oTarget, METAMAGIC_ANY, TRUE, 24, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));


effect eEffect;
eEffect = EffectSkillIncrease(SKILL_SPOT, 8);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);

eEffect = EffectSkillIncrease(SKILL_LISTEN, 8);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);

eEffect = EffectSkillIncrease(SKILL_SEARCH, 8);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);

}
