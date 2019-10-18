void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_BESTOW_CURSE, oTarget, METAMAGIC_ANY, TRUE, 40, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
