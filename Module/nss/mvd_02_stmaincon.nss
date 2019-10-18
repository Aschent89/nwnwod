/*
 * This script sets the CUSTOM token for the acivation status of
 * the LRES.
 *
 * MvDunkelfels 2005-1-8
 */

#include "mvd_02_const"

int StartingConditional()
{
    if( GetLocalInt( GetModule(), cMvD_02_sLRESAktive ) ) {
        SetCustomToken( 5000, "activated" );
    } else {
        SetCustomToken( 5000, "deaktivated" );
    }
    return( TRUE );
}
