void main()
{
    object oPC = GetPCSpeaker();
    object oCreator;
    int nType;
    int nSubType;
    effect eEffect = GetFirstEffect(oPC);

    while (GetIsEffectValid(eEffect)) {
        oCreator = GetEffectCreator(eEffect);
        nSubType = GetEffectSubType(eEffect);
        if (oCreator == oPC && nSubType == SUBTYPE_SUPERNATURAL) {
            nType = GetEffectType(eEffect);
            if (nType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE) {
                RemoveEffect(oPC, eEffect); }}
    eEffect = GetNextEffect(oPC); }

    DeleteLocalInt(oPC, "MR_WALKING");


}
