void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FINGER_OF_DEATH, oTarget, METAMAGIC_ANY, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
