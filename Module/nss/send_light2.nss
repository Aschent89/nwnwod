#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(2000, oPC, TRUE);

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("wp_lighttemp2");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

oTarget=GetFirstFactionMember(oPC, FALSE);

while (GetIsObjectValid(oTarget))
   {
   AssignCommand(oTarget, ClearAllActions());

   AssignCommand(oTarget, ActionJumpToLocation(lTarget));
   oTarget=GetNextFactionMember(oPC, FALSE);
   }

}
