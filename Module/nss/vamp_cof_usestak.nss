#include "vamp_pentagram_h"
#include "vamp_main_h"
#include "vamp_persistent"
//::///////////////////////////////////////////////
//:: FileName f_vampirecoffinm
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/13/2003 11:53:18 PM
//:://////////////////////////////////////////////

//used to be the balor ondeath fireball...
void doFireball(object oOwner){
    effect eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eDam;
    effect eStatus;
    location lTarget = GetLocation(OBJECT_SELF);
    float fDelay;
    int iStatus;
    int nDamage;
    int nCasterLvl = Determine_Vampire_Level(oOwner);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget)){
        //Get the distance between the explosion and the target to calculate delay
        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
        //Roll damage for each target
        nDamage = d8(nCasterLvl);
        //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, (10 + nCasterLvl), SAVING_THROW_TYPE_NEGATIVE);
        //Set the damage effect
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
        if(nDamage > 0 && oTarget != oOwner){
            iStatus = Random(61);
            if(iStatus < 44){
                eStatus = EffectPoison(iStatus);
            }
            else{
                eStatus = EffectDisease(iStatus - 44);
            }
            // Apply effects to the currently selected target.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eStatus, oTarget));
        }
        if(oTarget == OBJECT_SELF){
            DestroyObject(OBJECT_SELF, fDelay);
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}


void main(){
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "FALLEN_VAMPIRE_STAKE");
    if(!GetIsObjectValid(oItemToTake)){
        FloatingTextStringOnCreature("You don't have a stake to use!", GetPCSpeaker());
        return;
    }
    if(!GetLocalInt(OBJECT_SELF, "FALLEN_IN_COFFIN")){
        FloatingTextStringOnCreature("Your too late, the vampire has awoken!", GetPCSpeaker());
        return;
    }
    DestroyObject(oItemToTake);
    object oOwner = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN");
    effect eVis = EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES);
    Vampire_Set_Int(oOwner, "FALLEN_VAMPIRE_STAKED", TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    SetCommandable(TRUE, oOwner);
    AssignCommand(oOwner, ClearAllActions(TRUE));
    SetCommandable(FALSE, oOwner);
    CreateItemOnObject("bloodvampire", GetPCSpeaker());
    eVis = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
    pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_FIRE_LASH, 3.5, 0.3);
    DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, 2.0));
    DelayCommand(3.0, SetPlotFlag(OBJECT_SELF, FALSE));
    if(GetIsObjectValid(oOwner)){
        DelayCommand(3.5, ExecuteScript("f_vampirestaked", oOwner));
    }
    DelayCommand(3.5, doFireball(oOwner));
}
