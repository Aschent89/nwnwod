#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();
object oTarget;
location lTarget;
oTarget = GetWaypointByTag("starter_area");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), GetLocation(oTarget));
CreateItemOnObject("vamp_caitiff", oPC);
CreateItemOnObject("vamp_g_cele_1", oPC);
CreateItemOnObject("vamp_fort_1", oPC);
CreateItemOnObject("vamp_pote_1", oPC);
//CreateItemOnObject("vamppoint", oPC);
//RewardPartyXP(12000, oPC, FALSE);
//CreateItemOnObject("sabbat_key", oPC);


CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
CreateItemOnObject("soulrune", oPC);
}
