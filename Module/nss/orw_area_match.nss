////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Weather System
//  opw_area_match
//  By Don Anderson
//  dandersonru@msn.com
//
//  Matches Weather from a Source Area
//
////////////////////////////////////////////////////////////////////////////////

#include "orw_inc_weather"

void Weather(object oArea)
{
    object oMod  = GetModule();
    string sMatch = GetLocalString(oArea,"WEATHERMATCH");
    object oMatch = GetLocalObject(oArea,"WEATHER_MATCHWP");
    string sATag = GetTag(oArea);
    int nHour = GetTimeHour();

    //Shut Down Macthed Weather Areas With No PC/DM
    int nClient = CountPCsInArea(oArea, TRUE);
    if(nClient == 0)
    {
      SetLocalInt(oMatch,"MATCHRUNNING",0);
      return;
    }

    //Check to See if this Area is Already Running
    int nMRun = GetLocalInt(oMatch,"MATCHRUNNING");
    if(nMRun == 0) SetLocalInt(oMatch,"MATCHRUNNING",1);

    //Dynamic Skyboxes Enabled
    int nSkybox = GetLocalInt(oMod,"WEATHERSKYBOX");

    //Weather Cycle Time
    int nMPH = GetLocalInt(oMod,"WEATHERCYCLE");
    int nCycle = nMPH * 60;
    nCycle = nCycle/2;
    float fCycle = IntToFloat(nCycle) * 6.0;

    //Set for HTF System
    SetLocalString(oArea,"MATCHTAG",sMatch);

    //Fog color needs a kick in the rear =D
    int nFSet = GetLocalInt(oArea,"FOGSET");
    if(nFSet == 0)
    {
      SetFogColor(FOG_TYPE_ALL,FOG_MORNING,oArea);
      SetLocalInt(oArea,"FOGSET",1);
    }

    //Only Natural Areas
    int nNat = GetIsAreaNatural(oArea);
    if(nNat != 1) return;

//:****************************************************************************/
//: WHAT TYPE OF FOG

    //Is there a Fog Override?
    object oFOver = GetNearestObjectByTag("FOG_OVERRIDE",oMatch,1);
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

//: WHAT TYPE OF FOG
//:****************************************************************************/

//:****************************************************************************/
//: WEATHER SOURCE AREA

    //Get Source Area
    string sSource = GetLocalString(oMatch,"WEATHERSOURCE");
    object oSource = GetObjectByTag(sSource);

    //Get Source Area Information
    int nTZ = GetLocalInt(oSource,WEATHERTZONE);
    int nMT = GetLocalInt(oSource,WEATHERMAXTEMP);
    int nPZ = GetLocalInt(oSource,WEATHERPZONE);
    int nWC = GetLocalInt(oSource,WEATHERWATER);
    int nCT = GetLocalInt(oSource,WEATHERCURTEMP);
    int nHM = GetLocalInt(oSource,WEATHERCURHUMID);
    int nWarm = GetLocalInt(oSource,WEATHERWFRONT);
    int nCold = GetLocalInt(oSource,WEATHERCFRONT);
    int nFCount = GetLocalInt(oSource,WEATHERCOUNTER);
    int nSDurat = GetLocalInt(oSource,WEATHERDURATION);
    int nLevel = GetLocalInt(oSource,WEATHERLEVEL);
    int nCW = GetWeather(oSource);
    SetWeather(oArea,nCW);
    int nFAS = GetFogAmount(nFT,oSource);
    int nFCS = GetFogColor(nFT,oSource);

    //Update this Area For Player Messages
    SetLocalInt(oArea,WEATHERTZONE,nTZ);
    SetLocalInt(oArea,WEATHERMAXTEMP,nMT);
    SetLocalInt(oArea,WEATHERPZONE,nPZ);
    SetLocalInt(oArea,WEATHERWATER,nWC);
    SetLocalInt(oArea,WEATHERLEVEL,nLevel);
    SetLocalInt(oArea,WEATHERCURTEMP,nCT);//Current Temp
    SetLocalInt(oArea,WEATHERCURHUMID,nHM);//Current Humidity
    SetLocalInt(oArea,WEATHERWFRONT,nWarm);
    SetLocalInt(oArea,WEATHERCFRONT,nCold);
    SetLocalInt(oArea,WEATHERCOUNTER,nFCount);
    SetLocalInt(oArea,WEATHERDURATION,nSDurat);

//: WEATHER MATCHING AREAS
//:****************************************************************************/

//:****************************************************************************/
//: SKY BOXES

    //Now Check the Area for Humidity
    if(nHM > 100) nHM = 100;//Not more than 100% Humidity

    //Only if Dynamic Skyboxes are on and PC/DM is in the area
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

//: SKY BOXES
//:****************************************************************************/

//:****************************************************************************/
//: MAKE FOG/CLOUDS PER SOURCE AREA

    int nFO = GetLocalInt(oArea,"FOG_OVERRIDE");
    if(nFO == 0)
    {
      SetFogAmount(FOG_TYPE_ALL,nFAS,oArea);
      SetFogColor(FOG_TYPE_ALL,nFCS,oArea);
    }

//: MAKE FOG/CLOUDS PER SOURCE AREA
//:****************************************************************************/

//:****************************************************************************/
//: MAKE WIND BY WEATHER LEVEL

    object oWindSoft = GetNearestObjectByTag("SoftWind",oMatch);
    object oWindStrong = GetNearestObjectByTag("StrongWind",oMatch);
    int nWindSoft = GetLocalInt(oArea,"WINDSOFT");
    int nWindStrong = GetLocalInt(oArea,"WINDSTRONG");

    //Soft Winds
    if(nLevel <= 3 && nWindSoft == 0)
    {
      SoundObjectPlay(oWindSoft);
      SoundObjectStop(oWindStrong);
      SetLocalInt(oArea,"WINDSOFT",1);
      SetLocalInt(oArea,"WINDSTRONG",0);
      nWindSoft = 1;
      nWindStrong = 0;
    }
    //Strong Winds
    if(nLevel > 3 && nWindStrong == 0)
    {
      SoundObjectPlay(oWindStrong);
      SoundObjectStop(oWindSoft);
      SetLocalInt(oArea,"WINDSOFT",0);
      SetLocalInt(oArea,"WINDSTRONG",1);
      nWindSoft = 0;
      nWindStrong = 1;
    }

    //Wind Volume Control
    if(nLevel == 1 && nWindSoft == 1) SoundObjectSetVolume(oWindSoft, 5);
    if(nLevel == 2 && nWindSoft == 1) SoundObjectSetVolume(oWindSoft, 7);
    if(nLevel == 3 && nWindSoft == 1) SoundObjectSetVolume(oWindSoft, 10);
    if(nLevel == 4 && nWindStrong == 1) SoundObjectSetVolume(oWindStrong, 10);
    if(nLevel == 5 && nWindStrong == 1) SoundObjectSetVolume(oWindStrong, 15);

//: MAKE WIND BY WEATHER LEVEL
//:****************************************************************************/

//:****************************************************************************/
//: MAKE THUNDER BY WEATHER LEVEL

    object oThunder = GetNearestObjectByTag("Thunder",oMatch);
    int nThunder = GetLocalInt(oArea,"THUNDER");

    //Stop Thunder
    if(nCW != WEATHER_RAIN && nLevel < 3 && nThunder == 1)
    {
      SoundObjectStop(oThunder);
      SetLocalInt(oArea,"THUNDER",1);
    }
    //Start Thunder
    if(nCW == WEATHER_RAIN && nLevel >= 3 && nCT >= 0 && nThunder == 0)
    {
      SoundObjectPlay(oThunder);
      SetLocalInt(oArea,"THUNDER",1);
    }

//: MAKE THUNDER BY WEATHER LEVEL
//:****************************************************************************/

//:****************************************************************************/
//: MAKE LIGHTNING BY WEATHER LEVEL

    //Start Lightning
    if(nCW == WEATHER_RAIN && nLevel == 5 && nCT >= 0 && nThunder == 1)
    {
      int nAir = d2(1);
      location lStrike = RandomLocation(oArea,nAir);
      LightningStrike(oArea,lStrike,nAir);
    }

//: MAKE LIGHTNING BY WEATHER LEVEL
//:****************************************************************************/

//:****************************************************************************/
//: MESSAGES TO PLAYERS IN THE AREA

    int nNth = 1;
    object oPC = GetNearestObject(OBJECT_TYPE_CREATURE,oMatch,nNth);
    while(GetIsObjectValid(oPC) == TRUE)
    {
      if(GetIsPC(oPC) == TRUE || GetIsDM(oPC) == TRUE || GetIsDMPossessed(oPC) == TRUE)
      {
        ExecuteScript("orw_pc_message",oPC);
      }
      nNth++;
      oPC = GetNearestObject(OBJECT_TYPE_CREATURE,oMatch,nNth);
    }

//: MESSAGES TO PLAYERS IN THE AREA
//:****************************************************************************/

    DelayCommand(fCycle,Weather(oArea));
}

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    string sMatch = GetLocalString(oArea,"WEATHERMATCH");

    //Only For DMs and Players
    int nProcess = FALSE;
    if(GetIsPC(oPC)) nProcess = TRUE;
    if(GetIsDM(oPC)) nProcess = TRUE;
    if(GetIsDMPossessed(oPC)) nProcess = TRUE;
    if(nProcess == FALSE) return;

    if(sMatch == "") return;
    object oMatch = GetNearestObjectByTag(sMatch,oPC,1);

    //Check to See if this Area is Already Running
    int nMRun = GetLocalInt(oMatch,"MATCHRUNNING");
    if(nMRun == 1) return;

    //No Match No Weather
    if(GetIsObjectValid(oMatch) == FALSE) return;
    SetLocalObject(oArea,"WEATHER_MATCHWP",oMatch);

    DelayCommand(0.5,Weather(oArea));
}
