////////////////////////////////////////////////////////////////////////////////
//  Siege Keg Blaster on Locked Chest
//  ors_od_chest
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Chest OnDamaged Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"
#include "x0_i0_spells"

void main()
{
    object oPC = GetLastDamager();
    object oChest = OBJECT_SELF;
    location lLoc = GetLocation(oChest);

    //Remove Invisibility
    if (GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY, oPC) == TRUE)
    {
      RemoveAnySpellEffects(SPELL_IMPROVED_INVISIBILITY, oPC);
    }
    else if (GetHasSpellEffect(SPELL_INVISIBILITY, oPC) == TRUE)
    {
      RemoveAnySpellEffects(SPELL_INVISIBILITY, oPC);
    }
    else if (GetHasSpellEffect(SPELLABILITY_AS_INVISIBILITY, oPC) == TRUE)
    {
      RemoveAnySpellEffects(SPELLABILITY_AS_INVISIBILITY, oPC);
    }
    else if(GetHasSpellEffect(SPELLABILITY_AS_IMPROVED_INVISIBLITY, oPC) == TRUE)
    {
      RemoveAnySpellEffects(SPELLABILITY_AS_IMPROVED_INVISIBLITY, oPC);
    }

    //Only Valid if the Chest is Locked! Heh
    int nLocked = GetLocked(oChest);
    if(nLocked == FALSE) return;

    float fRadius = 15.0;//Blast Radius
    int nFireDam = d20(5)+20;//These things are Dangerous LOL
    int nConcDam = d20(5)+20;//Concussion Damage
    int nPierDam = d10(5)+10;//Piercing Spray Damage
    effect eFire = EffectDamage(nFireDam, DAMAGE_TYPE_FIRE, DAMAGE_POWER_PLUS_TWENTY);
    effect eConc = EffectDamage(nConcDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_FIVE);
    effect ePierce = EffectDamage(nPierDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_FIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    float fDelay = 0.5;

    //Make Explosion
    effect eBoom1 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom1, lLoc);
    effect eBoom2 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
    DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom2, lLoc));

    //Make Scorchmark on Ground and Remove Keg
    ORS_CreateFieldEffect(lLoc);

    //Now we apply damage to things in the Blast Radius
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
       if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
       {
         //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
         //int nReflex = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePierce, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 3.0));
       }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

    //Now Destroy Chest
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(2000, DAMAGE_TYPE_FIRE, DAMAGE_POWER_PLUS_TWENTY), oChest));
}
