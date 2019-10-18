#include "toy_source"
//Thigh Cuffs
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
    int nAppearance = BDSM_NUMBER_THIGH_CUFFS_F;

    if (GetGender(OBJECT_SELF) == GENDER_MALE) {
        string sWrongToy = "This toy only works on females!";
        FloatingTextStringOnCreature(sWrongToy, OBJECT_SELF, FALSE);
        FloatingTextStringOnCreature(sWrongToy, oToyOwner, FALSE);
        DeleteLocalString(OBJECT_SELF, "MR_TOY_TAG");
        DeleteLocalString(OBJECT_SELF, "MR_TOY_NAME");
        DeleteLocalObject(OBJECT_SELF, "MR_TOY_OWNER");
        return; }

    //Removal messages
    string sSpeak1 = sOwnerName + " removes a leather cuff from each thigh of " + sTargetName;
    string sOwnerMessage1 = "You remove the leather cuffs from the thigh of " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes the leather cuffs from your thighs.";

    //Add messages
    string sSpeak2 = sOwnerName + " fastens a leather cuff around each thigh of " + sTargetName;
    string sOwnerMessage2 = "You fasten a leather cuff around each thigh of " + sTargetName;
    string sTargetMessage2 = sOwnerName + " fastens a leather cuff around each of your thighs.";

    //Get the targets clothing
    object oChest = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);
    object oModified;
    object oModified2;

    if (nToyInUse) {
        //Reset the clothing to 0
        oModified = CopyItemAndModify(oChest, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_RTHIGH, 0);
        oModified2 = CopyItemAndModify(oModified, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_LTHIGH, 0);
        //Equip the new clothing
        DelayCommand(0.8, AssignCommand(OBJECT_SELF, ActionEquipItem(oModified2, INVENTORY_SLOT_CHEST)));
        //Destroy the old clothing
        DelayCommand(1.3, DestroyObject(oModified));
        DelayCommand(1.4, DestroyObject(oChest));
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        //Alter the clothing
        oModified = CopyItemAndModify(oChest, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_LTHIGH, nAppearance);
        oModified2 = CopyItemAndModify(oModified, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_RTHIGH, nAppearance);
        //Equip the new clothing
        DelayCommand(0.8, AssignCommand(OBJECT_SELF, ActionEquipItem(oModified2, INVENTORY_SLOT_CHEST)));
        //Destroy the old clothing
        DelayCommand(1.3, DestroyObject(oModified));
        DelayCommand(1.4, DestroyObject(oChest));
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
