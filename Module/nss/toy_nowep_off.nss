#include "toy_source"
void main()
{
    //Get the local variables
    object oMaster = GetPCSpeaker();;
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");
    object oLeash = GetLocalObject(oMaster, "MR_COLLAR_LEASH");
    object oCollar = GetLocalObject(oMaster, "MR_COLLAR_COLLAR");

    //Get the name of the slave and process a string
    string sSlaveName = GetName(oSlave);
    string sSpeak = "The enchanted collar around the neck of " + sSlaveName + " stops glowing, allowing them to use weapons.";

    //Flag them as being able to use weapons
    DeleteLocalInt(oSlave, "COLLAR_NO_WEAPONS");

    //Speak the emote
    AssignCommand(oSlave, ActionSpeakString(sSpeak));

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");

}
