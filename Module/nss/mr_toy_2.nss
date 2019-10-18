#include "toy_source"
//Shackles
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
    string sSpeak1 = sOwnerName + " removes the shackles from the hands of " + sTargetName;
    string sOwnerMessage1 = "You remove the shackles from the hands of " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes the shackles from your hands.";

    //Add messages
    string sSpeak2 = sOwnerName + " moves the hands of " + sTargetName + " behind their back and locks them in shackles.";
    string sOwnerMessage2 = "You lock the hands of " + sTargetName + " in shackles.";
    string sTargetMessage2 = sOwnerName + " locks your hands in shackles.";

    if (nToyInUse) {
        //Clear the Spell Failure
        ToyClearEffect(OBJECT_SELF, EFFECT_TYPE_SPELL_FAILURE);
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        effect eEffect = EffectSpellFailure();
        //Apply the Spell Failure effect and unequip any weapons or shields they have
        AssignCommand(OBJECT_SELF, ToyApplyEffect(OBJECT_SELF, eEffect));
        DelayCommand(0.5, AssignCommand(OBJECT_SELF, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF))));
        DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF))));
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
