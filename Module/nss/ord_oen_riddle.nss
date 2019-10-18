////////////////////////////////////////////////////////////////////////////////
//
//  Olander's - Riddle Doors
//  ord_oen_riddle
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is a Trigger OnEnter Script that runs on the Riddle Door. This actually
//  Creates the Riddle Listener object. Paint this around the Riddle Door.
//
//  If this Door is also a Transition Door....it must be Unique as well. Change
//  The door variable to the Tag of the Riddle Door to what yours is.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetEnteringObject();
  string sDoor = GetLocalString(OBJECT_SELF,"RIDDLE_DOOR");
  if(sDoor == "TAG") sDoor = "RiddleDoor";
  object oDoor = GetNearestObjectByTag(sDoor);
  if(!GetIsOpen(oDoor))
  {
    //Not for NPCs
    if(GetIsPC(oPC) == FALSE && GetIsDM(oPC) == FALSE && GetIsDMPossessed(oPC) == FALSE) return;

    //Check for a Matching Key/Letter
    string sKey = GetLocalString(oDoor,"RIDDLE_KEY");
    object oKey = GetItemPossessedBy(oPC,sKey);
    if(GetIsObjectValid(oKey))
    {
      SetLocked(oDoor,FALSE);
      AssignCommand(oDoor,ActionOpenDoor(oDoor));
      return;
    }

    //Create the Listener
    location lLoc = GetLocation(oPC);
    object oLis = CreateObject(OBJECT_TYPE_PLACEABLE,"listener",lLoc);
    string sAnswer = GetLocalString(oDoor,"RIDDLE_ANSWER");
    SetLocalString(oLis,"RIDDLE_DOOR",sDoor);
    SetListenPattern(oLis,sAnswer,60000);
    SetListening(oLis,TRUE);
  }
}
