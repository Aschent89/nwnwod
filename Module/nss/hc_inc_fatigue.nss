// hcr3 7/17/2003
//hc_inc_fatigue
//
// Created August 14, 2002 by Edward Beck.
// Helper functions to apply fatigue effects to PC's, and save the state.
// Include in scripts that want to use fatigue effects.

void MakePlayerFatigued(object oPC, string message = "")
{
    if (!GetIsPC(oPC)) return;
    int bFatigued = GetLocalInt(oPC, "bFatigued");
    int bExhausted = GetLocalInt(oPC, "bExhausted");
    if (bFatigued || bExhausted) return;
    // hcr3 7/17/2003
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                  ExtraordinaryEffect(EffectAbilityDecrease( ABILITY_STRENGTH, 2)), oPC));
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                  ExtraordinaryEffect(EffectAbilityDecrease( ABILITY_DEXTERITY, 2)), oPC));
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect( EffectMovementSpeedDecrease (60)), oPC));
    if (message!="") FloatingTextStringOnCreature(message, oPC, FALSE);
    SetLocalInt(oPC,"bFatigued",TRUE);
}

void MakePlayerExhausted(object oPC, string message = "")
{
    if (!GetIsPC(oPC)) return;
    int bFatigued = GetLocalInt(oPC, "bFatigued");
    int bExhausted = GetLocalInt(oPC, "bExhausted");
    if (bExhausted) return;
    if (bFatigued) {
        // hcr3 7/17/2003
        RemoveEffect( oPC, ExtraordinaryEffect( EffectAbilityDecrease( ABILITY_STRENGTH, 2)));
        RemoveEffect( oPC, ExtraordinaryEffect( EffectAbilityDecrease( ABILITY_DEXTERITY, 2)));
        RemoveEffect( oPC, ExtraordinaryEffect( EffectMovementSpeedDecrease(60)));
        SetLocalInt(oPC,"bFatigued",FALSE);
    }
    // hcr3 7/17/2003
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                  ExtraordinaryEffect(EffectAbilityDecrease( ABILITY_STRENGTH, 6)), oPC));
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                  ExtraordinaryEffect(EffectAbilityDecrease( ABILITY_DEXTERITY, 6)), oPC));
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect( EffectMovementSpeedDecrease(80)), oPC));
    if (message!="") FloatingTextStringOnCreature( message, oPC, FALSE);
    SetLocalInt(oPC,"bExhausted",TRUE);
}

void MakePlayerCollapse(object oPC, string message = "")
{
    if (!GetIsPC(oPC)) return;
    effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
    effect eBlind =  SupernaturalEffect(EffectBlindness());
    effect eCollapse = SupernaturalEffect(EffectSleep());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCollapse, oPC, 30.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 29.0);
    DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0));

    if (message!="") FloatingTextStringOnCreature(message, oPC, FALSE);
}

void MakePCDrunk(object oPC, int IntLoss, string message = "")
{
    if (!GetIsPC(oPC)) return;
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                 SupernaturalEffect(EffectAbilityDecrease( ABILITY_INTELLIGENCE, IntLoss)), oPC, 30.0));
    if (message!="") FloatingTextStringOnCreature(message, oPC, FALSE);
}
