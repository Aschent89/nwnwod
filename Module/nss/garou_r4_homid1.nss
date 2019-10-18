
void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_MIND_BLANK, oTarget, METAMAGIC_ANY, TRUE, 28, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
