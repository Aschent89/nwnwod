/*
 * Removes the TargetObject if the user of the staff is done
 *
 * MvDunkelfels 2004-12-12
 */
#include "mvd_02_const"

void main()
{
    DeleteLocalObject( OBJECT_SELF, cMvD_02_sTargetObject );
}
