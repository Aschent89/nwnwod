void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_DEATH_ARMOR, oTarget, METAMAGIC_ANY, TRUE, 22, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_ELEMENTAL_SHIELD, oTarget, METAMAGIC_ANY, TRUE, 22, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_MESTILS_ACID_SHEATH, oTarget, METAMAGIC_ANY, TRUE, 22, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));

}
