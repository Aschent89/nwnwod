#include "f_vampire_h"

//::///////////////////////////////////////////////
//:: NotSafeToRest
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns TRUE if this is an area that the
    player is not allowed to rest in and the condition
    is not achieved.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
int NotSafeToRest(object oPC)
{

    // * The resting system only works on Hardcore
    // * or above.
    if (GetGameDifficulty() < GAME_DIFFICULTY_CORE_RULES) return FALSE;
    return !GetLocalInt(GetArea(oPC), "bAllowRest");
}

//::///////////////////////////////////////////////
//:: NotOnSafeRest
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    returns TRUE if the player is not in a safe
    zone within an area.

    RULE: There must be at least one door
          All doors must be closed

    - takes player object
    - finds nearest safe zone
    - is player in safe zone?
       - find all doors in safe zone
        - are all doors closed?
            - if YES to all the above
                is safe to rest,
                    RETURN FALSE
    - otherwise give appropriate feedback and return TRUE
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
int NotOnSafeRest(object oPC)
{  // SpawnScriptDebugger();
    object oSafeTrigger = GetNearestObjectByTag("X0_SAFEREST", oPC);
    int bAtLeastOneDoor = FALSE;
    int bAllDoorsClosed = TRUE;
    int bPCInTrigger = FALSE;

    if (GetIsObjectValid(oSafeTrigger))
    {
        if (GetObjectType(oSafeTrigger) == OBJECT_TYPE_TRIGGER)
        {

            // * cycle through trigger looking for oPC
            // * and looking for closed doors
            object oInTrig = GetFirstInPersistentObject(oSafeTrigger, OBJECT_TYPE_ALL);
            while (GetIsObjectValid(oInTrig) == TRUE)
            {
                // * rester is in trigger!
                if (oPC == oInTrig)
                {
                    bPCInTrigger = TRUE;
                }
                else
                {
                    // * one door found
                    if (GetObjectType(oInTrig) == OBJECT_TYPE_DOOR)
                    {
                        bAtLeastOneDoor = TRUE;
                        // * the door was open, exit
                        if (GetIsOpen(oInTrig) == TRUE)
                        {
                            return TRUE; //* I am not in a safe rest place because a door is open
                        }
                    }
                }
                oInTrig = GetNextInPersistentObject(oSafeTrigger, OBJECT_TYPE_ALL);
            }
        }
    }
    if (bPCInTrigger == FALSE || bAtLeastOneDoor == FALSE)
    {
        return TRUE;
    }
    // * You are in a safe trigger, if in a trigger, and all doors closed on that trigger.
    return FALSE;
}

void GetOutOfCoffin(object oCoffin, int iStartHP)
{
if(GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_STAKED")) return;
effect eDamage;
if(GetLocalInt(oCoffin, "FALLEN_VAMPIRE_GARLIC"))
    {
    eDamage = EffectDamage((GetCurrentHitPoints() - iStartHP), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);
    DelayCommand(1.5, FloatingTextStringOnCreature("Someone applied garlic to your coffin rendering this rest useless.", OBJECT_SELF));
    DeleteLocalInt(oCoffin, "FALLEN_VAMPIRE_GARLIC");
    }
if(GetLocalInt(oCoffin, "FALLEN_VAMPIRE_HOLYWATER"))
    {
    eDamage = EffectDamage((GetCurrentHitPoints() / 3), DAMAGE_TYPE_DIVINE, DAMAGE_POWER_ENERGY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);
    DelayCommand(1.5, FloatingTextStringOnCreature("Someone put holy water into your coffin harming you greatly before your aura removed the holy liquid.", OBJECT_SELF));
    DeleteLocalInt(oCoffin, "FALLEN_VAMPIRE_HOLYWATER");
    }
if(GetLocalInt(oCoffin, "FALLEN_VAMPIRE_ROSEWARD"))
    {
    eDamage = EffectDamage((GetCurrentHitPoints() / 2), DAMAGE_TYPE_DIVINE, DAMAGE_POWER_ENERGY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);
    DelayCommand(1.5, FloatingTextStringOnCreature("Someone has sealed your coffin with a wild rose! With great effort you were able to get out, but you cannot get back in until the rose is gone. You will really die if killed before your coffin destroys the rose!", OBJECT_SELF));
    }
AssignCommand(oCoffin, PlayAnimation(ANIMATION_PLACEABLE_OPEN));
DelayCommand(1.0, Vampire_Apply_Stats(OBJECT_SELF));
DelayCommand(2.0, AssignCommand(oCoffin, PlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
DelayCommand(2.0, SetCommandable(TRUE, OBJECT_SELF));
DeleteLocalInt(oCoffin, "FALLEN_IN_COFFIN");
DeleteLocalInt(OBJECT_SELF, "FALLEN_IN_COFFIN");
}

void ShowZzz(object oCoffin)
{
effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
if(GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_STAKED")) return;
if(GetCurrentAction(OBJECT_SELF) == ACTION_REST)
    {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCoffin);
    DelayCommand(4.0, ShowZzz(oCoffin));
    }
}

void SleepInCoffin(object oCoffin, int iStartHP)
{
if(GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_STAKED")) return;
SetCommandable(TRUE, OBJECT_SELF);
ActionRest();
ActionDoCommand(GetOutOfCoffin(oCoffin, iStartHP));
SetCommandable(FALSE, OBJECT_SELF);
DelayCommand(4.0, ShowZzz(oCoffin));
}

void RemoveAnyAOE()
{
effect eE = GetFirstEffect(OBJECT_SELF);
while(GetIsEffectValid(eE))
    {
    if(GetEffectType(eE) == EFFECT_TYPE_AREA_OF_EFFECT)
         RemoveEffect(OBJECT_SELF, eE);
    eE = GetNextEffect(OBJECT_SELF);
    }
}

void RemoveBothersomeEffects()
{ //these effect can mess up the cutscene invis that is needed to make stuff look
  //right. So they are removed.
effect eE = GetFirstEffect(OBJECT_SELF);
int iType;
while(GetIsEffectValid(eE))
    {
    iType = GetEffectType(eE);
    if(iType == EFFECT_TYPE_ETHEREAL ||
       iType == EFFECT_TYPE_IMPROVEDINVISIBILITY ||
       iType == EFFECT_TYPE_INVISIBILITY ||
       iType == EFFECT_TYPE_CONCEALMENT ||
       iType == EFFECT_TYPE_SANCTUARY)
         RemoveEffect(OBJECT_SELF, eE);
    eE = GetNextEffect(OBJECT_SELF);
    }
}

void GetInCoffin(object oCoffin, int iStartHP)
{
effect eInvis = SupernaturalEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY));
effect eBlind = SupernaturalEffect(EffectBlindness());
AssignCommand(oCoffin, PlayAnimation(ANIMATION_PLACEABLE_OPEN));
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF));
DelayCommand(1.5, RemoveAnyAOE());
DelayCommand(2.0, AssignCommand(oCoffin, PlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlind, OBJECT_SELF));
DelayCommand(3.0, SleepInCoffin(oCoffin, iStartHP));
}

void main()
{
object oCoffin = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN");
if(GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_DEAD"))
    {
    DeleteLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_DEAD");
    }
else if (NotSafeToRest(OBJECT_SELF) == TRUE)
    { //this allows hardcore compatabiity with sou expansion, but no canceling when dead.
    if (NotOnSafeRest(OBJECT_SELF) == TRUE)
        {
        ClearAllActions();
        AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN), ClearAllActions());
        FloatingTextStrRefOnCreature(40156, OBJECT_SELF);
        }
    }
SetLocalInt(oCoffin, "FALLEN_IN_COFFIN", TRUE);
SetLocalInt(OBJECT_SELF, "FALLEN_IN_COFFIN", TRUE);
RemoveBothersomeEffects();
ClearAllActions(TRUE);
ActionForceMoveToObject(oCoffin, FALSE, 1.0, 5.0);
ActionDoCommand(GetInCoffin(oCoffin, GetCurrentHitPoints()));
SetCommandable(FALSE, OBJECT_SELF);
}
