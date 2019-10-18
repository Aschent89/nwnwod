/*
 * Test if LRES is deactivated
 *
 * MvDunkelfels 2005-1-8
 */

#include "mvd_02_const"

int StartingConditional()
{
    if( GetLocalInt( GetModule(), cMvD_02_sLRESAktive ) ) {
        return( FALSE );
    } else {
        return( TRUE );
    }
}
