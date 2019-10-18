void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FIRE_STORM, oTarget, METAMAGIC_ANY, TRUE, 22, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_ICE_STORM, oTarget, METAMAGIC_ANY, TRUE, 22, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_STORM_OF_VENGEANCE, oTarget, METAMAGIC_ANY, TRUE, 22, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}

