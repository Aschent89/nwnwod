/*
 * Force XP distribution run
 *
 * MvDunkelfels 2004-12-13
 */
#include "mvd_02_giver"
#include "mvd_02_const"

void main()
{
    object oModule = GetModule();
    int iCurrentHour = GetTimeHour();
    int iCurrentMin = GetTimeMinute();
    SetLocalInt( oModule, cMvD_02_sHourLastRun, iCurrentHour );
    SetLocalInt( oModule, cMvD_02_sMinuteLastRun, iCurrentMin );
    MvD_02_AllotXP();
}
