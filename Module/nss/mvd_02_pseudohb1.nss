/*
 * This script is the pseudo heartbeat that checks if the master still has
 * a familiar and manages the listening setting.
 *
 * MvDunkelfels 2005-04-10
 */

void main()
{
    object oFam = GetAssociate( ASSOCIATE_TYPE_FAMILIAR );
    if( GetIsObjectValid( oFam ) ) {
        DelayCommand( 6.0f, ExecuteScript( "mvd_02_pseudohb1", OBJECT_SELF ) );
        return;
    } else {
        SetListening( OBJECT_SELF, TRUE );
    }
}
