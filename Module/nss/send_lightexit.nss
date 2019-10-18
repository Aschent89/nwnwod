void main()
{

object oPC = GetPCSpeaker();

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("wp_buriedcity");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

DelayCommand(5.0, AssignCommand(oPC, ClearAllActions()));

DelayCommand(8.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

effect eEffect;
eEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);

DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC));

}
