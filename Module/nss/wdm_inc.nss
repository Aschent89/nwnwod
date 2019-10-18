////////////////////////////////////////////////////////////////////////////////
//  Dead and Wild Magic System - Include File
//  wdm_inc
//  By Don Anderson
//  dandersonru@msn.com
//
//  The source scripts are by Catscan....GREAT WORK here.
//
/*
For Dead Magic:
1) Place the Dead Magic Waypoint (Custom Special 1) in the Area
2) Edit the NAME field to change this 1_1 to:
    1st # - Strip all Magical Effects on Entering Creature (0 is OFF)
    2nd # - Strip all Magical Properties from Items (0 is OFF)

for Wild Magic:
1) Place the Wild Magic Waypoint (Custom Special 1) in the Area
2) Edit the NAME field to change the Percentage Chance of a Wild Magic Surge.
   This value should be between 1 and 100. Out of Range Values Default of 50 is used.

This work is based off of the wild and dead magic zones created by BioWare in the HotU campaign.

The main difference between the original and modified works are:

 * Easily configurable per area or dynamically via scripting
 * Dead magic item stripping and restoration is not achieved via copying the items of the
   character.  Instead, the item properties are serialized into a string and stored on
   the item itself.  Doing this allows the item properties to be restored if a PW server crashes
   or resets before the properties have been restored.

*/
//
////////////////////////////////////////////////////////////////////////////////

#include "tokenizer_inc"

#include "x2_inc_switches"
#include "x2_inc_itemprop"

//:****************************************************************************/
//:CONSTANTS (DO NOT TOUCH)

const int WDM_DEBUG               = FALSE;//Enable debug messages to the log for testing
const string WDM_WILDM_ZONE       = "wdm_wildm_zone";
const string WDM_DEADM_ZONE       = "wdm_deadm_zone";
const string WDM_WM_PERCENT       = "wdm_wm_percent";
const string WDM_WM_SCRIPT        = "wdm_wm_script";
const string WDM_DM_STREFFECTS    = "wdm_dm_streffects";
const string WDM_DM_STRITEMS      = "wdm_dm_stritems";
const string WDM_ITEM_PROPS_VAR   = "wdm_item_props_var";
const string WDM_MAGIC_STRIPPED   = "wdm_magic_stripped";
const string WDM_END_MARKER       = ".";
const string WDM_DELIM            = "_";
const string WDM_SURGE_MSG        = "* Wild Magic Surge *";
const int WDM_DEFAULT_PERCENT     = 50;
const string WDM_DEFAULT_SCRIPT   = "x0_s3_rodwonder";

//:CONSTANTS (DO NOT TOUCH)
//:****************************************************************************/

//////////////////////////////////////////////////
// STRUCTURES
//

// This structure returns wild magic information
// for a particular area.
//   * iIsWildMagic - TRUE if the area is
//                    a Wild magic zone, otherwise FALSE
//   * iPercentage - the percent chance
//                       of a wild magic surge, or zero
//                       if the area isn't a wild magic
//                       zone
//   * sScript - the name of the script to perform wild magic
//               or "" if the area isn't a wild magic zone
struct WildMagicInfo
{
    int iIsWildMagic;
    int iPercentage;
    string sScript;
};

// This structure returns dead magic information for
// a particular area.
//   * iIsDeadMagic - TRUE if the area is a Dead magic zone,
//                    otherwise FALSE
//   * iStripProperties - TRUE if this Dead magic zone strips
//                        item properties, otherwise FALSE
//   * iStripEffects - TRUE if this Dead magic zone strips status
//                     effects
struct DeadMagicInfo
{
    int iIsDeadMagic;
    int iStripProperties;
    int iStripEffects;
};


//////////////////////////////////////////////////
// FUNCTION PROTOTYPES
//

// Main entry point for wild and dead magic zone handling.
// This should be called from the module override spell hook
// script.
// Returns TRUE if SetModuleOverrideSpellScriptFinished should
//  be invoked by the caller of this function, otherwise returns
//  FALSE.
int WDM_HandleMagicZone();

// Enable/Disable an area's wild magic status.
// If iEnable is TRUE, the area will be designated as a wild
// magic zone.  Additionally, when iEnable is TRUE, the
// default wild magic surge percentage and script can be
// overridden.
//
// To make an area normal again, call this method passing
// FALSE for iStatus.
void WDM_SetAreaWildMagicStatus(object oArea, int iEnable,
                                int iPercentage = 50,
                                string sScript = WDM_DEFAULT_SCRIPT);

// Returns all information pertaining to wild magic status
// of an area, SEE the docs for the WildMagicInfo struct
// for details.
struct WildMagicInfo WDM_GetAreaWildMagicStatus(object oArea);

// Enable/Disable an area's dead magic status.
// If iEnable is TRUE, the area will be designated as a dead
// magic zone.  Additionally, when iEnable is TRUE, the builder
// can specify whether or not item properties and status effects
// are stripped from the player (default in both cases is FALSE).
//
// To make an area normal again, call this method passing
// FALSE for iStatus.
void WDM_SetAreaDeadMagicStatus(object oArea, int iEnable,
                                int iStripEffects = FALSE,
                                int iStripItemProps = FALSE);

// Returns all information pertaining to dead magic status
// of an area, SEE the docs for the DeadMagicInfo struct
// for details.
struct DeadMagicInfo WDM_GetAreaDeadMagicStatus(object oArea);

// Strips any status effects and magic properties of all items
// the entering object owns (only if the area the PC is currently
// in is configured to do so).
void WDM_StripMagic(object oEnter);

// Restores any previously stripped item properties to the items
// of the exiting object.  Pass TRUE to iForceRestoration
// if one wishes to force the restoration processes.
void WDM_RestoreMagic(object oExit, int iForceRestoration = FALSE);

// Restore all properties to the specified item.
void WDM_RestoreAllProperties(object oItem,
                              object oPC = OBJECT_INVALID,
                              int nSlot = -1);


// Remove all properties from the specified item.
void WDM_RemoveAllProperties(object oItem, object oPC = OBJECT_INVALID);



//////////////////////////////////////////////////
// FUNCTION IMPLEMENTATIONS
//

//////////////////////////////////////////////////
// "PRIVATE" FUNCTIONS


int GetIsAlcohol(object oItem)
{

    itemproperty ip;
    ip = GetFirstItemProperty(oItem);
    // if there is more than 1 property then this item should be stripped
    if(GetIsItemPropertyValid(GetNextItemProperty(oItem)))
        return FALSE;
    if(GetItemPropertyType(ip) == ITEM_PROPERTY_CAST_SPELL)
    {
        int nSubType = GetItemPropertySubType(ip);
        if(nSubType == IP_CONST_CASTSPELL_SPECIAL_ALCOHOL_BEER ||
           nSubType == IP_CONST_CASTSPELL_SPECIAL_ALCOHOL_SPIRITS ||
           nSubType == IP_CONST_CASTSPELL_SPECIAL_ALCOHOL_WINE)
            return TRUE;
    }
    return FALSE;

} // END GetIsAlcohol


int GetIsPoisonAmmo(object oItem)
{

    itemproperty ip;
    ip = GetFirstItemProperty(oItem);
    // if there is more than 1 property then this item should be stripped
    if(GetIsItemPropertyValid(GetNextItemProperty(oItem)))
        return FALSE;

    if(IPGetItemHasItemOnHitPropertySubType(oItem, IP_CONST_ONHIT_ITEMPOISON))
        return TRUE; // single poison property
    return FALSE;

} // END GetIsPoisonAmmo


int GetIsDyeKit(object oItem)
{

    if(GetBaseItemType(oItem) == BASE_ITEM_MISCSMALL)
    {
        itemproperty ip = GetFirstItemProperty(oItem);
        if(GetItemPropertyType(ip) == ITEM_PROPERTY_CAST_SPELL)
        {
            int nSubType = GetItemPropertySubType(ip);
            return (nSubType >= 490 && nSubType <= 497);
        }
        return FALSE;
    }
    return FALSE;

} // END GetIsDyeKit


string GetItemPropertiesAsString(itemproperty ip)
{

    // Position 1: Item Type
    // Position 2: Cost Table Value
    // Position 3: Sub Type
    // Position 4: Param 1 Value
    string sSerializedProp = "";
    sSerializedProp =
        AddTokenToString(
            IntToString(GetItemPropertyType(ip)), sSerializedProp, WDM_DELIM);

    sSerializedProp =
        AddTokenToString(
            IntToString(
                GetItemPropertyCostTableValue(ip)), sSerializedProp, WDM_DELIM);

    sSerializedProp =
        AddTokenToString(
            IntToString(GetItemPropertySubType(ip)), sSerializedProp, WDM_DELIM);

    sSerializedProp =
        AddTokenToString(
            IntToString(
                GetItemPropertyParam1Value(ip)), sSerializedProp, WDM_DELIM);

    return sSerializedProp;

} // END GetItemPropertiesAsString


void StoreItemProperties(string sProperties, object oItem)
{

    SetLocalString(oItem, WDM_ITEM_PROPS_VAR, sProperties);

} // END StoreItemProperties


string GetItemProperties(object oItem, int nDeleteVar = FALSE)
{

    string sProps = GetLocalString(oItem, WDM_ITEM_PROPS_VAR);
    if (nDeleteVar && sProps != "")
        DeleteLocalString(oItem, WDM_ITEM_PROPS_VAR);

    return sProps;

} // END GetItemProperties


void RemoveAllProperties(object oItem, object oPC = OBJECT_INVALID)
{

    if(oItem == OBJECT_INVALID)
        return;

    // Temporary properties go *poof* forever. Thanks Jim Shue
    IPRemoveAllItemProperties(oItem, DURATION_TYPE_TEMPORARY);

    // if no properties, return
    if (GetItemProperties(oItem) != "")
        return;


    int nType = GetBaseItemType(oItem);
    if(nType == BASE_ITEM_TORCH ||
       nType == BASE_ITEM_TRAPKIT ||
       nType == BASE_ITEM_HEALERSKIT ||
       nType == BASE_ITEM_GRENADE ||
       nType == BASE_ITEM_THIEVESTOOLS ||
       nType == BASE_ITEM_CRAFTMATERIALMED || // crafting stuff
       nType == BASE_ITEM_CRAFTMATERIALSML)
        return;

    if(GetIsAlcohol(oItem) || GetIsPoisonAmmo(oItem) || GetIsDyeKit(oItem))
        return;

    string sAllPropsForItem;
    itemproperty ip = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ip))
    {
        sAllPropsForItem =
            AddTokenToString(GetItemPropertiesAsString(ip), sAllPropsForItem);
        RemoveItemProperty(oItem, ip);
        ip = GetNextItemProperty(oItem);
    }
    sAllPropsForItem = AddTokenToString(WDM_END_MARKER, sAllPropsForItem);

    // Don't set any variable if only the END_MARKER is present
    if (sAllPropsForItem != WDM_END_MARKER)
    {
        StoreItemProperties(sAllPropsForItem, oItem);
        if (oPC != OBJECT_INVALID)
            if (WDM_DEBUG) WriteTimestampedLogEntry("[" + GetName(oPC) +
               "] Serialized " + "properties for item [" + GetName(oItem) +
               "]: " + sAllPropsForItem);
        else
            if (WDM_DEBUG) WriteTimestampedLogEntry("[" +
               GetName(GetArea(oItem)) + "] Serialized properties for item [" +
               GetName(oItem) + "]: " + sAllPropsForItem);
    }

} // END RemoveAllProperties


// remove any affects applied to the object in question
void WDMRemoveEffects(object oObject)
{

    effect eEff = GetFirstEffect(oObject);
    while(GetIsEffectValid(eEff))
    {
        int nType = GetEffectType(eEff);
        if(GetEffectSubType(eEff) != SUBTYPE_EXTRAORDINARY &&
           (nType == EFFECT_TYPE_ABILITY_INCREASE ||
           nType == EFFECT_TYPE_AC_INCREASE ||
           nType == EFFECT_TYPE_ATTACK_INCREASE ||
           nType == EFFECT_TYPE_BLINDNESS ||
           nType == EFFECT_TYPE_CHARMED ||
           nType == EFFECT_TYPE_CONCEALMENT ||
           nType == EFFECT_TYPE_CONFUSED ||
           nType == EFFECT_TYPE_CURSE ||
           nType == EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE ||
           nType == EFFECT_TYPE_DAMAGE_INCREASE ||
           nType == EFFECT_TYPE_DAMAGE_REDUCTION ||
           nType == EFFECT_TYPE_DAMAGE_RESISTANCE ||
           nType == EFFECT_TYPE_DAZED ||
           nType == EFFECT_TYPE_DEAF ||
           nType == EFFECT_TYPE_DOMINATED ||
           nType == EFFECT_TYPE_ELEMENTALSHIELD ||
           nType == EFFECT_TYPE_ETHEREAL ||
           nType == EFFECT_TYPE_FRIGHTENED ||
           nType == EFFECT_TYPE_HASTE ||
           nType == EFFECT_TYPE_IMMUNITY ||
           nType == EFFECT_TYPE_IMPROVEDINVISIBILITY ||
           nType == EFFECT_TYPE_INVISIBILITY ||
           nType == EFFECT_TYPE_INVULNERABLE ||
           nType == EFFECT_TYPE_ABILITY_INCREASE ||
           nType == EFFECT_TYPE_NEGATIVELEVEL ||
           nType == EFFECT_TYPE_PARALYZE ||
           nType == EFFECT_TYPE_POLYMORPH ||
           nType == EFFECT_TYPE_REGENERATE ||
           nType == EFFECT_TYPE_SANCTUARY ||
           nType == EFFECT_TYPE_SAVING_THROW_INCREASE ||
           nType == EFFECT_TYPE_SEEINVISIBLE ||
           nType == EFFECT_TYPE_SILENCE ||
           nType == EFFECT_TYPE_SKILL_INCREASE ||
           nType == EFFECT_TYPE_SLOW ||
           nType == EFFECT_TYPE_SPELL_IMMUNITY ||
           nType == EFFECT_TYPE_SPELL_RESISTANCE_INCREASE ||
           nType == EFFECT_TYPE_SPELLLEVELABSORPTION ||
           nType == EFFECT_TYPE_TEMPORARY_HITPOINTS ||
           nType == EFFECT_TYPE_TRUESEEING ||
           nType == EFFECT_TYPE_ULTRAVISION ||
           nType == EFFECT_TYPE_INVULNERABLE))

           RemoveEffect(oObject, eEff);
           eEff = GetNextEffect(oObject);
    }

} // END RemoveEffects


// This is a rewrite of IPGetItemPropertyByID.  There were a few issues
// found when using that function to accomplish the creation of an
// itemproperty (one being not all types are covered, the other that
// the parameters weren't well documented, and some were out of order).
itemproperty GetItemPropertyByID(int nPropID, int nCostTableValue = 0,
                                 int nSubType = 0, int nValue1 = 0)
{

    itemproperty ipRet;
    switch(nPropID)
    {
        case ITEM_PROPERTY_ABILITY_BONUS:
            ipRet = ItemPropertyAbilityBonus(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_AC_BONUS:
            ipRet = ItemPropertyACBonus(nCostTableValue);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
            ipRet = ItemPropertyACBonusVsAlign(nCostTableValue, nSubType);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
            ipRet = ItemPropertyACBonusVsDmgType(nCostTableValue, nSubType);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
            ipRet = ItemPropertyACBonusVsRace(nCostTableValue, nSubType);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
            ipRet = ItemPropertyACBonusVsSAlign(nCostTableValue, nSubType);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS:
            ipRet = ItemPropertyAttackBonus(nCostTableValue);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
            ipRet = ItemPropertyAttackBonusVsAlign(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
            ipRet = ItemPropertyAttackBonusVsRace(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
            ipRet = ItemPropertyAttackBonusVsSAlign(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION:
            ipRet = ItemPropertyWeightReduction(nCostTableValue);
            break;
        case ITEM_PROPERTY_BONUS_FEAT:
            ipRet = ItemPropertyBonusFeat(nSubType);
            break;
        case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
            ipRet = ItemPropertyBonusLevelSpell(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_CAST_SPELL:
            ipRet = ItemPropertyCastSpell(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DAMAGE_BONUS:
            ipRet = ItemPropertyDamageBonus(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
            ipRet = ItemPropertyDamageBonusVsAlign(nSubType,
                                                   nValue1, nCostTableValue);
            break;
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
            ipRet = ItemPropertyDamageBonusVsRace(nSubType,
                                                  nValue1, nCostTableValue);
            break;
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
            ipRet = ItemPropertyDamageBonusVsSAlign(nSubType,
                                                    nValue1, nCostTableValue);
            break;
        case ITEM_PROPERTY_DAMAGE_REDUCTION:
            ipRet = ItemPropertyDamageReduction(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DAMAGE_RESISTANCE:
            ipRet = ItemPropertyDamageResistance(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DAMAGE_VULNERABILITY:
            ipRet = ItemPropertyDamageResistance(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DARKVISION:
            ipRet = ItemPropertyDarkvision();
            break;
        case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:
            ipRet = ItemPropertyDecreaseAbility(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DECREASED_AC:
            ipRet = ItemPropertyDecreaseAC(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:
            ipRet = ItemPropertyAttackPenalty(nCostTableValue);
            break;
        case ITEM_PROPERTY_DECREASED_DAMAGE:
            ipRet = ItemPropertyDamagePenalty(nCostTableValue);
            break;
        case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:
            ipRet = ItemPropertyEnhancementPenalty(nCostTableValue);
            break;
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS :
            ipRet = ItemPropertyReducedSavingThrow(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC:
            ipRet = ItemPropertyBonusSavingThrowVsX(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:
            ipRet = ItemPropertyDecreaseSkill(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT:
            ipRet = ItemPropertyContainerReducedWeight(nCostTableValue);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
            ipRet = ItemPropertyEnhancementBonus(nCostTableValue);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
            ipRet = ItemPropertyEnhancementBonusVsAlign(nSubType,
                                                        nCostTableValue);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
            ipRet = ItemPropertyEnhancementBonusVsSAlign(nSubType,
                                                         nCostTableValue);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
            ipRet = ItemPropertyEnhancementBonusVsRace(nSubType,
                                                       nCostTableValue);
            break;
        case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE:
            ipRet = ItemPropertyExtraMeleeDamageType(nCostTableValue);
            break;
        case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE:
            ipRet = ItemPropertyExtraRangeDamageType(nCostTableValue);
            break;
        case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT:
            ipRet = ItemPropertyFreeAction();
            break;
        case ITEM_PROPERTY_HASTE:
            ipRet = ItemPropertyHaste();
            break;
        case ITEM_PROPERTY_HEALERS_KIT:
            ipRet = ItemPropertyHealersKit(nCostTableValue);
            break;
        case ITEM_PROPERTY_HOLY_AVENGER:
            ipRet = ItemPropertyHolyAvenger();
            break;
        case ITEM_PROPERTY_KEEN:
            ipRet = ItemPropertyKeen();
            break;
        case ITEM_PROPERTY_LIGHT:
            ipRet = ItemPropertyLight(nCostTableValue, nValue1);
            break;
        case ITEM_PROPERTY_MASSIVE_CRITICALS:
            ipRet = ItemPropertyMassiveCritical(nCostTableValue);
            break;
        case ITEM_PROPERTY_NO_DAMAGE:
            ipRet = ItemPropertyNoDamage();
            break;
        case ITEM_PROPERTY_ON_HIT_PROPERTIES:
            ipRet = ItemPropertyOnHitProps(nSubType, nCostTableValue, nValue1);
            break;
        case ITEM_PROPERTY_TRAP:
            ipRet = ItemPropertyTrap(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_TRUE_SEEING:
            ipRet = ItemPropertyTrueSeeing();
            break;
        case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
            ipRet = ItemPropertyUnlimitedAmmo(nCostTableValue);
            break;
        case ITEM_PROPERTY_ONHITCASTSPELL:
            if (nSubType == IP_CONST_ONHIT_CASTSPELL_INTELLIGENT_WEAPON_ONHIT)
                nCostTableValue += 1;
            ipRet = ItemPropertyOnHitCastSpell(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_ARCANE_SPELL_FAILURE:
            ipRet = ItemPropertyArcaneSpellFailure(nCostTableValue);
            break;
        case ITEM_PROPERTY_USE_LIMITATION_CLASS:
            ipRet = ItemPropertyLimitUseByClass(nSubType);
            break;
        case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
            ipRet = ItemPropertyBonusSavingThrow(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_SAVING_THROW_BONUS:
            ipRet = ItemPropertyBonusSavingThrowVsX(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_MIGHTY:
            ipRet = ItemPropertyMaxRangeStrengthMod(nCostTableValue);
            break;
        case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
            ipRet = ItemPropertyVampiricRegeneration(nCostTableValue);
            break;
        case ITEM_PROPERTY_REGENERATION:
            ipRet = ItemPropertyRegeneration(nCostTableValue);
            break;
        case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
            ipRet = ItemPropertyDamageImmunity(nSubType, nCostTableValue);
            break;
        case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS:
            ipRet = ItemPropertyImmunityMisc(nSubType);
            break;
        case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL:
            ipRet = ItemPropertyImmunityToSpellLevel(nCostTableValue);
            break;
        case ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL:
            ipRet = ItemPropertySpellImmunitySpecific(nSubType);
            break;
        case ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL:
            ipRet = ItemPropertySpellImmunitySchool(nSubType);
            break;
        case ITEM_PROPERTY_SPELL_RESISTANCE:
            ipRet = ItemPropertyBonusSpellResistance(nCostTableValue);
            break;
        case ITEM_PROPERTY_TURN_RESISTANCE:
            ipRet = ItemPropertyTurnResistance(nCostTableValue);
            break;
        case ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP:
            ipRet = ItemPropertyLimitUseByAlign(nSubType);
            break;
        case ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE:
            ipRet = ItemPropertyLimitUseByRace(nSubType);
            break;
        case ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT:
            ipRet = ItemPropertyLimitUseBySAlign(nSubType);
            break;
        case ITEM_PROPERTY_VISUALEFFECT:
            ipRet = ItemPropertyVisualEffect(nSubType);
            break;
        case ITEM_PROPERTY_WEIGHT_INCREASE:
            ipRet = ItemPropertyWeightIncrease(nCostTableValue);
            break;
        case ITEM_PROPERTY_SKILL_BONUS:
            ipRet = ItemPropertySkillBonus(nSubType, nCostTableValue);
    }
    return ipRet;

} // END GetItemPropertyByID


int DoWildMagicZone(object oArea, struct WildMagicInfo wildInfo)
{

    if (WDM_DEBUG) WriteTimestampedLogEntry("Wild magic zone [" +
        GetName(oArea) + "]");

    int iPercent = wildInfo.iPercentage;
    if (iPercent < 1 || iPercent > 100)
        iPercent = WDM_DEFAULT_PERCENT;

    if (WDM_DEBUG) WriteTimestampedLogEntry("Wild magic percent: " +
        IntToString(iPercent));

    string sScript = wildInfo.sScript;
    if (sScript == "")
        sScript = WDM_DEFAULT_SCRIPT;

    if (WDM_DEBUG) WriteTimestampedLogEntry("Wild magic script: " + sScript);

    if (d100() <= iPercent)
    {
        FloatingTextStringOnCreature(WDM_SURGE_MSG, OBJECT_SELF);
        ExecuteScript(sScript, OBJECT_SELF);
        return TRUE;
    }

    return FALSE;

} // END DoWildMagicZone


int DoDeadMagicZone(object oArea)
{

    if (WDM_DEBUG) WriteTimestampedLogEntry("Dead magic zone [" +
            GetName(oArea) + "]");

    return TRUE;

} // END DoDeadMagicZone


////////////////////////////////////////////////////
// "PUBLIC" FUNCTIONS


int WDM_HandleMagicZone()
{
    if (GetIsDM(OBJECT_SELF) || GetIsDMPossessed(OBJECT_SELF))
        return FALSE;

    object oArea = GetArea(OBJECT_SELF);

    struct WildMagicInfo wildInfo = WDM_GetAreaWildMagicStatus(oArea);
    struct DeadMagicInfo deadInfo = WDM_GetAreaDeadMagicStatus(oArea);

    int iWild = wildInfo.iIsWildMagic;
    int iDead = deadInfo.iIsDeadMagic;

    // If an area is both marked as dead and wild,
    // do nothing
    if (iWild && iDead)
    {
        if (WDM_DEBUG) WriteTimestampedLogEntry("Area [" + GetName(oArea) +
            "] has been configured as both a dead and wild magic zone.  Neither " +
            "configuration will take effect.");
        return FALSE;
    }

    int iReturn = FALSE;

    if (iWild)
        iReturn = DoWildMagicZone(oArea, wildInfo);
    if (iDead)
        iReturn = DoDeadMagicZone(oArea);

    return iReturn;

} // END WDM_HandleMagicZone


void WDM_RestoreAllProperties(object oItem,
                              object oPC = OBJECT_INVALID,
                              int nSlot = -1)
{

    // this is a pc object that has an item in inventory
    // slot or normal inventory
    if(oPC != OBJECT_INVALID)
    {
          if(oItem == OBJECT_INVALID)
              oItem = GetItemInSlot(nSlot, oPC);
          if(oItem == OBJECT_INVALID)
              return;
    }

    string sAllProperties = GetItemProperties(oItem, TRUE);

    if (sAllProperties != "")
    {
        int iTokenCount = GetTokenCount(sAllProperties);
        int i;
        for (i = 1; i <= iTokenCount; i++)
        {
            string token = GetTokenFromString(i, sAllProperties);
            if (token == WDM_END_MARKER)
                break;

            // Position 1: Item Type
            // Position 2: Cost Table Value
            // Position 3: Sub Type
            // Position 4: Param 1 Value
            int iType = StringToInt(GetTokenFromString(1, token, WDM_DELIM));
            itemproperty iProp = GetItemPropertyByID(iType,
                StringToInt(GetTokenFromString(2, token, WDM_DELIM)),
                StringToInt(GetTokenFromString(3, token, WDM_DELIM)),
                StringToInt(GetTokenFromString(4, token, WDM_DELIM)));


            if (!GetIsItemPropertyValid(iProp))
            {
                if (WDM_DEBUG) WriteTimestampedLogEntry(
                    "[WDM_wdm_i:RestorAllProperties] [" +
                    GetName(oPC) + "] Unable to restore" +
                    " property [" + token + "] for item [" + GetName(oItem) +
                    "].");
            }
            else
            {
                if (iType != ITEM_PROPERTY_ON_HIT_PROPERTIES &&
                    iType != ITEM_PROPERTY_ONHITCASTSPELL)
                {
                    IPSafeAddItemProperty(oItem,
                                          iProp,
                                          0.0f,
                                          X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
                }
                else
                {
                    IPSafeAddItemProperty(oItem, iProp);
                }
            }
        }
    }

} // END WDM_RestoreAllProperties


void WDM_RemoveAllProperties(object oItem, object oPC = OBJECT_INVALID)
{

    if(oItem == OBJECT_INVALID)
        return;

    // Temporary properties go *poof* forever. Thanks Jim Shue
    IPRemoveAllItemProperties(oItem, DURATION_TYPE_TEMPORARY);

    // if no properties, return
    if (GetItemProperties(oItem) != "")
        return;


    int nType = GetBaseItemType(oItem);
    if(nType == BASE_ITEM_TORCH ||
       nType == BASE_ITEM_TRAPKIT ||
       nType == BASE_ITEM_HEALERSKIT ||
       nType == BASE_ITEM_GRENADE ||
       nType == BASE_ITEM_THIEVESTOOLS ||
       nType == BASE_ITEM_CRAFTMATERIALMED || // crafting stuff
       nType == BASE_ITEM_CRAFTMATERIALSML)
        return;

    if(GetIsAlcohol(oItem) || GetIsPoisonAmmo(oItem) || GetIsDyeKit(oItem))
        return;

    string sAllPropsForItem;
    itemproperty ip = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ip))
    {
        sAllPropsForItem =
            AddTokenToString(GetItemPropertiesAsString(ip), sAllPropsForItem);
        RemoveItemProperty(oItem, ip);
        ip = GetNextItemProperty(oItem);
    }
    sAllPropsForItem = AddTokenToString(WDM_END_MARKER, sAllPropsForItem);

    // Don't set any variable if only the END_MARKER is present
    if (sAllPropsForItem != WDM_END_MARKER)
    {
        StoreItemProperties(sAllPropsForItem, oItem);
        if (oPC != OBJECT_INVALID)
            if (WDM_DEBUG) WriteTimestampedLogEntry("[" + GetName(oPC) +
               "] Serialized properties for item [" + GetName(oItem) + "]: " +
               sAllPropsForItem);
        else
            if (WDM_DEBUG) WriteTimestampedLogEntry("[" + GetName(GetArea(oItem)) +
               "] Serialized properties for item [" + GetName(oItem) + "]: " +
               sAllPropsForItem);
    }

} // END WDM_RemoveAllProperties



void WDM_StripMagic(object oEnter)
{

    if (GetLocalInt(oEnter, WDM_MAGIC_STRIPPED))
        return;

    object oArea = GetArea(OBJECT_SELF);

    struct DeadMagicInfo dmInfo = WDM_GetAreaDeadMagicStatus(oArea);

    if (dmInfo.iStripEffects)
        WDMRemoveEffects(oEnter);

    if (dmInfo.iStripProperties)
    {
        object oItem = GetFirstItemInInventory(oEnter);
        while(oItem != OBJECT_INVALID)
        {
            RemoveAllProperties(oItem, oEnter);
            oItem = GetNextItemInInventory(oEnter);
        }
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oEnter);
        RemoveAllProperties(oItem, oEnter);
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oEnter);
        RemoveAllProperties(oItem, oEnter);
    }

    // Save state on PC pertaining to the fact that magic has
    // been stripped.
    SetLocalInt(oEnter, WDM_MAGIC_STRIPPED, TRUE);

} // END WDM_StripMagic


void WDM_RestoreMagic(object oExit, int iForceRestoration = FALSE)
{

    // If not forcing restoration, check for WDM_MAGIC_STRIPPED.
    // If that variable is not present, return.
    if (!iForceRestoration)
        if (!GetLocalInt(oExit, WDM_MAGIC_STRIPPED))
            return;


    // Handle all items in inventory:
    object oItem = GetFirstItemInInventory(oExit);
    while(oItem != OBJECT_INVALID)
    {
        DelayCommand(1.0, WDM_RestoreAllProperties(oItem, oExit, -1));
        oItem = GetNextItemInInventory(oExit);
    }
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_ARMS));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_ARROWS));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_BELT));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_BOLTS));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_BOOTS));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_BULLETS));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_CHEST));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_CLOAK));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_HEAD));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_LEFTHAND));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_LEFTRING));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_NECK));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_RIGHTHAND));
    DelayCommand(1.0,
        WDM_RestoreAllProperties(OBJECT_INVALID, oExit, INVENTORY_SLOT_RIGHTRING));


    SetLocalInt(oExit, WDM_MAGIC_STRIPPED, FALSE);

} // END WDM_RestoreMagic


void WDM_SetAreaWildMagicStatus(object oArea, int iEnable,
                                int iPercentage = 50,
                                string sScript = WDM_DEFAULT_SCRIPT)
{
    if (iEnable)
    {
        SetLocalInt(oArea, WDM_WILDM_ZONE, TRUE);
        SetLocalInt(oArea, WDM_WM_PERCENT, iPercentage);
        SetLocalString(oArea, WDM_WM_SCRIPT, sScript);
    }
    else
    {
        DeleteLocalInt(oArea, WDM_WILDM_ZONE);
        DeleteLocalInt(oArea, WDM_WM_PERCENT);
        DeleteLocalString(oArea, WDM_WM_SCRIPT);
    }
} // END WDM_SetAreaWildMagicStatus


struct WildMagicInfo WDM_GetAreaWildMagicStatus(object oArea)
{
    struct WildMagicInfo info;
    info.iIsWildMagic = GetLocalInt(oArea, WDM_WILDM_ZONE);
    info.iPercentage  = GetLocalInt(oArea, WDM_WM_PERCENT);
    info.sScript      = GetLocalString(oArea, WDM_WM_SCRIPT);

    return info;
} // END WDM_GetAreaWildMagicStatus


void WDM_SetAreaDeadMagicStatus(object oArea, int iEnable,
                                int iStripEffects = FALSE,
                                int iStripItemProps = FALSE)
{
    if (iEnable)
    {
        SetLocalInt(oArea, WDM_DEADM_ZONE, TRUE);
        SetLocalInt(oArea, WDM_DM_STREFFECTS, iStripEffects);
        SetLocalInt(oArea, WDM_DM_STRITEMS, iStripItemProps);
    }
    else
    {
        DeleteLocalInt(oArea, WDM_DEADM_ZONE);
        DeleteLocalInt(oArea, WDM_DM_STREFFECTS);
        DeleteLocalInt(oArea, WDM_DM_STRITEMS);
    }
} // END WDM_SetAreaDeadMagicStatus


struct DeadMagicInfo WDM_GetAreaDeadMagicStatus(object oArea)
{
    struct DeadMagicInfo info;
    info.iIsDeadMagic     = GetLocalInt(oArea, WDM_DEADM_ZONE);
    info.iStripProperties = GetLocalInt(oArea, WDM_DM_STRITEMS);
    info.iStripEffects    = GetLocalInt(oArea, WDM_DM_STREFFECTS);

    return info;
} // END WDM_GetAreaDeadMagicStatus

//void main() {}
