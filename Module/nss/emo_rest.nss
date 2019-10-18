

void main()
{
    // Get Last Speaker
    object oPC = GetLastSpeaker();


    // Assign Animation

    DelayCommand(0.2, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 60000.0f)));

}
