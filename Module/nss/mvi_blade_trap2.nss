void main()
{
//USER DEFINED VARIABLES========================================================
//==============================================================================
    int iDmgType = DAMAGE_TYPE_SLASHING;   // type of damage to apply
    int iDmg = d8(2);                      // dice to use, and how many (ie, 4d8)
    int iVisual = VFX_FNF_SWINGING_BLADE;  // visual effect to display
    int iDexDC = 23;                       // DC of the DEX check
      // the below are what we apply when the PC fails the check by a lot (>5)
      // if it's an arm hit, the arm crits apply, for a leg hit, the leg ones
      // the caster crit applies if it's an arm hit (simulating trouble casting)
    effect eCritArm = EffectAttackDecrease(1);
    effect eCritLeg = EffectMovementSpeedDecrease(50);
    effect eCritLeg2 = EffectAbilityDecrease(ABILITY_DEXTERITY,1);
    effect eCritCaster = EffectSpellFailure(25);
//==============================================================================
//==============================================================================

    object oPC = GetEnteringObject();
    effect eApply;                     // create this for later - for criticals
    effect ePara = EffectParalyze();   // used later on to freeze a PC
    string sCritArea;                  // message to send the PC about the critical
    int iDex = GetAbilityScore(oPC,ABILITY_DEXTERITY);  // find the PCs DEX score
    int iRand = d20();  // this simulates the PCs ability check roll

      // get the difference between the DC and the PCs total roll
    int iDiff = iDexDC - (iDex + iRand);
      // send the PC a message with their results (like a typical trap does)
    SendMessageToPC(oPC,GetName(oPC)+" rolled "+
                   IntToString(iRand)+" + " +
                   IntToString(iDex)+" = " +
                   IntToString(iDex+iRand)+
                   " vs DC"+IntToString(iDexDC)+".");

      // if the difference is negative, it means they beat the roll (passed the check)
    if (iDiff <= 0)
    {   iDmg = iDmg/2;   }  // half damage for a successful save

    else if (iDiff <= 5)    // check failed by a little - damage only (do nothing)
    {}

    else if (iDiff > 5)     // we failed big, we're in trouble now
    {   iRand = d100();
        if (iRand > 50)     // random check - 50% arm hit, 50% leg hit
        {   eApply = EffectLinkEffects(eCritLeg2,eCritLeg);
            sCritArea = "leg";   }
        else
        {   eApply = EffectLinkEffects(eCritCaster,eCritArm);
            sCritArea = "arm";   }
    }

    effect eDamage = EffectDamage(iDmg,iDmgType,DAMAGE_POWER_PLUS_FIVE);
    effect eViz = EffectVisualEffect(iVisual);

      // time to apply everything and display the trap
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oPC);
    AssignCommand(oPC,ClearAllActions());  // pause the PC in their tracks
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0f,5.0f));

    if (iDiff > 5)  // only apply the additional effects if the PC failed big
    {   SendMessageToPC(oPC,"The trap blades have struck you for a critical hit in the "+sCritArea+"!");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eApply,oPC,300.0f);
    }

      // display the swinging blades
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,eViz,oPC,10.0f);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eViz,GetLocation(OBJECT_SELF),10.0f);
}
