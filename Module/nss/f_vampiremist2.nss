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
    //Declare major variables
    object oTarget = GetEnteringObject();
    int iRace = GetRacialType(oTarget);
    object oOwner = GetAreaOfEffectCreator();
    if(!GetIsObjectValid(oOwner))
        {
        DestroyObject(OBJECT_SELF);
        return;
        }
    if(GetIsEnemy(oTarget, oOwner))
        {
        if(iRace != RACIAL_TYPE_MAGICAL_BEAST && iRace != RACIAL_TYPE_OUTSIDER &&
           (iRace != RACIAL_TYPE_DRAGON || GetCreatureSize(oTarget) < CREATURE_SIZE_LARGE))
            {
            SetIsTemporaryNeutral(oTarget, oOwner, TRUE, 12.0);
            SetIsTemporaryNeutral(oOwner, oTarget, TRUE, 12.0);
            AssignCommand(oTarget, ClearAllActions(TRUE));
            }
        }
}
