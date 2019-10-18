/*
 * Functions used for the HeartBeat.
 *
 * MvDunkelfels 2004-12-5
 */

#include "mvd_02_const"

/*
 * This function calculates the difference between the "current" time
 * and the "last" time in minutes.
 * iCurrentHour: The "Current" hour
 * iCurrentMin: The "Current" minute
 * iLastHour: the "Last" hour
 * iLastMin: the "Last" minute
 * RETURN: Time difference in minutes
 */
int MvD_02_TimeDiff( int iCurrentHour, int iCurrentMin, int iLastHour,
        int iLastMin );

/*
 * Function that should be called in the MOdule HeartBeat.
 */
void MvD_02_ModuleHeartBeat();


void MvD_02_ModuleHeartBeat() {
    object oModule = GetModule();
    int iTimeToRun = GetLocalInt( oModule, cMvD_02_sHeartBeatTime );
    int iCurrentMin = GetTimeMinute();
    int iCurrentHour = GetTimeHour();
    int iLastMinute = GetLocalInt( oModule, cMvD_02_sMinuteLastRun );
    int iLastHour = GetLocalInt( oModule, cMvD_02_sHourLastRun );

    // Test if we should run
    if( MvD_02_TimeDiff( iCurrentHour, iCurrentMin, iLastHour,
                    iLastMinute ) >= iTimeToRun ) {
        // If so, set "last" time
        SetLocalInt( oModule, cMvD_02_sHourLastRun, iCurrentHour );
        SetLocalInt( oModule, cMvD_02_sMinuteLastRun, iCurrentMin );

        // Signal the hub to start checking and alloting.
        SignalEvent( GetObjectByTag( cMvD_02_sHubTag ),
            EventUserDefined( cMvD_02_iUserEventNr ) );
    }
}

int MvD_02_TimeDiff( int iCurrentHour, int iCurrentMin, int iLastHour,
        int iLastMin ) {
    int iMinDiff = 0;
    int iMinPerH = FloatToInt( HoursToSeconds( 1 ) ) / 60;
    if( iCurrentHour >= iLastHour ) {
        iMinDiff = iMinPerH * ( iCurrentHour - iLastHour );
    } else {
        iMinDiff = iMinPerH * ( 24 - iLastHour + iCurrentHour );
    }
    iMinDiff += ( iCurrentMin - iLastMin );
    return( iMinDiff );
}
