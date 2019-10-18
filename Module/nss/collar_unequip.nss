#include "toy_source"
void main()
{
    //Get the local variables
    object oMaster = GetPCSpeaker();;
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");
    object oLeash = GetLocalObject(oMaster, "MR_COLLAR_LEASH");
    object oCollar = GetLocalObject(oMaster, "MR_COLLAR_COLLAR");

    //Process the string
    string sName = GetName(oSlave);
    string sSpeak = "The enchanted collar around the neck of " + sName + " unlocks, the magic throbbing threw it disapearing.";

    //Flag them as being able to remove the collar and take it off
    AssignCommand(oSlave, ActionSpeakString(sSpeak));
    SetLocalInt(oSlave, "MR_COLLAR_OFF", 1);
    object oNeck = GetItemInSlot(INVENTORY_SLOT_NECK, oSlave);
    DelayCommand(0.5, AssignCommand(oSlave, ActionUnequipItem(oNeck)));

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");


}
