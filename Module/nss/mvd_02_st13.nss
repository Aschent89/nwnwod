/*
 * Set max. time in CUSTOM
 *
 * MvDunkelfels 2004-12-16
 */

#include "mvd_02_const"
int StartingConditional()
{
    SetCustomToken( 5000, IntToString( GetLocalInt( GetModule(),
        cMvD_02_sMaxTimeDiff ) ) );
    return(TRUE);
}
