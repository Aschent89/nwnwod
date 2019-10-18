#include "toy_source"
//Gag
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
    string sSpeak1 = sOwnerName + " removes the " + sToyName + " from the mouth of " + sTargetName;
    string sOwnerMessage1 = "You remove the " + sToyName + " from the mouth of " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes the " + sToyName + " from your mouth.";

    //Add messages
    string sSpeak2 = sOwnerName + " stuffs a " + sToyName + " into the mouth of  " + sTargetName;
    string sOwnerMessage2 = "You stuff a " + sToyName + " into the mouth of " + sTargetName;
    string sTargetMessage2 = sOwnerName + " stuffs a " + sToyName + " into your mouth.";

    if (nToyInUse) {
        //Clear the Silence
        ToyClearEffect(OBJECT_SELF, EFFECT_TYPE_SILENCE);
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        effect eEffect = EffectSilence();
        //Apply the Silence effect
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
