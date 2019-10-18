////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Auto Shut Door
//  ors_autoshut
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Door OnOpen Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    float fASD = GetLocalFloat(GetModule(),"ASD");//See  ors_mod_onload
    float fASO = GetLocalFloat(OBJECT_SELF,"ASD");//Override Delay

    if(fASO > 0.0) DelayCommand(fASO, ActionCloseDoor(OBJECT_SELF));
    else DelayCommand(fASD, ActionCloseDoor(OBJECT_SELF));
}
