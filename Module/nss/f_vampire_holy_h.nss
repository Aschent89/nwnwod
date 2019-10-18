#include "f_vampire_spls_h"
#include "X0_I0_SPELLS"

//::///////////////////////////////////////////////
//:: DoGrenade
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does a damage type grenade (direct or splash on miss)
    Altered: Now affects pc vampires as well.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void DoVampireGrenade(int nDirectDamage, int nSplashDamage, int vSmallHit, int vRingHit, int nDamageType, float fExplosionRadius , int nObjectFilter, int nRacialType=RACIAL_TYPE_ALL)
{
    //Declare major variables  ( fDist / (3.0f * log( fDist ) + 2.0f) )
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamage = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt;
    effect eMissile;
    effect eVis = EffectVisualEffect(vSmallHit);
    location lTarget = GetSpellTargetLocation();


    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    int nTouch;


    if (GetIsObjectValid(oTarget) == TRUE)
    {
/*        // * BK September 27 2002
        // * if the object is 'far' from the original impact it
        // * will be an automatic miss too
        location lObject = GetLocation(oTarget);
        float fDistance = GetDistanceBetweenLocations(lTarget, lObject);
//        SpawnScriptDebugger();
        if (fDistance > 1.0)
        {
            nTouch = -1;
        }
        else
        This did not work. The location and object location are the same.
        For now we'll have to live with the possiblity of the 'explosion'
        happening away from where the grenade hits.
        We could convert everything to splash...
        */
            nTouch = TouchAttackRanged(oTarget);

    }
    else
    {
        nTouch = -1; // * this means that target was the ground, so the user
                    // * intended to splash
    }
    if (nTouch >= 1)
    {
        //Roll damage
        int nDam = nDirectDamage;

        if(nTouch == 2)
        {
            nDam *= 2;
        }

        //Set damage effect
        effect eDam = EffectDamage(nDam, nDamageType);
        //Apply the MIRV and damage effect

        // * only damage enemies
        if(spellsIsTarget(oTarget,SPELL_TARGET_STANDARDHOSTILE,OBJECT_SELF) )
        {
        // * must be the correct racial type (only used with Holy Water)
            if ((nRacialType != RACIAL_TYPE_ALL) && (nRacialType == GetRacialType(oTarget) || GetIsVampire(oTarget)))
//alterations are on the line above this. -Fallen
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget); VISUALS outrace the grenade, looks bad
            }
            else
            if ((nRacialType == RACIAL_TYPE_ALL) )
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget); VISUALS outrace the grenade, looks bad
            }

        }

    //    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
    }

// *
// * Splash damage always happens as well now
// *
    {
        effect eExplode = EffectVisualEffect(vRingHit);
       //Apply the fireball explosion at the location captured above.

/*       float fFace = GetFacingFromLocation(lTarget);
       vector vPos = GetPositionFromLocation(lTarget);
       object oArea = GetAreaFromLocation(lTarget);
       vPos.x = vPos.x - 1.0;
       vPos.y = vPos.y - 1.0;
       lTarget = Location(oArea, vPos, fFace);
       missing code looks bad because it does not jive with visual
*/
       ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fExplosionRadius, lTarget, TRUE, nObjectFilter);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget,SPELL_TARGET_STANDARDHOSTILE,OBJECT_SELF) )
        {
            float fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            //Roll damage for each target
            nDamage = nSplashDamage;

            //Set the damage effect
            effect eDam = EffectDamage(nDamage, nDamageType);
            if(nDamage > 0)
            {
        // * must be the correct racial type (only used with Holy Water)
                if ((nRacialType != RACIAL_TYPE_ALL) && (nRacialType == GetRacialType(oTarget) || GetIsVampire(oTarget)))
//alterations are on the line above this. -Fallen
                {
                    // Apply effects to the currently selected target.
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
                else
                if ((nRacialType == RACIAL_TYPE_ALL) )
                {
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }

            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fExplosionRadius, lTarget, TRUE, nObjectFilter);
    }
    }
}

