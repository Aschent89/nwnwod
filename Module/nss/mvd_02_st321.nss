/*
 * Decrease MinTimeDiff by 1
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"

void main()
{
    object oMod = GetModule();
    int iLast = GetLocalInt( oMod, cMvD_02_sMinTimeDiff );
    if( (iLast - 1) <= 1 ) {
        SetLocalInt( oMod, cMvD_02_sMinTimeDiff, 1 );
    } else {
        SetLocalInt( oMod, cMvD_02_sMinTimeDiff, iLast - 1 );
    }
}
