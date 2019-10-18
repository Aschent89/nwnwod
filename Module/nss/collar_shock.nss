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
    string sSpeak = "The enchanted collar around the neck of " + sSlaveName + " begins to glow, a jolt of electricity coursing threw it.";

    //Determine the Damage effect
    int nDamage = d4(COLLAR_DAMAGE_MULTIPLIER);
    effect eVisual = EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY);
    effect eDamage = EffectDamage(nDamage);
    effect eLink = EffectLinkEffects(eVisual, eDamage);

    //Speak the emote and then shock the slave.
    AssignCommand(oSlave, ActionSpeakString(sSpeak));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oSlave));

    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");

}
