
void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_RESISTANCE, oTarget, METAMAGIC_ANY, TRUE, 1, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

effect eEffect;
eEffect = EffectDamage(30, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, GetItemActivator());

eEffect = EffectDamageIncrease(DAMAGE_BONUS_2d8, DAMAGE_TYPE_MAGICAL);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 180.0f);

}
