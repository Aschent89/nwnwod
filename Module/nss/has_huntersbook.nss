//::///////////////////////////////////////////////
//:: FileName has_huntersbook
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/21/2004 11:09:00 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "Huntersguide"))
		return FALSE;

	return TRUE;
}
