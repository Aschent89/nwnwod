/*
 * Called at activation of the LRES Configuration wand
 *
 * MvDunkelfels 2004-12-12
 */

#include "mvd_02_const"

void main()
{
        object MvD_oActivator = GetItemActivator();
        object MvD_oTarget = GetItemActivatedTarget();
        object oModule = GetModule();
        int iStaffInUse = GetLocalInt( oModule, cMvD_02_sStaffInUse );
       if( GetIsDM( MvD_oActivator ) ) {

       if( MvD_oActivator == MvD_oTarget ) {
        if( iStaffInUse ) {
         SetLocalInt( oModule, cMvD_02_sStaffInUse, TRUE );
         AssignCommand( MvD_oActivator, ActionStartConversation( MvD_oTarget,
                "mvd_02_stabdiag3", FALSE, TRUE ) );
        } else {
         AssignCommand( MvD_oActivator, ActionStartConversation( MvD_oTarget,
                "mvd_02_stabdiag1", FALSE, TRUE ) );
        }
       } else {
        if( GetIsPC( MvD_oTarget ) ) {
            SetLocalObject( MvD_oActivator, cMvD_02_sTargetObject, MvD_oTarget );
            AssignCommand( MvD_oActivator, ActionStartConversation(
                MvD_oActivator, "mvd_02_stabdiag2", FALSE, TRUE ) );
        }
       }
       }
   return;

}
