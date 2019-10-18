void main()

{
  int n = 1;
  object oDestroy = GetNearestObjectByTag("x0_tomb", OBJECT_SELF, n++);
  while (GetIsObjectValid(oDestroy))
  {
    location lSpawn = GetLocation(oDestroy);
    effect eMind = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMind, GetLocation(oDestroy));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMind, GetLocation(oDestroy));
    CreateObject(OBJECT_TYPE_CREATURE, "vm_dunedainskele", lSpawn, TRUE);
    DestroyObject(oDestroy);
    oDestroy = GetNearestObjectByTag("x0_tomb", OBJECT_SELF, n++);
  }
}

