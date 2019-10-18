/*
 * TRUE, if the linear factor is off
 *
 * MvDunkelfels 2004-12-18
 */

#include "mvd_02_const"

int StartingConditional()
{
    if( GetLocalInt( GetModule(), cMvD_02_sLinearFactor ) == FALSE ) {
        return( TRUE );
    } else {
        return( FALSE );
    }
}
