/*
 * The UserDefinedEvent script for the LRES Main Hub.
 * It does the allotment of XPs and the check if signaled the
 * defined Event.
 *
 * MvDunkelfels 2005-1-8
 */

#include "mvd_02_const"
#include "mvd_02_giver"

void main()
{
    int iEventNr = GetUserDefinedEventNumber();

    switch( iEventNr ) {
        case cMvD_02_iUserEventNr:
            MvD_02_AllotXP();
            break;
    }
}
