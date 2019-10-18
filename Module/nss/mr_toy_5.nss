#include "toy_source"
//Collar with Bell
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
    string sSpeak1 = sOwnerName + " removes a black leather collar with a small silver bell from the neck of " + sTargetName;;
    string sOwnerMessage1 = "You remove a black leather collar with a small silver bell from the neck of " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes a black leather collar with a small silver bell from your neck.";

    //Add messages
    string sSpeak2 = sOwnerName + " attaches a black leather collar with a small silver bell around the neck of " + sTargetName;
    string sOwnerMessage2 = "You place a black leather collar with a small silver bell around the neck of " + sTargetName;
    string sTargetMessage2 = sOwnerName + " attaches a black leather collar with a small silver bell around your neck.";

    if (nToyInUse) {
        //Clear the Stealth penatlies
        ToyClearEffect(OBJECT_SELF, EFFECT_TYPE_SKILL_DECREASE);
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        effect eEffect = EffectSkillDecrease(SKILL_HIDE, 100);
        effect eEffect2 = EffectSkillDecrease(SKILL_MOVE_SILENTLY, 100);
        //Apply the Stealth penalties
        AssignCommand(OBJECT_SELF, ToyApplyEffect(OBJECT_SELF, eEffect));
        DelayCommand(0.5, AssignCommand(OBJECT_SELF, ToyApplyEffect(OBJECT_SELF, eEffect2)));
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
