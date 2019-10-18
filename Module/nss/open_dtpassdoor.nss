void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("DTPassDoor");

SetLocked(oTarget, FALSE);

DelayCommand(0.5, AssignCommand(oTarget, ActionOpenDoor(oTarget)));

}

