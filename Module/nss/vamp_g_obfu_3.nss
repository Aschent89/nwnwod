void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_RESISTANCE, oTarget, METAMAGIC_ANY, TRUE, 1, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

//The PC will technically start a conversation with himself
//You should add some odd little sound to the first line in the
//conversation file, or the PC will give his normal voicegreeting.

AssignCommand(oTarget, ActionStartConversation(oPC, "1000faces"));


effect eEffect;
eEffect = EffectSkillIncrease(SKILL_HIDE, 8);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);

eEffect = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 8);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 720.0f);
}

