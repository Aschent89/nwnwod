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
    string sSpeak = "The enchanted collar around the neck of " + sName + " stops glowing, allowing " + sGender + " body to move freely again.";

    //Free the slave
    SetLocalInt(oSlave, "COLLAR_EFFECT_TYPE", EFFECT_TYPE_PARALYZE);
    DeleteLocalInt(oSlave, "MR_COLLAR_FROZEN");
    AssignCommand(oSlave, ClearAllActions());
    DelayCommand(2.0, AssignCommand(oSlave, ActionSpeakString(sSpeak)));
    DelayCommand(1.0, ExecuteScript("collar_clear", oSlave));


    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");


}
