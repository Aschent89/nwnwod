void main()
{
object oPC;

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_BIGBYS_FORCEFUL_HAND, oTarget, METAMAGIC_ANY, TRUE, 40, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_HOLD_MONSTER, oTarget, METAMAGIC_ANY, TRUE, 40, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
