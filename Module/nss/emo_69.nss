
// hug nearest person from behind

// the #include below is for the MoveToNewLocation command
#include "x0_i0_position"

void main()
{
    object oPC = OBJECT_SELF ;
    object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;

    // get opposite facing for vector, set pc facing to match target facing
    float fTargetface = GetOppositeDirection (GetFacing(oTarget));
    float fPCFace = GetFacing(oTarget) ;

    // Tweaking oTarget's facing vector angle to line up PCs better
    // fTargetface = GetNormalizedDirection(fTargetface - 60.0);

    // figure out location we want to move to
    // this is oTarget's position displaced by 0.0*(oTarget's's facing vector)
    object oArea = GetArea(oPC);
    vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)*0.85;
    location lDest = Location(oArea, posDest, fPCFace);
    MoveToNewLocation ( lDest, oPC);

    // perform animation
    DelayCommand( 2.0, AssignCommand( oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 0.5, 60000.0)));

}
