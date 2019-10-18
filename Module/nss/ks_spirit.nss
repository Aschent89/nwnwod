void main()
{
    effect ePtfy = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
//    effect eHold = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePtfy, OBJECT_SELF);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHold, OBJECT_SELF);
}
