/*
 * This script summons the familiar and sets the listening status of familiar
 * and master. It also starts the pseudo heartbeat that checks for the
 * existence of the familiar.
 *
 * 2005-4-10 MvDunkelfels
 */

#include "mvd_02_const"

void MvD_02_SummonFamiliar( object oMaster = OBJECT_SELF ) {
    SummonFamiliar( oMaster );
    // Are we a player and not a DM?
    if( GetIsPC( oMaster ) && !(GetIsDMPossessed( oMaster )) ) {
        object oFam = GetAssociate( ASSOCIATE_TYPE_FAMILIAR, oMaster );
        if( GetIsObjectValid( oFam ) ) {
            // Set listen pattern
            SetListenPattern( oFam, "**", cMvD_02_iListenPatternNumber );
            SetListening( oMaster, FALSE );
            SetListening( oFam, TRUE );
            // Start pseudo HB
            DelayCommand( 6.0f, ExecuteScript( "mvd_02_pseudohb1", oMaster ) );
        }
    }
}
