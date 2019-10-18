/*
 *  Set the CoutPerPC in CUSTOM
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"

int StartingConditional()
{
SetCustomToken(5000,IntToString(GetLocalInt(GetModule(),
    cMvD_02_sCountPerPC ) ) );
    return(TRUE);
}
