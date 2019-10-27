///This script is made to be an onactiontaken where someone will say they want to go to
/// a certain waypoint and they'll be teleported there.
/// Change the waypoint name down on line 14 inside the (" ") to whatever the
/// current waypoint will be.

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("WP_umbra_neq");

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
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

}
