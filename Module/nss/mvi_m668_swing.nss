void main()
{
    object oPC = GetEnteringObject();

    if((GetLocalInt(OBJECT_SELF,"fired") != 1) && (GetIsPC(oPC)))
    {
        effect eDmg = EffectDamage(d6(2)+3,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_FIVE);
        effect eDown = EffectKnockdown();
        object oTrap = GetObjectByTag("mvi_tr_swingrock");

        AssignCommand(oTrap,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oPC);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDown,oPC,5.0f);

        SetLocalInt(OBJECT_SELF,"fired",1);
    }
}
