
void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_BULLS_STRENGTH, oTarget, METAMAGIC_ANY, TRUE, 18, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

effect eEffect;
eEffect = EffectAbilityIncrease(ABILITY_STRENGTH, 4);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY, 4);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

eEffect = EffectRegenerate(4, 5.0f);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 420.0f);

}

