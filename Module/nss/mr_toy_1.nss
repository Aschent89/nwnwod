#include "toy_source"
//Leash
void main()
{
    //Get stored data
    string sToyTag = GetLocalString(OBJECT_SELF, "MR_TOY_TAG");
    string sNameTag = GetLocalString(OBJECT_SELF, "MR_TOY_NAME");
    object oToyOwner = GetLocalObject(OBJECT_SELF, "MR_TOY_OWNER");

    //Get the names of the two players
    string sTargetName = GetName(OBJECT_SELF);
    string sOwnerName = GetName(oToyOwner);

    int nToyInUse = GetLocalInt(OBJECT_SELF, sToyTag);

    //Removal messages
    string sSpeak1 = sOwnerName + " removes the leash from the neck of " + sTargetName;
    string sOwnerMessage1 = "You remove the leash from the neck of " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes the leash from your neck.";

    //Add messages
    string sSpeak2 = sOwnerName + " attachs a leash around the neck of " + sTargetName;
    string sOwnerMessage2 = "You attach a leash around the neck of " + sTargetName;
    string sTargetMessage2 = sOwnerName + " attaches a leash to your neck.";

    if (nToyInUse) {
        //Clear the ForceFollow
        AssignCommand(OBJECT_SELF, ClearAllActions());
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        //Force the target to follow the player
        AssignCommand(OBJECT_SELF, ClearAllActions());
        AssignCommand(OBJECT_SELF, ActionForceFollowObject(oToyOwner, 0.5));
        //Send the appropraite messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage2);
            SendMessageToPC(oToyOwner, sOwnerMessage2); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak2));
        //Set the flag
        SetLocalInt(OBJECT_SELF, sToyTag, 1); }

    DeleteLocalString(OBJECT_SELF, "MR_TOY_TAG");
    DeleteLocalString(OBJECT_SELF, "MR_TOY_NAME");
    DeleteLocalObject(OBJECT_SELF, "MR_TOY_OWNER");


}
