//::///////////////////////////////////////////////
//:: FileName f_vampirecoffinf
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2003 10:50:23 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "X1_WMGRENADE005"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "NW_IT_MSMLMISC15"))
        return TRUE;

    return FALSE;
}
