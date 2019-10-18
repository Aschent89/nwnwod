//::///////////////////////////////////////////////
//:: FileName quest_has_diahea
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/17/2009 12:59:46 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "templerelic"))
        return FALSE;

    return TRUE;
}
