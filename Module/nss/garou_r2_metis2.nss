void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_HOLD_PERSON, oTarget, METAMAGIC_ANY, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
