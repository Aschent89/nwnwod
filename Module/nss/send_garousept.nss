void main()
{

object oPC = GetPCSpeaker();

SendMessageToPC(oPC, "*A small slit in the tree opens and you are allowed in*");

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("wp_garou");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

DelayCommand(2.0, AssignCommand(oPC, ClearAllActions()));

DelayCommand(5.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

effect eEffect;
eEffect = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);

DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC));

}
