/*
 * Test if LRES is active
 *
 * MvDunkelfels 2005-1-8
 */

#include "mvd_02_const"

int StartingConditional()
{
    return( GetLocalInt( GetModule(), cMvD_02_sLRESAktive ) );
}
