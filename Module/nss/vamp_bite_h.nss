int GetHasGarlicProtection(object oTarget){
    return GetHasSpellEffect(410, oTarget);
}

int GetIsBitable(object oTarget = OBJECT_SELF){
    effect eCheck = GetFirstEffect(oTarget);
    int iCheck = GetEffectType(eCheck);
    if(GetLocalInt(oTarget, "FALLEN_VAMPIRE_BITE_PERMISSION")){
        DeleteLocalInt(oTarget, "FALLEN_VAMPIRE_BITE_PERMISSION");
        return TRUE;
    }
    while(GetIsEffectValid(eCheck)){
        if(iCheck == EFFECT_TYPE_PARALYZE  || iCheck == EFFECT_TYPE_SLEEP  || iCheck == EFFECT_TYPE_STUNNED){
             return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
        iCheck = GetEffectType(eCheck);
    }
    return FALSE;
}

int GetBadBlood(object oTarget = OBJECT_SELF){
    if(GetLocalInt(oTarget, "FALLEN_VAMPIRE_HASBLOOD") == 1){
        return TRUE;
    }
    effect eCheck = GetFirstEffect(oTarget);
    int iCheck = GetEffectType(eCheck);
    while(GetIsEffectValid(eCheck)){
        if(iCheck == EFFECT_TYPE_DISEASE  || iCheck == EFFECT_TYPE_POISON){
             return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
        iCheck = GetEffectType(eCheck);
    }
    return FALSE;
}

void ApplyBloodFX(object oTarget = OBJECT_SELF){
    int iX = Random(61);
    effect eFX;
    if(iX < 44){
        eFX = EffectPoison(iX);
    }
    else{
        iX -= 44;
        if(iX == DISEASE_RED_SLAAD_EGGS){
            iX = DISEASE_BLINDING_SICKNESS; //I like blinding sickness... =)
        }
        eFX = EffectDisease(iX);
    }
    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
    eFX=EffectLinkEffects(eVis, eFX);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFX, oTarget);
}

int GetIsUnableToBite(object oTarget){
    effect eCheck = GetFirstEffect(oTarget);
    int iCheck = GetEffectType(eCheck);
    while(GetIsEffectValid(eCheck))    {
        if(iCheck == EFFECT_TYPE_BLINDNESS  ||
           iCheck == EFFECT_TYPE_CONFUSED  ||
           iCheck == EFFECT_TYPE_DARKNESS  ||
           iCheck == EFFECT_TYPE_DAZED  ||
           iCheck == EFFECT_TYPE_DOMINATED  ||
           iCheck == EFFECT_TYPE_ENTANGLE  ||
           iCheck == EFFECT_TYPE_ETHEREAL  ||
           iCheck == EFFECT_TYPE_FRIGHTENED  ||
           iCheck == EFFECT_TYPE_PETRIFY  ||
           iCheck == EFFECT_TYPE_POLYMORPH  ||
           iCheck == EFFECT_TYPE_TURNED ||
           iCheck == EFFECT_TYPE_PARALYZE  ||
           iCheck == EFFECT_TYPE_SLEEP  ||
           iCheck == EFFECT_TYPE_STUNNED)
        {
             return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
        iCheck = GetEffectType(eCheck);
    }
    return FALSE;
}

void doVampireRevealed(object oSelf, object oNearest, object oTarget){
    FloatingTextStringOnCreature("Your true nature has been seen!", oSelf, FALSE);
    if(GetIsPC(oNearest)){
        SetPCDislike(oSelf, oNearest);
    }
    FloatingTextStringOnCreature(GetName(oSelf) + " is a vampire and has been marked as an enemy!", oNearest, FALSE);
    SetIsTemporaryEnemy(oSelf, oNearest);
    SetIsTemporaryEnemy(oNearest, oSelf);
    if(GetIsPC(oTarget)){
        SetPCDislike(oSelf, oTarget);
    }
    FloatingTextStringOnCreature(GetName(oSelf) + " is a vampire and has been marked as an enemy!", oTarget, FALSE);
    SetIsTemporaryEnemy(oSelf, oTarget);
    SetIsTemporaryEnemy(oTarget, oSelf);
}

