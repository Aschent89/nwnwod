////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Auto Shut Door Night Lock
//  ors_autoshutnl
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Door OnOpen AND OnFailToOpen Events
//
//  This will work for ANY Door.....except the ones you make  _NL  on the RIGHT
//  side of the Tag!
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oDoor        = OBJECT_SELF;
    object oPC          = GetLastOpenedBy();

    int nNight          = GetIsNight();
    int nDay            = GetIsDay();
    int nDawn           = GetIsDawn();
    int nDusk           = GetIsDusk();
    int nClosing        = GetLocalInt(oDoor,"CLOSING");

    string sDoor        = GetTag(oDoor);
    string sNoLock      = GetStringRight(sDoor, 3);
    string sMessage     = "Closed during night!";

    //This is the Auto Close Delay
    float fASD = GetLocalFloat(GetModule(),"ASD");//See  ors_mod_onload
    float fASO = GetLocalFloat(OBJECT_SELF,"ASD");//Override Delay

    //Check to see if this is an NPC
    if(!GetIsPC(oPC)) return;

    //Check to see if it is already closing
    if(nClosing == 1) return;

    //Check for Night
    if(nDusk == TRUE || nNight == TRUE)
    {
      //If the Door is Locked
      if(GetLocked(oDoor) == TRUE)
      {
        //Check to see of the Door is a Closed at Night Door
        int nClosed = GetLocalInt(oDoor,"CLOSEDATNIGHT");
        if(nClosed == 1)
        {
          SendMessageToPC(oPC,sMessage);
          return;
        }
        else return;
      }

      if(GetLocked(oDoor) == FALSE)
      {
        //Check to see if this is a Locking Door
        if(sNoLock != "_NL")
        {
          AssignCommand(oPC,ClearAllActions(TRUE));
          ActionCloseDoor(oDoor);
          if(fASO > 0.0) DelayCommand(fASO, ActionCloseDoor(OBJECT_SELF));
          else DelayCommand(fASD, ActionCloseDoor(OBJECT_SELF));
          SetLocalInt(oDoor,"CLOSEDATNIGHT",1);
          SendMessageToPC(oPC,sMessage);
          return;
        }
        else
        {
          DeleteLocalInt(oDoor,"CLOSEDATNIGHT");
          SetLocalInt(oDoor,"CLOSING",1);
          ActionOpenDoor(oDoor);
          if(fASO > 0.0) DelayCommand(fASO, ActionCloseDoor(OBJECT_SELF));
          else DelayCommand(fASD, ActionCloseDoor(OBJECT_SELF));
          DelayCommand(fASD + 0.5,DeleteLocalInt(oDoor,"CLOSING"));
          return;
        }
      }
    }

    if(nDawn == TRUE || nDay == TRUE)
    {
      //If the Door is Locked
      if(GetLocked(oDoor) == TRUE)
      {
        DeleteLocalInt(oDoor,"CLOSEDATNIGHT");
        SetLocalInt(oDoor,"CLOSING",1);
        ActionDoCommand(SetLocked(oDoor,FALSE));
        ActionOpenDoor(oDoor);
        if(fASO > 0.0) DelayCommand(fASO, ActionCloseDoor(OBJECT_SELF));
        else DelayCommand(fASD, ActionCloseDoor(OBJECT_SELF));
        DelayCommand(fASD + 0.5,DeleteLocalInt(oDoor,"CLOSING"));
        return;
      }

      //If the Door is Not Locked
      if(GetLocked(oDoor) == FALSE)
      {
        DeleteLocalInt(oDoor,"CLOSEDATNIGHT");
        SetLocalInt(oDoor,"CLOSING",1);
        ActionOpenDoor(oDoor);
        if(fASO > 0.0) DelayCommand(fASO, ActionCloseDoor(OBJECT_SELF));
        else DelayCommand(fASD, ActionCloseDoor(OBJECT_SELF));
        DelayCommand(fASD + 0.5,DeleteLocalInt(oDoor,"CLOSING"));
        return;
      }
    }
}
