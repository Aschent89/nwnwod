//::///////////////////////////////////////////////
//:: FileName has_humid_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/15/2009 12:26:46 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "garou_humid_1"))
		return FALSE;

	return TRUE;
}
