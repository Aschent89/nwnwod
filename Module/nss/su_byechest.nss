void main()
{
    object oItem = GetFirstItemInInventory();
    if(oItem == OBJECT_INVALID)
    {
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF);
        DestroyObject(OBJECT_SELF);
    }
}
