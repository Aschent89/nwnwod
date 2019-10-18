void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_ICE_DAGGER, oTarget, METAMAGIC_ANY, TRUE, 12, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));

}
