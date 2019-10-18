////////////////////////////////////////////////////////////////////////////////
///
/// Class Control System (CCS)
/// Created on 11/25/03 by DarthJohn
/// Last Modified on 02/02/04 by DarthJohn
/// Originally based on HCR code (http://www.rpging.net/nwn)
///
/// Script: ccs_inc
///
////////////////////////////////////////////////////////////////////////////////
///
/// DO NOT EDIT THIS SCRIPT!
/// This is the include file that handles all custom commands and redundant
/// checks.
///
////////////////////////////////////////////////////////////////////////////////

#include "ccs_defaults"

/// This function makes nClass available to oPC.
/// - oPC = the player character
/// - nClass = CLASS_TYPE_*
void AllowClass(object oPC, int nClass);

/// This function makes nClass unavailable to oPC.
/// - oPC = the player character
/// - nClass = CLASS_TYPE_*
void BlockClass(object oPC, int nClass);

/// This function makes all classes unavailable to oPC.
/// - oPC = the player character
void BlockAllClasses(object oPC);

/// This function makes all classes available to oPC.
/// - oPC = the player character
void AllowAllClasses(object oPC);

/// This function checks to see if oTrainer has any classes in common with oPC,
/// and returns the class as CLASS_TYPE_*.
/// - oPC = the player character
/// - oTrainer = PC or NPC trainer
/// - nClassPos = starts checking for a common class at this position, and keeps
///   searching until it reaches the 3rd position.  Setting this value to a
///   number greater than 3 will cause it to return CLASS_TYPE_INVALID.
int GetTrainableClass(object oPC, object oTrainer, int nClassPos=1);

/// This function returns TRUE if oPC has levels in nClassType, otherwise it
/// returns FALSE.
/// - oPC = the player character
/// - nClassType = CLASS_TYPE_*
int GetIsTrainableClass(object oPC, int nClassType=CLASS_TYPE_INVALID);

/// This function returns TRUE if oNPC has levels in nClassType, otherwise it
/// returns FALSE.
/// - oNPC = either the NPC Trainer or the PC Trainer
/// - nClassType = CLASS_TYPE_*
int GetTrainerClass(object oNPC, int nClassType=CLASS_TYPE_INVALID);

/// This function returns TRUE if oPC is able to multiclass, as specified in the
/// "ccs_defaults" script.
/// - oPC = the player character
int GetCanMulticlass(object oPC);

/// This function returns TRUE if oPC is already multiclassed.
/// - oPC = the player character
int GetIsMulticlassed(object oPC);

/// This function determines oPC's base attack bonus without modifiers from STR
/// or DEX.  This is how the game engine determines if a PC has reached the
/// class prerequisits.
/// - oPC = the player character
int GetRealBaseAttackBonus(object oPC);

/// This function determines oPC's nSkill rank without any modifiers specified by
/// nAbility.  This is how the game engine determines if a PC has reached the
/// class prerequisits.
/// - nSkill = SKILL_*
/// - nAbility = ABILITY_*
/// - oPC = the player character
int GetRealSkillRank(int nSkill, int nAbility, object oPC);

/// This function returns TRUE if oPC has the feat Weapon Focus, regardless of
/// what the weapon focus is actually in.
/// - oPC = the player character
int GetHasWeaponFocus(object oPC);

/// This function returns TRUE if oPC has reached the prerequisites for
/// nClassType, will also return FALSE if nClasstype is not a prestige class.
/// - oPC = the player character
/// - nClassType = CLASS_TYPE_*
int GetCanPrestige(object oPC, int nClassType);

/// This function removes all the variables attached to oPC that were used by
/// CCS.
/// - oPC = the player character
void RemoveVariables(object oPC);

/// This function returns the position of nClassType, basically a reverse of the
/// GetClassByPosition() function.
/// - nClassType = CLASS_TYPE_*
/// - oPC = the player character
int GetPositionByClass(int nClassType, object oPC);

/// This function returns TRUE if nClassType is a prestige class.
/// - nClassType = CLASS_TYPE_*
int GetIsPrestigeClass(int nClassType);

/// This function returns oPC's character level, discarding any prestige class
/// levels. So if oPC has level 6 rogue and level 2 Shadowdancer, this function
/// would return 6.
/// - oPC = the player character
int GetNonPrestigeCharacterLevel(object oPC);

/// This function makes the classes oPC already has levels in, available to him
/// when he trains. CCS assumes that all classes are always blocked unless
/// otherwise enabled.
/// - oPC = the player character
void EnableFamiliarClasses(object oPC);

int VerifyClass(object oPC, int nClass)
{
    int nCheck = FALSE; int nAllow = 1;

    if(nClass == CLASS_TYPE_BARBARIAN)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowBarb");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_BARD)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowBard");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_CLERIC)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowCler");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_DRUID)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowDruid");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_FIGHTER)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowFight");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_MONK)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowMonk");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_PALADIN)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowPal");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_RANGER)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowRang");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_ROGUE)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowRog");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_SORCERER)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowSorc");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_WIZARD)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowWiz");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_SHADOWDANCER)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowShadow");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_HARPER)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowHarper");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_ARCANE_ARCHER)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowArcher");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_ASSASSIN)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowAsasin");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_BLACKGUARD)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowBlkGrd");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_WEAPON_MASTER)
    {
      nAllow = GetLocalInt(oPC,"X2_AllowWM");
      if(nAllow < 1) nCheck = TRUE;
    }

   if(nClass == CLASS_TYPE_SHIFTER)
    {
      nAllow = GetLocalInt(oPC,"X2_AllowShiftr");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_PALEMASTER)
    {
      nAllow = GetLocalInt(oPC,"X2_AllowPalema");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_DWARVENDEFENDER)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowDwDef");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_DRAGONDISCIPLE)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowDrDis");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_DIVINECHAMPION)
    {
      nAllow = GetLocalInt(oPC,"X2_AllowDivcha");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_WIZARD)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowWiz");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_WIZARD)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowWiz");
      if(nAllow < 1) nCheck = TRUE;
    }

    if(nClass == CLASS_TYPE_WIZARD)
    {
      nAllow = GetLocalInt(oPC,"X1_AllowWiz");
      if(nAllow < 1) nCheck = TRUE;
    }

    return nCheck;
}

void AllowClass(object oPC, int nClass)
{
    switch(nClass) {
        case CLASS_TYPE_BARBARIAN: DeleteLocalInt(oPC,"X1_AllowBarb");
            break;
        case CLASS_TYPE_BARD: DeleteLocalInt(oPC,"X1_AllowBard");
            break;
        case CLASS_TYPE_CLERIC: DeleteLocalInt(oPC,"X1_AllowCler");
            break;
        case CLASS_TYPE_DRUID: DeleteLocalInt(oPC,"X1_AllowDruid");
            break;
        case CLASS_TYPE_FIGHTER: DeleteLocalInt(oPC,"X1_AllowFight");
            break;
        case CLASS_TYPE_MONK: DeleteLocalInt(oPC,"X1_AllowMonk");
            break;
        case CLASS_TYPE_PALADIN: DeleteLocalInt(oPC,"X1_AllowPal");
            break;
        case CLASS_TYPE_RANGER: DeleteLocalInt(oPC,"X1_AllowRang");
            break;
        case CLASS_TYPE_ROGUE: DeleteLocalInt(oPC,"X1_AllowRog");
            break;
        case CLASS_TYPE_SORCERER: DeleteLocalInt(oPC,"X1_AllowSorc");
            break;
        case CLASS_TYPE_WIZARD: DeleteLocalInt(oPC,"X1_AllowWiz");
            break;
        case CLASS_TYPE_SHADOWDANCER: DeleteLocalInt(oPC,"X1_AllowShadow");
            break;
        case CLASS_TYPE_HARPER: DeleteLocalInt(oPC,"X1_AllowHarper");
            break;
        case CLASS_TYPE_ARCANE_ARCHER: DeleteLocalInt(oPC,"X1_AllowArcher");
            break;
        case CLASS_TYPE_ASSASSIN: DeleteLocalInt(oPC,"X1_AllowAsasin");
            break;
        case CLASS_TYPE_BLACKGUARD: DeleteLocalInt(oPC,"X1_AllowBlkGrd");
            break;
        case CLASS_TYPE_WEAPON_MASTER: DeleteLocalInt(oPC,"X2_AllowWM");
            break;
        case CLASS_TYPE_SHIFTER: DeleteLocalInt(oPC,"X2_AllowShiftr");
            break;
        case CLASS_TYPE_PALEMASTER: DeleteLocalInt(oPC,"X2_AllowPalema");
            break;
        case CLASS_TYPE_DWARVENDEFENDER: DeleteLocalInt(oPC,"X1_AllowDwDef");
            break;
        case CLASS_TYPE_DRAGONDISCIPLE: DeleteLocalInt(oPC,"X1_AllowDrDis");
            break;
        case CLASS_TYPE_DIVINECHAMPION: DeleteLocalInt(oPC,"X2_AllowDivcha");
            break;
    }
}

void BlockClass(object oPC, int nClass)
{
    switch(nClass) {
        case CLASS_TYPE_BARBARIAN: SetLocalInt(oPC,"X1_AllowBarb",1);
            break;
        case CLASS_TYPE_BARD: SetLocalInt(oPC,"X1_AllowBard",1);
            break;
        case CLASS_TYPE_CLERIC: SetLocalInt(oPC,"X1_AllowCler",1);
            break;
        case CLASS_TYPE_DRUID: SetLocalInt(oPC,"X1_AllowDruid",1);
            break;
        case CLASS_TYPE_FIGHTER: SetLocalInt(oPC,"X1_AllowFight",1);
            break;
        case CLASS_TYPE_MONK: SetLocalInt(oPC,"X1_AllowMonk",1);
            break;
        case CLASS_TYPE_PALADIN: SetLocalInt(oPC,"X1_AllowPal",1);
            break;
        case CLASS_TYPE_RANGER: SetLocalInt(oPC,"X1_AllowRang",1);
            break;
        case CLASS_TYPE_ROGUE: SetLocalInt(oPC,"X1_AllowRog",1);
            break;
        case CLASS_TYPE_SORCERER: SetLocalInt(oPC,"X1_AllowSorc",1);
            break;
        case CLASS_TYPE_WIZARD: SetLocalInt(oPC,"X1_AllowWiz",1);
            break;
        case CLASS_TYPE_SHADOWDANCER: SetLocalInt(oPC,"X1_AllowShadow",1);
            break;
        case CLASS_TYPE_HARPER: SetLocalInt(oPC,"X1_AllowHarper",1);
            break;
        case CLASS_TYPE_ARCANE_ARCHER: SetLocalInt(oPC,"X1_AllowArcher",1);
            break;
        case CLASS_TYPE_ASSASSIN: SetLocalInt(oPC,"X1_AllowAsasin",1);
            break;
        case CLASS_TYPE_BLACKGUARD: SetLocalInt(oPC,"X1_AllowBlkGrd",1);
            break;
        case CLASS_TYPE_WEAPON_MASTER: SetLocalInt(oPC,"X2_AllowWM",1);
            break;
        case CLASS_TYPE_SHIFTER: SetLocalInt(oPC,"X2_AllowShiftr",1);
            break;
        case CLASS_TYPE_PALEMASTER: SetLocalInt(oPC,"X2_AllowPalema",1);
            break;
        case CLASS_TYPE_DWARVENDEFENDER: SetLocalInt(oPC,"X1_AllowDwDef",1);
            break;
        case CLASS_TYPE_DRAGONDISCIPLE: SetLocalInt(oPC,"X1_AllowDrDis",1);
            break;
        case CLASS_TYPE_DIVINECHAMPION: SetLocalInt(oPC,"X2_AllowDivcha",1);
            break;
    }
}

void BlockAllClasses(object oPC)
{
    SetLocalInt(oPC,"X1_AllowBarb",1);
    SetLocalInt(oPC,"X1_AllowBard",1);
    SetLocalInt(oPC,"X1_AllowCler",1);
    SetLocalInt(oPC,"X1_AllowDruid",1);
    SetLocalInt(oPC,"X1_AllowFight",1);
    SetLocalInt(oPC,"X1_AllowMonk",1);
    SetLocalInt(oPC,"X1_AllowPal",1);
    SetLocalInt(oPC,"X1_AllowRang",1);
    SetLocalInt(oPC,"X1_AllowRog",1);
    SetLocalInt(oPC,"X1_AllowSorc",1);
    SetLocalInt(oPC,"X1_AllowWiz",1);
    SetLocalInt(oPC,"X1_AllowShadow",1);
    SetLocalInt(oPC,"X1_AllowHarper",1);
    SetLocalInt(oPC,"X1_AllowArcher",1);
    SetLocalInt(oPC,"X1_AllowAsasin",1);
    SetLocalInt(oPC,"X1_AllowBlkGrd",1);
    SetLocalInt(oPC,"X2_AllowWM",1);
    SetLocalInt(oPC,"X2_AllowShiftr",1);
    SetLocalInt(oPC,"X2_AllowPalema",1);
    SetLocalInt(oPC,"X1_AllowDwDef",1);
    SetLocalInt(oPC,"X1_AllowDrDis",1);
    SetLocalInt(oPC,"X2_AllowDivcha",1);
}

void AllowAllClasses(object oPC)
{
    SetLocalInt(oPC,"X1_AllowBarb",0);
    SetLocalInt(oPC,"X1_AllowBard",0);
    SetLocalInt(oPC,"X1_AllowCler",0);
    SetLocalInt(oPC,"X1_AllowDruid",0);
    SetLocalInt(oPC,"X1_AllowFight",0);
    SetLocalInt(oPC,"X1_AllowMonk",0);
    SetLocalInt(oPC,"X1_AllowPal",0);
    SetLocalInt(oPC,"X1_AllowRang",0);
    SetLocalInt(oPC,"X1_AllowRog",0);
    SetLocalInt(oPC,"X1_AllowSorc",0);
    SetLocalInt(oPC,"X1_AllowWiz",0);
    SetLocalInt(oPC,"X1_AllowShadow",0);
    SetLocalInt(oPC,"X1_AllowHarper",0);
    SetLocalInt(oPC,"X1_AllowArcher",0);
    SetLocalInt(oPC,"X1_AllowAsasin",0);
    SetLocalInt(oPC,"X1_AllowBlkGrd",0);
    SetLocalInt(oPC,"X2_AllowWM",0);
    SetLocalInt(oPC,"X2_AllowShiftr",0);
    SetLocalInt(oPC,"X2_AllowPalema",0);
    SetLocalInt(oPC,"X1_AllowDwDef",0);
    SetLocalInt(oPC,"X1_AllowDrDis",0);
    SetLocalInt(oPC,"X2_AllowDivcha",0);
}

int GetTrainableClass(object oPC, object oTrainer, int nClassPos=1)
{
    int nClass=CLASS_TYPE_INVALID;
    int nNPCClassPos=1;
    int nTrainerClass=GetClassByPosition(nNPCClassPos,oTrainer);
    int nPCClass=GetClassByPosition(nClassPos,oPC);

    while(nNPCClassPos < 4){
        if(nPCClass == nTrainerClass)
            nClass=nTrainerClass;
        nNPCClassPos++;
    }
    return nClass;
}

int GetIsTrainableClass(object oPC, int nClassType=CLASS_TYPE_INVALID)
{
    if(!GetLevelByClass(nClassType,oPC))
        return FALSE;
    else return TRUE;
}

int GetTrainerClass(object oNPC, int nClassType=CLASS_TYPE_INVALID)
{
    int nTrainerClass;
    int nCounter=1;
    while(nCounter < 4){
        nTrainerClass=GetClassByPosition(nCounter,oNPC);
        if(nTrainerClass == nClassType && nTrainerClass != CLASS_TYPE_INVALID)
            return TRUE;
        nCounter++;
    }
    return FALSE;
}

int GetCanMulticlass(object oPC)
{
    int nResult;
    int nLevelPos1=GetLevelByPosition(1,oPC);
    int nLevelPos2=GetLevelByPosition(2,oPC);
    int nLevelPos3=GetLevelByPosition(3,oPC);

    if(nLevelPos1 >= CCS_MULTICLASS_LEVEL_AMOUNT && !nLevelPos2)
        nResult=TRUE;
    else if(nLevelPos2 >= CCS_MULTICLASS_LEVEL_AMOUNT && !nLevelPos3)
        nResult=TRUE;
    else nResult=FALSE;
    return nResult;
}

int GetIsMulticlassed(object oPC)
{
    if(GetLevelByPosition(2,oPC))
        return TRUE;
    else return FALSE;
}

int GetRealBaseAttackBonus(object oPC)
{
    int nResult;
    int nAbilityBonus;
    int nBaseAttack=GetBaseAttackBonus(oPC);
    if(GetHasFeat(FEAT_WEAPON_FINESSE))
        nAbilityBonus=GetAbilityModifier(ABILITY_DEXTERITY);
    else nAbilityBonus=GetAbilityModifier(ABILITY_STRENGTH);
    nResult=nBaseAttack;
    return nResult;
}

int GetRealSkillRank(int nSkill, int nAbility, object oPC)
{
    int nResult;
    int nAbilityBonus=GetAbilityModifier(nAbility,oPC);
    int nSkillRank=GetSkillRank(nSkill,oPC);
    nResult=nSkillRank-nAbilityBonus;
    return nResult;
}

int GetHasWeaponFocus(object oPC)
{
    if(GetHasFeat(FEAT_WEAPON_FOCUS_BASTARD_SWORD,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_BATTLE_AXE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_CLUB,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_CREATURE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_DAGGER,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_DART,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_DIRE_MACE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_DOUBLE_AXE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_DWAXE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_GREAT_AXE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_GREAT_SWORD,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_HALBERD,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_HAND_AXE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_HEAVY_FLAIL,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_KAMA,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_KATANA,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_KUKRI,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_FLAIL,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_HAMMER,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_MACE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_LONG_SWORD,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_LONGBOW,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_MORNING_STAR,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_RAPIER,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_SCIMITAR,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_SCYTHE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_SHORT_SWORD,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_SHORTBOW,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_SHURIKEN,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_SICKLE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_SLING,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_SPEAR,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_STAFF,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_THROWING_AXE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_UNARMED_STRIKE,oPC) ||
      GetHasFeat(FEAT_WEAPON_FOCUS_WAR_HAMMER,oPC))
        return TRUE;
    else return FALSE;
}

int GetCanPrestige(object oPC, int nClassType)
{
    int nResult;
    switch(nClassType){
        case CLASS_TYPE_ARCANE_ARCHER:{
            if(GetRacialType(oPC) == RACIAL_TYPE_ELF ||
              GetRacialType(oPC) == RACIAL_TYPE_HALFELF){
                if(GetHasFeat(FEAT_WEAPON_FOCUS_LONGBOW,oPC) ||
                  GetHasFeat(FEAT_WEAPON_FOCUS_SHORTBOW,oPC)){
                    if(GetRealBaseAttackBonus(oPC) >= 6 &&
                      GetHasFeat(FEAT_POINT_BLANK_SHOT,oPC) &&
                      GetCasterLevel(oPC)){
                        nResult=TRUE;
                    }
                    else nResult=FALSE;
                }
                else nResult=FALSE;
            }
            else nResult=FALSE;
        }
            break;
        case CLASS_TYPE_ASSASSIN:{
            if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL){
                if(GetRealSkillRank(SKILL_HIDE,ABILITY_DEXTERITY,oPC) >= 8 &&
                  GetRealSkillRank(SKILL_MOVE_SILENTLY,ABILITY_DEXTERITY,oPC) >= 8)
                    nResult=TRUE;
                else nResult=FALSE;
            }
            else nResult=FALSE;
        }
            break;
        case CLASS_TYPE_BLACKGUARD:{
            if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL){
                if(GetRealBaseAttackBonus(oPC) >= 6 &&
                  GetRealSkillRank(SKILL_HIDE,ABILITY_DEXTERITY,oPC) >= 5 &&
                  GetHasFeat(FEAT_CLEAVE,oPC))
                    nResult=TRUE;
                else nResult=FALSE;
            }
            else nResult=FALSE;
        }
            break;
        case CLASS_TYPE_HARPER:{
            if(GetAlignmentGoodEvil(oPC) != ALIGNMENT_EVIL){
                if(GetRealSkillRank(SKILL_SEARCH,ABILITY_INTELLIGENCE,oPC) >= 4 &&
                  GetRealSkillRank(SKILL_PERSUADE,ABILITY_CHARISMA,oPC) >= 8 &&
                  GetRealSkillRank(SKILL_LORE,ABILITY_INTELLIGENCE,oPC) >= 6 &&
                  GetRealSkillRank(SKILL_DISCIPLINE,ABILITY_STRENGTH,oPC) >= 4 &&
                  GetHasFeat(FEAT_ALERTNESS,oPC) &&
                  GetHasFeat(FEAT_IRON_WILL,oPC))
                    nResult=TRUE;
                else nResult=FALSE;
            }
            else nResult=FALSE;
        }
            break;
        case CLASS_TYPE_SHADOWDANCER:{
            if(GetRealSkillRank(SKILL_MOVE_SILENTLY,ABILITY_DEXTERITY,oPC) >= 8 &&
              GetRealSkillRank(SKILL_HIDE,ABILITY_DEXTERITY,oPC) >= 10 &&
              GetRealSkillRank(SKILL_TUMBLE,ABILITY_DEXTERITY,oPC) >= 5 &&
              GetHasFeat(FEAT_DODGE,oPC) &&
              GetHasFeat(FEAT_MOBILITY,oPC))
                nResult=TRUE;
            else nResult=FALSE;
        }
            break;
        case CLASS_TYPE_WEAPON_MASTER:{
            if(GetRealBaseAttackBonus(oPC) >= 5 &&
              GetHasFeat(FEAT_DODGE,oPC) &&
              GetHasFeat(FEAT_MOBILITY,oPC) &&
              GetHasFeat(FEAT_EXPERTISE,oPC) &&
              GetHasFeat(FEAT_SPRING_ATTACK,oPC) &&
              GetHasFeat(FEAT_WHIRLWIND_ATTACK,oPC) &&
              GetRealSkillRank(SKILL_INTIMIDATE,ABILITY_CHARISMA,oPC) >= 4){
                if(GetHasWeaponFocus(oPC))
                    nResult=TRUE;
            }
            else nResult=FALSE;
        }
            break;

        case CLASS_TYPE_SHIFTER:{
            if(GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 5 ){
                if(GetHasFeat(FEAT_ALERTNESS,oPC))
                    nResult=TRUE;
            }
            else nResult=FALSE;
        }
            break;

        case CLASS_TYPE_PALEMASTER:{
            if(GetAlignmentGoodEvil(oPC) != ALIGNMENT_GOOD){
                if(GetLevelByClass(CLASS_TYPE_BARD,oPC) > 6 ||
                  GetLevelByClass(CLASS_TYPE_SORCERER,oPC) > 5 ||
                  GetLevelByClass(CLASS_TYPE_WIZARD,oPC) > 4)
                    nResult=TRUE;
            }
            else nResult=FALSE;
        }
            break;
        case CLASS_TYPE_DWARVENDEFENDER:{
            if(GetRacialType(oPC) == RACIAL_TYPE_DWARF){
                if(GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL){
                    if(GetRealBaseAttackBonus(oPC) >= 7){
                        if(GetHasFeat(FEAT_DODGE,oPC) &&
                          GetHasFeat(FEAT_TOUGHNESS,oPC))
                            nResult=TRUE;
                         else{
                           SendMessageToPC(oPC,"Failed GetHasFeat Checks");
                            nResult=FALSE;
                        }
                    }
                    else{
                        SendMessageToPC(oPC,"Failed GetRealBaseAttack Check");
                        nResult=FALSE;
                    }
                }
                else{
                    SendMessageToPC(oPC,"Failed GetAlignmentLawChaos Check");
                    nResult=FALSE;
                }
            }
            else{
                SendMessageToPC(oPC,"Failed GetRacialType Check");
                nResult=FALSE;
            }
        }
            break;
        case CLASS_TYPE_DRAGONDISCIPLE:{
            if(GetLevelByClass(CLASS_TYPE_BARD,oPC) ||
              GetLevelByClass(CLASS_TYPE_SORCERER,oPC)){
                if(GetRealSkillRank(SKILL_LORE,ABILITY_INTELLIGENCE,oPC) >= 8)
                    nResult=TRUE;
            }
            else nResult=FALSE;
        }
            break;
        case CLASS_TYPE_DIVINECHAMPION:{
            if(GetAlignmentGoodEvil(oPC) != ALIGNMENT_EVIL &&
              GetHasWeaponFocus(oPC) &&
              GetRealBaseAttackBonus(oPC) >= 7)
                nResult=TRUE;
            else nResult=FALSE;
        }
            break;
    }
    return nResult;
}

void RemoveVariables(object oPC)
{
    DeleteLocalInt(oPC,"CLASS_TYPE");
    DeleteLocalInt(oPC,"CHANGING_CLASS");
    DeleteLocalObject(oPC,"PC_TRAINER");
    DeleteLocalString(oPC,"CCS_CONV");
}

int GetPositionByClass(int nClassType, object oPC)
{
    int nResult=0;
    int nClassPos=1;
    while(nClassPos < 4){
        if(GetClassByPosition(nClassPos,oPC) == nClassType)
            nResult=nClassPos;
        nClassPos++;
    }
    return nResult;
}

int GetIsPrestigeClass(int nClassType)
{
    if(nClassType == CLASS_TYPE_ARCANE_ARCHER ||
      nClassType == CLASS_TYPE_ASSASSIN ||
      nClassType == CLASS_TYPE_BLACKGUARD ||
      nClassType == CLASS_TYPE_DIVINECHAMPION ||
      nClassType == CLASS_TYPE_DRAGONDISCIPLE ||
      nClassType == CLASS_TYPE_DWARVENDEFENDER ||
      nClassType == CLASS_TYPE_HARPER ||
      nClassType == CLASS_TYPE_PALEMASTER ||
      nClassType == CLASS_TYPE_SHADOWDANCER ||
      nClassType == CLASS_TYPE_SHIFTER ||
      nClassType == CLASS_TYPE_WEAPON_MASTER)
        return TRUE;
    else return FALSE;
}

int GetNonPrestigeCharacterLevel(object oPC)
{
    int nTotalCharacterLevel=GetLevelByPosition(1,oPC);
    if(!GetIsPrestigeClass(GetClassByPosition(2,oPC))){
        nTotalCharacterLevel=nTotalCharacterLevel+GetLevelByPosition(2,oPC);
        if(!GetIsPrestigeClass(GetClassByPosition(3,oPC)))
            nTotalCharacterLevel=nTotalCharacterLevel+GetLevelByPosition(3,oPC);
    }
    return nTotalCharacterLevel;
}

void EnableFamiliarClasses(object oPC)
{
    int nCounter=1;
    while(nCounter<4){
        if(GetLevelByPosition(nCounter,oPC))
            AllowClass(oPC,GetClassByPosition(nCounter,oPC));
        else return;
        nCounter++;
    }
}

//void main(){}
