//::///////////////////////////////////////////////
//:: FileName f_vampirecoffine
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2003 10:49:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "FALLEN_VAMPIRE_WILDROSE") || GetLocalInt(OBJECT_SELF, "FALLEN_ROSEWARD"))
        return FALSE;

    return TRUE;
}
