//::///////////////////////////////////////////////
//:: Name: pgs_terr_plc_ou
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnUsed script for Territory Flags, and Markers.
*/
//:://////////////////////////////////////////////
//:: Created By: Samius Maximus
//:: Created On:
//:://////////////////////////////////////////////
#include "inc_gsystem_terr"

void main()
{
    object oPlayer = GetLastUsedBy();
    int iTerritory;

    //--------------------------------------------
    //Determine if a Territory Marker was used.
    //--------------------------------------------
    if (GetResRef (OBJECT_SELF) == "territorymarker")
    {
        iTerritory = GetPGSMarkerTerritory (OBJECT_SELF);
        SetLocalInt (oPlayer, "Territory_Marker_Used", TRUE);
    }
    else  /*Territory flag was used.*/
    {
        iTerritory = GetPGSFlagTerritory (OBJECT_SELF);
        SetLocalInt (oPlayer, "Territory_Marker_Used", FALSE);
    }

    //--------------------------------------------
    //Check status for the selected territory.
    //--------------------------------------------
    if (GetTerritoryGuildNumber (iTerritory) > 0)
        SetCustomToken (4001, "claimed");
    else
        SetCustomToken (4001, "unclaimed");

    SetLocalInt (oPlayer, "Territory_Number", iTerritory);
    ActionStartConversation (oPlayer, "pgs_territory", TRUE, FALSE);
}
