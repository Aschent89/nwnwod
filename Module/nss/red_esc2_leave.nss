void main()
{
object oPC = GetLastUsedBy();
location lLoc = GetLocation(GetWaypointByTag("ESCRYPT_UP"));
AssignCommand(oPC,ActionJumpToLocation(lLoc));
}
