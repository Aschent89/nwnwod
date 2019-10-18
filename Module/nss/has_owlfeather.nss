//::///////////////////////////////////////////////
//:: FileName has_owlfeather
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/13/2011 11:21:34 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "cnrFeatherOwl"))
		return FALSE;

	return TRUE;
}
