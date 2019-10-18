//  ----------------------------------------------------------------------------
//  hc_inc
//  ----------------------------------------------------------------------------
/*
    Library of constants, variables and functions used throughout the HCR.

    This script contains default values for PlayerState and is included in
    any file where PlayerState must be checked.  Other PlayerState's could be
    added here.
*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.03.0b - 27 Feb 2005 - CFX
    ARMOR ENCUMBRANCE AND RACIAL MOVEMENT RATES
    Credits: Kornstalxs, who did the original code and Kerry Solberg who modified it.
    adapted to HCR by CFX

    HCR 3.02 - 05 August 2004 - Sunjammer
    - added PLAYER_ID constant
    - added HC_SetCurrentHitPoints function

    HCR 3.02 - 16 June 2004 - Sunjammer
    - added RECOVERING PlayerState constant
    - added new wrapper functions for "attributes" and DelayExecuteScript
*/
//  ----------------------------------------------------------------------------
#include "hc_inc_pwdb_func"
// added for racial movement speed and armor encumberance
#include "x2_inc_itemprop"

//  ----------------------------------------------------------------------------
//  CONSTANTS
//  ----------------------------------------------------------------------------

// values for persistant player states
const int PWS_PLAYER_STATE_ALIVE        = 0;
const int PWS_PLAYER_STATE_DYING        = 1;
const int PWS_PLAYER_STATE_DEAD         = 2;
const int PWS_PLAYER_STATE_STABLE       = 3;
const int PWS_PLAYER_STATE_STABLEHEAL   = 6; // deprecated: use RECOVERING
const int PWS_PLAYER_STATE_RECOVERING   = 6;
const int PWS_PLAYER_STATE_RESURRECTED  = 7;
const int PWS_PLAYER_STATE_RESTRUE      = 8;
const int PWS_PLAYER_STATE_RAISEDEAD    = 9;

// name of Player ID variable
const string HC_VAR_PLAYER_ID           = "";

// ARMOR ENCUMBRANCE AND RACIAL MOVEMENT RATES

// Debug Messages:  set to 0 to deactivate; set to 1 to activate
const int CRP_DEBUG = 1;

//The % movement penalty for Halfling, Dwarves, and Gnomes
const int SML_CREATURE_MOVEPEN = 20;
//The % AC encumbrance movement penalty for Humans, Elves, Halfelves, and Halforcs
const int MDM_CREATURE_ARMORPEN = 20;
//The % AC encumbrance movement penalty for Halflings, Dwarves, and Gnomes
const int SML_CREATURE_ARMORPEN = 15;

const string MSG = "Armor/Shield Applies: Movement Rate: ";


//  ----------------------------------------------------------------------------
//  VARIABLES
//  ----------------------------------------------------------------------------

object oMod = GetModule();


//  ----------------------------------------------------------------------------
//  PROTOTYPES
//  ----------------------------------------------------------------------------

// Simple wrapper to delay oTarget's execution of sScript for fSeconds.
void DelayExecuteScript(float fSeconds, string sScript, object oTarget);

// Sets the Unique Player ID of oPC to oPC.
void SetPlayerID(object oPC);

// Returns the Unique Player ID of oPC.
string GetPlayerID(object oPC);

// Set oPC's state to nPS.
void SPS(object oPC, int nPS);

// Returns the current player state of oPC.
int GPS(object oPC);

// Simple wrapper to return persistant value of sAttribute for oPC
//  - oPC:          any player
//  - sAttribute:   name of attribute
int HC_GetPersistantAttribute(object oPC, string sAttribute);

// Simple wrapper to set persistant value of sAttribute for oPC to nValue
//  - oPC:          any player
//  - sAttribute:   name of attribute
//  - nValue:       new value for sAttribute
void HC_SetPersistantAttribute(object oPC, string sAttribute, int nValue);

// Sets oCreatures current hit points to nHitPoints subject to normal minimum
// and maximum.  Setting to -ve value will affect PCs and NPCs as normal.
//  - oCreature:        any valid creature
//  - nNewHP:           new hitpoint value
void HC_SetCurrentHitPoints(object oCreature, int nNewHP);

//  ----------------------------------------------------------------------------
//  FUNCTIONS
//  ----------------------------------------------------------------------------

void DelayExecuteScript(float fSeconds, string sScript, object oTarget)
{
    DelayCommand(fSeconds, ExecuteScript(sScript, oTarget));
}


void SetPlayerID(object oPC)
{
    string sID = GetName(oPC) + GetPCPlayerName(oPC);
    SetLocalString(oPC, HC_VAR_PLAYER_ID, sID);
}


string GetPlayerID(object oPC)
{
    string sID = GetLocalString(oPC, HC_VAR_PLAYER_ID);
    if (sID == "")
    {
        SetPlayerID(oPC);
        sID = (GetName(oPC) + GetPCPlayerName(oPC));
    }
    return sID;
}


void SPS(object oPC, int nPS)
{
    if (GetLocalInt(oMod, "PERSIST"))
        SetCampaignInt("HCRPC" + GetPlayerID(oPC), "PlayerState", nPS);
    else
        SetPersistentInt(oMod, "PlayerState" + GetPlayerID(oPC), nPS);
}


int GPS(object oPC)
{
    if (GetLocalInt(oMod, "PERSIST"))
        return GetCampaignInt("HCRPC" + GetPlayerID(oPC), "PlayerState");
    else
        return GetPersistentInt(oMod, "PlayerState" + GetPlayerID(oPC));
}


int HC_GetPersistantAttribute(object oPC, string sAttribute)
{
    // return persistant variable suffixed with player's ID
    return GetPersistentInt(oMod, sAttribute + GetPlayerID(oPC));
}


void HC_SetPersistantAttribute(object oPC, string sAttribute, int nValue)
{
    // set persistant variable suffixed with player's ID to new value
    SetPersistentInt(oMod, sAttribute + GetPlayerID(oPC), nValue);
}


void HC_SetCurrentHitPoints(object oCreature, int nNewHP)
{
    if(GetIsObjectValid(oCreature))
    {
        int nCurHP = GetCurrentHitPoints(oCreature);

        // heal to set higher, damage to set lower, nothing to stay the same
        if(nNewHP > nCurHP)
        {
            // use (new - cur) and value will be correct even for -ve HP
            effect eHeal = EffectHeal(nNewHP - nCurHP);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCreature);
        }
        else if(nNewHP < nCurHP)
        {
            // use (cur - new) and value will be correct even for -ve HP
            effect eDamage = EffectDamage(nCurHP - nNewHP, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oCreature);
        }
    }
}

// Racial and Armor speed routines - cfx

//Apply armor encumbrance penalties to oObject
void HC_EffectArmorEncumbrance(object oObject);

//Remove armor encumbrance penalties from oObject
void HC_RemoveArmorEncumbrance(object oObject);

//Sets movement rates to more closely match the 3.5 D&D rules.
void HC_SetRacialMovementRate(object oCreature);

void HC_SetRacialMovementRate(object oCreature)
{
    if(GetLocalInt(oCreature, "RACIAL_MOVEMENT") == 1)
        return;

    int nType = GetRacialType(oCreature);
    if(nType == RACIAL_TYPE_ANIMAL || nType == RACIAL_TYPE_BEAST ||
       nType == RACIAL_TYPE_DRAGON || nType == RACIAL_TYPE_MAGICAL_BEAST ||
       nType == RACIAL_TYPE_VERMIN) return;

    if(GetCreatureSize(oCreature) == CREATURE_SIZE_SMALL || nType == RACIAL_TYPE_DWARF)
   {
        if(CRP_DEBUG == 1) SendMessageToPC(oCreature, "Setting Racial Movement");
        effect eRate = SupernaturalEffect(EffectMovementSpeedDecrease(SML_CREATURE_MOVEPEN));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRate, oCreature);
        SetLocalInt(oCreature, "RACIAL_MOVEMENT", 1);
        return;
   }
}
void HC_EffectArmorEncumbrance(object oObject)
{
    object oArmor = GetPCItemLastEquipped();
    if(GetBaseItemType(oArmor) != BASE_ITEM_ARMOR)
        return;
    if(GetRacialType(oObject) == RACIAL_TYPE_DWARF)
        return;

    int nNetAC = GetItemACValue(oArmor);
    int nBonus = IPGetWeaponEnhancementBonus(oArmor, ITEM_PROPERTY_AC_BONUS);
    int nBaseAC = nNetAC - nBonus;
    float fMod;

    switch(nBaseAC)
    {
        case 0: case 1: case 2: case 3: return;
        case 4: case 5: fMod = 2.5f; break;
        default: fMod = 1.0f;
    }
    effect ePenalty;
    int nRate;
    if(GetCreatureSize(oObject) == CREATURE_SIZE_SMALL)
    {
        nRate = FloatToInt(SML_CREATURE_ARMORPEN / fMod);
        ePenalty = SupernaturalEffect(EffectMovementSpeedDecrease(nRate));
    }
    else
    {
        nRate = FloatToInt(MDM_CREATURE_ARMORPEN / fMod);
        ePenalty = SupernaturalEffect(EffectMovementSpeedDecrease(nRate));
    }
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenalty, oObject);
    SendMessageToPC(oObject, MSG + "Decreased " + IntToString(nRate) + "%");

}
void HC_RemoveArmorEncumbrance(object oObject)
{
    object oArmor = GetPCItemLastUnequipped();
    if(GetBaseItemType(oArmor) != BASE_ITEM_ARMOR)
        return;
    if(GetRacialType(oObject) == RACIAL_TYPE_DWARF)
        return;
    int nType;
    effect ePenalty = GetFirstEffect(oObject);
    while(GetIsEffectValid(ePenalty))
    {
        nType = GetEffectType(ePenalty);
        if(CRP_DEBUG >= 1) SendMessageToPC(OBJECT_SELF, IntToString(nType));
        if(GetEffectCreator(ePenalty) == OBJECT_SELF &&
           nType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE &&
           GetEffectSubType(ePenalty) == SUBTYPE_SUPERNATURAL)
        {
            RemoveEffect(oObject, ePenalty);
        }
        ePenalty = GetNextEffect(oObject);
    }
    SendMessageToPC(oObject, MSG + "Normal");
    SetLocalInt(oObject, "RACIAL_MOVEMENT", 0);
    DelayCommand(0.5, HC_SetRacialMovementRate(oObject));
}

// void main (){}
