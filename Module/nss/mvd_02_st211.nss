/*
 * Increase max. XP amount by 1.
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"

void main()
{
    object oMod = GetModule();
    int iLast = GetLocalInt( oMod, cMvD_02_sMaxXPToGive );
    if( (iLast + 1) >= 65300 ) {
        SetLocalInt( oMod, cMvD_02_sMaxXPToGive, 65300 );
    } else {
        SetLocalInt( oMod, cMvD_02_sMaxXPToGive, iLast +1 ) ;
    }
}
