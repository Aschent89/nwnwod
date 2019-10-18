#include "f_vampire_defs"
#include "f_vampire_spls_h"

void Vampire_NPC_hide(object oNPC)
{
    int Num = 2;
    object oTarget = GetNearestObject(OBJECT_TYPE_DOOR, oNPC);
    while(GetIsObjectValid(oTarget))
        {
        if(GetIsObjectValid(GetTransitionTarget(oTarget)))
            {
            if(GetLocked(oTarget))
                {
                if(!GetPlotFlag(oTarget) && !GetImmortal(oTarget))
                    {
                    ClearAllActions(TRUE);
                    ActionMoveToObject(oTarget, TRUE);
                    ActionAttack(oTarget);
                    ActionJumpToObject(GetTransitionTarget(oTarget));
                    return;
                    }
                }
            else
                {
                ClearAllActions(TRUE);
                ActionMoveToObject(oTarget, TRUE);
                ActionJumpToObject(GetTransitionTarget(oTarget));
                return;
                }
            }
        oTarget = GetNearestObject(OBJECT_TYPE_DOOR, oNPC, Num);
        Num++;
        }
    Num = 2;
    oTarget = GetNearestObject(OBJECT_TYPE_TRIGGER, oNPC);
    while(GetIsObjectValid(oTarget))
        {
        if(GetIsObjectValid(GetTransitionTarget(oTarget)))
            {
            ClearAllActions(TRUE);
            ActionMoveToObject(oTarget, TRUE);
            ActionJumpToObject(GetTransitionTarget(oTarget));
            return;
            }
        oTarget = GetNearestObject(OBJECT_TYPE_TRIGGER, oNPC, Num);
        Num++;
        }
}

void Vampire_Heartbeat(int bFirstTime = TRUE)
{
object oWho = OBJECT_SELF;
effect eDamage, eDamage2;
int iDamage = 1 + Random(SunDamage);
int iDamage2 = Random(iDamage - 1) + 1;
int bOutDoors = GetLocalInt(oWho, "FALLEN_VAMPIRE_OUTDOORS");
if(GetIsNight() || !bOutDoors) return;
if(bOutDoors == 3 || (bOutDoors && !DamageInBadWeather && GetWeather(GetArea(OBJECT_SELF)) != WEATHER_CLEAR))
    {
    DelayCommand(30.0, Vampire_Heartbeat(TRUE));
    return;
    }
if(GetIsPC(oWho))
    {
    if(bFirstTime)
        {
        if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_SUNPROOF, oWho)) return;
        FloatingTextStringOnCreature("The daylight burns you.", oWho, FALSE);
        }
    }
else
    {
    Vampire_NPC_hide(oWho);
    }
iDamage -= iDamage2;
eDamage = EffectDamage(iDamage, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_ENERGY);
eDamage2 = EffectDamage(iDamage2, DAMAGE_TYPE_FIRE, DAMAGE_POWER_ENERGY);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oWho);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage2, oWho);
DelayCommand(30.0, Vampire_Heartbeat(FALSE));
}

void main()
{
Vampire_Heartbeat(TRUE);
}
