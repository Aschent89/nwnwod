/*
 * Decrease Residuum by 1
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"

void main()
{
    object oMod = GetModule();
    int iLast = GetLocalInt( oMod, cMvD_02_sMaxResiduum );
    if( (iLast - 1) <= 0 ) {
        SetLocalInt( oMod, cMvD_02_sMaxResiduum, 0 );
    } else {
        SetLocalInt( oMod, cMvD_02_sMaxResiduum, iLast - 1 );
    }
}
