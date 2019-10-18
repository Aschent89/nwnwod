// hcr3.1
// took out disabled checking.
// 5.5
// Added scroll failure based on low ability scores.
// 5.4
// Ability check to see if caster has a high enough ability to cast a spell.
// also has scroll check failure.
// written by Jamos

#include "hc_text_ability"


// hcr3.1 took out disabled checking.

int FailureCheck(object oW, int nCasterLevel, int nSpellLevel, int nLvl, int nWisMod){
 int nDamage;
 effect eDamage;
 effect eVis;
 int nRoll = d20(1);
 SendMessageToPC(oW, "Failure Roll: "+IntToString(nRoll));
 if ((nRoll+nLvl) < (nCasterLevel+1)){
    nRoll = d20(1);
    SendMessageToPC(oW, "Mishap Roll: "+IntToString(nRoll));
    if ((nRoll == 1) || ((nRoll+nWisMod) < 5)){
           nDamage = d6(nSpellLevel);
           eDamage = EffectDamage(nDamage);
           ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oW);
           eVis = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
           ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oW);
           SendMessageToPC(oW, MISHAP+IntToString(nDamage));
           return 1;
    }
    else
    {
           SendMessageToPC(oW, FAILURE);
           return 1;
    }
 }
 return 0;
}


int ScrollCast()
{
int nCLERIC = FALSE;
int nBARD = FALSE;
int nDRUID = FALSE;
int nPALADIN = FALSE;
int nRANGER = FALSE;
int nSORCERER = FALSE;
int nWIZARD = FALSE;
int nROGUE = FALSE;
int nRoll;
int nLvl;
int nELvl = 0;
int nEAbl = 0;
int nCasterLevel;
int nSpellLevel;
int nSkill;
string sName = GetName(GetSpellCastItem());
string sTag = GetTag(GetSpellCastItem());
int nSp=GetSpellId();
object oW=OBJECT_SELF;
int nCLERICL = GetLevelByClass(CLASS_TYPE_CLERIC, oW);
if  (nCLERICL > 0) nCLERIC = TRUE;
int nBARDL = GetLevelByClass(CLASS_TYPE_BARD, oW);
if  (nBARDL > 0) nBARD = TRUE;
int nDRUIDL = GetLevelByClass(CLASS_TYPE_DRUID, oW);
if  (nDRUIDL > 0) nDRUID = TRUE;
int nPALADINL = GetLevelByClass(CLASS_TYPE_PALADIN, oW);
if  (nPALADINL > 0) nPALADIN = TRUE;
// Paladins have 0 caster level till 4.
if  (nPALADINL < 4) nPALADINL = 0;
int nRANGERL = GetLevelByClass(CLASS_TYPE_RANGER, oW);
if  (nRANGERL > 0) nRANGER = TRUE;
// rangers have 0 caster level till level 4.
if  (nRANGERL < 4) nRANGERL = 0;
int nSORCERERL = GetLevelByClass(CLASS_TYPE_SORCERER, oW);
if  (nSORCERERL > 0) nSORCERER = TRUE;
int nWIZARDL = GetLevelByClass(CLASS_TYPE_WIZARD, oW);
if  (nWIZARDL > 0) nWIZARD = TRUE;
int nROGUEL = GetLevelByClass(CLASS_TYPE_ROGUE, oW);
if  (nROGUEL > 0) nROGUE = TRUE;

int nCHARISMA = GetAbilityScore(oW, ABILITY_CHARISMA);
int nWISDOM = GetAbilityScore(oW, ABILITY_WISDOM);
int nINTELLEGENCE = GetAbilityScore(oW, ABILITY_INTELLIGENCE);
int nWisMod = GetAbilityModifier(ABILITY_WISDOM, oW);
int nIntMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oW);
int nCharMod = GetAbilityModifier(ABILITY_CHARISMA, oW);
nCasterLevel = GetCasterLevel(OBJECT_SELF);
//SendMessageToPC(oW, "Beginning Scroll Caster Level "+IntToString(nCasterLevel));
nSpellLevel = StringToInt(GetSubString(sTag, 0, 1));

if (nSp == SPELL_LEGEND_LORE || nSp == SPELL_NEUTRALIZE_POISON){
    if (FindSubString(sName, "(A)") > -1)
          nCasterLevel = nCasterLevel+5;
}
if (nSp == SPELL_WAR_CRY){
    if (FindSubString(sName, "(A)") > -1)
       nCasterLevel = nCasterLevel+3;
}
if (nSp == SPELL_DOMINATE_PERSON || nSp == SPELL_FEAR ||
    nSp == SPELL_FIND_TRAPS || nSp == SPELL_HOLD_MONSTER
    || nSp ==SPELL_HOLD_PERSON || nSp == SPELL_REMOVE_BLINDNESS_AND_DEAFNESS
    || nSp == SPELL_REMOVE_CURSE || nSp == SPELL_REMOVE_DISEASE
    || nSp == SPELL_TRUE_SEEING || nSp == SPELL_BESTOW_CURSE){
    if (FindSubString(sName, "(A)") > -1)
       nCasterLevel = nCasterLevel+2;
}
if (nSp == SPELL_SILENCE || nSp == SPELL_SOUND_BURST){
    if (FindSubString(sName, "(A)") > -1)
          nCasterLevel = nCasterLevel+1;
}
if (nSp == SPELL_PROTECTION_FROM_ELEMENTS) {
          nCasterLevel = nCasterLevel+1;
}
if (nSp == SPELL_POLYMORPH_SELF){
    if (FindSubString(sName, "(D)") > -1)
          nCasterLevel = nCasterLevel+7;
}
if (nSp == SPELL_FINGER_OF_DEATH || nSp == SPELL_SUNBEAM){
    if (FindSubString(sName, "(D)") > -1)
          nCasterLevel = nCasterLevel+2;
}
//SendMessageToPC(oW, "Ending Scroll Caster Level "+IntToString(nCasterLevel));
//SendMessageToPC(oW, "Spell Level "+IntToString(nSpellLevel));
string sRef;
//sRef = GetResRef(GetObjectByTag(GetTag(GetSpellCastItem())));
//SendMessageToPC(oW, "Scroll ResRef "+sRef);

nSkill = GetSkillRank(SKILL_USE_MAGIC_DEVICE, OBJECT_SELF);
//SendMessage9ToPC(oW, "USE MAGIC DEVICE "+IntToString(nSkill));
if (nSkill > 0)
   nELvl = (d20(1)+nSkill)-20;
// 5.5 Use Magic Device Emulate Ability roll.
if (nSkill > 0)
   nEAbl = (d20(1)+nSkill)-15;
// 5.5 set fail to false
int nFail = FALSE;
// 5.5 set spell check level to spell level + 10
int nSpellCheck = nSpellLevel + 10;
// check for arcane scroll
if (FindSubString(sName, "(A)") > -1){
    // check for Bard/Wizard spell
    if (FindSubString(sTag, "_BW") > -1){
      nLvl = nWIZARDL;
      if (nLvl < nBARDL) nLvl = nBARDL;

      // 5.5 new ability check for scrolls
      if ((nBARD && nSpellCheck > nCHARISMA && !nWIZARD) ||
          (nWIZARD && nSpellCheck > nINTELLEGENCE && !nBARD)||
          (nWIZARD && nBARD && nSpellCheck > nINTELLEGENCE &&
           nSpellCheck > nCHARISMA))
      {
          // use magic device emulation check.
          if ((nEAbl >= nSpellCheck) && (nROGUE || nBARD))
          {}// do nothing
          else {
             SendMessageToPC(oW, DRAIN);
             return 1;
          }
      }

    }
    // check for bard only spell
    else if (FindSubString(sTag, "_B") > -1)
    {
       nLvl = nBARDL;

       if (nSpellCheck > nCHARISMA)
          // use magic device emulation check.
          if ((nEAbl >= nSpellCheck) && (nROGUE || nBARD))
          {}// do nothing
          else {
             SendMessageToPC(oW, DRAIN);
             return 1;
          }

    }
    // check for Wizard/Sorceror spell
    else if (FindSubString(sTag, "_WS") > -1){
      nLvl = nWIZARDL;
      if (nLvl < nSORCERERL) nLvl = nSORCERERL;

      // 5.5 new ability check for scrolls
      if ((nSORCERER && nSpellCheck > nCHARISMA && !(nWIZARD)) ||
          (nWIZARD && nSpellCheck > nINTELLEGENCE && !(nSORCERER))||
          (nWIZARD && nSORCERER && nSpellCheck > nINTELLEGENCE &&
           nSpellCheck > nCHARISMA))
      {
          // use magic device emulation check.
          if ((nEAbl >= nSpellCheck) && (nROGUE || nBARD))
          {}// do nothing
          else {
             SendMessageToPC(oW, DRAIN);
             return 1;
          }
      }

    }
    // all arcane classes can cast
    else {
      nLvl = nWIZARDL;
      if (nLvl < nSORCERERL) nLvl = nSORCERERL;
      if (nLvl < nBARDL) nLvl = nBARDL;

      // 5.5 new ability check for scrolls
      if ((nSORCERER && nSpellCheck > nCHARISMA && !nWIZARD && !nBARD) ||
          (nWIZARD && nSpellCheck > nINTELLEGENCE && !nSORCERER && !nBARD)||
          (nBARD && nSpellCheck > nCHARISMA && !nWIZARD && !nSORCERER) ||
          (nWIZARD && nSORCERER && !nBARD && nSpellCheck > nINTELLEGENCE &&
           nSpellCheck > nCHARISMA) ||
          (nWIZARD && nBARD && !nSORCERER && nSpellCheck > nINTELLEGENCE &&
           nSpellCheck > nCHARISMA) ||
          (nBARD && nSORCERER && !nWIZARD && nSpellCheck > nCHARISMA) ||
          (nWIZARD && nSORCERER && nBARD && nSpellCheck > nINTELLEGENCE &&
           nSpellCheck > nCHARISMA))
      {
          // use magic device emulation check.
          if ((nEAbl >= nSpellCheck) && (nROGUE || nBARD))
          {}// do nothing
          else {
             SendMessageToPC(oW, DRAIN);
             return 1;
          }
      }

    }
}
// check for divine scroll
else if (FindSubString(sName, "(D)") > -1){
     // Druid/Ranger only scroll
     if (FindSubString(sTag, "_DR") > -1){
       nLvl = nDRUIDL;
       if (nLvl < (nRANGERL/2)) nLvl = (nRANGERL/2);
     }
     // Druid only scroll
     if (FindSubString(sTag, "_D") > -1)
       nLvl = nDRUIDL;
     // Ranger only scroll
     else if (FindSubString(sTag, "_R") > -1)
       nLvl = (nRANGERL/2);
     // Paladin only scroll
     else if (FindSubString(sTag, "_P") > -1)
       nLvl = (nPALADINL/2);
     // Cleric/Paladin/Ranger spell
     else if (FindSubString(sTag, "_CPR") > -1){
       nLvl = nCLERICL;
       if (nLvl < (nPALADINL/2)) nLvl = (nPALADINL/2);
       if (nLvl < (nRANGERL/2)) nLvl = (nRANGERL/2);
     }
     // Cleric/Druid/Paladin spell
     else if (FindSubString(sTag, "_CDP") > -1){
       nLvl = nCLERICL;
       if (nLvl < (nPALADINL/2)) nLvl = (nPALADINL/2);
       if (nLvl < nDRUIDL) nLvl = (nDRUIDL);
     }
          // Cleric/Druid/Ranger spell
     else if (FindSubString(sTag, "_CDR") > -1){
       nLvl = nCLERICL;
       if (nLvl < (nRANGERL/2)) nLvl = (nRANGERL/2);
       if (nLvl < nDRUIDL) nLvl = (nDRUIDL);
     }
     // Cleric/Druid spell
     else if (FindSubString(sTag, "_CD") > -1){
       nLvl = nCLERICL;
      if (nLvl < (nDRUIDL)) nLvl = (nDRUIDL);
     }
     // Cleric/Paladin spell
     else if (FindSubString(sTag, "_CP") > -1){
       nLvl = nCLERICL;
       if (nLvl < (nPALADINL/2)) nLvl = (nPALADINL/2);
     }
     // Cleric/Ranger spell
     else if (FindSubString(sTag, "_CR") > -1){
       nLvl = nCLERICL;
       if (nLvl < (nRANGERL/2)) nLvl = (nRANGERL/2);
     }
     // Cleric only scroll
     else if (FindSubString(sTag, "_C") > -1)
       nLvl = nCLERICL;
     // all divine casters can cast
     else {
       nLvl = nCLERICL;
       if (nLvl < (nPALADINL/2)) nLvl = (nPALADINL/2);
       if (nLvl < (nRANGERL/2)) nLvl = (nRANGERL/2);
       if (nLvl < (nDRUIDL)) nLvl = (nDRUIDL);
     }

     // 5.5 new ability check for scrolls
     if (nSpellCheck > nWISDOM)
     {
          // use magic device emulation check.
          if ((nEAbl >= nSpellCheck) && (nROGUE || nBARD))
          {}// do nothing
          else {
             SendMessageToPC(oW, DRAIN);
             return 1;
          }
     }

}
else
     // regular scroll bypass scroll failure
     return 0;
if (nLvl < nELvl && (nROGUE || nBARD)) nLvl = nELvl;

//SendMessageToPC(oW, "Your Caster Level "+IntToString(nLvl));
if (nLvl >= nCasterLevel)
    return 0;
else
     if (FailureCheck(oW, nCasterLevel, nSpellLevel, nLvl, nWisMod)) return 1;

return 0;
}
