void main()
{
object PC = GetPCSpeaker();
object   oWaypoint = GetWaypointByTag("welcomeToWod");
location lLocation = GetLocation(oWaypoint);
AssignCommand(PC,ActionJumpToLocation(lLocation));




}
