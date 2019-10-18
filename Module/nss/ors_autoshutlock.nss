////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Auto Shut and Lock
//  ors_autoshutlock
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Door OnOpen Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    float fASD = GetLocalFloat(GetModule(),"ASD");//See  opw_mod_onload
    float fASO = GetLocalFloat(OBJECT_SELF,"ASD");//Override Delay

    if(fASO > 0.0)
    {
      DelayCommand(fASO - 2.0, ActionDoCommand(SetLocked(OBJECT_SELF,TRUE)));
      DelayCommand(fASO, ActionCloseDoor(OBJECT_SELF));
    }
    else
    {
      DelayCommand(fASD - 2.0, ActionDoCommand(SetLocked(OBJECT_SELF,TRUE)));
      DelayCommand(fASD, ActionCloseDoor(OBJECT_SELF));
    }
}
