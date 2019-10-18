/*
 * Script deactivates the LRES
 *
 * MvDunkelfels 2005-1-8
 */

#include "mvd_02_const"

void main()
{
    SetLocalInt( GetModule(), cMvD_02_sLRESAktive, FALSE );
}
