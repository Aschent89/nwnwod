#include "toy_source"
void CollarEquip(object oCollar, object oSlave)
{
    object oOldCollar = GetItemInSlot(INVENTORY_SLOT_NECK, oSlave);

    //If the slave is wearing a collar, unequip it and equip the new one
    if (GetIsObjectValid(oOldCollar)) {
        AssignCommand(oSlave, ActionUnequipItem(oOldCollar));
        DelayCommand(1.0, AssignCommand(oSlave, ActionEquipItem(oCollar, INVENTORY_SLOT_NECK)));
        return; }
    //Otherwise just equip the collar
    AssignCommand(oSlave, ActionEquipItem(oCollar, INVENTORY_SLOT_NECK));
}

void main()
{
    object oSlave = GetPCSpeaker();
    object oDom = GetLocalObject(oSlave, "MR_TOY_OWNER");
    object oBlankCollar = GetLocalObject(oSlave, "MR_COLLAR");

   //Get the waypoint in the module core to create the collar and leash
    object oWaypoint = GetWaypointByTag(BDSM_CORE_WAYPOINT);
    location lLoc = GetLocation(oWaypoint);

    //Destroy the Blank Collar
    DestroyObject(oBlankCollar);

    //Get the CD Keys of both players and combine them to create an unique id
    string sSlaveCD = GetPCPublicCDKey(oSlave, TRUE);
    string sDomCD = GetPCPublicCDKey(oDom, TRUE);
    string sID = sSlaveCD + sDomCD;

    //Create the new tags for the Leash and Collar
    string sNewLeashTag = LEASH_PREFIX + sID;
    string sNewCollarTag = COLLAR_PREFIX + sID;

    //Get the Names of each player and create new names for the collar and leash
    string sSlaveName = GetName(oSlave);
    string sDomName = GetName(oDom);
    string sNewCollarName = sDomName + "'s Slave Collar";
    string sNewLeashName = sSlaveName + "'s Leash";

    //Determine the messages
    string sMessage1 = "";
    string sMessage2 = "";
    if (EMOTE_STRINGS_OFF) {
        sMessage1 = "You have locked a slave collar around the neck of " + sSlaveName;
        sMessage2 = sDomName + " has locked a slave collar around your neck."; }
    if (!EMOTE_STRINGS_OFF) sMessage1 = sDomName + " has locked a slave collar around the neck of " + sSlaveName;

    //Speak the messages
    if (EMOTE_STRINGS_OFF) {
        SendMessageToPC(oSlave, sMessage2);
        SendMessageToPC(oDom, sMessage1); }
    if (!EMOTE_STRINGS_OFF) AssignCommand(oDom, SpeakString(sMessage1));

    //Create the collar, modify it, and then copy it onto the player.
    object oCollar = CreateObject(OBJECT_TYPE_ITEM, COLLAR_RESREF, lLoc, FALSE, sNewCollarTag);
    SetName(oCollar, sNewCollarName);
    object oNewCollar = CopyObject(oCollar, GetLocation(oSlave), oSlave);
    DelayCommand(0.5, DestroyObject(oCollar));

    //Create the leash, modify it, and then copy it onto the player.
    object oLeash = CreateObject(OBJECT_TYPE_ITEM, LEASH_RESREF, lLoc, FALSE, sNewLeashTag);
    SetName(oLeash, sNewLeashName);
    CopyObject(oLeash, GetLocation(oDom), oDom);
    DelayCommand(0.5, DestroyObject(oLeash));

    //If the slave is wearing clothing, modify it to have the appearance of
    //a slave collar
    object oCloth = GetItemInSlot(INVENTORY_SLOT_CHEST, oSlave);

    if (GetIsObjectValid(oCloth)) DelayCommand(1.5, AddSlaveCollar(oCloth, oSlave));

    //If the collar is unequippable, equip the new collar
    if (COLLAR_UNEQUIPABLE) DelayCommand(2.0, CollarEquip(oNewCollar, oSlave));

    //Save both characters
    DelayCommand(3.0, ExportSingleCharacter(oSlave));
    DelayCommand(3.0, ExportSingleCharacter(oDom));


}
