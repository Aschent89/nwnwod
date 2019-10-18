/*
 * Blocks the selected PC from the XP givings of the LRES
 *
 * MvDunkelfels 2004-12-10
 */
#include "mvd_02_const"

void main()
{
    object oTarget = GetLocalObject( OBJECT_SELF, cMvD_02_sTargetObject );
    SetLocalInt( oTarget, cMvD_02_sIsBlocked, TRUE );
}
