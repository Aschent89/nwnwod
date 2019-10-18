/*
 * This module has the functions that get called if a PC or a specially
 * set up NSC/object hears a player speaking something
 *
 * The function MvD_02_ConversatNPC can also be used for objects.
 *
 * MvDunkelfels 2004-12-11
 */

#include "mvd_02_const"

/*
 * MvD_02_00CMatchCase: Compares the string match with the
 * case-sensitive substrings defined in mvd_02_const.
 * Match: The string to compare
 * RETURN: TRUE if OOC, FALSE else.
 */
int MvD_02_OOCMatchCase( string Match ) {
    if( FindSubString( Match, cMvD_02_sOOC1 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC2 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC3 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC4 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC5 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC6 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC7 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC8 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC9 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC10 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC11 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC12 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC13 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC14 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC15 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC16 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC17 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC18 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOC19 ) != -1 ) {
        return( TRUE );
    } else {
        return( FALSE );
    }
}

/*
 * MvD_02_OOCMatchNoCase: Compares the string case-insensitive with
 * the OOC words defined in mvd_02_const.
 * MatchString: The string to test.
 * RETURN: TRUE if OOC, FALSE else
 */
int MvD_02_OOCMatchNoCase( string MatchString ) {

    // make the string lowercase
    string  Match = GetStringLowerCase( MatchString );

    if( FindSubString( Match, cMvD_02_sOOCWord1 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord2 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord3 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord4 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord5 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord6 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord7 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord8 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord9 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord10 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord11 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord12 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord13 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord14 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord15 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord16 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord17 ) != -1 ) {
        return( TRUE );
    } else if( FindSubString( Match, cMvD_02_sOOCWord18 ) != -1 ) {
        return( TRUE );
    } else {
        return( FALSE );
    }
}

/*
 * This function should be called in nw_g0_conversat. It increases
 * the dialog counter of the PC if the string spoken is not OOC.
 */
void MvD_02_Conversat() {
    object oPC = GetLastSpeaker();
    int iMatch = GetListenPatternNumber();
    string sMatch = GetMatchedSubstring( 0 );
    object oArea = GetArea( oPC );

    // If not in a legal area...
    if( oArea == OBJECT_INVALID ) {
        return;
    }
    // If in an OOC area
    if( FindSubString( GetName( oArea ), cMvD_02_sOOCAreaName ) != -1  ) {
        return;
    }

    // Is the Speaker a PC?
    if( GetIsPC( oPC ) ) {
        // If it is a familiar, set variables on the master
        if( GetAssociateType( oPC ) == ASSOCIATE_TYPE_FAMILIAR ) {
            oPC = GetMaster( oPC );
        }
        if( GetIsPC( OBJECT_SELF ) &&
                    ( iMatch == cMvD_02_iListenPatternNumber ) ){
            if( GetStringLength( sMatch ) >= cMvD_02_iStrMinLength ) {
                // Test for OOC strings
                if( (MvD_02_OOCMatchCase( sMatch ) == FALSE) &&
                    (MvD_02_OOCMatchNoCase( sMatch ) == FALSE) ) {
                        SetLocalInt( oPC, cMvD_02_sDiagCounter,
                            GetLocalInt( oPC, cMvD_02_sDiagCounter ) + 1 );
                }
            }
        }
    }
}

/*
 * Rhis function should be called in the OnConversation script
 * of an NSC/object that should be a listener (not advised due to
 * the possibility of PC abuse). It increases the dialog counter of
 * the PC speaking if the string is not OOC.
 */
void MvD_02_ConversatNPC() {
    object oPC = GetLastSpeaker();
    int iMatch = GetListenPatternNumber();
    string sMatch = GetMatchedSubstring( 0 );
    object oArea = GetArea( oPC );

    // If not in a legal area...
    if( oArea == OBJECT_INVALID ) {
        return;
    }
    // If in an OOC Area...
    if( FindSubString( GetName( oArea ), cMvD_02_sOOCAreaName ) != -1  ) {
        return;
    }

    if( GetIsPC( oPC ) ) {
        if( GetAssociateType( oPC ) == ASSOCIATE_TYPE_FAMILIAR ) {
            oPC = GetMaster( oPC );
        }
        if( iMatch == cMvD_02_iListenPatternNumber ){
            if( GetStringLength( sMatch ) >= cMvD_02_iStrMinLength ) {
                if( (MvD_02_OOCMatchCase( sMatch ) == FALSE) &&
                    (MvD_02_OOCMatchNoCase( sMatch ) == FALSE) ) {
                        SetLocalInt( oPC, cMvD_02_sDiagCounter,
                            GetLocalInt( oPC, cMvD_02_sDiagCounter ) + 1 );
                }
            }
        }
    }
}

/*
 * This function must be called, if the familiar should listen for its master
 * (i.e. if it is summoned). The normal way is to call it at the end of
 * nw_ch_ac4
 */
void MvD_02_ConversatFamiliar() {

    // If we are not a familiar...
    if( GetAssociateType( OBJECT_SELF ) != ASSOCIATE_TYPE_FAMILIAR ) {
        return;
    }

    object oPC = GetLastSpeaker();
    // No points if our master is the speaker...
    if( GetMaster( OBJECT_SELF ) == oPC ) {
        return;
    }

    int iMatch = GetListenPatternNumber();
    string sMatch = GetMatchedSubstring( 0 );
    object oArea = GetArea( oPC );

    // If not in a legal area...
    if( oArea == OBJECT_INVALID ) {
        return;
    }
    // If in an OOC area...
    if( FindSubString( GetName( oArea ), cMvD_02_sOOCAreaName ) != -1  ) {
        return;
    }

    if( GetIsPC( oPC ) ) {
        if( GetAssociateType( oPC ) == ASSOCIATE_TYPE_FAMILIAR ) {
            oPC = GetMaster( oPC );
        }
        if( iMatch == cMvD_02_iListenPatternNumber ){
            if( GetStringLength( sMatch ) >= cMvD_02_iStrMinLength ) {
                if( (MvD_02_OOCMatchCase( sMatch ) == FALSE) &&
                (MvD_02_OOCMatchNoCase( sMatch ) == FALSE) ) {
                    SetLocalInt( oPC, cMvD_02_sDiagCounter,
                        GetLocalInt( oPC, cMvD_02_sDiagCounter ) + 1 );
                }
            }
        }
    }
}
