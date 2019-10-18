//::///////////////////////////////////////////////
//:: FileName f_vampirecoffing
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2003 10:52:00 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "NW_IT_MSMLMISC24"))  //<--that is garlics tag
        return FALSE;

    return TRUE;
}
