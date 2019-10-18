/*
 * TRUE if random time is on
 *
 * MvDunkelfels 2004-12-16
 */

#include "mvd_02_const"

int StartingConditional()
{
    return( GetLocalInt( GetModule(), cMvD_02_sIsPCRandomTime ) );
}
