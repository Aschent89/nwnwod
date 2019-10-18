void main()
{
    object oSelf = OBJECT_SELF;
    // Set to Undestroyable, unraiseable, unselectable
    SetIsDestroyable(FALSE, FALSE, FALSE);
    // Apply a death effect as so we die
    effect eDeath = EffectDeath();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oSelf);

}
