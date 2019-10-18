void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;

object oCaster;
oCaster = oPC;

//AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_SANCTUARY, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

eEffect = EffectSkillIncrease(SKILL_BLUFF, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 240.0f);

eEffect = EffectSkillIncrease(SKILL_INTIMIDATE, 10);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 240.0f);

eEffect = EffectSkillIncrease(SKILL_PERSUADE, 10);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 240.0f);

}
