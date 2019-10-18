/*
 * TRUE, if linear factor is on.
 *
 * MvDunkelfels 2004-12-18
 */

#include "mvd_02_const"

int StartingConditional()
{
    return( GetLocalInt( GetModule(), cMvD_02_sLinearFactor ) );
}
