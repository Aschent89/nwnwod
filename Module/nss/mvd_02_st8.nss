/*
 * Reset IG variables to the defaults set in mvd_02_const
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"
#include "mvd_02_init"
void main()
{
    MvD_02_ModInit();
    int iPC = 0;
    object oPC = GetFirstPC();
    while( GetIsObjectValid( oPC ) ) {
        iPC++;
        oPC = GetNextPC();
    }
    SetLocalInt( GetModule(), cMvD_02_sMinDialogCount,
        cMvD_02_iMinDialogCount + iPC * cMvD_02_iCountPerPC );

}
