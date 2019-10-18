/*
 * Decrease MinDialogCount by 5
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"
void main() {
    object oMod = GetModule();
    int iLast = GetLocalInt( oMod, cMvD_02_sMinDialogCount );
    if( (iLast - 5) <= 0 ) {
        SetLocalInt( oMod, cMvD_02_sMinDialogCount, 0 );
    } else {
        SetLocalInt( oMod, cMvD_02_sMinDialogCount, iLast - 5 );
    }
}
