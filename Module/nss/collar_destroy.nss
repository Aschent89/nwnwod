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
    string sGender;
    switch (GetGender(oSlave)) {
        case GENDER_FEMALE : sGender = "her"; break;
        case GENDER_MALE : sGender = "his"; break;}
    string sSpeak = "The enchanted collar around the neck of " + sSlaveName + " begins to sparkle, then chip and finnaly disintegrate into metal powder, falling from " + sGender + " neck.";

    //Destroy the collar
    SetLocalInt(OBJECT_SELF, "MR_COLLAR_OFF", 1);
    AssignCommand(oSlave, ActionSpeakString(sSpeak));
    DestroyObject(oLeash);
    DestroyObject(oCollar);
    DelayCommand(1.0, DeleteLocalInt(OBJECT_SELF, "MR_COLLAR_OFF"));

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");


}
