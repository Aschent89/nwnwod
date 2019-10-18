#include "nw_i0_plot"
void main()
{

object oPC = GetLastRespawnButtonPresser();

if (!GetIsPC(oPC)) return;

ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);

ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)), oPC);

RemoveEffects(oPC);

//CreateItemOnObject("deathdeed", oPC);

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("wp_torpor");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

}
