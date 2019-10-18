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
    string sSpeak = "The enchanted collar around the neck of " + sName + " begins to glow, " + sGender + " ability to cast and use magic being stripped away.";

   //Make the effect
    SetLocalInt(oSlave, "COLLAR_EFFECT_TYPE", 2);

    //Disable the slave's spell casting
    DelayCommand(1.0, ExecuteScript("collar_effect", oSlave));
    AssignCommand(oSlave, SpeakString(sSpeak));
    SetLocalInt(oSlave, "MR_COLLAR_SPELL_OFF", 1);

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");
}
