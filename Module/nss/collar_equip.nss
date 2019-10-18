#include "toy_source"
void main()
{
    //Get the local variables
    object oMaster = GetPCSpeaker();;
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");
    object oLeash = GetLocalObject(oMaster, "MR_COLLAR_LEASH");
    object oCollar = GetLocalObject(oMaster, "MR_COLLAR_COLLAR");

    //Process the string
    string sSlaveName = GetName(oSlave);
    string sMasterName = GetName(oMaster);
    string sSpeak = sMasterName + " locks an enchanted collar back around the neck of " + sSlaveName;

    //Remove the flag and put the collar back on it off
    AssignCommand(oMaster, ActionSpeakString(sSpeak));
    DelayCommand(3.0, DeleteLocalInt(oSlave, "MR_COLLAR_OFF"));
    object oNeck = GetItemInSlot(INVENTORY_SLOT_NECK, oSlave);
    if (GetIsObjectValid(oNeck)) DelayCommand(0.5, AssignCommand(oSlave, ActionUnequipItem(oNeck)));
    DelayCommand(1.0, AssignCommand(oSlave, ActionEquipItem(oCollar, INVENTORY_SLOT_NECK)));

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");


}
