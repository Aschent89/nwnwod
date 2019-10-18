#include "nw_i0_generic"
void main()
{

object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
if (GetItemPossessedBy(oPC, "ks_bloodhunt")== OBJECT_INVALID)
   return;

object oTarget;
oTarget = GetObjectByTag("ks_camguard");

AdjustReputation(oPC, oTarget, -100);

SetIsTemporaryEnemy(oPC, oTarget);

AssignCommand(oTarget, ActionAttack(oPC));

AssignCommand(oTarget, DetermineCombatRound(oPC));

}
