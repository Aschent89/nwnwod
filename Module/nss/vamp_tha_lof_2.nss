void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FLAME_ARROW, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FLAME_ARROW, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
