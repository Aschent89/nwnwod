void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_HASTE, oTarget, METAMAGIC_ANY, TRUE, 16, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
