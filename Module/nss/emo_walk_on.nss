void main()
{
    object oPC = GetPCSpeaker();
    effect eMovementSpeedDecrease = SupernaturalEffect(EffectMovementSpeedDecrease(75));

    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMovementSpeedDecrease, oPC));
    SetLocalInt(oPC, "MR_WALKING", 1);

}
