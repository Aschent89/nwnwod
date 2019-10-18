/*
 * Functions to distribute XP using the hub object.
 * 
 * MvDunkelfels 2005-1-8
 */

#include "mvd_02_modheart"
#include "mvd_02_const"
/*
 * Calculates if a PC should get RP XP.
 * oTarget_PC: The PC to check
 * iCurrentHour: The current hour
 * iCurrentMin: the current minute
 * iMinTimeDiff: the minimal time between to XP servings
 * iMinDiag: THe minimal dialog counter needed.
 * RETURN: TRUE if XP should be given, FALSE else.
 */
int MvD_02_WillGetXP( object oTarget_PC, int iCurrentHour, int iCurrentMin,
        int iMinTimeDiff, int iMinDiag );

/*
 * Resets the PC variables after a CP serving.
 * oTarget_PC: The PC to reset
 * iCurrenHour: The current hour
 * iCurrentMin: the current minute
 * iMinDiag: The minimal amount of dialog points.
 * iMaxRes: The amount of dialog point that should survive the reset
 */
void MvD_02_ResetPC( object oTarget_PC, int iCurrentHour, int iCurrentMin,
        int iMinDiag, int iMaxRes, int iPCRandomTime, int iMinTimeDiff,
        int iMaxTimeDiff );

/*
 * Actual function that gives out XP. If a special function should
 * be called in your Mod or PW fpr XP givings, this is the function
 * to call it in.
 * oTargetPC: The PC that should get some XP
 * iXp: The amount of XP to give
 */
void MvD_02_GiveXP( object oTargetPC, int iXP );

/*
 * Function that checks through all PCs if they should get Xp or 
 * not during this run. Before calling this function the current hour
 * and current minute must be set in cMvD_02_sHourLastRun and 
 * cMvD_02_sMinuteLastRun respectivly. This is the case, so that the
 * time of the call to this function is the reference time to check 
 * against, and not the time NWN decides to run the function.
 */
void MvD_02_AllotXP();



void MvD_02_GiveXP( object oTargetPC, int iXP ) {
    GiveXPToCreature( oTargetPC, iXP );
}

void MvD_02_AllotXP() {
    object oModule = GetModule();

    // check if the LRES is active
    if( GetLocalInt( oModule, cMvD_02_sLRESAktive ) ) {
    int iCurrentHour = GetLocalInt( oModule, cMvD_02_sHourLastRun );
    int iCurrentMin = GetLocalInt( oModule, cMvD_02_sMinuteLastRun ) ;
    int iMinXP = GetLocalInt( oModule, cMvD_02_sMinXPToGive );
    int iMaxXP = GetLocalInt( oModule, cMvD_02_sMaxXPToGive );
    int iMaxRes = GetLocalInt( oModule, cMvD_02_sMaxResiduum );
    int iMinDiag = GetLocalInt( oModule, cMvD_02_sMinDialogCount );
    int iXP = 0;
    int iPCRandomTime = GetLocalInt( oModule, cMvD_02_sIsPCRandomTime );
    int iMinTimeDiff = GetLocalInt( oModule, cMvD_02_sMinTimeDiff );
    int iMaxTimeDiff = 0;
    int iTimeDiff = iMinTimeDiff;
    int iLinearFactor = GetLocalInt( oModule, cMvD_02_sLinearFactor );

    if( iPCRandomTime == TRUE ) {
        iMaxTimeDiff = GetLocalInt( oModule, cMvD_02_sMaxTimeDiff );
    }

    object  oPC = GetFirstPC();

    // Loop through all PCs, test if they should get XP, and
    // if the PC should, give out XP and reset the PC.
    while( GetIsObjectValid( oPC ) ) {
        if( iPCRandomTime == TRUE ) {
            iTimeDiff = GetLocalInt( oPC, cMvD_02_sPCTimeDiff );
        }
        if( MvD_02_WillGetXP( oPC, iCurrentHour, iCurrentMin,
                    iTimeDiff, iMinDiag ) ) {
            iXP = Random(iMaxXP-iMinXP) + iMinXP;
            if( (iLinearFactor == TRUE) && (iPCRandomTime == TRUE) ) {
                iXP = iXP * FloatToInt(GetLocalFloat( oPC, cMvD_02_sXPMult ) );
            }
            MvD_02_GiveXP( oPC, iXP );
            MvD_02_ResetPC( oPC, iCurrentHour, iCurrentMin,
                    iMinDiag, iMaxRes, iPCRandomTime, iMinTimeDiff,
                    iMaxTimeDiff );
        }
        oPC = GetNextPC();
    }
    }
}

void MvD_02_ResetPC( object oTargetPC, int iCurrentHour, int iCurrentMin,
        int iMinDiag, int iMaxRes, int iPCRandomTime, int iMinTimeDiff,
        int iMaxTimeDiff ) {
     int iLinearFactor = GetLocalInt( GetModule(), cMvD_02_sLinearFactor );
    // Set time last given
    SetLocalInt( oTargetPC, cMvD_02_sHourLastGiven, iCurrentHour );
    SetLocalInt( oTargetPC, cMvD_02_sMinLastGiven, iCurrentMin );
    // Get IG set minimal dialog counter
    int iCount = GetLocalInt( oTargetPC, cMvD_02_sDiagCounter );
    // Reset dialog count.
    if( (iCount - iMinDiag) >= iMaxRes ) {
        SetLocalInt( oTargetPC, cMvD_02_sDiagCounter, iMaxRes );
    } else {
        SetLocalInt( oTargetPC, cMvD_02_sDiagCounter, iCount -
                iMinDiag );
    }
    if( iPCRandomTime == TRUE ) {
        int iDiffTime = Random( iMaxTimeDiff - iMinTimeDiff ) + iMinTimeDiff;
        SetLocalInt( oTargetPC, cMvD_02_sPCTimeDiff, iDiffTime );
        if( iLinearFactor ) {
            SetLocalFloat( oTargetPC, cMvD_02_sXPMult, IntToFloat( iDiffTime ) /
                    IntToFloat( iMinTimeDiff ) );
        }
    }
}

int MvD_02_WillGetXP( object oTargetPC, int iCurrentHour, int iCurrentMin,
        int iMinTimeDiff, int iMinDiag ) {

    // If a PC is blocked return FALSE
    if( GetLocalInt( oTargetPC, cMvD_02_sIsBlocked ) ) {
        return( FALSE );
    } else {

        int iLastHour = GetLocalInt( oTargetPC, cMvD_02_sHourLastGiven );
        int iLastMin = GetLocalInt( oTargetPC, cMvD_02_sMinLastGiven );
        int iDiag = GetLocalInt( oTargetPC, cMvD_02_sDiagCounter );
        int iMinDiff = MvD_02_TimeDiff( iCurrentHour, iCurrentMin,
            iLastHour, iLastMin );

        if( (iMinDiff >= iMinTimeDiff) && (iDiag >= iMinDiag) ) {
            return( TRUE );
        } else {
            return( FALSE );
        }
    }
}
