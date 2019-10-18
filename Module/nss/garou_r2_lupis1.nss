

void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oTarget, METAMAGIC_ANY, TRUE, 18, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oTarget = oPC;

effect eEffect;
eEffect = EffectSkillIncrease(SKILL_SPOT, 12);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 180.0f);

}

