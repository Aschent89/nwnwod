const string sOwner = "Dawn Walker";

void main()
{
object oPC = GetEnteringObject();

// Explore the area for the player on the map.
ExploreAreaForPlayer(GetArea(GetEnteringObject()), GetEnteringObject());
// Save the start location.
// This script was created by Dawn Walker on Nov.13.2008.
SetCampaignLocation("Nebari", "Unspecified", GetLocation(GetEnteringObject()), GetEnteringObject());

if (GetName(oPC) == sOwner)
    {
        return;
    }
object oSearch = GetFirstPC();
while (GetIsObjectValid(oSearch) == TRUE && GetName(oSearch) != sOwner)
    {
        oSearch = GetNextPC();
    }
if (GetIsObjectValid(oSearch) == TRUE && GetName(oSearch) == sOwner)
    {
        SendMessageToPC(oSearch, GetName(oPC) + " has entered the Abandoned Barracks.");
    }
}
