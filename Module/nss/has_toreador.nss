//::///////////////////////////////////////////////
//:: FileName has_tremere
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/6/2009 1:31:57 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "vamp_toreador"))
        return FALSE;

    return TRUE;
}
