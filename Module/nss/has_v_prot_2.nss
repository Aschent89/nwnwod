//::///////////////////////////////////////////////
//:: FileName has_m_conn_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/25/2009 4:17:10 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "vamp_prot_2"))
        return FALSE;

    return TRUE;
}
