////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Module On Respawn
//  ors_mod_respawn
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
    object oPC = GetLastRespawnButtonPresser();
    object oMod = GetModule();
    string sDB = GetLocalString(oMod,"ORS_DATABASE");

    //ORS Allegiance and Subraces
    ORS_Subrace(oPC);
}
