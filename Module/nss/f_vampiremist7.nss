#include "f_vampire_h"

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
SetCommandable(FALSE, OBJECT_SELF);
Vampire_Remove_Stats(OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMist, OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSilence, OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpellFail, OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMovement, OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTrapImmune, OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMiss, OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDLink, OBJECT_SELF);
SetCommandable(TRUE, OBJECT_SELF);
}
