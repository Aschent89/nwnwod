void main()
{
    object oPC = GetItemActivator();
    object oExit = GetWaypointByTag("POM_EntryPort");
    AssignCommand(oPC, ActionJumpToObject(oExit, FALSE));
}
