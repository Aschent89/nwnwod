void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_SANCTUARY, oTarget, METAMAGIC_ANY, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

effect eEffect;
eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 50);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 40);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 40);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 40);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, 30);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 30);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 30);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 30);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 30);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 30);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 360.0f);

}

