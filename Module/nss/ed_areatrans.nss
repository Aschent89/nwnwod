//ed_areatrans
//Put this in area transitions' OnEnter events or the doors' OnAreaTransitionClick
// events to and from the endless desert areas.
//picks a random endlessdesert area to send player to or if they make the chance,
//send thems to the direction they were traveling out, if there is one.

#include "ed_include"
void main()
{
    //SpawnScriptDebugger();
    object oPC = GetEnteringObject();
    AssignCommand(oPC, ClearAllActions(TRUE));
    float fFacing = GetFacing(oPC);
    string sTarget = GetName(OBJECT_SELF);
    object oExitTarget = GetTransitionTarget(OBJECT_SELF);
    int iRand = Random(100) + 1;
    location lLoc;

    if(iRand <= ED_PERCENT_CHANCE_TO_EXIT_ENDLESS_AREA && GetIsObjectValid(oExitTarget)) lLoc = GetLocation(oExitTarget);
    else
    {
        object oArea = ED_GetRandomArea(sTarget);
        lLoc = ED_GetRandomLocationInArea(oArea);
    }

    SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);

    AssignCommand(oPC, ActionJumpToLocation(lLoc));
    AssignCommand(oPC, SetFacing(fFacing));
}
