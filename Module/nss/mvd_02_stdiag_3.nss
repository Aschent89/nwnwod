/*
 * Reactivates the XP givings of the LRES for this PC and resets his
 * vars to login values.
 *
 * MvDunkelfels 2004-12-12
 */
#include "mvd_02_const"
#include "mvd_02_giver"
void main()
{
    object oTarget = GetLocalObject( OBJECT_SELF, cMvD_02_sTargetObject );
    if( GetLocalInt( oTarget, cMvD_02_sIsBlocked ) ) {
        object oModule = GetModule();
        int iCurrentMin = GetTimeMinute();
        int iCurrentHour = GetTimeHour();
        int iMaxRes = GetLocalInt( oModule, cMvD_02_sMaxResiduum );
        int iMinDiag = GetLocalInt( oModule, cMvD_02_sMinDialogCount );
        int iPCRandomTime = GetLocalInt( oModule, cMvD_02_sIsPCRandomTime );
        int iMinTimeDiff = GetLocalInt( oModule, cMvD_02_sMinTimeDiff );
        int iMaxTimeDiff = GetLocalInt( oModule, cMvD_02_sMaxTimeDiff );
        MvD_02_ResetPC( oTarget, iCurrentHour, iCurrentMin, iMinDiag,
                iMaxRes, iPCRandomTime, iMinTimeDiff, iMaxTimeDiff );
        SetLocalInt( oTarget, cMvD_02_sIsBlocked, FALSE );
    }
}
