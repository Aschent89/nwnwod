////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - On Fail To Open
//  ors_door_ofto
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Door OnFailToOpen Events
//
//  This will Open a Door IF a Player has a Key that matches the Variable
//  KEY  string  TagOfKey
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oDoor = OBJECT_SELF;
    object oPC = GetClickingObject();

    //This is the Auto Close Delay
    float fASD = GetLocalFloat(GetModule(),"ASD");//See  ors_mod_onload
    float fASO = GetLocalFloat(oDoor,"ASD");//Override Delay

    //Check to see if this is an NPC
    if(!GetIsPC(oPC)) return;

    //If the Door is Locked
    if(GetLocked(oDoor) == TRUE)
    {
      //Check for Key on Player
      string sKey = GetLocalString(oDoor,"KEY");
      object oKey = GetItemPossessedBy(oPC,sKey);
      if(GetIsObjectValid(oKey))
      {
        AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0));
        DelayCommand(1.5, ActionOpenDoor(oDoor));
        if(fASO > 0.0) DelayCommand(fASO, ActionCloseDoor(oDoor));
        else DelayCommand(fASD, ActionCloseDoor(oDoor));
        SetLocked(oDoor,TRUE);
      }
      else
      {
        AssignCommand(oPC, SpeakString ("Bah!  Must be locked."));
      }
    }
}
