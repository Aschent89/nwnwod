#include "toy_source"
//Butt Plugs
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

    //Determine what clothing model number to use
    int nAppearance;
    string sTail;

    if (sToyName == "Butt Plug With Cat Tail") {
        sTail = "long silken cat tail";
        switch (GetGender(OBJECT_SELF)) {
            case GENDER_FEMALE : nAppearance = BDSM_NUMBER_CATTAIL_F; break;
            case GENDER_MALE : nAppearance = BDSM_NUMBER_CATTAIL_M; break; } }
    if (sToyName == "Butt Plug With Devil Tail") {
        sTail = "long pointed devil tail";
        switch (GetGender(OBJECT_SELF)) {
            case GENDER_FEMALE : nAppearance = BDSM_NUMBER_DEVILTAIL_F; break;
            case GENDER_MALE : nAppearance = BDSM_NUMBER_DEVILTAIL_M; break; } }
    if (sToyName == "Butt Plug With Dog Tail") {
        sTail = "short fluffy dog tail";
        switch (GetGender(OBJECT_SELF)) {
            case GENDER_FEMALE : nAppearance = BDSM_NUMBER_DOGTAIL_F; break;
            case GENDER_MALE : nAppearance = BDSM_NUMBER_DOGTAIL_M; break; } }

    //Removal messages
    string sSpeak1 = sOwnerName + " removes the  butt plug from the behind of " + sTargetName;
    string sOwnerMessage1 = "You remove a butt plug from the behind of " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes a butt plug from your behind";

    //Add messages " + sTargetName;
    string sSpeak2 = sOwnerName + " pushes a butt plug with a " + sTail + " into the behind of " + sTargetName;
    string sOwnerMessage2 = "You push a butt plug with a " + sTail + " into the behind of " + sTargetName;
    string sTargetMessage2 = sOwnerName + " pushes a butt plug with a " + sTail + " into your behind.";

    //Get the targets clothing
    object oChest = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);
    object oModified;


    if (nToyInUse) {
        //Reset the clothing to 0
        oModified = CopyItemAndModify(oChest, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_BELT, 0);
        //Equip the new clothing
        DelayCommand(0.8, AssignCommand(OBJECT_SELF, ActionEquipItem(oModified, INVENTORY_SLOT_CHEST)));
        //Destroy the old clothing
        DelayCommand(1.3, DestroyObject(oChest));
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Play the sound
        PlayVoiceChat(VOICE_CHAT_PAIN1, OBJECT_SELF);
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        //Alter the clothing
        oModified = CopyItemAndModify(oChest, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_BELT, nAppearance);
        //Equip the new clothing
        DelayCommand(0.8, AssignCommand(OBJECT_SELF, ActionEquipItem(oModified, INVENTORY_SLOT_CHEST)));
        //Destroy the old clothing
        DelayCommand(1.3, DestroyObject(oChest));
        //Send the appropraite messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage2);
            SendMessageToPC(oToyOwner, sOwnerMessage2); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak2));
        //Play the sound
        PlayVoiceChat(VOICE_CHAT_PAIN2, OBJECT_SELF);
        //Set the flag
        SetLocalInt(OBJECT_SELF, sToyTag, 1); }

    DeleteLocalString(OBJECT_SELF, "MR_TOY_TAG");
    DeleteLocalString(OBJECT_SELF, "MR_TOY_NAME");
    DeleteLocalObject(OBJECT_SELF, "MR_TOY_OWNER");


}
