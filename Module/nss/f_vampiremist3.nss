//::///////////////////////////////////////////////
//:: Vampire Mist On Enter and Heartbeat
//:: f_vampiremist2
//:://////////////////////////////////////////////
/*
    Upon entering the mist cloud any enemies will
    become temporary friends for 2 rounds. This
    way casters who would have an idea of what the
    mist is can still hit you with spells from
    afar (until they get within your influence)
    and melee characters will not attack you. This
    also lets you do some nasty sneak attacks as
    is only proper >:). Also, due to their nature
    magical beasts, outsiders, and big dragons are
    immune to this effect.
*/
//:://////////////////////////////////////////////
//:: Created By: Fallen
//:://////////////////////////////////////////////
#include "f_vampire_spls_h"

void main()
{
object oOwner = GetAreaOfEffectCreator();
if(!GetIsObjectValid(oOwner))
    {
    DestroyObject(OBJECT_SELF);
    return;
    }
object oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
int iRace;
while(GetIsObjectValid(oTarget))
    {
    if(GetIsEnemy(oTarget, oOwner))
        {
        iRace = GetRacialType(oTarget);
        if(iRace != RACIAL_TYPE_MAGICAL_BEAST && iRace != RACIAL_TYPE_OUTSIDER &&
           (iRace != RACIAL_TYPE_DRAGON || GetCreatureSize(oTarget) < CREATURE_SIZE_LARGE))
            {
            SetIsTemporaryNeutral(oTarget, oOwner, TRUE, 12.0);
            SetIsTemporaryNeutral(oOwner, oTarget, TRUE, 12.0);
            AssignCommand(oTarget, ClearAllActions(TRUE));
            }
        }
    oTarget = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    }

oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_DOOR);
while(GetIsObjectValid(oTarget))
    {
    if (GetLocked(oTarget) && !GetLocalInt(oTarget, "VAMPIRE_DOOR_IGNORE"))
        {
        SetLocalInt(oTarget, "VAMPIRE_DOOR_IGNORE", TRUE);
        DelayCommand(18.0, DeleteLocalInt(oTarget, "VAMPIRE_DOOR_IGNORE"));
        if(GetIsObjectValid(GetTransitionTarget(oTarget)))
            {
            SetLocalLocation(oOwner, "VAMPIRE_MIST_TARGET", GetLocation(GetTransitionTarget(oTarget)));
            }
        else
            {
            vector vTarget = GetPosition(oTarget);
            vector vSelf = GetPosition(oOwner);
            vTarget.x += (vSelf.x - vTarget.x) * -1.0;
            vTarget.y += (vSelf.y - vTarget.y) * -1.0;
            SetLocalLocation(oOwner, "VAMPIRE_MIST_TARGET", Location(GetArea(oTarget), vTarget, GetFacing(oOwner)));
            }
        ExecuteScript("f_vampiremist4", oOwner);
        }
    oTarget = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_DOOR);
    }
}
