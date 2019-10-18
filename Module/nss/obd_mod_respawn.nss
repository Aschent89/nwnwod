////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_mod_respawn
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is the Module Respawn
//
////////////////////////////////////////////////////////////////////////////////

#include "obd_include"

void main()
{
    object oPC = GetLastRespawnButtonPresser();

    SetLocalInt(oPC,"OBD_FORCE_RESPAWN",0);
    SetLocalInt(oPC,"OBD_FORCE_RESPAWN_COUNT",0);
    Respawn(oPC);
}
