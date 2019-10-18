// Statue script, By Heat.
// Put this on the OnSpawn tag of the NPC you wish to
// be a statue.

void main()
{
    effect ePtfy = EffectVisualEffect(VFX_DUR_PETRIFY);
    effect eHold = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePtfy, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHold, OBJECT_SELF);
}
