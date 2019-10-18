#include "toy_source"
//Rope
void main()
{
    //Get stored data
    string sToyTag = GetLocalString(OBJECT_SELF, "MR_TOY_TAG");
    string sToyName = GetLocalString(OBJECT_SELF, "MR_TOY_NAME");
    object oToyOwner = GetLocalObject(OBJECT_SELF, "MR_TOY_OWNER");

    //Get the names of the two players
    string sTargetName = GetName(OBJECT_SELF);
    string sOwnerName = GetName(oToyOwner);

    int nToyInUse = GetLocalInt(OBJECT_SELF, sToyTag);

    //Removal messages
    string sSpeak1 = sOwnerName + " unties " + sTargetName;
    string sOwnerMessage1 = "You untie " + sTargetName;
    string sTargetMessage1 = sOwnerName + " unties you.";

    //Add messages
    string sSpeak2 = sOwnerName + " ties up " + sTargetName + " in silk rope.";
    string sOwnerMessage2 = "You tie up " + sTargetName + " in silk rope";
    string sTargetMessage2 = sOwnerName + " ties you up in silk rope.";

    if (nToyInUse) {
        //Clear the Paralyze
        ToyClearEffect(OBJECT_SELF, EFFECT_TYPE_PARALYZE);
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        //Check to see if they are leashed and if they are free them.
        if (GetLocalInt(OBJECT_SELF, BDSM_LEASH)) {
            DeleteLocalInt(OBJECT_SELF, BDSM_LEASH);
            AssignCommand(OBJECT_SELF, ClearAllActions()); }
        effect eEffect = EffectParalyze();
        //Apply the Paralyze effect
        AssignCommand(OBJECT_SELF, ToyApplyEffect(OBJECT_SELF, eEffect));
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
