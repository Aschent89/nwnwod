/*
 * Increase MaxTimeDiff by 1 
 *
 * MvDunkelfels 2004-12-16
 */
#include "mvd_02_const"

void main()
{
    object oMod = GetModule();
    int iLast = GetLocalInt( oMod, cMvD_02_sMaxTimeDiff );
    if( (iLast + 1) > 65300 ) {
        SetLocalInt( oMod, cMvD_02_sMaxTimeDiff, 65300 );
    } else {
        SetLocalInt( oMod, cMvD_02_sMaxTimeDiff, iLast + 1 );
    }
}
