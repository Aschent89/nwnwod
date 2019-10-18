/*
 * Set CUSTOM tokens for printing of the PC values
 *
 * MvDunkelfels 2004-12-10
 */

#include "mvd_02_const"
#include "mvd_02_modheart"

int StartingConditional()
{
    object oModule = GetModule();
    object oTarget = GetLocalObject( OBJECT_SELF, cMvD_02_sTargetObject );
    string sName = GetName( oTarget );
    string sDiag = IntToString( GetLocalInt( oTarget, cMvD_02_sDiagCounter ) );
    int iLastHour = GetLocalInt( oTarget, cMvD_02_sHourLastRun );
    int iLastMin = GetLocalInt( oTarget, cMvD_02_sMinuteLastRun );
    int iCurrentMin = GetTimeMinute();
    int iCurrentHour = GetTimeHour();
    string sDiff = IntToString( MvD_02_TimeDiff( iCurrentHour, iCurrentMin,
                    iLastHour, iLastMin ) );
    int iSperre = GetLocalInt( oTarget, cMvD_02_sIsBlocked );
    SetCustomToken( 5000, sName );
    SetCustomToken( 5001, sDiag );
    SetCustomToken( 5003, sDiff );

    if( GetLocalInt( oModule, cMvD_02_sIsPCRandomTime ) ) {
        SetCustomToken( 5004, IntToString( GetLocalInt( oTarget,
                cMvD_02_sPCTimeDiff ) ) );
    } else {
        SetCustomToken( 5004, IntToString( GetLocalInt( oModule,
                cMvD_02_sMinTimeDiff ) ) );
    }
    if( iSperre ) {
        SetCustomToken( 5002, "blocked" );
    } else {
        SetCustomToken( 5002, "unblocked" );
    }
    return( TRUE );
}
