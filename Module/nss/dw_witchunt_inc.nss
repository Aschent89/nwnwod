//::///////////////////////////////////////////////
//:: Witchunter Functions Include
//:: dw_witchunt_inc
//:://////////////////////////////////////////////
/*
  Holds all the work horse functions.
*/
//:://////////////////////////////////////////////
//:: Created By: Dreamwarder
//:: Created On: 28/7/03
//:://////////////////////////////////////////////

/////////////////////
//:: CONSTANT LIST
/////////////////////

   string DW_DATABASE = "WITCHUNT_AREAS";

/////////////////////
//:: FUNCTION LIST
/////////////////////

// Take the area's name and return the Witchunter object in the area
object GetWitchuntObjectByAreaName(string sArea);

// Store all valid teleport areas in the database file
void InitializeWitchunterAreas();


// ----- The library ----- //

void InitializeWitchunterAreas()
{
   DestroyCampaignDatabase(DW_DATABASE);
   int nArea = 0;
   object oWH = GetObjectByTag("WITCHUNTAREA", nArea);
   object oArea;
   string sName;

   while(GetIsObjectValid(oWH))
   {
      oArea = GetArea(oWH);
      sName = GetStringUpperCase(GetName(oArea));
      SetCampaignLocation(DW_DATABASE,sName+"loc",GetLocation(oWH));
      SetCampaignInt(DW_DATABASE,sName+"int",nArea);
      nArea++;
      oWH = GetObjectByTag("WITCHUNTAREA", nArea);
   }
   SetCampaignInt(DW_DATABASE,"WITCHUNT_COUNT",nArea);
}

object GetWitchuntObjectByAreaName(string sArea)
{
   sArea = GetStringUpperCase(sArea);
   location loc = GetCampaignLocation(DW_DATABASE,sArea+"loc");
   int nArea = GetCampaignInt(DW_DATABASE,sArea+"int");
   object oWH = GetObjectByTag("WITCHUNTAREA", nArea);
   object oFound;

   if(GetArea(oWH)==GetAreaFromLocation(loc)) oFound = oWH;

   return oFound;
}
