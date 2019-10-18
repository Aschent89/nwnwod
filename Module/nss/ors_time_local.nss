////////////////////////////////////////////////////////////////////////////////
//  Local(City) Time Clock
//  ors_time_local
//  By Don Anderson
//  dandersonru@msn.com
//
//  This gives you the Current Time and Day and Gongs at the Top and Bottom of the Hour.
//  NOTE: Because of the nature of custom setting the minutes per hours PLEASE
//        USE minutes that are in multiples of 2 (Or the standard 2 Min of Bioware)
//
//   This is Called from the User Defined Event 205
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
    //For each Local Clock
    int nNth = 0;
    object oClock = GetObjectByTag("LocalClock",nNth);

    while(oClock != OBJECT_INVALID)
    {
      //Start the Local Clock
      int nClock = GetLocalInt(oClock,"LCLOCK_STARTED");
      if(nClock == 0)
      {
        SetLocalInt(oClock,"LCLOCK_STARTED",1);
        AssignCommand(oClock,LocalTime(oClock,0));
      }
      //Clock has been started already
      if(nClock == 1) AssignCommand(oClock,LocalTime(oClock,0));

      nNth++;
      if(nNth > 50) break;//Break out of loop
      oClock = GetObjectByTag("LocalClock",nNth);
    }
}
