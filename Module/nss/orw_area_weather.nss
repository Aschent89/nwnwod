////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Weather System
//  opw_area_weather
//  By Don Anderson
//  dandersonru@msn.com
//
//  Makes Weather Function in a Module (This is called from the Module Heartbeat
//  Event so this does not need to be placed anywhere)
//
////////////////////////////////////////////////////////////////////////////////

#include "orw_inc_weather"

void main()
{
    object oTVar = OBJECT_SELF;
    string sTVar = GetName(oTVar);
    object oMod  = GetModule();
    object oArea = GetArea(oTVar);
    string sATag = GetTag(oArea);//Each Area Tag Must be Unique!!

    //Dynamic Skyboxes Enabled
    int nSkybox = GetLocalInt(oMod,"WEATHERSKYBOX");

    //Only Natural Areas
    int nNat = GetIsAreaNatural(oArea);
    if(nNat != 1) return;

    //Fog color needs a kick in the rear =D
    int nFSet = GetLocalInt(oArea,"FOGSET");
    if(nFSet == 0)
    {
      SetFogColor(FOG_TYPE_ALL,FOG_MORNING,oArea);
      SetLocalInt(oArea,"FOGSET",1);
    }

    //An Area must be Initialized First
    int nAI = GetLocalInt(oArea,WEATHERINIAREA);
    if(nAI == 0)
    {
      InializeArea(oArea,sTVar);

      //Set Up Matching Areas if Source Waypoint Exists
      string sSource = "SOURCE_" +sATag;
      object oSource = GetNearestObjectByTag(sSource,oTVar,1);
      if(GetIsObjectValid(oSource) == TRUE)
      {
        string sMatch = "MATCH_" +sATag;//Waypoint Must Match the Source Area Tag!!

        //Now we get the areas that have the Matching Weather Waypoint
        int nMth = 0;
        object oMArea;
        object oMatch = GetObjectByTag(sMatch,nMth);
        while(GetIsObjectValid(oMatch))
        {
          oMArea = GetArea(oMatch);
          SetLocalString(oMatch,"WEATHERSOURCE",sATag);
          SetLocalString(oMArea,"WEATHERMATCH",sMatch);
          if(nMth > 50) break;
          nMth++;
          oMatch = GetObjectByTag(sMatch,nMth);
        }
      }
    }

    //Check for Season Change and Intialize Area
    int nIniSeason = GetLocalInt(oArea,WEATHERINISEASON);
    int nCurSeason = GetLocalInt(oArea,WEATHERCURSEASON);
    if(nCurSeason != nIniSeason)
    {
      SetInitializedSeason(oArea);
      InializeArea(oArea,sTVar);
    }

    int nTZ = GetLocalInt(oArea,WEATHERTZONE);
    int nPZ = GetLocalInt(oArea,WEATHERPZONE);
    int nMT = GetLocalInt(oArea,WEATHERMAXTEMP);
    int nWC = GetLocalInt(oArea,WEATHERWATER);
    int nIT = GetLocalInt(oArea,WEATHERINITEMP);
    int nIH = GetLocalInt(oArea,WEATHERINIHUMID);
    int nCW = GetCurrentWeather(oArea);
    int nHour = GetTimeHour();
    int nSeason = GetLocalInt(oArea,WEATHERCURSEASON);
    int nWarm = GetLocalInt(oArea,WEATHERWFRONT);
    int nCold = GetLocalInt(oArea,WEATHERCFRONT);
    int nCT = GetLocalInt(oArea,WEATHERCURTEMP);//Current Temp
    int nHM = GetLocalInt(oArea,WEATHERCURHUMID);//Current Humidity
    int nWet = GetCurrentWeather(oArea);

//:****************************************************************************/
//: WARM AND COLD FRONTS

    int D100 = d100(1);
    int nCF = CheckFront(oArea);
    if(D100 >= 60)
    {
      if(nCF == FALSE) InitializeWarmFront(oArea);
    }
    if(D100 <= 59)
    {
      if(nCF == FALSE) InitializeColdFront(oArea);
    }

//: WARM AND COLD FRONTS
//:****************************************************************************/

//:****************************************************************************/
//: NATURAL HEATING/COOLING CYCLE OF EACH DAY

    //Calc the Heating and Cooling part of the day
    int nHeat = 0;
    if(nHour >= 0 && nHour <=  7) nHeat = 0;
    if(nHour >  7 && nHour <= 16) nHeat = 1;
    if(nHour > 16 && nHour <= 23) nHeat = 0;

    //Warm the Air
    if(nHeat == 1)
    {
      int nMaxR = d3(1) + nMT;
      if(nCT > nMaxR) CoolAirTemp(oArea,nCW,nHeat,nCT);
      else WarmAirTemp(oArea,nCW,nHeat,nCT);
    }

    //Cool the Air
    if(nHeat == 0)
    {
      int nMaxR = nMT - 30;
      if(nCT < nMaxR) WarmAirTemp(oArea,nCW,nHeat,nCT);
      else CoolAirTemp(oArea,nCW,nHeat,nCT);
    }

    //Refresh Current Temp
    nCT = GetLocalInt(oArea,WEATHERCURTEMP);

//: NATURAL HEATING/COOLING CYCLE OF EACH DAY
//:****************************************************************************/

//:****************************************************************************/
//: NATURAL HUMIDITY ACCUMULATION

    //Humidity is Accumulated During the Heating Day and by Area Water Content
    int nIWF = GetLocalInt(oArea,WEATHERWFRONT);
    int nICF = GetLocalInt(oArea,WEATHERCFRONT);
    if(nCF == TRUE && nIWF == 1) nWC = nWC + 5;
    if(nCF == TRUE && nICF == 1) nWC = nWC - 5;

    //Day Humidity During Warm Front
    if(nHeat == 1 && nIWF == 1 && nPZ > 0)
    {
      //The chance to Raise Humidity
      int nHMAdd = d100(1) + nWC;
      if(nHMAdd >= 70) nHM = nHM + 1;
    }

    //Night Humidity During Warm Front
    if(nHeat == 0 && nIWF == 1 && nPZ > 0)
    {
      //The chance to Raise Humidity
      int nHMAdd = d100(1) + nWC;
      if(nHMAdd >= 70) nHM = nHM + 1;
    }

    //Day Humidity During Cold Front (When Not Raining)
    if(nHeat == 1 && nICF == 1 && nPZ > 0 && nWet != WEATHER_RAIN && nWet != WEATHER_SNOW)
    {
      //The chance to Lower Humidity
      int nHMAdd = d100(1) + nWC;
      if(nHMAdd <= 30) nHM = nHM - 1;
    }

    //Night Humidity During Cold Front (When Not Raining)
    if(nHeat == 0 && nICF == 1 && nPZ > 0 && nWet != WEATHER_RAIN && nWet != WEATHER_SNOW)
    {
      //The chance to Lower Humidity
      int nHMAdd = d100(1) + nWC;
      if(nHMAdd <= 30) nHM = nHM - 1;
    }

    //Now Set Our New Humidity
    if(nHM >= 100) nHM = 100;
    if(nHM < 0) nHM = 0;
    if(nPZ > 0) SetLocalInt(oArea,WEATHERCURHUMID,nHM);
    else
    {
      nHM = 0;
      SetLocalInt(oArea,WEATHERCURHUMID,nHM);
    }

//: NATURAL HUMIDITY ACCUMULATION
//:****************************************************************************/

//:****************************************************************************/
//: RAIN AND SETTING WEATHER LEVEL

    //Now Set Up the Weather Level Potential
    //Cold Fronts Will Initiate the Rain
    int nLevel = 0;//Really Clear Sky
    if(nHM >= 20) nLevel = 1;//Normal
    if(nHM >= 30) nLevel = 2;//Cloudy

    //Cold Front
    if(IsInColdFront(oArea) == TRUE && nPZ > 0)
    {
      //Now Set Up the Weather Level Potential
      if(nHM >= 40) nLevel = 3;//Raining/Snowing
      if(nHM >= 60) nLevel = 4;//Thunderstorm No Lightning
      if(nHM >= 80) nLevel = 5;//Thunderstorm With Lightning
    }

    //Spark a Rainstorm
    if(IsInWarmFront(oArea) == TRUE && nPZ > 0 && nHM >= 80)
    {
      nLevel = 3;//Raining/Snowing
      InitializeColdFront(oArea);
    }

    SetLocalInt(oArea,WEATHERLEVEL,nLevel);

    //Only if Dynamic Skyboxes are On
    if(nSkybox == 1)
    {
      //Very Clear Skies
      if(nLevel == 0 && GetSkyBox(oArea) != SKYBOX_DESERT_CLEAR)
      {
        //This Eliminates Skybox Flip Flops
        if(nHM < 15) SetSkyBox(SKYBOX_DESERT_CLEAR,oArea);
      }

      //Party Cloudy Warm Weather Skies
      if(nLevel == 1 && nCT >= 0 && GetSkyBox(oArea) != SKYBOX_GRASS_CLEAR)
      {
        if(GetSkyBox(oArea) == SKYBOX_WINTER_CLEAR || GetSkyBox(oArea) == SKYBOX_ICY)
        {
          if(nHM >= 20 && nHM < 30 && nCT >=5) SetSkyBox(SKYBOX_GRASS_CLEAR,oArea);
        }
        else
        {
          if(nHM >= 20 && nHM < 30) SetSkyBox(SKYBOX_GRASS_CLEAR,oArea);
        }
      }

      //Party Cloudy Cold Weather Skies
      if(nLevel == 1 && nCT < 0 && GetSkyBox(oArea) != SKYBOX_WINTER_CLEAR)
      {
        if(nHM >= 20 && nHM < 30) SetSkyBox(SKYBOX_WINTER_CLEAR,oArea);
      }

      //Stormy Warm Weather Skies
      if(nLevel == 2 && nCT >= 0 && GetSkyBox(oArea) != SKYBOX_GRASS_STORM)
      {
        if(nHM >= 30 && nHM < 40) SetSkyBox(SKYBOX_GRASS_STORM,oArea);

        if(GetSkyBox(oArea) == SKYBOX_ICY || GetSkyBox(oArea) == SKYBOX_WINTER_CLEAR)
        {
          if(nHM >= 30 && nHM < 40 && nCT >=5) SetSkyBox(SKYBOX_GRASS_STORM,oArea);
        }
        else
        {
          if(nHM >= 30 && nHM < 40) SetSkyBox(SKYBOX_GRASS_STORM,oArea);
        }
      }

      //Stormy Cold Weather Skies
      if(nLevel == 2 && nCT < 0 && GetSkyBox(oArea) != SKYBOX_ICY)
      {
        if(nHM >= 30 && nHM < 40) SetSkyBox(SKYBOX_ICY,oArea);
      }

      //Full Clouded
      if(nLevel >= 3 && GetSkyBox(oArea) != SKYBOX_NONE)
      {
        SetSkyBox(SKYBOX_NONE,oArea);
      }
    }

    //Now Check to see if it already Raining or Snowing and Reduce Humidity
    if(nWet == WEATHER_RAIN || nWet == WEATHER_SNOW)
    {
      //We build down by Humidity
      int nHMSub = nHM - 1;
      SetLocalInt(oArea,WEATHERCURHUMID,nHMSub);
    }

//: RAIN AND SETTING WEATHER LEVEL
//:****************************************************************************/

//:****************************************************************************/
//: WHAT TYPE OF FOG

    int nFogLight = FOG_MORNING;
    int nFogMed = FOG_LIGHTRAIN;
    int nFogDark = FOG_STORMCLOUDS;

    //Fog Dynamic Override
    object oFDO = GetNearestObjectByTag("FOG_DYNAMICOVERRIDE",oTVar,1);
    if(oFDO != OBJECT_INVALID)
    {
      string sName = GetName(oFDO);

      if(sName == "Snow")
      {
        nFogLight = FOG_LSNOW;
        nFogMed = FOG_MSNOW;
        nFogDark = FOG_DSNOW;
      }

      if(sName == "Desert")
      {
        nFogLight = FOG_LDESERT;
        nFogMed = FOG_MDESERT;
        nFogDark = FOG_DDESERT;
      }

      if(sName == "Bluish")
      {
        nFogLight = FOG_LBLUISH;
        nFogMed = FOG_MBLUISH;
        nFogDark = FOG_DBLUISH;
      }
    }

    //Is there a Fog Override?
    object oFOver = GetNearestObjectByTag("FOG_OVERRIDE",oTVar,1);
    int nFOver = GetLocalInt(oArea,"FOG_OVERRIDE");
    if(oFOver != OBJECT_INVALID && nFOver == 0)
    {
      string sFOver = GetName(oFOver);
      string sQty = GetStringLeft(sFOver,3);
      string sColor = GetSubString(sFOver,4,3);

      int nColor = FOG_MORNING;//Default

      if(sColor == "Bla") nColor = FOG_COLOR_BLACK;
      if(sColor == "Blu") nColor = FOG_COLOR_BLUE_DARK;
      if(sColor == "Bro") nColor = FOG_COLOR_BROWN_DARK;
      if(sColor == "Gre") nColor = FOG_COLOR_GREEN_DARK;
      if(sColor == "Ora") nColor = FOG_COLOR_ORANGE_DARK;
      if(sColor == "Red") nColor = FOG_COLOR_RED_DARK;
      if(sColor == "Yel") nColor = FOG_COLOR_YELLOW_DARK;
      if(sColor == "Gra") nColor = FOG_LIGHTRAIN;

      int nQty = StringToInt(sQty);

      SetLocalInt(oArea,"FOG_OVERRIDE",1);
      SetFogAmount(FOG_TYPE_ALL,nQty,oArea);
      SetFogColor(FOG_TYPE_ALL,nColor,oArea);
    }

    int nLight = GetIsLight();
    int nFT = 0;
    if(nLight == 0) nFT = FOG_TYPE_SUN;
    if(nLight == 1) nFT = FOG_TYPE_SUN;
    if(nLight == 2) nFT = FOG_TYPE_MOON;

    int nFA = GetFogAmount(nFT,oArea);

//: WHAT TYPE OF FOG
//:****************************************************************************/

//:****************************************************************************/
//: MAKE FOG IN THE MORNING AND EVENING

    int nSI = GetLocalInt(oArea,WEATHERLEVEL);
    int nFO = GetLocalInt(oArea,"FOG_OVERRIDE");

    if(nHour >= 0 && nHour <= 6 && nSI <= 1 && nHM >= 10 && nFO == 0)
    {
      if(nCW != WEATHER_CLEAR) SetWeather(oArea,WEATHER_CLEAR);

      if(nHour >= 0 && nHour <= 6)
      {
        if(nFA <= 15) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);
      }
    }

    if(nHour >= 18 && nHour <= 23 && nSI <= 1 && nHM >= 10 && nFO == 0)
    {
      if(nCW != WEATHER_CLEAR) SetWeather(oArea,WEATHER_CLEAR);

      if(nHour >= 18 && nHour <= 23)
      {
        if(nFA <= 15) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);
      }
    }

//: MAKE FOG IN THE MORNING AND EVENING
//:****************************************************************************/

//:****************************************************************************/
//: MAKE CLOUDS BY WEATHER LEVEL

    //Burn off Morning Fog
    if(nHour >= 7 && nHour <= 17 && nSI <= 1 && nFO == 0)
    {
      if(nCW != WEATHER_CLEAR) SetWeather(oArea,WEATHER_CLEAR);

      //Burn off Fog
      if(nFA > 0) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
    }

    //Cloudy Sky
    if(((nHour >=0 && nHour < 3) || (nHour >= 7 && nHour <= 23)) && nSI == 2 && nFO == 0)
    {
      if(nCW != WEATHER_CLEAR) SetWeather(oArea,WEATHER_CLEAR);

      //Create Clouds
      if(nFA < 5) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);

      //Waver the Cloud Shadow
      if(nFA >= 5 && nFA <= 8)
      {
        int nRC = d2(1);
        if(nRC == 1) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);
        if(nRC == 2) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
      }

      //Build Clouds Back This Stage
      if(nFA > 10) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
    }

    //Raining or Snowing
    if(nHour >= 0 && nSI == 3 && nFO == 0)
    {
      //Create Clouds
      if(nFA < 8) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);

      //Create Rain or Snow
      if(nFA >= 8)
      {
        if(nCW != WEATHER_RAIN && nCT >= 0) SetWeather(oArea,WEATHER_RAIN);
        if(nCW != WEATHER_SNOW && nCT < 0) SetWeather(oArea,WEATHER_SNOW);
      }

      //Waver the Cloud Shadow
      if(nFA >= 8 && nFA <= 12)
      {
        int nRC = d2(1);
        if(nRC == 1) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);
        if(nRC == 2) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
      }

      //Build Clouds Back This Stage
      if(nFA > 12) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
    }

    //Storm with No Lightning
    if(nHour >= 0 && nSI == 4 && nFO == 0)
    {
      //Create Clouds
      if(nFA < 10) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);

      if(nFA >= 8)
      {
        if(nCW != WEATHER_RAIN && nCT >= 0) SetWeather(oArea,WEATHER_RAIN);
        if(nCW != WEATHER_SNOW && nCT < 0) SetWeather(oArea,WEATHER_SNOW);
      }

      //Waver the Cloud Shadow
      if(nFA >= 10 && nFA <= 13)
      {
        int nRC = d2(1);
        if(nRC == 1) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);
        if(nRC == 2) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
      }

      //Build Clouds Back This Stage
      if(nFA > 13) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
    }

    //Storm with Lightning
    if(nHour >= 0 && nSI == 5 && nFO == 0)
    {
      //Create Clouds
      if(nFA < 12) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);

      if(nFA >= 8)
      {
        if(nCW != WEATHER_RAIN && nCT >= 0) SetWeather(oArea,WEATHER_RAIN);
        if(nCW != WEATHER_SNOW && nCT < 0) SetWeather(oArea,WEATHER_SNOW);
      }

      //Waver the Cloud Shadow
      if(nFA >= 12 && nFA <= 15)
      {
        int nRC = d2(1);
        if(nRC == 1) SetCloud(oArea,1,nFogLight,nFogMed,nFogDark);
        if(nRC == 2) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
      }

      //Build Clouds Back This Stage
      if(nFA > 15) SetCloud(oArea,-1,nFogLight,nFogMed,nFogDark);
    }

//: MAKE CLOUDS BY WEATHER LEVEL
//:****************************************************************************/

//:****************************************************************************/
//: MAKE WIND BY WEATHER LEVEL

    object oWindSoft = GetNearestObjectByTag("SoftWind",oTVar);
    object oWindStrong = GetNearestObjectByTag("StrongWind",oTVar);
    int nWindSoft = GetLocalInt(oArea,"WINDSOFT");
    int nWindStrong = GetLocalInt(oArea,"WINDSTRONG");

    //Soft Winds
    if(nSI <= 3 && nWindSoft == 0)
    {
      SoundObjectPlay(oWindSoft);
      SoundObjectStop(oWindStrong);
      SetLocalInt(oArea,"WINDSOFT",1);
      SetLocalInt(oArea,"WINDSTRONG",0);
      nWindSoft = 1;
      nWindStrong = 0;
    }
    //Strong Winds
    if(nSI > 3 && nWindStrong == 0)
    {
      SoundObjectPlay(oWindStrong);
      SoundObjectStop(oWindSoft);
      SetLocalInt(oArea,"WINDSOFT",0);
      SetLocalInt(oArea,"WINDSTRONG",1);
      nWindSoft = 0;
      nWindStrong = 1;
    }

    //Wind Volume Control
    if(nSI == 1 && nWindSoft == 1) SoundObjectSetVolume(oWindSoft, 5);
    if(nSI == 2 && nWindSoft == 1) SoundObjectSetVolume(oWindSoft, 7);
    if(nSI == 3 && nWindSoft == 1) SoundObjectSetVolume(oWindSoft, 10);
    if(nSI == 4 && nWindStrong == 1) SoundObjectSetVolume(oWindStrong, 10);
    if(nSI == 5 && nWindStrong == 1) SoundObjectSetVolume(oWindStrong, 15);

//: MAKE WIND BY WEATHER LEVEL
//:****************************************************************************/

//:****************************************************************************/
//: MAKE THUNDER BY WEATHER LEVEL

    object oThunder = GetNearestObjectByTag("Thunder",oTVar);
    int nThunder = GetLocalInt(oArea,"THUNDER");

    //Stop Thunder
    if(nCW != WEATHER_RAIN && nSI < 3 && nThunder == 1)
    {
      SoundObjectStop(oThunder);
      SetLocalInt(oArea,"THUNDER",1);
    }
    //Start Thunder
    if(nCW == WEATHER_RAIN && nSI >= 3 && nCT >= 0 && nThunder == 0)
    {
      SoundObjectPlay(oThunder);
      SetLocalInt(oArea,"THUNDER",1);
    }

//: MAKE THUNDER BY WEATHER LEVEL
//:****************************************************************************/

//:****************************************************************************/
//: MAKE LIGHTNING BY WEATHER LEVEL

    //Start Lightning
    if(nCW == WEATHER_RAIN && nSI == 5 && nCT >= 0 && nThunder == 1)
    {
      int nAir = d2(1);
      location lStrike = RandomLocation(oArea,nAir);
      LightningStrike(oArea,lStrike,nAir);
    }

//: MAKE LIGHTNING BY WEATHER LEVEL
//:****************************************************************************/

//:****************************************************************************/
//: RESET WEATHER FRONTS

   int nFCount = GetLocalInt(oArea,WEATHERCOUNTER);
   int nSDurat = GetLocalInt(oArea,WEATHERDURATION);

   //Currently in a Weather Front
   if(nCF == TRUE)
   {
     if(nFCount == nSDurat)
     {
       SetLocalInt(oArea,WEATHERAFRONT,0);
       SetLocalInt(oArea,WEATHERWFRONT,0);
       SetLocalInt(oArea,WEATHERCFRONT,0);
       SetLocalInt(oArea,WEATHERCOUNTER,0);
       SetLocalInt(oArea,WEATHERDURATION,0);
     }
   }

//: RESET WEATHER FRONTS
//:****************************************************************************/

//:****************************************************************************/
//: MESSAGES TO PLAYERS IN THE AREA

   int nNth = 1;
   object oPC = GetNearestObject(OBJECT_TYPE_CREATURE,oTVar,nNth);
   while (GetIsObjectValid(oPC) == TRUE)
   {
      if(GetIsPC(oPC) == TRUE || GetIsDM(oPC) == TRUE || GetIsDMPossessed(oPC) == TRUE)
      {
        ExecuteScript("orw_pc_message",oPC);
      }
      nNth++;
      oPC = GetNearestObject(OBJECT_TYPE_CREATURE,oTVar,nNth);
   }

//: MESSAGES TO PLAYERS IN THE AREA
//:****************************************************************************/

//:****************************************************************************/
//: FRONT COUNTER

    //Only Count When a Front is in the Area
    if(nSDurat > 0)
    {
      nFCount = nFCount + 1;
      SetLocalInt(oArea,WEATHERCOUNTER,nFCount);
    }

//: FRONT COUNTER
//:****************************************************************************/

}
