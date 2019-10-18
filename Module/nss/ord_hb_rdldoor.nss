////////////////////////////////////////////////////////////////////////////////
//
//  Olander's - Riddle Doors
//  ord_hb_rdldoor
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is a Heartbeat Script that runs on the Riddle Door Listener.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oLis = OBJECT_SELF;
  int nCC = GetLocalInt(oLis,"CYCLECOUNT");
  int nCycle = 6;
  int nNth;

  string sDoor = GetLocalString(oLis,"RIDDLE_DOOR");
  if(sDoor == "TAG") sDoor = "RiddleDoor";
  object oDoor = GetNearestObjectByTag(sDoor);
  if(!GetIsOpen(oDoor))
  {
    int nLPN = GetListenPatternNumber();
    if(nLPN == 60000)
    {
      SetLocked(oDoor,FALSE);
      AssignCommand(oDoor,ActionOpenDoor(oDoor));
      DestroyObject(oLis,0.1);
    }
  }

  nCC++;
  if(nCC > nCycle){DestroyObject(oLis,0.1);}
  else SetLocalInt(oLis, "CYCLECOUNT", nCC);
}
