#include "x2_inc_switches"

//does everything myResistSPell does, only it adjusts for +1 ECL
// uses spell script: "add_spell_penetr" , also any changes made to "prc_caster_level" will affect
// it the same way as they affect the GetChangesToCasterLevel function.
int MyPRCResistSpell(object oCaster, object oTarget, float fDelay = 0.0);


// Scraped - because it turned out not to be quite versatile enough.
//effect PRCElementalDamage(object oCaster, int nDamage, int nType, int nDamagePower = DAMAGE_POWER_NORMAL);


// returns amount added to Caster Level to allow adjustments for +1 ECL
// uses spell script: "prc_caster_level"
int GetChangesToCasterLevel(object oCaster);

// returns any additional changes to spell save DC you want included other
// than the basic 10 + spell level + attribute + feats
// uses spell script:  "add_spell_dc"
int GetChangesToSaveDC(object oCaster);

// returns alternate damage type for spells that do area of effect, or damage sheilds.
// uses script: "set_damage_type"
int ChangedElementalDamage(object oCaster, int nDamageType);

// returns the same metamagic feat constant that gets read in, unless the
// executing script tells it otherwise.
int PRCGetMetamagic(int nMetaMagicFeat);

// returns a damage effect, changing said damage based on whatever the executed script
// returns.   It sets the damage type as a local int, so the script can use that information
// if needed.
effect EffectPRCDamage(int nDamageAmount, int nDamageType = DAMAGE_TYPE_MAGICAL, int nDamagePower= DAMAGE_POWER_NORMAL);

// returns a damage shield effect, changing the amount of damage based on whatever either of the
// two executed scripts returns.
effect EffectPRCDamageShield(int nDamageAmount, int nRandomAmount, int nDamageType);

// returns a heal effect, changing the amount healed based on the executed script,
// if necessary
effect EffectPRCHeal(int nAmountToHeal);

// returns a temporary hit points effect.  Remember when altering the executed script for this
// that Vampire Touch is supposed to give the exact same number of temp hp as the negative damage it deals.
effect EffectPRCTemporaryHitpoints(int nHitPoints);

// returns a melee touch attack result.  It should be the same result as the function it replaces,
// but it here as a place holder in case you want to alter the way that happens.  It doesn't
// execute a script, so you'll have to redefine it here and recompile everything if you want to change
// it.
int TouchPRCAttackMelee(object oTarget, int bDisplayFeedback=TRUE);

// same as TouchPRCAttackMelee, but it's a ranged touch attack instead.
int TouchPRCAttackRanged(object oTarget, int bDisplayFeedback=TRUE);


/////////////////////
// These next 6 were accidental changes, so I won't make them execute scripts.
// I had my find and replace program take every instance of "EffectDamage" and
// make it "EffectPRCDamage" , so these following functions were the result,
// and rather than go back and fix this, I figure why not?
//  I *could* fix it, but why not just define them here for fun in case someone
//  wants to mess with them.?????

// These functions work just like their normal counterparts.
// You can redefine them here if you want, or leave them alone.   Doing it here
// only save you the trouble of using a line replacer to do it.  That's all it does. :)
effect EffectPRCDamageDecrease(int nPenalty, int nDamageType=DAMAGE_TYPE_MAGICAL);
effect EffectPRCDamageImmunityDecrease(int nDamageType, int nPercentImmunity);
effect EffectPRCDamageImmunityIncrease(int nDamageType, int nPercentImmunity);
effect EffectPRCDamageIncrease(int nBonus, int nDamageType=DAMAGE_TYPE_MAGICAL);
effect EffectPRCDamageReduction(int nAmount, int nDamagePower, int nLimit=0);
effect EffectPRCDamageResistance(int nDamageType, int nAmount, int nLimit=0);

// does SR checks.   Runs ExecuteScriptAndReturnInt() twice,  once to get adjusted PRC caster level
// and a second time to get any random spell penetration bonuses or to exclude certain targets from
// taking damage.   The caster level script is called "prc_caster_level" and  the other is "add_spell_penetr"

// I think the code for it was much more readable before I tried to optimise it a bit. :)

int MyPRCResistSpell(object oCaster, object oTarget, float fDelay = 0.0)
{

    if (fDelay > 0.5)
    {
        fDelay = fDelay - 0.1;
    }

    int nResist = 0;
    int nTargetSR = GetSpellResistance(oTarget);
    int nRolled;
    string toSay = "";


    DeleteLocalObject(oCaster, "X2_Target_2_B_SCREENED");
    SetLocalObject(oCaster, "X2_Target_2_B_SCREENED", oTarget);

    nResist = ExecuteScriptAndReturnInt("screen_targets", oCaster);

    DeleteLocalObject(oCaster, "X2_Target_2_B_SCREENED");


    // Make sure this script returns 0 if you don't want any thing specifically screened.
    // If this script returns 0, nothing happens
    // If 1, Spell is automatically resisted with the usual SR vfx
    // If 2, same, but with globe vfx
    // If 3, same, but with spell mantle vfx
    // If 4 or higher, same but with no vfx.

    /// I figured it would be better processing time wise rather than to fire off 2 scripts
    /// one for friendly fire checks, and one for random spell penetration bonuses, to just
    /// have them both happen in  "add_spell_penetr"


    if(nResist == 0)
        {
        if(nTargetSR > 0)             // no matter how big the negative modifier you give the
            {                         // caster on their spell penetration check, it will never
                                      // fail against an sr of 0.

            int nCasterLevel = GetCasterLevel(oCaster) + ExecuteScriptAndReturnInt("prc_caster_level", oCaster);
        // this is the same as saying:  GetCasterLevel(oCaster) + GetChangesToCasterLevel(oCaster);
        // I just think it would be silly to actually call the GetChangesToCasterLevel(oCaster) function.
        // It only wastes like I don't know: 5 operations or so?  But why waste them?
            if(GetHasFeat(FEAT_EPIC_SPELL_PENETRATION, oCaster))
                {
                nCasterLevel = nCasterLevel + 6;
                }
                else if(GetHasFeat(FEAT_GREATER_SPELL_PENETRATION, oCaster))
                {
                nCasterLevel = nCasterLevel + 4;
                }
                else if(GetHasFeat(FEAT_SPELL_PENETRATION, oCaster))
                {
                nCasterLevel = nCasterLevel + 2;
                }

            // Adds any special amounts you might want to add to the check, useful if you want to
            // do something like have a staff or scepter of penetrating spell resistance, or a special
            // feat that adds a special bonus to the caster's checks to beat spell resistance.
            nCasterLevel = nCasterLevel + ExecuteScriptAndReturnInt("add_spell_penetr", oCaster);


            int nRolled = d20(1);
            // d&d 3.0E PHB page 150: caster's check (d20 + caster level) must equal or exceed target's SR
            // for the spell to affect it.  So the spell only fails if that check is LESS than the sr,
            // and succeeds if it's equal or greater.

            if(nCasterLevel + nRolled <  nTargetSR) // Do the actual spell resistance check.
                {
                nResist = 1; // <- This is what kills the spell.
                toSay = (IntToString(nRolled) + " + " + IntToString(nCasterLevel) + " = "
                + IntToString(nRolled + nCasterLevel) + " vs. Spell Resistance " + IntToString(nTargetSR)
                + " :  Resisted Spell. ");
                }
                else
                {
                toSay = (IntToString(nRolled) + " + " + IntToString(nCasterLevel) + " = "
                + IntToString(nRolled + nCasterLevel) + " vs. Spell Resistance " + IntToString(nTargetSR)
                + " :  Spell Resistance Defeated. ");
                }
                // A touch I thought I'd add in, since it's possible now.  Caster and Target get
                // to see the roll.  :)  They only see it if the spell hits or is defeated by SR.
                //
                DelayCommand(fDelay, SendMessageToPC(oCaster, toSay));
                DelayCommand(fDelay, SendMessageToPC(oTarget, toSay));

           }// end of check for if target has SR


        if(nResist == 0)    // I don't want it to run the Resist Spell function if SR wasn't penetrated
                {          // or if the target was already getting passed over, or it could waste some
                          // of the target's spell mantle unnecessarily.

                        // The downside is that globes of invulnerability also aren't tested against
                       // if sr isn't penetrated, only if it is.
                      // ie. if both a globe and SR stop a spell, the globe vfx won't fire, only
                     // the SR vfx.

                int nOtherReason = ResistSpell(oCaster, oTarget);
                switch(nOtherReason)
                    {
                    case 2: nResist = 2;break; // Spell stopped by globe
                    case 3: nResist = 3;break; // Spell stopped by spell mantle.
                    }

                }// end of check for globes of invulnerability, and spell mantles.
    }// end of original if(nResist == 0) check much earlier.   Yeah, there's 2 of them.



    effect eSR = EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE);
    effect eGlobe = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eMantle = EffectVisualEffect(VFX_IMP_SPELL_MANTLE_USE);

    if(nResist == 1) //Spell Resistance
    {
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSR, oTarget));

    }
    else if(nResist == 2) //Globe
    {
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGlobe, oTarget));
    }
    else if(nResist == 3) //Spell Mantle
    {
        if (fDelay > 0.5)
        {
            fDelay = fDelay - 0.1;
        }
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMantle, oTarget));
    }
    return nResist;
}
// End of MyPRCResistSpell. :)  the longest function in this file.



// This function was scrapped, in favor of the other elemental damage modifying function.
// It lacked too much in versatility.
/*
effect PRCElementalDamage(object oCaster, int nDamage, int nType, int nDamagePower = DAMAGE_POWER_NORMAL)
{

int nNewType = ExecuteScriptAndReturnInt("set_damage_type", oCaster);
if(nNewType != 0)
{
nType = nNewType;
}
return EffectPRCDamage(nDamage, nType, nDamagePower);

}
*/




/// used to get the +1 ECL caster level amount of a PRC
/// uses ExecuteScriptAndReturnInt() to get the amount of +1 ECL levels
/// that should be added to the spell's casting class due to a PRC
/// the script is called  "prc_caster_level"
int GetChangesToCasterLevel(object oCaster)
{
int nLevelAdded =  ExecuteScriptAndReturnInt("prc_caster_level", oCaster);
return nLevelAdded;
}



/// used to get additional modifications a DM may want made to a spell's save DC
/// uses ExecuteScriptAndReturnInt to decide if the save DC of the caster's spell
/// should be changed.     The script is called  "add_spell_dc"

int GetChangesToSaveDC(object oCaster)
{
return  ExecuteScriptAndReturnInt("add_spell_dc", oCaster);
}



//  uses ExecuteScriptAndReturnInt to decide whether the type
//  of elemental damage a spell does should be changed.   Mind you, the vfx for
//  an elemental spell will stay the same, only the damage type will change.
//  the script being executed is called "set_damage_type"

int ChangedElementalDamage(object oCaster, int nDamageType)
{
int nNewType = ExecuteScriptAndReturnInt("set_damage_type", oCaster);
if(nNewType != 0)
{
nDamageType = nNewType;
}
return nDamageType;
}




// returns the same metamagic feat constant that gets read in, unless the
// executing script tells it otherwise.
int PRCGetMetamagic(int nMetaMagicFeat)
{
int nAlter = ExecuteScriptAndReturnInt("change_metamagic", OBJECT_SELF);
if(nAlter != 0)
// if you want to have it not do a metamagic feat at all, like cancel the metamagic feat
// that is being used (this function is only applicable to extend, maximise, and empower)
// just have it return a value that doesn't match any of those 3 constants.  Nothing will happen
// in the spell script itself unless one of those 3 exact numbers is returned.
{
nMetaMagicFeat = nAlter;
}
return nMetaMagicFeat;
}




// returns a damage effect, changing said damage based on whatever the executed script
// returns.   It sets the damage type as a local int, so the script can use that information
// if needed.
effect EffectPRCDamage(int nDamageAmount, int nDamageType = DAMAGE_TYPE_MAGICAL, int nDamagePower= DAMAGE_POWER_NORMAL)
{
DeleteLocalInt(OBJECT_SELF, "X2_Current_Damage_Type");
DeleteLocalInt(OBJECT_SELF, "X2_Current_Damage_Amount");
SetLocalInt(OBJECT_SELF, "X2_Current_Damage_Type", nDamageType);
SetLocalInt(OBJECT_SELF, "X2_Current_Damage_Amount", nDamageAmount);
// This is so the script being executed can refer to this value
nDamageAmount = nDamageAmount + ExecuteScriptAndReturnInt("add_damage", OBJECT_SELF);
DeleteLocalInt(OBJECT_SELF, "X2_Current_Damage_Type");
DeleteLocalInt(OBJECT_SELF, "X2_Current_Damage_Amount");

return EffectDamage(nDamageAmount, nDamageType, nDamagePower);
}




// returns a damage shield effect, changing the amount of damage based on whatever either of the
// two executed scripts returns.
effect EffectPRCDamageShield(int nDamageAmount, int nRandomAmount, int nDamageType)
{
DeleteLocalInt(OBJECT_SELF, "X2_Current_Damage_Type");
DeleteLocalInt(OBJECT_SELF, "X2_Current_Damage_Amount");
DeleteLocalInt(OBJECT_SELF, "X2_Current_Random_Damage");
SetLocalInt(OBJECT_SELF, "X2_Current_Damage_Type", nDamageType);
SetLocalInt(OBJECT_SELF, "X2_Current_Damage_Amount", nDamageAmount);
SetLocalInt(OBJECT_SELF, "X2_Current_Random_Damage", nRandomAmount);

// This is so the script getting executed can refer to this value
nDamageAmount = nDamageAmount + ExecuteScriptAndReturnInt("add_damageshield", OBJECT_SELF);


int nAlter2 = ExecuteScriptAndReturnInt("add_randdamage", OBJECT_SELF);
// This script should return a constant, DAMAGE_BONUS_1d4, DAMAGE_BONUS_1d6, DAMAGE_BONUS_1d8,
// DAMAGE_BONUS_1d10, DAMAGE_BONUS_1d12, DAMAGE_BONUS_2d4, DAMAGE_BONUS_2d6, DAMAGE_BONUS_2d8,
// DAMAGE_BONUS_2d10, or DAMAGE_BONUS_2d12.
if(nAlter2)
{
nRandomAmount = nAlter2;
// Note that what "add_randdamage" returns is not added to nRandomAmount.  It's a constant, so
// it has to replace it in order to have any significance.
}
DeleteLocalInt(OBJECT_SELF, "X2_Current_Damage_Type");
DeleteLocalInt(OBJECT_SELF, "X2_Current_Damage_Amount");
DeleteLocalInt(OBJECT_SELF, "X2_Current_Random_Damage");

return EffectDamageShield(nDamageAmount, nRandomAmount, nDamageType);
}



// returns a heal effect, changing the amount healed based on the executed script,
// if necessary
effect EffectPRCHeal(int nAmountToHeal)
{
DeleteLocalInt(OBJECT_SELF, "X2_Current_Healing_Amount");
SetLocalInt(OBJECT_SELF, "X2_Current_Healing_Amount", nAmountToHeal);
nAmountToHeal = nAmountToHeal + ExecuteScriptAndReturnInt("add_healing", OBJECT_SELF);
DeleteLocalInt(OBJECT_SELF, "X2_Current_Healing_Amount");

return EffectHeal(nAmountToHeal);
}



// returns a temporary hit points effect.  Remember when altering the executed script for this
// that Vampire Touch is supposed to give the exact same number of temp hp as the negative damage it deals.
effect EffectPRCTemporaryHitpoints(int nHitPoints)
{
DeleteLocalInt(OBJECT_SELF, "X2_Current_Healing_Amount");
SetLocalInt(OBJECT_SELF, "X2_Current_Healing_Amount", nHitPoints);
nHitPoints = nHitPoints + ExecuteScriptAndReturnInt("add_hitpoints", OBJECT_SELF);
DeleteLocalInt(OBJECT_SELF, "X2_Current_Healing_Amount");

return EffectTemporaryHitpoints(nHitPoints);
}



// returns a melee touch attack result.  It should be the same result as the function it replaces,
// but it here as a place holder in case you want to alter the way that happens.  It doesn't
// execute a script, so you'll have to redefine it here and recompile everything if you want to change
// it.
int TouchPRCAttackMelee(object oTarget, int bDisplayFeedback=TRUE)
{
return TouchAttackMelee(oTarget, bDisplayFeedback);
}



// same as TouchPRCAttackMelee, but it's a ranged touch attack instead.
int TouchPRCAttackRanged(object oTarget, int bDisplayFeedback=TRUE)
{
return TouchAttackRanged(oTarget, bDisplayFeedback);
}


// These functions work just like their normal counterparts.
// You can redefine them here if you want, or leave them alone.   Doing it here
// only save you the trouble of using a line replacer to do it.  That's all it does. :)
effect EffectPRCDamageDecrease(int nPenalty, int nDamageType=DAMAGE_TYPE_MAGICAL)
{
return EffectDamageDecrease(nPenalty,nDamageType);
}
effect EffectPRCDamageImmunityDecrease(int nDamageType, int nPercentImmunity)
{
return EffectDamageImmunityDecrease(nDamageType,nPercentImmunity);
}
effect EffectPRCDamageImmunityIncrease(int nDamageType, int nPercentImmunity)
{
return EffectDamageImmunityIncrease(nDamageType,nPercentImmunity);
}
effect EffectPRCDamageIncrease(int nBonus, int nDamageType=DAMAGE_TYPE_MAGICAL)
{
return EffectDamageIncrease(nBonus,nDamageType);
}
effect EffectPRCDamageReduction(int nAmount, int nDamagePower, int nLimit=0)
{
return EffectDamageReduction(nAmount, nDamagePower,  nLimit);
}
effect EffectPRCDamageResistance(int nDamageType, int nAmount, int nLimit=0)
{
return EffectDamageResistance(nDamageType, nAmount, nLimit);
}
