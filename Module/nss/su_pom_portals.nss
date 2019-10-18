void main()
{
    object oPC = GetLastUsedBy();
    object oExit = GetWaypointByTag(GetLocalString(OBJECT_SELF, "Target"));
    AssignCommand(oPC, ActionJumpToObject(oExit, FALSE));
}
