void main()
{
    //Bounces the player to the nearest same object with cool effects
    object oPC = GetLastUsedBy();
    object oTarget = GetNearestObjectByTag(GetTag(OBJECT_SELF));
    effect eVis = EffectVisualEffect(VFX_IMP_DISPEL);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oPC);
    AssignCommand(oPC, JumpToObject(oTarget));
}
