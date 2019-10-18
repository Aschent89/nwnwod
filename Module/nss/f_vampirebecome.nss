

#include "f_vampire_h"
#include "f_vampirepenta_h"

void cleanInventory()
{ //remove any items that you would not be able to pick up
object oO = GetFirstItemInInventory();
string sTag = GetTag(oO);
int i = 0;
while(GetIsObjectValid(oO))
    {
    if(sTag == "FALLEN_VAMPIRE_WILDROSE" || sTag == "X1_WMGRENADE005" ||
       sTag == "NW_IT_MSMLMISC15" || FindSubString(GetStringLowerCase(sTag + " " + GetName(oO)), "silver") != -1)
        {
        CopyObject(oO, GetLocation(OBJECT_SELF));
        DestroyObject(oO);
        }
    oO = GetNextItemInInventory();
    sTag = GetTag(oO);
    }
for(i = 0; i < 13; i++)
    {
    oO = GetItemInSlot(i);
    if(GetIsObjectValid(oO) && FindSubString(GetStringLowerCase(GetTag(oO) + " " + GetName(oO)), "silver") != -1)
        {
        CopyObject(oO, GetLocation(OBJECT_SELF));
        DestroyObject(oO);
        }
    }
}

void main()
{
        effect eRegen = SupernaturalEffect(EffectRegenerate(1, 1.0));
        effect eVis = EffectVisualEffect(VFX_IMP_HARM);
        effect eVis2 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        eVis = EffectLinkEffects(eVis2, eVis);
        eRegen = SupernaturalEffect(EffectLinkEffects(eVis, eRegen));
        if(GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD) AdjustAlignment(OBJECT_SELF, ALIGNMENT_EVIL, 50);
        ClearAllActions(TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, 5.0);
        eRegen = EffectDamage((GetCurrentHitPoints(OBJECT_SELF) - 1));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRegen, OBJECT_SELF);
        ClearAllActions(TRUE);
        ActionWait(1.0);
        DelayCommand(0.5, pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_EVIL, 6.0));
        if(d2() == 1)
            {
            ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 8.0);
            }
        else
            {
            ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 8.0);
            }
        SetCommandable(FALSE, OBJECT_SELF);
        eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
        DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
        DelayCommand(6.0, SetIsVampire(TRUE, OBJECT_SELF));
        DelayCommand(7.0, SetCommandable(TRUE, OBJECT_SELF));
        DelayCommand(7.2, cleanInventory());
        if(!GetIsPC(OBJECT_SELF)) ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
          else Vampire_Fresh_Blood(OBJECT_SELF); //blood hunger system start
}
