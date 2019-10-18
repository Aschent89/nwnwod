/*
 * Activates the LRES
 *
 * MvDunkelfels 2005-1-8
 */

#include "mvd_02_const"
#include "mvd_02_giver"

void main()
{
    object oModule = GetModule();
    SetLocalInt( oModule, cMvD_02_sLRESAktive, TRUE );

    int iCurrentMin = GetTimeMinute();
    int iCurrentHour = GetTimeHour();
    int iMaxRes = GetLocalInt( oModule, cMvD_02_sMaxResiduum );
    int iMinDiag = GetLocalInt( oModule, cMvD_02_sMinDialogCount );
    int iPCRandomTime = GetLocalInt( oModule, cMvD_02_sIsPCRandomTime );
    int iMinTimeDiff = GetLocalInt( oModule, cMvD_02_sMinTimeDiff );
    int iMaxTimeDiff = GetLocalInt( oModule, cMvD_02_sMaxTimeDiff );

    object oPC = GetFirstPC();
    while( GetIsObjectValid( oPC ) ) {
        MvD_02_ResetPC( oPC, iCurrentHour, iCurrentMin, iMinDiag,
                iMaxRes, iPCRandomTime, iMinTimeDiff, iMaxTimeDiff );
        oPC = GetNextPC();
    }

}
