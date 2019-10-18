
void main()
{
    // Get Last Speaker
    object oPC = GetLastSpeaker();
    // Assign Animation
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM4, 1.0, 30.0f));
}
