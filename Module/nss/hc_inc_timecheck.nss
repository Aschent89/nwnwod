//  ----------------------------------------------------------------------------
//  hc_inc_timecheck
//  ----------------------------------------------------------------------------
/*
    Common function for checking the time elapsed.

    HCR 3.02 - Unresolved Issues
    ----------------------------
    There remains a BioWare bug that means that when the game time rolls round
    onto a new year it will jump to first day of the sixth month instead of the
    first day of the first month.

*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 05 August 2004 - Sunjammer
    - rewritten

    Credits:
    - Archaegeo
*/
//  ----------------------------------------------------------------------------
#include "hc_inc_pwdb_func"


//  ----------------------------------------------------------------------------
//  VARIABLES
//  ----------------------------------------------------------------------------

// deprecated
int nConv = FloatToInt(HoursToSeconds(1));


//  ----------------------------------------------------------------------------
//  PROTOTYPES
//  ----------------------------------------------------------------------------

// returns the number of seconds since the module started
int HC_GetSecondsSinceStart();


//  ----------------------------------------------------------------------------
//  DEPRECATED
//  ----------------------------------------------------------------------------

int SecondsSinceBegin()
{
    // call updated function
    return HC_GetSecondsSinceStart();
}


//  ----------------------------------------------------------------------------
//  FUNCTIONS
//  ----------------------------------------------------------------------------

int HC_GetSecondsSinceStart()
{
    int nElapsed;
    object oMod = GetModule();

    // get start date and time
    int nStartYr = GetPersistentInt(oMod, "YearStart");
    int nStartMn = GetPersistentInt(oMod, "MonthStart");
    int nStartDy = GetPersistentInt(oMod, "DayStart");
    int nStartHr = GetPersistentInt(oMod, "HourStart");

    // get current date and time
    int nCurYr = GetCalendarYear();
    int nCurMn = GetCalendarMonth();
    int nCurDy = GetCalendarDay();
    int nCurHr = GetTimeHour();
    int nCurMi = GetTimeMinute();
    int nCurSc = GetTimeSecond();

    // get the real time to game time conversion factor (TCF)
    int nTCF = FloatToInt(HoursToSeconds(1));

    // calculate difference between now and then
    nElapsed = nCurYr - nStartYr;                           // years
    nElapsed = (nElapsed * 12) + (nCurMn - nStartMn);       // to months
    nElapsed = (nElapsed * 28) + (nCurDy - nStartDy);       // to days
    nElapsed = (nElapsed * 24) + (nCurHr - nStartHr);       // to hours
    nElapsed = (nElapsed * nTCF) + (nCurMi * 60) + nCurSc;  // to seconds

    // return the total
    return nElapsed;
}

