/*
 * Set the CUSTOM values
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"
int StartingConditional()
{
    object oMod = GetModule();
    SetCustomToken(5000, IntToString( GetLocalInt( oMod,
        cMvD_02_sMinXPToGive ) ) );
    SetCustomToken(5001, IntToString( GetLocalInt( oMod,
        cMvD_02_sMaxXPToGive ) ) );
    SetCustomToken( 5002, IntToString( GetLocalInt( oMod,
        cMvD_02_sMinTimeDiff ) ) );
    SetCustomToken( 5007, IntToString( GetLocalInt( oMod,
        cMvD_02_sMaxTimeDiff ) ) );
    SetCustomToken( 5003, IntToString( GetLocalInt( oMod,
        cMvD_02_sMaxResiduum ) ) );
    SetCustomToken( 5004, IntToString( GetLocalInt( oMod,
        cMvD_02_sHeartBeatTime ) ) );
    SetCustomToken( 5005, IntToString( GetLocalInt( oMod,
        cMvD_02_sMinDialogCount ) ) );
    SetCustomToken( 5006, IntToString( GetLocalInt( oMod,
        cMvD_02_sCountPerPC ) ) );
    return( TRUE );
}
