//::///////////////////////////////////////////////
//:: FileName has_feraproof
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/1/2011 11:44:52 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "ks_annaleg"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "ks_ghheart"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "ks_ratkins"))
		return FALSE;

	return TRUE;
}
