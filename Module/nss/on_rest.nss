void main()
{
    object oPC = GetLastPCRested();
    int nReadyToRest = GetLocalInt(oPC, "MR_REST_FLAG");


    //If the player is trying to rest and he is not flagged as ready to rest
    //by the emote conversation, start the conversation
    if (!nReadyToRest) {
        AssignCommand(oPC, ClearAllActions());
        DelayCommand(0.5, AssignCommand(oPC, ActionStartConversation(oPC, "emote_rest", TRUE, FALSE)));
        return; }

    //If they have finished or cancelled the rest, delete the flag
    DeleteLocalInt(oPC, "MR_REST_FLAG");
}
