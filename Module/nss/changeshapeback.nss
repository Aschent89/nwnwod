
void main()
{
    object oPC = GetPCSpeaker();
    effect eChange = EffectVisualEffect(VFX_IMP_CHARM);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eChange, oPC);
    if (GetRacialType(oPC)==RACIAL_TYPE_HUMAN){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HUMAN);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_ELF){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ELF);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_HALFELF){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ELF);
    }
    else if(GetRacialType(oPC)==RACIAL_TYPE_HALFORC){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ORC);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_HALFLING){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALFLING);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_DWARF){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DWARF);
    }
    else if (GetRacialType(oPC)==RACIAL_TYPE_GNOME){
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_GNOME);
    }
    //SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HUMAN);

}
