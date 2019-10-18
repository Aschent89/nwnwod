//::///////////////////////////////////////////////
//:: FileName f_vampirecoffind
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2003 10:48:27 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "FALLEN_VAMPIRE_STAKE"))
		return FALSE;

	return TRUE;
}
