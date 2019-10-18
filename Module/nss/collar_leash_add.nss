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
    string sSpeak = sMasterName + " attaches a leather leash to the enchanted collar around the neck of " + sSlaveName;

    //Check for other effects that could interfere with the Leashing
    if (GetLocalInt(oSlave, BDSM_LEASH)) DeleteLocalInt(oSlave, BDSM_LEASH);
    if (GetLocalInt(oSlave, "MR_COLLAR_FROZEN")) {
        ToyClearEffect(oSlave, EFFECT_TYPE_CUTSCENE_PARALYZE);
        DeleteLocalInt(oSlave, "MR_COLLAR_FROZEN"); }

    //Clear any animations or follow object commands already in effect.
    DelayCommand(0.2, AssignCommand(oSlave, ClearAllActions(FALSE)));

    //Leash the player
    AssignCommand(oMaster, ActionSpeakString(sSpeak));
    DelayCommand(0.5, AssignCommand(oSlave, ActionForceFollowObject(oMaster, 1.0)));
    SetLocalInt(oSlave, "MR_COLLAR_LEASH", 1);

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");

}
