/*
 * Functions to initialise the Module and the PC logging in.
 *
 * MvDunkelfels 2004-12-11
 */

#include "MvD_02_Const"

/*
 * This function initialises the Status of the PC on log in.
 * Must be called in OnClientEnter.
 */
void MvD_02_PlayerEnter();

/*
 * This function accounts for leaving PCs in the minimal dialog
 * count needed. Must be called in OnClientExit.
 */
void MvD_02_PlayerExit();

/*
 * This function sets an NSC/object up as a listener.
 * oNSC: The object to set up.
 */
void MvD_02_NSCInit( object oNSC );

/*
 * This function initialises the Module for the use of the LRES.
 * Must be called in OnModuleLoad.
 */
void MvD_02_ModInit();

void MvD_02_PlayerEnter() {
    object oPC = GetEnteringObject();

    // If it is a DM Client return
    if( GetIsDM( oPC ) ) {
        return;
    }

    // If its a player
    if( GetIsPC( oPC ) ) {
        object oModule = GetModule();
        int iMinDiagCount = GetLocalInt( oModule, cMvD_02_sMinDialogCount );
        int iCountPerPC = GetLocalInt( oModule, cMvD_02_sCountPerPC );
        int iMinTimeDiff = GetLocalInt( oModule, cMvD_02_sMinTimeDiff );
        int iMaxTimeDiff = GetLocalInt( oModule, cMvD_02_sMaxTimeDiff );
        int iRandomTime = Random( iMaxTimeDiff - iMinTimeDiff ) + iMinTimeDiff;

        SetLocalInt( oPC, cMvD_02_sDiagCounter, 0 );
        SetLocalInt( oPC, cMvD_02_sHourLastGiven, GetTimeHour() );
        SetLocalInt( oPC, cMvD_02_sMinLastGiven, GetTimeMinute() );
        SetLocalInt( oPC, cMvD_02_sIsBlocked, FALSE );
        SetLocalInt( oPC, cMvD_02_sPCTimeDiff, iRandomTime );
        SetLocalFloat( oPC, cMvD_02_sXPMult, IntToFloat( iRandomTime ) /
                IntToFloat( iMinTimeDiff ) );
        if( (iMinDiagCount + iCountPerPC) >= 65300 ) {
            SetLocalInt(oModule, cMvD_02_sMinDialogCount, 65300 );
        } else {
            SetLocalInt( oModule, cMvD_02_sMinDialogCount, iMinDiagCount +
                iCountPerPC );
        }
        SetListenPattern( oPC, "**", cMvD_02_iListenPatternNumber );
        SetListening( oPC, TRUE );
        SetLocalInt( oPC, cMvD_02_sIsPlayer, 1 );
    }
}

void MvD_02_PlayerExit() {
    object oModule = GetModule();
    object oPC = GetExitingObject();
    int iIsPlayer = GetLocalInt( oPC, cMvD_02_sIsPlayer );

    if( iIsPlayer == 1 ) {
        int iMinDiagCount = GetLocalInt( oModule, cMvD_02_sMinDialogCount );
        int iCountPerPC = GetLocalInt( oModule, cMvD_02_sCountPerPC );
        if( (iMinDiagCount - iCountPerPC) <= 1 ) {
            SetLocalInt( oModule, cMvD_02_sMinDialogCount, 1 );
        } else {
            SetLocalInt( oModule, cMvD_02_sMinDialogCount,
                iMinDiagCount - iCountPerPC );
        }
    }
}

void MvD_02_NSCInit( object oNSC ) {
    SetListenPattern( oNSC, "**", cMvD_02_iListenPatternNumber );
    SetListening( oNSC, TRUE );
}

void MvD_02_ModInit() {
    object oModule = GetModule();

    SetLocalInt( oModule, cMvD_02_sMinXPToGive, cMvD_02_iMinXP );
    SetLocalInt( oModule, cMvD_02_sMaxXPToGive, cMvD_02_iMaxXP );
    SetLocalInt( oModule, cMvD_02_sHeartBeatTime,
            cMvD_02_iHeartBeatTime );
    SetLocalInt( oModule, cMvD_02_sMaxResiduum, cMvD_02_iMaxResiduum );
    SetLocalInt( oModule, cMvD_02_sMinTimeDiff, cMvD_02_iMinTimeDiff );
    SetLocalInt( oModule, cMvD_02_sMaxTimeDiff, cMvD_02_iMaxTimeDiff );
    SetLocalInt( oModule, cMvD_02_sIsPCRandomTime, cMvD_02_iPCRandomTime );
    SetLocalInt( oModule, cMvD_02_sHourLastRun, GetTimeHour() );
    SetLocalInt( oModule, cMvD_02_sMinuteLastRun, GetTimeMinute() );
    SetLocalInt( oModule, cMvD_02_sMinDialogCount,
            cMvD_02_iMinDialogCount );
    SetLocalInt( oModule, cMvD_02_sCountPerPC, cMvD_02_iCountPerPC );
    SetLocalInt( oModule, cMvD_02_sStaffInUse, FALSE );
    SetLocalInt( oModule, cMvD_02_sLinearFactor, cMvD_02_iIsXPMult );
    SetLocalInt( oModule, cMvD_02_sLRESAktive, TRUE );
}
