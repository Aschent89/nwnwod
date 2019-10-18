void main()

{
  int n = 1;
  object oDestroy = GetNearestObjectByTag("VM_StoneDoorLocked", OBJECT_SELF, n++);
  while (GetIsObjectValid(oDestroy))
  {
    effect eMind = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMind, GetLocation(oDestroy));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMind, GetLocation(oDestroy));
    DestroyObject(oDestroy);
    oDestroy = GetNearestObjectByTag("VM_StoneDoorLocked", OBJECT_SELF, n++);
  }
}

