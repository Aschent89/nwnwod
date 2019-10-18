//::///////////////////////////////////////////////
//:: FileName has_razimssouls
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/17/2011 10:17:35 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ks_razimsouls"))
        return FALSE;

    return TRUE;
}
