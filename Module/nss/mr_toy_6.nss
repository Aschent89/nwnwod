#include "toy_source"
//Blindfold
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
    string sSpeak1 = sOwnerName + " unties the blindfold from the eyes of " + sTargetName;
    string sOwnerMessage1 = "You untie the blindfold from " + sTargetName;
    string sTargetMessage1 = sOwnerName + " unties the blindfold around your eyes.";

    //Add messages
    string sSpeak2 = sOwnerName + " ties a blindfold around the eyes of " + sTargetName;
    string sOwnerMessage2 = "You tie a blindfold around the eyes of " + sTargetName;
    string sTargetMessage2 = sOwnerName + " ties a blindfold around your eyes.";

    if (nToyInUse) {
        //Clear the Blindness
        ToyClearEffect(OBJECT_SELF, EFFECT_TYPE_BLINDNESS);
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        effect eEffect = EffectBlindness();
        //Apply the Blindness effect
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
