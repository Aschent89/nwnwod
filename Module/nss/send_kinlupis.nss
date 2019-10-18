#include "nw_i0_tool"

void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("garou_kinfolk", oPC);
CreateItemOnObject("garoulupisshift", oPC);
CreateItemOnObject("gar_tri_gaia", oPC);
RewardPartyXP(12500, oPC, FALSE);
SetSubRace(oPC, "Kinfolk Lupis");

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


object oTarget;
location lTarget;
oTarget = GetWaypointByTag("wp_new");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

}
