
void main()
{
    // Get Last Speaker
    object oPC = GetLastSpeaker();
    // Assign Animation
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 0.5, 60000.0f));
}
