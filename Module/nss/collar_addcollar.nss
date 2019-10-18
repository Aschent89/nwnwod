#include "toy_source"
void main()
{
    //Get the local variables
    object oMaster = GetPCSpeaker();;
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");
    object oLeash = GetLocalObject(oMaster, "MR_COLLAR_LEASH");
    object oCollar = GetLocalObject(oMaster, "MR_COLLAR_COLLAR");

    object oClothing = GetItemInSlot(INVENTORY_SLOT_CHEST, oSlave);

    if (!GetIsObjectValid(oClothing))
        FloatingTextStringOnCreature("The slave is not wearing any clothing!", oMaster, FALSE);

    if (GetIsObjectValid(oClothing)) {
        AddSlaveCollar(oClothing, oSlave);
        FloatingTextStringOnCreature("Your master has changed your clothing to have the appearance of a slave collar", oSlave, FALSE); }

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");


}
