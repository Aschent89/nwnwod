#include "f_vampire_h"

int GetChildBlood(object oO)
{
if(GetLocalInt(oO, "FALLEN_VAMPIRE_HASBLOOD") == 3) return TRUE;
int temp = GetAppearanceType(oO);
if (temp == APPEARANCE_TYPE_KID_FEMALE || temp == APPEARANCE_TYPE_KID_MALE) return TRUE;
temp = GetAge(oO);
if(temp > 0 && temp < 13) return TRUE;
return FALSE;
}

void main()
{
object oTarget = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
DeleteLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
if(!GetIsObjectValid(oTarget)) return;
if(!GetIsBitable(oTarget)) return;
int targetHP = GetCurrentHitPoints(oTarget);
int myNeed = GetMaxHitPoints() - GetCurrentHitPoints();
effect eKill = SupernaturalEffect(EffectDamage((targetHP * 4), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY));
effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
effect eVis2 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
effect eRegen = SupernaturalEffect(EffectRegenerate(1, 1.0));
string sTemp = (UseGuaranteedBloodTypes)?"gblood":"blood";
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
if(targetHP > 0)
    {
    targetHP /= HPPerBottle;
    if(targetHP < 1) targetHP = 1;
    if(GetBadBlood(oTarget)) sTemp += "bad";
    else if(GetLocalInt(oTarget, "FALLEN_VAMPIRE_HASBLOOD") == 2) sTemp += "virgin";
    else if(GetChildBlood(oTarget)) sTemp += "child";
    if(UseVialOfPreservationSystem)
        {
        object oItem = GetFirstItemInInventory(OBJECT_SELF);
        for(myNeed = 0; myNeed < targetHP && GetIsObjectValid(oItem); myNeed++)
            {
            while(GetIsObjectValid(oItem) && GetTag(oItem) != "FALLEN_VAMPIRE_EMPTY_VIAL") oItem = GetNextItemInInventory(OBJECT_SELF);
            if(GetIsObjectValid(oItem))
                {
                if(GetItemStackSize(oItem) < 2) DestroyObject(oItem);
                    else SetItemStackSize(oItem, GetItemStackSize(oItem) - 1);
                CreateItemOnObject(sTemp, OBJECT_SELF, 1);
                FloatingTextStringOnCreature("You have filled a vial with excess blood for later use.", OBJECT_SELF, FALSE);
                }
            }
        }
    else
        {
        for(myNeed = 0; myNeed < targetHP; myNeed++) CreateItemOnObject(sTemp, OBJECT_SELF, 1);
        FloatingTextStringOnCreature("You have bottled the extra blood for later use.", OBJECT_SELF, FALSE);
        }
    }
ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
FloatingTextStringOnCreature(GetName(OBJECT_SELF) + " drains your blood while you are helpless.", oTarget);
}
