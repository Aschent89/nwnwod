#include "toy_source"
void main()
{
    //Get the local variables
    object oMaster = GetPCSpeaker();;
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");
    object oLeash = GetLocalObject(oMaster, "MR_COLLAR_LEASH");
    object oCollar = GetLocalObject(oMaster, "MR_COLLAR_COLLAR");

    //Get the names and process a string
    string sMasterName = GetName(oMaster);
    string sSlaveName = GetName(oSlave);
    string sSpeak = sMasterName + " removes the leather leash attached to the enchanted collar around the neck of " + sSlaveName;

    //Unleash the player
    AssignCommand(oMaster, ActionSpeakString(sSpeak));
    DelayCommand(0.2, AssignCommand(oSlave, ClearAllActions(FALSE)));
    DeleteLocalInt(oSlave, "MR_COLLAR_LEASH");

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");

}
