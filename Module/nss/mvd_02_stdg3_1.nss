/*
 * Called if someone wants to use the staff regardless of the warning.
 *
 * MvDunkelfels 2004-12-16
 */
void main()
{
    AssignCommand( OBJECT_SELF, ActionStartConversation( OBJECT_SELF,
            "mvd_02_stabdiag1", FALSE, TRUE ) );
}
