#include "f_vampire_h"

void makeEpicThrall(object oTarget)
{
effect eTemp = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
effect eLink = SupernaturalEffect(EffectCutsceneDominated());
int iCapped = GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_IMP_UNH_THRALL, OBJECT_SELF);
int iMyLevel = Determine_Vampire_Level(OBJECT_SELF);
int iTemp;
eLink = EffectLinkEffects(eTemp, eLink); //base link
if(iMyLevel < 20) iMyLevel = 20;
iTemp = ((iMyLevel - 20) / 4) + 1; //stat boosts
if(iCapped)
    {
    eTemp = EffectAbilityIncrease(ABILITY_STRENGTH, 5);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_CHARISMA, 5);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_CONSTITUTION, 5);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_DEXTERITY, 5);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 5);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_WISDOM, 5);
    eLink = EffectLinkEffects(eTemp, eLink);
    }
else if(iTemp > 1)
    {
    eTemp = EffectAbilityIncrease(ABILITY_STRENGTH, Random(iTemp + 1));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_CHARISMA, Random(iTemp + 1));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_CONSTITUTION, Random(iTemp + 1));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_DEXTERITY, Random(iTemp + 1));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_INTELLIGENCE, Random(iTemp + 1));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAbilityIncrease(ABILITY_WISDOM, Random(iTemp + 1));
    eLink = EffectLinkEffects(eTemp, eLink);
    }
if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_IMP_UNH_THRALL, OBJECT_SELF))
    {
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 40);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAreaOfEffect(AOE_MOB_TYRANT_FOG);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAreaOfEffect(AOE_MOB_UNEARTHLY);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAreaOfEffect(AOE_MOB_UNNATURAL);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAreaOfEffect(AOE_MOB_FEAR);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectAreaOfEffect(AOE_MOB_TIDE_OF_BATTLE);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectRegenerate(8, 6.0);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectImmunity(IMMUNITY_TYPE_DEATH);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectImmunity(IMMUNITY_TYPE_DISEASE);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectImmunity(IMMUNITY_TYPE_POISON);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectImmunity(IMMUNITY_TYPE_TRAP);
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectHaste();
    eLink = EffectLinkEffects(eTemp, eLink);
    }
else if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_UNH_THRALL, OBJECT_SELF))
    {
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, Random(iMyLevel));
    eLink = EffectLinkEffects(eTemp, eLink);
    eTemp = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
    eLink = EffectLinkEffects(eTemp, eLink);
    iTemp = Random(iMyLevel);
    if(iTemp > Random(5))
        {
        eTemp = EffectAreaOfEffect(AOE_MOB_TYRANT_FOG);
        eLink = EffectLinkEffects(eTemp, eLink);
        }
    if(iTemp > Random(15))
        {
        eTemp = EffectAreaOfEffect(AOE_MOB_UNEARTHLY);
        eLink = EffectLinkEffects(eTemp, eLink);
        }
    if(iTemp > Random(30))
        {
        eTemp = EffectAreaOfEffect(AOE_MOB_UNNATURAL);
        eLink = EffectLinkEffects(eTemp, eLink);
        }
    if(iTemp > Random(45))
        {
        eTemp = EffectAreaOfEffect(AOE_MOB_FEAR);
        eLink = EffectLinkEffects(eTemp, eLink);
        }
    if(iTemp > Random(60))
        {
        eTemp = EffectAreaOfEffect(AOE_MOB_TIDE_OF_BATTLE);
        eLink = EffectLinkEffects(eTemp, eLink);
        }
    eTemp = EffectRegenerate((Random(iMyLevel / 5) + 1), 6.0);
    switch(Random(8))
        {
        case 0:
        eTemp = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
        eLink = EffectLinkEffects(eTemp, eLink);
        break;
        case 1:
        eTemp = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
        eLink = EffectLinkEffects(eTemp, eLink);
        break;
        case 2:
        eTemp = EffectImmunity(IMMUNITY_TYPE_DEATH);
        eLink = EffectLinkEffects(eTemp, eLink);
        break;
        case 3:
        eTemp = EffectImmunity(IMMUNITY_TYPE_DISEASE);
        eLink = EffectLinkEffects(eTemp, eLink);
        break;
        case 4:
        eTemp = EffectImmunity(IMMUNITY_TYPE_POISON);
        eLink = EffectLinkEffects(eTemp, eLink);
        break;
        case 5:
        eTemp = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
        eLink = EffectLinkEffects(eTemp, eLink);
        break;
        case 6:
        eTemp = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
        eLink = EffectLinkEffects(eTemp, eLink);
        break;
        case 7:
        eTemp = EffectImmunity(IMMUNITY_TYPE_TRAP);
        eLink = EffectLinkEffects(eTemp, eLink);
        }
    if(Random(iMyLevel) > 19)
        {
        eTemp = EffectHaste();
        eLink = EffectLinkEffects(eTemp, eLink);
        }
    }
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
}

void makeThrall(object oTarget)
{
effect ePoly = SupernaturalEffect(EffectPolymorph(POLYMORPH_TYPE_ZOMBIE));
effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
effect eDom = SupernaturalEffect(EffectCutsceneDominated());
ePoly = SupernaturalEffect(EffectLinkEffects(eVis, ePoly));
eDom = SupernaturalEffect(EffectLinkEffects(ePoly, eDom));
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDom, oTarget);
}

void main()
{
object oTarget = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
DeleteLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
if(!GetIsObjectValid(oTarget)) return;
if(!GetIsBitable(oTarget) || GetIsPC(oTarget)) return;
if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_IMP_THRALL, OBJECT_SELF)) makeEpicThrall(oTarget);
  else makeThrall(oTarget);
ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);
SetIsTemporaryFriend(oTarget);
SetIsTemporaryFriend(OBJECT_SELF, oTarget);
Vampire_Fresh_Blood(OBJECT_SELF); //for the blood hunger system
if(Random(4) == 0 || GetBadBlood(oTarget))
    {
    DestroyObject(oTarget);
    if(GetBadBlood(oTarget))
        {
        ApplyBloodFX(OBJECT_SELF);
        FloatingTextStringOnCreature("You have failed to create a thrall, and the blood was impure as well.", OBJECT_SELF, FALSE);
        }
    else FloatingTextStringOnCreature("You have failed to create a thrall.", OBJECT_SELF, FALSE);
    }
else
    {
    FloatingTextStringOnCreature("The thrall was created sucessfuly.", OBJECT_SELF, FALSE);
    ExecuteScript("f_vampire_thrall", oTarget);
    }
}
