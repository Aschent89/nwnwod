////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Siege System - Siege Keg..Lights the Fuse When Used By Someone
//  os_keg_onused
//  by Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "os_inc"

void main()
{
    object oPC = GetLastUsedBy();
    object oKeg = OBJECT_SELF;
    string sFuse = "FUSELIT";

    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0));

    //To make sure there are no double ligting of the fuse
    if (GetLocalInt(oKeg,sFuse) == 1) return;
    SetLocalInt(oKeg,sFuse,1);

    DelayCommand(2.5,OS_SmokingKeg(oKeg));
    DelayCommand(5.0,OS_SmokingKeg(oKeg));
    DelayCommand(7.5,OS_SmokingKeg(oKeg));
    DelayCommand(8.0,OS_FireKeg(oKeg));
    DelayCommand(9.0,OS_SmokingKeg(oKeg));
    DelayCommand(10.0,ExecuteScript("os_keg_detonate",oKeg));
}
