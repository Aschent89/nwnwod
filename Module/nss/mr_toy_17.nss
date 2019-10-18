#include "toy_source"
//Nude Costume
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
    string sOwnerMessage1 = "You have removed the Nude Costume from " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes your Nude Costume.";

    //Add messages
    string sOwnerMessage2 = "You have equipped " + sTargetName + " with a Nude Costume.";
    string sTargetMessage2 = sOwnerName + " has equipped you with a Nude Costume.";

    object oCostume;
    object oOldClothItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);

    if (nToyInUse || GetTag(oOldClothItem) == BDSM_NUDE_COSTUME) {
        //Destroy the Costume
        oCostume = GetItemPossessedBy(OBJECT_SELF, BDSM_NUDE_COSTUME);
        DestroyObject(oCostume);
        //Send the appropiate messages
        SendMessageToPC(OBJECT_SELF, sTargetMessage1);
        SendMessageToPC(oToyOwner, sOwnerMessage1);
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        //Create the NudeCostume
        oCostume = CreateItemOnObject(BDSM_NUDE_COSTUME, OBJECT_SELF);
        //If they are wearing something, remove it.
        if (GetIsObjectValid(oOldClothItem)) AssignCommand(OBJECT_SELF, ActionUnequipItem(oOldClothItem));
        //Finnally equip the Nude Costume
        DelayCommand(1.5, AssignCommand(OBJECT_SELF, ActionEquipItem(oCostume, INVENTORY_SLOT_CHEST)));
        //Send the appropraite message
        SendMessageToPC(OBJECT_SELF, sTargetMessage2);
        SendMessageToPC(oToyOwner, sOwnerMessage2);
        //Set the flag
        SetLocalInt(OBJECT_SELF, sToyTag, 1); }

    DeleteLocalString(OBJECT_SELF, "MR_TOY_TAG");
    DeleteLocalString(OBJECT_SELF, "MR_TOY_NAME");
    DeleteLocalObject(OBJECT_SELF, "MR_TOY_OWNER");


}
