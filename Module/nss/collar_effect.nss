#include "toy_source"
void main()
{
    effect eEffect;
    effect eVisual;
    effect eLink;
    switch (GetLocalInt(OBJECT_SELF, "COLLAR_EFFECT_TYPE")) {
        case 1 : {
            eEffect = EffectParalyze();
            eVisual = EffectVisualEffect(COLLAR_FORCE_POSITION_VFX);
            if (COLLAR_FORCE_POSITION_VFX != 0) {
                eLink = EffectLinkEffects(eVisual, eEffect); }
            else {
                eLink = eEffect; }
            break; }
        case 2 : {
            eEffect = EffectSpellFailure(100);
            eVisual = EffectVisualEffect(COLLAR_DISABLE_SPELL_VFX);
            if (COLLAR_DISABLE_SPELL_VFX != 0) {
                eLink = EffectLinkEffects(eVisual, eEffect); }
            else {
                eLink = eEffect; }
            break; } }

    AssignCommand(OBJECT_SELF, ToyApplyEffect(OBJECT_SELF, eLink));
    DeleteLocalInt(OBJECT_SELF, "COLLAR_EFFECT_TYPE");

}
