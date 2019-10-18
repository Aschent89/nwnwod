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
    string sGender;
    switch (GetGender(oSlave)) {
        case GENDER_FEMALE : sGender = "her"; break;
        case GENDER_MALE : sGender = "his"; break;}
    string sSpeak = "The enchanted collar around the neck of " + sName + " begins to glow, the belts, strings, and buckles holding " + sGender + " clothing together beginning to come undone, the clothes falling freely to the ground.";

    object oChest = GetItemInSlot(INVENTORY_SLOT_CHEST, oSlave);

    //Strip the clothing
    AssignCommand(oSlave, SpeakString(sSpeak));
    AssignCommand(oSlave, ActionUnequipItem(oChest));
    if (COLLAR_STRIP_CLOTHING_VFX != 0) {
        effect eVisual = EffectVisualEffect(COLLAR_STRIP_CLOTHING_VFX);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oSlave); }

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");


}
