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
    string sSpeak = "The enchanted collar around the neck of " + sSlaveName + " begins to glow, prohibiting them from using furniture.";

    //Clear all actions in case they are sitting
    AssignCommand(oSlave, ClearAllActions());

    //Flag them as being unable to sit in chairs
    SetLocalInt(oSlave, "COLLAR_NO_SIT", 1);

    //Speak the emote
    AssignCommand(oSlave, ActionSpeakString(sSpeak));

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");

}
