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
    string sSpeak = "The enchanted collar around the neck of " + sName + " begins to glow, " + sGender + " body being manipulated by some unseen force.";

    //Clear any leashs
    DeleteLocalInt(oSlave, BDSM_LEASH);
    DeleteLocalInt(oSlave, "MR_COLLAR_LEASH");

    AssignCommand(oSlave, ClearAllActions());

    //Make the effect
    SetLocalInt(oSlave, "COLLAR_EFFECT_TYPE", 1);

    //Play the animation then freeze them.
    SetLocalInt(oSlave, "MR_COLLAR_FROZEN", 1);
    AssignCommand(oSlave, ActionSpeakString(sSpeak));
    float fDuration = 120.0 * 60.0;
    DelayCommand(0.7, AssignCommand(oSlave, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDuration)));
    DelayCommand(1.0, ExecuteScript("collar_effect", oSlave));


    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");


}
