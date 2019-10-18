void PortalOn(object oPortal)
{
    int iState = GetLocalInt(oPortal, "state");
    if(iState == FALSE)
    {
    //turn it on
        AssignCommand(oPortal, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    //make it pretty
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION), GetLocation(oPortal));
        effect eVis = EffectVisualEffect(VFX_DUR_GLYPH_OF_WARDING);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPortal);
        eVis = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPortal);
        eVis = EffectVisualEffect(VFX_DUR_SPELLTURNING);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPortal);
        eVis = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPortal);
        eVis = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPortal);
        SetUseableFlag(oPortal, FALSE);
        SetLocalInt(oPortal, "State", TRUE);
    }
}

void PortalOff(object oPortal)
{
    int iState = GetLocalInt(oPortal, "state");
    if(iState == TRUE)
    {
        //turn it off
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_IMPLOSION), GetLocation(oPortal));
        AssignCommand(oPortal, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        effect eVis = GetFirstEffect(oPortal);
        while (GetIsEffectValid(eVis))
        {
            RemoveEffect(oPortal, eVis);
            eVis = GetNextEffect(oPortal);
        }
    }
}

void main()
{
    //object oPortal = OBJECT_SELF;
    PortalOn(OBJECT_SELF);
}
