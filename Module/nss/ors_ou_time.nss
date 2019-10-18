////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Time Clock
//  ors_ou_time
//  By Don Anderson
//  dandersonru@msn.com
//
//  This gives you the Current Time and Day when a Clock is Used
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
    object oClock = OBJECT_SELF;
    AssignCommand(oClock,LocalTime(oClock,1));
}
