#include "rp_global"
///////////////////////////////////////////////////////////////////////////////
/////////////////////Mad Rabbit's Roleplaying World////////////////////////////
/////////////////Code For Campsite Based Resting System////////////////////////
///////////////////////////////////////////////////////////////////////////////

////////////////////////////////Constants//////////////////////////////////////

//Resting flag
const string RP_RESTING_FLAG = "RP_RESTING_FLAG";

//Resting effect generator tag
const string RP_RESTING_TAG_GENERATOR = "rp_rest_gen";

///////////////////////////////Definitions/////////////////////////////////////

//Function that applies blindness and sleeping effects to oPC when resting
void RpRestApplyEffects(object oPC);

//Function that removes blindness and sleeping effects from oPC when not resting
void RpRestClearEffects(object oPC);

///////////////////////////////Declarations////////////////////////////////////

void RpRestApplyEffects(object oPC)
{

    object oGenerator = GetObjectByTag(RP_RESTING_TAG_GENERATOR);
    effect eBlind = SupernaturalEffect(EffectBlindness());
    effect eVisual = EffectVisualEffect(VFX_IMP_SLEEP);

    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlind, oPC));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPC);
}

void RpRestClearEffects(object oPC)
{
    effect eEffect = GetFirstEffect(oPC);
    object oGenerator = GetObjectByTag(RP_RESTING_TAG_GENERATOR);
    object oCreator;

    while (GetIsEffectValid(eEffect)) {

        oCreator = GetEffectCreator(eEffect);

        if (oCreator == oGenerator)
            RemoveEffect(oPC, eEffect);

        eEffect = GetNextEffect(oPC); }
}




