////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Weather System - Main Include Functions
//  orw_inc_weather
//  By Don Anderson
//  dandersonru@msn.com
//
//  Makes Weather Function in a Module
/*
Custom Waypoint T_VARIABLES (Found in Waypoint Custom Special 1
Number Slots = TVAR_0_0_020_020_N

Temperature Zone (All Degrees in Celsius)
0 - None Weather Off
1 - Tropical   12 Months Warm 20 and Above
2 - Subtropical 8 Months Warm 20 to 30, 4 at 10 Min to 20
3 - Temperate 8 Months 10 to 10 to 20, 4 at 0 to 10
4 - Cold 4 Months 10 to 20, 8 at 10 to -20
5 - Polar 12 Months 10 and Below

Precipitation Class
0 - Arid - No Rain (even if Humidity is set)
1 - Semi Arid - Slight Summer Rain
2 - Arid Oceanic - Slight Winter Rain
3 - Oceanic - Winter Rain, Dry Summer
4 - Tropical - Summer Rain, Dry Winter
5 - Temperatate - Rain in all Seasons

Maximum Temperature for the Area
Default 020
Range -50 to 050 (capped by Temperature Zone)

NOTE: If you do not have a Negative Max you MUST have the zero in front of the temperature.

Area Water Content (in Percent)
Determines Fog and Clouds and helps tweak Precipitation
Default 020
Range 0 to 040

NOTE: More than 40 will make it very likely to rain all the time

Hemisphere
For North or South of Equator
Default N or North
*/
//
////////////////////////////////////////////////////////////////////////////////

//VARIABLE STRINGS USED
const string WEATHERLEVEL   = "WEATHERLEVEL";//Potential of the Current Weather Pattern in an Area
const string WEATHERCURRENT = "WEATHERCURRENT";//The Current Level of Weather in an Area
const string WEATHERDURATION = "WEATHERDURATION";//The Duration of the Current Front
const string WEATHERCOUNTER = "WEATHERCOUNTER";//The Current Count of the Weather Cycle
const string WEATHERTZONE   = "WEATHERTZONE";//This is the Climate Zone of an Area
const string WEATHERPZONE   = "WEATHERPZONE";//This is the Precipitaion Zone of an Area
const string WEATHERMAXTEMP = "WEATHERMAXTEMP";//This is the Maximum Temperature of an Area
const string WEATHERWATER   = "WEATHERWATER";//This is the Water Content % of an Area (Generates Humidity)
const string WEATHERINITEMP = "WEATHERINITEMP";//This is the Initial Temp Variable set on an area based upon season.
const string WEATHERINIHUMID ="WEATHERINIHUMID";//This is the Initial Humidity Variable set on an area based upon season.
const string WEATHERINISEASON = "WEATHERINISEASON";//Current Season
const string WEATHERCURSEASON = "WEATHERCURSEASON";//Current Season
const string WEATHERCURTEMP = "WEATHERCURTEMP";//Current Temp conditions in an Area
const string WEATHERCURHUMID = "WEATHERCURHUMID";//Current Humidity conditions in an Area
const string WEATHERCURFOG  = "WEATHERCURFOG";//Current Fog in Area
const string WEATHERINIAREA = "WEATHERINIAREA";//This is the Area Initialized Indicator
const string WEATHERAFRONT  = "WEATHERAFRONT";//This is the Font Allowed Indicator
const string WEATHERWFRONT  = "WEATHERWFRONT";//This is the Area Warm Front Indicator
const string WEATHERCFRONT  = "WEATHERCFRONT";//This is the Area Cold Front Indicator

//Temperature and Humidity Max Deviations from Initialized
const int TEMPMDCLEAR       = 10;//Weather Type is Clear
const int TEMPMDRAINING     = 3;//Weather Type is Raining
const int TEMPMDSNOW        = 2;//Weather Type is Snowing
const int TEMPMDFRONTOVR    = 5;//Front Over/Under Adder
const int TEMPMDFRONTCHG    = 2;//Front Bonus Change

//Fog Colors Used (Defaults)
const int FOG_MORNING       = 0x949494;//Light Grey
const int FOG_LIGHTRAIN     = 0x7F7F7F;//Medium Grey
const int FOG_STORMCLOUDS   = 0x6B6B6B;//Darker Grey

//Dynamic Overrides
const int FOG_LSNOW         = 0xCDCDCD;//Light Snow/Cold
const int FOG_MSNOW         = 0xBABABA;//Medium Snow/Cold
const int FOG_DSNOW         = 0xA3A3A3;//Darker Snow/Cold

const int FOG_LBLUISH       = 0xB4CDCD;//Light Cool Blue
const int FOG_MBLUISH       = 0x8DB6CD;//Medium Cool Blue
const int FOG_DBLUISH       = 0x4A708B;//Darker Cool Blue

const int FOG_LDESERT       = 0xE7C6A5;//Light Desert
const int FOG_MDESERT       = 0xD2B48C;//Medium Desert
const int FOG_DDESERT       = 0x8C7853;//Darker Desert

//:****************************************************************************/
//: SUPPORT FUNCTIONS

int GetAreaWidth(object oArea)
{
  int nX = 0;
  int nY = 0;
  vector vTile = Vector(0.0, 0.0, 0.0);
  location locTile;
  for (nX = 0; nX < 32; ++nX)
  {
    vTile.x = IntToFloat(nX);
    locTile = Location(oArea, vTile, 0.0);
    int iColor = GetTileMainLight1Color(locTile);
    if (iColor < 0 || iColor > 32) return(nX);
  }
  return 32;
}

int GetAreaHeight(object oArea)
{
  int nX = 0;
  int nY = 0;
  vector vTile = Vector(0.0, 0.0, 0.0);
  location locTile;
  for (nY = 0; nY < 32; ++nY)
  {
    vTile.y = IntToFloat(nY);
    locTile = Location(oArea, vTile, 0.0);
    int iColor = GetTileMainLight1Color(locTile);
    if (iColor < 0 || iColor > 32) return(nY);
  }
  return 32;
}

location RandomLocation(object oArea,int nAir = 1)
{
  location lLoc;
  int nMX = GetAreaWidth(oArea);
  int nMY = GetAreaHeight(oArea);
  int nCX = Random(nMX)*10;
  int nCY = Random(nMY)*10;
  int nDX = Random(10);
  int nDY = Random(10);
  float fDX = IntToFloat(nDX) * 0.1;
  float fDY = IntToFloat(nDY) * 0.1;
  float fCX = IntToFloat(nCX) + fDX;
  float fCY = IntToFloat(nCY) + fDY;
  int nZ;
  float fCZ = 0.0;
  if (nAir == 2)
  {
    nZ = Random(50);
    fCZ = IntToFloat(nZ) * 0.1;
  }
  vector vVec = Vector(fCX,fCY,fCZ);
  lLoc = Location(oArea,vVec,0.0);
  return lLoc;
}

int CountPCsInArea(object oArea = OBJECT_INVALID, int nDM = FALSE)
{
  int retVal = 0;
  if (oArea == OBJECT_INVALID) oArea = GetArea(OBJECT_SELF);
  object oPC = GetFirstPC();
  while (oPC != OBJECT_INVALID)
  {
    if(GetArea(oPC) == oArea)
    {
      if(GetIsDM(oPC) == TRUE || GetIsDMPossessed(oPC) == TRUE)
      {
        if(nDM == TRUE) retVal++;
      }
      else retVal++;
    }
    oPC = GetNextPC();
  }
  return retVal;
}

//: SUPPORT FUNCTIONS
//:****************************************************************************/

//:****************************************************************************/
//: WEATHER EFFECTS AND CHECKS

int GetIsLight()
{
  if (GetIsDay()||GetIsDawn()) return 1;
  else return 2;
}

void SetCloud(object oArea, int nCloud, int nLightColor, int nMediumColor, int nDarkColor)
{
  int nLight = GetIsLight();
  int nSI = GetLocalInt(oArea,WEATHERLEVEL);
  int nColor = nLightColor;
  int nFT = 0;

  if(nLight == 0) nFT = FOG_TYPE_SUN;
  if(nLight == 1) nFT = FOG_TYPE_SUN;
  if(nLight == 2) nFT = FOG_TYPE_MOON;

  int nAFog = GetFogAmount(nFT,oArea);
  if(nSI == 3) nColor = nMediumColor;
  if(nSI >= 4) nColor = nDarkColor;

  int nNFog = nAFog + nCloud;

  SetFogAmount(FOG_TYPE_ALL,nNFog,oArea);
  SetFogColor(FOG_TYPE_ALL,nColor,oArea);
}

void LightningStrike(object oArea, location lStrike, int nAir)
{
  //Lightning Strike Intensity
  int nLN = d100(1);//Bolt Strength
  float fRange = IntToFloat(nLN) * 0.1;//For Sphere of influence
  if(fRange < 3.0) fRange = 3.0;//Min Sphere
  if(fRange < 6.0) fRange = 6.0;//Max Sphere

  //Effects
  effect eEffBolt   = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
  effect eEffDam = EffectDamage(nLN, DAMAGE_TYPE_ELECTRICAL);
  effect eEffKnock = EffectKnockdown();
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffBolt, lStrike);

  //Lightning hits the Ground
  if(nAir == 1)
  {
    int nType;
    int nPain;
    object oObject = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lStrike, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oObject) == TRUE)
    {
      nType = GetObjectType(oObject);
      if(nType == OBJECT_TYPE_CREATURE)
      {
        //Struck by Lightning
        SendMessageToPC(oObject, "You just got stuck by Lightning!");
        PlayVoiceChat(VOICE_CHAT_PAIN1,oObject);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffDam, oObject);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffKnock, oObject, IntToFloat(d6(1)));
      }

      if(nType == OBJECT_TYPE_DOOR || nType == OBJECT_TYPE_PLACEABLE)
      {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffDam, oObject);
      }
      oObject = GetNextObjectInShape(SHAPE_SPHERE, fRange, lStrike, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
  }
}

int GetCurrentWeather(object oArea)
{
  int nCW = GetWeather(oArea);
  return nCW;
}

void SetCurrentSeason(object oArea)
{
   string sH = GetLocalString(oArea,"HEMISPHERE");
   int nSeason = 0;
   int nMonth = GetCalendarMonth();
   if(sH == "Northern")
   {
     if (nMonth < 3 || nMonth == 12) nSeason = 1;
     if (nMonth >= 3 && nMonth < 6) nSeason = 2;
     if (nMonth >= 6 && nMonth < 9) nSeason = 3;
     if (nMonth >= 9 && nMonth < 11) nSeason = 4;

     SetLocalInt(oArea,WEATHERCURSEASON,nSeason);
   }
   if(sH == "Southern")
   {
     if (nMonth < 3 || nMonth == 12) nSeason = 4;
     if (nMonth >= 3 && nMonth < 6) nSeason = 1;
     if (nMonth >= 6 && nMonth < 9) nSeason = 2;
     if (nMonth >= 9 && nMonth < 11) nSeason = 3;

     SetLocalInt(oArea,WEATHERCURSEASON,nSeason);
   }
}

void SetInitializedSeason(object oArea)
{
   string sH = GetLocalString(oArea,"HEMISPHERE");
   int nSeason = 0;
   int nMonth = GetCalendarMonth();
   if(sH == "Northern")
   {
     if (nMonth < 3 || nMonth == 12) nSeason = 1;
     if (nMonth >= 3 && nMonth < 6) nSeason = 2;
     if (nMonth >= 6 && nMonth < 9) nSeason = 3;
     if (nMonth >= 9 && nMonth < 11) nSeason = 4;

     SetLocalInt(oArea,WEATHERINISEASON,nSeason);
   }
   if(sH == "Southern")
   {
     if (nMonth < 3 || nMonth == 12) nSeason = 4;
     if (nMonth >= 3 && nMonth < 6) nSeason = 1;
     if (nMonth >= 6 && nMonth < 9) nSeason = 2;
     if (nMonth >= 9 && nMonth < 11) nSeason = 3;

     SetLocalInt(oArea,WEATHERINISEASON,nSeason);
   }
}

//: WEATHER EFFECTS AND CHECKS
//:****************************************************************************/

//:****************************************************************************/
//: WEATHER FRONTS AND TEMPERATURE CONTROL

int CheckFront(object oArea)
{
   int nICF = GetLocalInt(oArea,WEATHERCFRONT);
   int nIWF = GetLocalInt(oArea,WEATHERWFRONT);
   if(nICF == 1 || nIWF == 1) return TRUE;
   else return FALSE;
}

int IsInWarmFront(object oArea)
{
   int nWP = GetLocalInt(oArea,WEATHERWFRONT);
   if(nWP == 1) return TRUE;
   else return FALSE;
}

int IsInColdFront(object oArea)
{
   int nWP = GetLocalInt(oArea,WEATHERCFRONT);
   if(nWP == 1) return TRUE;
   else return FALSE;
}

void WarmAirTemp(object oArea,int nWeatherType,int nHeat,int nTemp)
{
  int nCW     = nWeatherType;
  int nH      = nHeat;
  int nCT     = nTemp;

  int nIWF    = GetLocalInt(oArea,WEATHERWFRONT);
  int D3      = d3(1);

  if(nIWF == 1)
  {
    if(nCW == WEATHER_CLEAR && D3 >= 1) nCT = nCT + 1;
    if(nCW == WEATHER_RAIN  && D3 >= 2) nCT = nCT + 1;
    if(nCW == WEATHER_SNOW  && D3 == 3) nCT = nCT + 1;
  }
  else
  {
    if(nCW == WEATHER_CLEAR && D3 >= 2) nCT = nCT + 1;
    if(nCW == WEATHER_RAIN  && D3 == 3) nCT = nCT + 1;
    if(nCW == WEATHER_SNOW  && D3 == 3) nCT = nCT + 1;
  }

  SetLocalInt(oArea,WEATHERCURTEMP,nCT);
}

void CoolAirTemp(object oArea,int nWeatherType,int nHeat,int nTemp)
{
  int nCW  = nWeatherType;
  int nH   = nHeat;
  int nCT  = nTemp;

  int nICF = GetLocalInt(oArea,WEATHERCFRONT);
  int D3      = d3(1);

  if(nICF == 1)
  {
    if(nCW == WEATHER_CLEAR && D3 >= 1) nCT = nCT - 1;
    if(nCW == WEATHER_RAIN  && D3 >= 2) nCT = nCT - 1;
    if(nCW == WEATHER_SNOW  && D3 == 3) nCT = nCT - 1;
  }
  else
  {
    if(nCW == WEATHER_CLEAR && D3 >= 2) nCT = nCT - 1;
    if(nCW == WEATHER_RAIN  && D3 == 3) nCT = nCT - 1;
    if(nCW == WEATHER_SNOW  && D3 == 3) nCT = nCT - 1;
  }

  SetLocalInt(oArea,WEATHERCURTEMP,nCT);
}

void InitializeWarmFront(object oArea)
{
   //Check for Current Front
   int nFA = GetLocalInt(oArea,WEATHERAFRONT);
   if(nFA == 1) return;

   //Set Warm Front
   else
   {
     //Minimum Front Duration is 10 Cycles
     int nSD = Random(50) + 1;
     if(nSD < 10) nSD = 10;

     SetLocalInt(oArea,WEATHERWFRONT,1);
     SetLocalInt(oArea,WEATHERCFRONT,0);
     SetLocalInt(oArea,WEATHERAFRONT,1);
     SetLocalInt(oArea,WEATHERCOUNTER,0);
     SetLocalInt(oArea,WEATHERDURATION,nSD);
   }
}

void InitializeColdFront(object oArea)
{
   //Check for Current Front
   int nFA = GetLocalInt(oArea,WEATHERAFRONT);
   if(nFA == 1) return;

   //Set Cold Front
   else
   {
     //Minimum Front Duration is 10 Cycles
     int nSD = Random(50) + 1;
     if(nSD < 10) nSD = 10;

     SetLocalInt(oArea,WEATHERWFRONT,0);
     SetLocalInt(oArea,WEATHERCFRONT,1);
     SetLocalInt(oArea,WEATHERAFRONT,1);
     SetLocalInt(oArea,WEATHERCOUNTER,0);
     SetLocalInt(oArea,WEATHERDURATION,nSD);
   }
}

//: WEATHER FRONTS AND TEMPERATURE CONTROL
//:****************************************************************************/

//:****************************************************************************/
//: AREA SETUP

string TempZone(string sTVar)
{
   string sSL = GetStringLeft(sTVar,6);
   string sSR = GetStringRight(sSL,1);
   return sSR;
}

string PrecipZone(string sTVar)
{
   string sSL = GetStringLeft(sTVar,8);
   string sSR = GetStringRight(sSL,1);
   return sSR;
}

string MaxTemp(string sTVar)
{
   string sSL = GetStringLeft(sTVar,12);
   string sSR = GetStringRight(sSL,3);
   return sSR;
}

string WaterContent(string sTVar)
{
   string sSL = GetStringLeft(sTVar,16);
   string sSR = GetStringRight(sSL,3);
   return sSR;
}

string Hemisphere(string sTVar)
{
   string sSR = GetStringRight(sTVar,1);
   string sRet = sSR;

   if(sRet != "N" || sRet != "S") return sRet = "N";//Default
   else return sRet;
}

//This is Run if the Area has not been set up yet
void InializeArea(object oArea,string sTVar)
{
  string sTZ = TempZone(sTVar);
  int nTZ = StringToInt(sTZ);
  if(nTZ < 0 || nTZ > 5) nTZ = 0;//Default
  SetLocalInt(oArea,WEATHERTZONE,nTZ);

  string sPZ = PrecipZone(sTVar);
  int nPZ = StringToInt(sPZ);
  if(nPZ < 0 || nPZ > 5) nPZ = 0;//Default
  SetLocalInt(oArea,WEATHERPZONE,nPZ);

  string sMT = MaxTemp(sTVar);
  int nMT = StringToInt(sMT);
  if(nMT < -50 || nMT > 50) nMT = 20;//Default
  SetLocalInt(oArea,WEATHERMAXTEMP,nMT);

  string sWC = WaterContent(sTVar);
  int nWC = StringToInt(sWC);
  if(nWC < 0 || nWC > 40) nWC = 20;//Default
  SetLocalInt(oArea,WEATHERWATER,nWC);

  string sH = Hemisphere(sTVar);
  if(sH == "N") sH = "Northern";
  if(sH == "S") sH = "Southern";
  SetLocalString(oArea,"HEMISPHERE",sH);

  //Now we can Initialize the Season
  SetInitializedSeason(oArea);

  int nSeason = GetLocalInt(oArea,WEATHERINISEASON);
  int nCT = 0;//Current Temp
  int nHM = 0;//Current Humidity

  //0 - None Weather Off
  if(nTZ == 0)
  {
    if(nSeason == 1) nCT = 0;
    if(nSeason == 2) nCT = 0;
    if(nSeason == 3) nCT = 0;
    if(nSeason == 4) nCT = 0;
  }
  //1 - Tropical 12 Months Warm 20 and Above
  if(nTZ == 1)
  {
    int nRT = d6(1);
    if(nSeason == 1) nCT = nMT - (nRT * 2);
    if(nSeason == 2) nCT = nMT - nRT;
    if(nSeason == 3) nCT = nMT;
    if(nSeason == 4) nCT = nMT - nRT;
    if(nCT < 20) nCT = 20;
  }
  //2 - Subtropical 8 Months Warm 20 to 30, 4 at 10 Min to 20
  if(nTZ == 2)
  {
    int nRT = d6(1);
    if(nMT > 30) nMT = 30;
    if(nSeason == 1) nCT = nMT - (nRT * 2);
    if(nSeason == 2) nCT = nMT - nRT;
    if(nSeason == 3) nCT = nMT;
    if(nSeason == 4) nCT = nMT - nRT;
    if(nCT < 10) nCT = 10;
  }
  //3 - Temperate 8 Months 10 to 20, 4 at 0 to 10
  if(nTZ == 3)
  {
    int nRT = d6(1);
    if(nMT > 20) nMT = 20;
    if(nSeason == 1) nCT = nMT - (nRT * 2);
    if(nSeason == 2) nCT = nMT - nRT;
    if(nSeason == 3) nCT = nMT;
    if(nSeason == 4) nCT = nMT - nRT;
    if(nCT < 0) nCT = 0;
  }
  //4 - Cold 4 Months 10 to 20, 8 at 10 to -20
  if(nTZ == 4)
  {
    int nRT = d6(1);
    if(nMT > 20) nMT = 20;
    if(nSeason == 1) nCT = nMT - (nRT * 2);
    if(nSeason == 2) nCT = nMT - nRT;
    if(nSeason == 3) nCT = nMT;
    if(nSeason == 4) nCT = nMT - nRT;
    if(nCT < -20) nCT = -20;
  }
  //5 - Polar 12 Months 10 and Below
  if(nTZ == 5)
  {
    int nRT = d6(1);
    if(nMT > 10) nMT = 10;
    if(nSeason == 1) nCT = nMT - (nRT * 2);
    if(nSeason == 2) nCT = nMT - nRT;
    if(nSeason == 3) nCT = nMT;
    if(nSeason == 4) nCT = nMT - nRT;
    if(nCT < -50) nCT = -50;
  }
  //0 - Arid - No Rain (even if Humidity is set)
  if(nPZ == 0)
  {
    if(nWC > 0) nWC = 0;
    if(nSeason == 1) nHM = nWC;
    if(nSeason == 2) nHM = nWC;
    if(nSeason == 3) nHM = nWC;
    if(nSeason == 4) nHM = nWC;
  }
  //1 - Semi Arid - Slight Summer Rain
  if(nPZ == 1)
  {
    if(nWC > 10) nWC = 10;
    if(nSeason == 1) nHM = nWC - 10;
    if(nSeason == 2) nHM = nWC;
    if(nSeason == 3) nHM = nWC + 5;
    if(nSeason == 4) nHM = nWC - 5;
  }
  //2 - Arid Oceanic - Slight Winter Rain
  if(nPZ == 2)
  {
    if(nWC > 10) nWC = 10;
    if(nSeason == 1) nHM = nWC + 5;
    if(nSeason == 2) nHM = nWC - 5;
    if(nSeason == 3) nHM = nWC - 10;
    if(nSeason == 4) nHM = nWC;
  }
  //3 - Oceanic - Winter Rain, Dry Summer
  if(nPZ == 3)
  {
    if(nWC > 40) nWC = 40;
    if(nSeason == 1) nHM = nWC;
    if(nSeason == 2) nHM = nWC - 15;
    if(nSeason == 3) nHM = nWC - 30;
    if(nSeason == 4) nHM = nWC - 10;
  }
  //4 - Tropical - Summer Rain, Dry Winter
  if(nPZ == 4)
  {
    if(nWC > 40) nWC = 40;
    if(nSeason == 1) nHM = nWC - 30;
    if(nSeason == 2) nHM = nWC - 5;
    if(nSeason == 3) nHM = nWC + 5;
    if(nSeason == 4) nHM = nWC - 5;
  }
  //5 - Temperatate - Rain in all Seasons
  if(nPZ == 5)
  {
    if(nWC > 40) nWC = 40;
    if(nSeason == 1) nHM = nWC - 10;
    if(nSeason == 2) nHM = nWC + 5;
    if(nSeason == 3) nHM = nWC + 10;
    if(nSeason == 4) nHM = nWC - 5;
  }
  //Make Sure We Have No Negatives
  if(nHM < 0) nHM = 0;

  SetCloud(oArea,0,FOG_MORNING,FOG_LIGHTRAIN,FOG_STORMCLOUDS);
  SetLocalInt(oArea,WEATHERINITEMP,nCT);
  SetLocalInt(oArea,WEATHERCURTEMP,nCT);
  SetLocalInt(oArea,WEATHERINIHUMID,nHM);
  SetLocalInt(oArea,WEATHERCURHUMID,nHM);
  SetLocalInt(oArea,WEATHERCURSEASON,nSeason);
  SetLocalInt(oArea,WEATHERINIAREA, 1);
}

//: AREA SETUP
//:****************************************************************************/

//void main(){}
