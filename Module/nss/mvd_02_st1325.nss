/*
 * Decrease MaxTimeDiff by 5
 *
 * MvDunkelfels 2004-12-16
 */
#include "mvd_02_const"

void main()
{
    object oMod = GetModule();
    int iLast = GetLocalInt( oMod, cMvD_02_sMaxTimeDiff );
    if( (iLast - 5) <= 1 ) {
        SetLocalInt( oMod, cMvD_02_sMaxTimeDiff, 1 );
    } else {
        SetLocalInt( oMod, cMvD_02_sMaxTimeDiff, iLast - 5 );
    }
}
