/*
 * Decrease minimal XP amount by 5
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"

void main()
{
    object oMod = GetModule();
    int iLast= GetLocalInt( oMod, cMvD_02_sMinXPToGive );
    if( (iLast - 5) <= 0 ) {
        SetLocalInt( oMod, cMvD_02_sMinXPToGive, 0 );
    } else {
        SetLocalInt( oMod, cMvD_02_sMinXPToGive, iLast - 5 );
    }
}
