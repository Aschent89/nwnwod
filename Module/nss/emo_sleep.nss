void main()
{
    // Get Last Speaker
    object oPC = GetLastSpeaker();
    // Assign Animation
    float nDur = 120.0 * 60.0;
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM10, 1.0, nDur));
}
