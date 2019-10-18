void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectSkillIncrease(SKILL_CRAFT_ARMOR, 12);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 240.0f);

eEffect = EffectSkillIncrease(SKILL_CRAFT_WEAPON, 12);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 240.0f);

eEffect = EffectSkillIncrease(SKILL_CRAFT_TRAP, 12);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 240.0f);

}
