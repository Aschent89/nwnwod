//You can delete this script as it is only for the demo

#include "orw_inc_weather"

void main()
{

   object oPC = GetLastUsedBy();
   object oArea = GetArea(oPC);
   object oSign = OBJECT_SELF;

   string sName = GetName(oSign);
   string sTag = GetTag(oSign);

   int nLight = GetIsLight();
   int nFT = 0;
   if(nLight == 0) nFT = FOG_TYPE_SUN;
   if(nLight == 1) nFT = FOG_TYPE_SUN;
   if(nLight == 2) nFT = FOG_TYPE_MOON;

   if(sName == "Set Fog To Desert")
   {
     SetLocalInt(oArea,"FOG_LIGHT",FOG_LDESERT);
     SetLocalInt(oArea,"FOG_MEDIUM",FOG_MDESERT);
     SetLocalInt(oArea,"FOG_DARK",FOG_DDESERT);

     SpeakString("Desert Colors Set.");
   }

   if(sName == "Set Fog To Snow")
   {
     SetLocalInt(oArea,"FOG_LIGHT",FOG_LSNOW);
     SetLocalInt(oArea,"FOG_MEDIUM",FOG_MSNOW);
     SetLocalInt(oArea,"FOG_DARK",FOG_DSNOW);

     SpeakString("Snow Colors Set.");
   }

   if(sName == "Set Fog To Bluish")
   {
     SetLocalInt(oArea,"FOG_LIGHT",FOG_LBLUISH);
     SetLocalInt(oArea,"FOG_MEDIUM",FOG_MBLUISH);
     SetLocalInt(oArea,"FOG_DARK",FOG_DBLUISH);

     SpeakString("Bluish Colors Set.");
   }

   if(sName == "Set Fog To Default")
   {
     SetLocalInt(oArea,"FOG_LIGHT",FOG_MORNING);
     SetLocalInt(oArea,"FOG_MEDIUM",FOG_LIGHTRAIN);
     SetLocalInt(oArea,"FOG_DARK",FOG_STORMCLOUDS);

     SpeakString("Default Colors Set.");
   }

   if(sName == "Add 10% Humidity")
   {
     int nHM = GetLocalInt(oArea,WEATHERCURHUMID);
     nHM = nHM + 10;
     SetLocalInt(oArea,WEATHERCURHUMID,nHM);

     SpeakString("Humidity Added. Now it is :" + IntToString(nHM)+ "%");
   }

   if(sName == "Remove 10% Humidity")
   {
     int nHM = GetLocalInt(oArea,WEATHERCURHUMID);
     nHM = nHM - 10;
     SetLocalInt(oArea,WEATHERCURHUMID,nHM);

     SpeakString("Humidity Removed. Now it is : " + IntToString(nHM)+ "%");
   }

   if(sName == "Storm Clouds")
   {
     int nFog = GetLocalInt(oArea,"FOG_DARK");
     SetFogColor(nFT,nFog,oArea);
   }

   if(sName == "Light Rain Clouds")
   {
     int nFog = GetLocalInt(oArea,"FOG_MEDIUM");
     SetFogColor(nFT,nFog,oArea);
   }

   if(sName == "Light Morning Fog")
   {
     int nFog = GetLocalInt(oArea,"FOG_LIGHT");
     SetFogColor(nFT,nFog,oArea);
   }

   if(sName == "Lightning")
   {
     int nAir = d2(1);
     location lStrike = RandomLocation(oArea,nAir);
     LightningStrike(oArea,lStrike,nAir);
   }
}
