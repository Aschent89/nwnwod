/*
 * Called if the minimal XP amount should be changed
 *
 * MvDunkelfels 2004-12-10
 */

#include "mvd_02_const"

int StartingConditional()
{
    SetCustomToken(5000, IntToString(GetLocalInt(GetModule(),
        cMvD_02_sMinXPToGive ) ) );
    return( TRUE );
}
