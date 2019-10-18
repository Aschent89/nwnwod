//::///////////////////////////////////////////////
//:: Name: inc_gsystem_terr
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file to handle guild territory related
    commands/functions.

    NOTE: Do not modify this script in any way!
        The only customizeable script is:
        "inc_gsystem_cnfg".
*/
//:://////////////////////////////////////////////
//:: Created By: Samius Maximus
//:: Created On:
//:://////////////////////////////////////////////
#include "inc_gsystem_cnfg"
#include "aps_include"

//**************************** PGS TERRITORY INFO ****************************\\

//------------------------------------------------
//GET functions for territory objects.
//------------------------------------------------
int GetPGSDoorTerritory (object oDoor);
int GetPGSFlagTerritory (object oFlag);
int GetPGSMarkerTerritory (object oMarker);
int GetPGSStorageTerritory (object oChest);

//------------------------------------------------
//GET & SET functions for territory guild number.
//------------------------------------------------
int GetTerritoryGuildNumber (int iTerritory);
void SetTerritoryGuildNumber (int iTerritory, int iGuild);

//------------------------------------------------
//GET & SET functions for teeritory names.
//------------------------------------------------
string GetTerritoryGuildName (int iTerritory);
void SetTerritoryName (int iTerritory, string sName);

//------------------------------------------------
//GET & SET functions for max territory number.
//------------------------------------------------
int GetMaxTerritoryNumber();
void SetMaxTerritoryNumber (int iMaxTerritory);

//------------------------------------------------
//GET & SET functions for territory count.
//------------------------------------------------
int GetGuildTerritoryCount (int iGuild);
void SetGuildTerritoryCount (int iGuild, int iCount);

//------------------------------------------------
//GET & SET functions for storage creatures.
//------------------------------------------------
object GetTerritoryStorageCreature (int iTerritory, int nNth);
void SetTerritoryStorageCreature (int iTerritory, int nNth, object oCreature);


//**************************** PGS TERRITORY INFO ****************************\\

//  //********************************************************************\\  \\
//  ||************************ BEGIN PGS FUNCTIONS ***********************||  \\
//  \\********************************************************************//  \\
int GetPGSDoorTerritory (object oDoor)
{
    string sTag = GetTag (oDoor);

    //--------------------------------------------
    //Return the territory number for the door.
    //--------------------------------------------
    //Example: Territory_Door_1
    return StringToInt (GetStringRight (sTag, (GetStringLength (sTag) - 15)));
}
int GetPGSFlagTerritory (object oFlag)
{
    string sTag = GetTag (oFlag);
    //--------------------------------------------
    //Return the territory number for the flag.
    //--------------------------------------------
    //Example: Territory_Flag_1
    return StringToInt (GetStringRight (sTag, (GetStringLength (sTag) - 15)));
}
int GetPGSMarkerTerritory (object oMarker)
{
    string sTag = GetTag (oMarker);

    //--------------------------------------------
    //Return the territory number for the marker.
    //--------------------------------------------
    //Example: Territory_Marker_1
    return StringToInt (GetStringRight (sTag, (GetStringLength (sTag) - 17)));
}
int GetPGSStorageTerritory (object oChest)
{
    string sTag = GetTag (oChest);

    //--------------------------------------------
    //Return the territory number for the marker.
    //--------------------------------------------
    //Example: Territory_Chest_1
    return StringToInt (GetStringRight (sTag, (GetStringLength (sTag) - 16)));
}

int GetTerritoryGuildNumber (int iTerritory)
{
    if (PGS_USE_BIOWARE_DB)
        return GetCampaignInt (PGS_TERRITORY_DB, "Territory" + IntToString
            (iTerritory) + "_Guild_Number");
    else
        return GetPersistentInt (GetModule(), "Territory" + IntToString
            (iTerritory) + "_Guild_Number", "guild");
}
void SetTerritoryGuildNumber (int iTerritory, int iGuild)
{
    if (PGS_USE_BIOWARE_DB)
        SetCampaignInt (PGS_TERRITORY_DB, "Territory" + IntToString (iTerritory) +
            "_Guild_Number", iGuild);
    else
        SetPersistentInt (GetModule(), "Territory" + IntToString (iTerritory) +
            "_Guild_Number", iGuild, 0, "guild");
}

string GetTerritoryGuildName (int iTerritory)
{
    if (PGS_USE_BIOWARE_DB)
        return GetCampaignString (PGS_TERRITORY_DB, "Territory" + IntToString
            (iTerritory) + "_Name");
    else
        return GetPersistentString (GetModule(), "Territory" + IntToString
            (iTerritory) + "_Name", "guild");
}
void SetTerritoryName (int iTerritory, string sName)
{
    if (PGS_USE_BIOWARE_DB)
        SetCampaignString (PGS_TERRITORY_DB, "Territory" + IntToString
            (iTerritory) + "_Name", sName);
    else
        SetPersistentString (GetModule(), "Territory" + IntToString
            (iTerritory) + "_Name", sName, 0, "guild");
}

int GetMaxTerritoryNumber()
{
    if (PGS_USE_BIOWARE_DB)
        return GetCampaignInt (PGS_TERRITORY_DB, "Max_Territory_Number");
    else
        return GetPersistentInt (GetModule(), "Max_Territory_Number", "guild");
}
void SetMaxTerritoryNumber (int iMaxTerritory)
{
    if (PGS_USE_BIOWARE_DB)
        SetCampaignInt (PGS_TERRITORY_DB, "Max_Territory_Number", iMaxTerritory);
    else
        SetPersistentInt (GetModule(), "Max_Territory_Number", iMaxTerritory,
            0, "guild");
}

int GetGuildTerritoryCount (int iGuild)
{
    if (PGS_USE_BIOWARE_DB)
        return GetCampaignInt (PGS_MODULE_DB, "Module_Guild" + IntToString
            (iGuild) + "_Territory_Count");
    else
        return GetPersistentInt (GetModule(), "Module_Guild" + IntToString
            (iGuild) + "_Territory_Count", "guild");
}
void SetGuildTerritoryCount (int iGuild, int iCount)
{
    if (PGS_USE_BIOWARE_DB)
        SetCampaignInt (PGS_MODULE_DB, "Module_Guild" + IntToString (iGuild) +
            "_Territory_Count", iCount);
    else
        SetPersistentInt (GetModule(), "Module_Guild" + IntToString (iGuild) +
            "_Territory_Count", iCount, 0, "guild");
}

object GetTerritoryStorageCreature (int iTerritory, int nNth)
{
    return RetrieveCampaignObject (PGS_TERRITORY_DB, "Territory" +
        IntToString (iTerritory) + "_Storage" + IntToString (nNth) + "_Creature",
        GetLocation (OBJECT_SELF));
}
void SetTerritoryStorageCreature (int iTerritory, int nNth, object oCreature)
{
    StoreCampaignObject (PGS_TERRITORY_DB, "Territory" +
        IntToString (iTerritory) + "_Storage" + IntToString (nNth) +
        "_Creature", oCreature);
}
//  //********************************************************************\\  \\
//  ||************************* END PGS FUNCTIONS ************************||  \\
//  \\********************************************************************//  \\
