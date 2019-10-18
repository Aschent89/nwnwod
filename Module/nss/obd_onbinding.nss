////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_onbinding
//  By Don Anderson
//  dandersonru@msn.com
//
//  Binds a Character to a Binding Stone
//
////////////////////////////////////////////////////////////////////////////////

#include "obd_include"

void main()
{
    object oPC      = GetPCSpeaker();
    object oBS      = OBJECT_SELF;
    effect eFX1     = EffectVisualEffect(VFX_IMP_BREACH);
    effect eFX2     = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    string sBP      = GetTag(oBS);
    string sBPName  = GetName(oBS);
    string sDB      = OBD_GetDBString();

    //Apply Effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX1, oBS);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX2, oBS);
    ActionWait(2.0f);
    AssignCommand (oPC, ActionPlayAnimation (ANIMATION_LOOPING_WORSHIP, 1.0, 7.0));
    AssignCommand (oPC, PlayVoiceChat (VOICE_CHAT_PAIN2));

    //Set Information Permanantly to Player
    NBDE_SetCampaignString(sDB,"BS_LASTBINDPOINT",sBP,oPC);
    string sSay = "You are now bound at " + sBPName + "!";
    SendMessageToPC(oPC,sSay);
}
