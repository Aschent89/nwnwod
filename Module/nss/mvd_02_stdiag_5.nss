/*
 * Resets the PC
 *
 * MvDunkelfels 2004-12-13
 */
#include "mvd_02_const"
#include "mvd_02_giver"

void main()
{
    object oTarget = GetLocalObject( OBJECT_SELF, cMvD_02_sTargetObject );
    object oModule = GetModule();
    int iPCRandomTime = GetLocalInt( oModule, cMvD_02_sIsPCRandomTime );
    int iMinTimeDiff = GetLocalInt( oModule, cMvD_02_sMinTimeDiff );
    int iMaxTimeDiff = GetLocalInt( oModule, cMvD_02_sMaxTimeDiff );
    int iCurrentMin = GetTimeMinute();
    int iCurrentHour = GetTimeHour();
    int iMaxRes = GetLocalInt( oModule, cMvD_02_sMaxResiduum );
    int iMinDiag = GetLocalInt( oModule, cMvD_02_sMinDialogCount );
    MvD_02_ResetPC( oTarget, iCurrentHour, iCurrentMin, iMinDiag,
            iMaxRes, iPCRandomTime, iMinTimeDiff, iMaxTimeDiff );
}
