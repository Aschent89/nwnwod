#include "f_vampire_h"
#include "f_vampirepenta_h"

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

void main()
{
if(!GetIsVampire(OBJECT_SELF))
    { //this should not be able to happen, but may as well make sure.
    SetIsVampire(FALSE, OBJECT_SELF);
    return;
    }
if(GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_MIST") > 0)
    {
    effect eVis2 = EffectVisualEffect(VFX_IMP_POLYMORPH);
    ClearAllActions(TRUE);
    if(d2() == 1)
        {
        ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 3.0);
        }
    else
        {
        ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 3.0);
        }
    SetCommandable(FALSE, OBJECT_SELF);
    pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_EVIL, 3.0);
    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF));
    DelayCommand(2.5, Vampire_Apply_Stats(OBJECT_SELF));
    DelayCommand(3.0, SetCommandable(TRUE, OBJECT_SELF));
    return;
    }
SetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_MIST", TRUE);
int myHD = Determine_Vampire_Level(OBJECT_SELF);
effect eInvis = SupernaturalEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY));
effect eVis = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
effect eMist = SupernaturalEffect(EffectAreaOfEffect(MistAOEType, "f_vampiremist2", "f_vampiremist3", "****"));
effect eSilence = SupernaturalEffect(EffectSilence());
effect eSpellFail = SupernaturalEffect(EffectSpellFailure(100, SPELL_SCHOOL_GENERAL));
effect eMovement = SupernaturalEffect(EffectMovementSpeedDecrease((21 - myHD) * 3));
effect eMiss = SupernaturalEffect(EffectMissChance(100));
effect eTrapImmune = SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_TRAP));
effect eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_ACID));
effect eDLink = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_BLUDGEONING));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_COLD));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_DIVINE));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_ELECTRICAL));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_FIRE));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_MAGICAL));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_NEGATIVE));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_PIERCING));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_POSITIVE));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_SLASHING));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
eDD = SupernaturalEffect(EffectDamageDecrease(200, DAMAGE_TYPE_SONIC));
eDLink = SupernaturalEffect(EffectLinkEffects(eDD, eDLink));
RemoveBothersomeEffects();
ClearAllActions(TRUE);
ActionWait(3.0);
if(d2() == 1)
    {
    ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 5.0);
    }
else
    {
    ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 5.0);
    }
DelayCommand(0.5, pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_EVIL, 5.5, 0.4, 0.6));
SetCommandable(FALSE, OBJECT_SELF);
DelayCommand(4.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
DelayCommand(5.0, Vampire_Remove_Stats(OBJECT_SELF));
DelayCommand(5.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMist, OBJECT_SELF));
DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF));
DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSilence, OBJECT_SELF));
DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpellFail, OBJECT_SELF));
DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMovement, OBJECT_SELF));
DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTrapImmune, OBJECT_SELF));
DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMiss, OBJECT_SELF));
DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDLink, OBJECT_SELF));
DelayCommand(6.5, SetCommandable(TRUE, OBJECT_SELF));
}
