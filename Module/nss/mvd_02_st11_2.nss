/*
 * Activate minimal random time
 *
 * MvDunkelfels 2004-12-16
 */

#include "mvd_02_const"

void main()
{
    object oModule = GetModule();
    int iMinTimeDiff = GetLocalInt( oModule, cMvD_02_sMinTimeDiff );
    int iMaxTimeDiff = GetLocalInt( oModule, cMvD_02_sMaxTimeDiff );
    int iRandomTime = 0;
    SetLocalInt( oModule, cMvD_02_sIsPCRandomTime, TRUE );

    object oPC = GetFirstPC();

    while( GetIsObjectValid( oPC ) ) {
        iRandomTime = Random( iMaxTimeDiff - iMinTimeDiff ) + iMinTimeDiff;
        SetLocalInt( oPC, cMvD_02_sPCTimeDiff, iRandomTime );
        SetLocalFloat( oPC, cMvD_02_sXPMult, IntToFloat( iRandomTime ) /
                IntToFloat( iMinTimeDiff ) );
        oPC= GetNextPC();
    }
}
