#include "toy_source"
//Hood
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
    string sSpeak1 = sOwnerName + " removes the black hood from the head of " + sTargetName;
    string sOwnerMessage1 = "You remove the black hood from the head of " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes the black hood over your head..";

    //Add messages
    string sSpeak2 = sOwnerName + " slips a black hood over the head of " + sTargetName + " and ties it shut.";
    string sOwnerMessage2 = "You slip a black hood over the head of " + sTargetName + " and tie it shut.";
    string sTargetMessage2 = sOwnerName + " slips a black hood over your head and ties it shut.";

    object oHood;

    if (nToyInUse) {
        //Clear the Hood penatlies
        ToyClearEffect(OBJECT_SELF, EFFECT_TYPE_BLINDNESS, EFFECT_TYPE_DEAF);
        //Destroy the Hood
        oHood = GetItemPossessedBy(OBJECT_SELF, BDSM_BLACK_HOOD);
        DestroyObject(oHood);
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {

        effect eEffect = EffectDeaf();
        effect eEffect2 = EffectBlindness();
        object oOldHeadItem = GetItemInSlot(INVENTORY_SLOT_HEAD, OBJECT_SELF);
        //Create the Hood
        oHood = CreateItemOnObject(BDSM_BLACK_HOOD, OBJECT_SELF);
        //If they are wearing something, remove it.
        if (GetIsObjectValid(oOldHeadItem)) AssignCommand(OBJECT_SELF, ActionUnequipItem(oOldHeadItem));
        //Apply the Stealth penalties
        AssignCommand(OBJECT_SELF, ToyApplyEffect(OBJECT_SELF, eEffect));
        AssignCommand(OBJECT_SELF, DelayCommand(0.5, ToyApplyEffect(OBJECT_SELF, eEffect2)));
        //Finnally equip the hood
        DelayCommand(1.5, AssignCommand(OBJECT_SELF, ActionEquipItem(oHood, INVENTORY_SLOT_HEAD)));
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
