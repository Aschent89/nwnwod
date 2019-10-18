#include "f_vampire_h"

void main()
{
object oTarget = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
DeleteLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
if(!GetIsObjectValid(oTarget)) return;
if(!GetIsBitable(oTarget)) return;
int targetHP = GetCurrentHitPoints(oTarget);
int myNeed = GetMaxHitPoints() - GetCurrentHitPoints();
effect eKill = SupernaturalEffect(EffectDamage(myNeed, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY));
effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
effect eVis2 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
effect eRegen = SupernaturalEffect(EffectRegenerate(1, 1.0));
eRegen = SupernaturalEffect(EffectLinkEffects(eVis, eRegen));
eKill = SupernaturalEffect(EffectLinkEffects(eVis2, eKill));
Vampire_Fresh_Blood(OBJECT_SELF); //for the blood hunger system
if(myNeed > 0)
    {
    if(targetHP > myNeed) targetHP -= myNeed;
      else myNeed = targetHP; targetHP = 0;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, IntToFloat(myNeed));
    if(GetBadBlood(oTarget))
        {
        ApplyBloodFX(OBJECT_SELF);
        FloatingTextStringOnCreature("The fresh blood strengthens you, but was impure.", OBJECT_SELF, FALSE);
        }
    else FloatingTextStringOnCreature("The fresh blood strengthens you.", OBJECT_SELF, FALSE);
    }
ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
FloatingTextStringOnCreature(GetName(OBJECT_SELF) + " drains your blood while you are helpless.", oTarget);
}

