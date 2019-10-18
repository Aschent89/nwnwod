////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Siege System - Detonates the Siege Keg
//  os_keg_detonate
//  by Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "os_inc"

void main()
{
    object oKeg = OBJECT_SELF;
    location lLoc = GetLocation(oKeg);

    if (GetLocalInt(oKeg,"DETONATE") == TRUE) return;
    SetLocalInt(oKeg,"DETONATE",TRUE);

    float fRadius = KEG_RADIUS;//Keg Blast Radius
    int nFireDam = d20(5)+20;//These things are Dangerous LOL
    int nConcDam = d10(5)+10;//Concussion Damage
    int nPierDam = d10(5)+10;//Piercing Spray Damage
    effect eFire = EffectDamage(nFireDam, DAMAGE_TYPE_FIRE, DAMAGE_POWER_PLUS_TWENTY);
    effect eConc = EffectDamage(nConcDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
    effect ePierce = EffectDamage(nPierDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    float fDelay = 0.5;

    //Make Explosion
    effect eBoom1 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom1, lLoc);
    effect eBoom2 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
    DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom2, lLoc));

    //Make Scorchmark on Ground and Remove Keg
    OS_CreateFieldEffect(lLoc);
    effect eDest = EffectDeath(TRUE,TRUE);
    DelayCommand(0.3,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDest,oKeg));
    PlaySound("sim_explsun");

    //Now we apply damage to things in the Blast Radius
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
       //Check For Doors
       if(GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
       {
         if (!GetPlotFlag(oTarget))
         {
           // Apply effects to the currently selected target.
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePierce, oTarget));
         }
       }
       //Check for other Placeables
       int nSiege = OS_GetIsSiege(oTarget);
       if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE && nSiege == TRUE)
       {
         if (!GetPlotFlag(oTarget))
         {
           // Apply effects to the currently selected target.
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePierce, oTarget));
         }
       }
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
}
