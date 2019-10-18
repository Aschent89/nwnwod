/*
 * Increase MinTimeDiff by 1
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"

void main()
{
    object oMod = GetModule();
    int iLast = GetLocalInt( oMod, cMvD_02_sMinTimeDiff );
    if( (iLast + 1) > 65300 ) {
        SetLocalInt( oMod, cMvD_02_sMinTimeDiff, 65300 );
    } else {
        SetLocalInt( oMod, cMvD_02_sMinTimeDiff, iLast + 1 );
    }
}
