void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FREEDOM_OF_MOVEMENT, oTarget, METAMAGIC_ANY, TRUE, 12, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}

