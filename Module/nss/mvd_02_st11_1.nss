/*
 * TRUE, if random time between XP givings is on
 *
 * MvDunkelfels 2004-12-16
 */

#include "mvd_02_const"

int StartingConditional()
{
    if( GetLocalInt( GetModule(), cMvD_02_sIsPCRandomTime ) == FALSE ) {
        return( TRUE );
    } else {
        return( FALSE );
    }
}
