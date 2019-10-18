////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - HTF and Cold Effects
//  ohtf_rate
//  By Don Anderson
//  dandersonru@msn.com
//
//  Makes the Player Hunger, Thirst, and Fatigue based on a multitude of input
//  values.
//
/*
  ORSv4 NEW!!
  NBDE Added for DB persistency. Item DB Storage has become flaky. The Player list
  is cycled through at Module Defined Intervals (ors_mod_onload). Very robust.
  Weather Information is given from Olander's Realistic Weather or the set up
  F_INTENSITY and C_INTENSITY waypoints as Static Temps.

  Added HTF Reversal Rates (Capped at 25) for being in a Resting Trigger or Near
  a Bedroll and/or Tent.

  Please see the ORS Builder's Guide for detailed Info and Setup.

  FRENCH NWN (And Possibly Others too)
  KNOWN ISSUE:
  Seems that with the French Version os NWN the -20 or 'Minus' Whatever will not
  be a valid Name. I guess the Negative Sign can not be used in the Name Field.

  If you place the C_INTENSITY Waypoint in an Area and DON'T CHANGE the name you
  can set a variable on the Area =>
  C_INTENSITY    int   -20

  The scripts will pick up the Variable as -20 now or whatever Temp you place in there! COOL
*/
//
////////////////////////////////////////////////////////////////////////////////

#include "ohtf_inc"

void main()
{
  object oPC          = OBJECT_SELF;
  object oMod         = GetModule();
  string sDB          = ORS_GetDBString();
  object oArea        = GetArea(oPC);
  string sATag        = GetTag(oArea);
  object oTVar        = GetNearestObjectByTag("T_VARIABLES",oPC);
  object oDiff        = GetNearestObjectByTag("F_INTENSITY",oPC);
  object oCold        = GetNearestObjectByTag("C_INTENSITY",oPC);

  //For Matched Weather Areas
  string sMatch       = GetLocalString(oArea,"MATCHTAG");
  object oMatch       = GetNearestObjectByTag(sMatch,oPC);

  int nCDefault       = StringToInt(GetName(oDiff));//This is the default Celsius Temp and Difficulty Value
  int nCelsius        = GetLocalInt(oArea,"WEATHERCURTEMP");
  float fBuffer       = GetLocalFloat(oMod,"BUFFER");

  string sFLocal      = "F_INTENSITY";
  string sCLocal      = "C_INTENSITY";

  int nHungerHP       = GetLocalInt(oMod,HTFHUNGER);
  int nThirstHP       = GetLocalInt(oMod,HTFTHIRST);
  int nFatigueHP      = GetLocalInt(oMod,HTFFATIGUE);
  int nHUNGERSYSTEM   = GetLocalInt(oMod,"HUNGERSYSTEM");
  int nFATIGUESYSTEM  = GetLocalInt(oMod,"FATIGUESYSTEM");
  int nCONBASEDHEAL   = GetLocalInt(oMod,"CONBASEDHEAL");
  int nLoopCount      = GetLocalInt(oPC,"LOOPCOUNT");

  object oFire1       = GetNearestObjectByTag("campfire",oPC,1);
  object oFire2       = GetNearestObjectByTag("cook_spit",oPC,1);
  object oFire3       = GetNearestObjectByTag("cook_pot",oPC,1);

  object oArmor       = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
  object oHelm        = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
  object oCloak       = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
  object oWeapon      = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  object oLHand       = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
  object oBoots       = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);

  string sArmor       = GetTag(oArmor);
  string sCloak       = GetTag(oCloak);
  string sHelm        = GetTag(oHelm);
  string sBoots       = GetTag(oBoots);

//:: HTF Variables
  int nIntensity      =  GetLocalInt(oPC,sFLocal);
  int nNight          = -3; //This is the Night Reduction to Area Intensity
  int nRain           =  1; //This is the Raining Adder to Area Intensity
  int nSnow           =  2; //This is the Raining Adder to Area Intensity
  int nCombat         = nIntensity * 1; //This is the Combat Adder to Area Intensity
  int nNArmor         =  0; //0% Adder to Area Intensity
  int nCArmor         =  1; //1-19% Adder to Area Intensity
  int nLArmor         =  1; //20-39% Adder to Area Intensity
  int nMArmor         =  2; //40-59% Adder to Area Intensity
  int nHArmor         =  2; //60-79% Adder to Area Intensity
  int nVHArmor        =  3; //80-100% Adder to Area Intensity
  int nHWeapon        =  1; //Heavy Weapons
  int nMWeapon        =  1; //Medium Weapons
  int nLWeapon        =  0; //Light Weapons
  int nHelm           =  0; //Helm Adder to Area Intensity
  int nLCloak         =  0; //Light Cloak Adder to Area Intensity
  int nMCloak         =  0; //Medium Cloak Adder to Area Intensity
  int nHCloak         =  0; //Heavy Cloak Adder to Area Intensity
  int nTorch          =  0; //Equiped Torch Type Item Adder
  float fHMult        =  1.0; //Hunger % of the total nTotalIntensity. Use to vary rate of Hunger
  float fTMult        =  1.0; //Thirst % of the total nTotalIntensity. Use to vary rate of Thirst
  float fFMult        =  1.0; //Fatigue % of the total nTotalIntensity. Use to vary rate of Fatigue

//:: Cold Effect Variables
  int nCIntensity     = GetLocalInt(oPC,sCLocal);
  int nCNight         =  5; //This is the Night Adder to Cold
  int nCNArmor        =  1; //Bare Skin Reduction from Cold
  int nCCArmor        =  1; //Clothing Armor Reduction from Cold
  int nCLArmor        =  2; //Light Armor Reduction from Cold
  int nCMArmor        =  3; //Medium Armor Reduction from Cold
  int nCHArmor        =  3; //Heavy Armor Reduction from Cold
  int nCHelm          =  3; //Helm Reduction from Cold
  int nCLCloak        =  1; //Light Cloak Reduction from Cold
  int nCMCloak        =  2; //Medium Cloak Reduction from Cold
  int nCHCloak        =  3; //Heavy Cloak Reduction from Cold
  int nCTorch         =  3; //Equiped Torch, Lantern, Open Lantern
  int nWhood          =  5; //Winter Hood Reduction from Cold
  int nWBoots         =  5; //Winter Boots Reduction from Cold
  int nWLight         =  5; //Winter Light Clothing Reduction from Cold
  int nWMedium        =  7; //Winter Medium Clothing from Cold
  int nWHeavy         =  9; //Winter Heavy Clothing from Cold

/******************************************************************************/
//:: HTF Reversal Mode (Resting Allowed and Bedrolls and Tents)

  int nRevMode = FALSE;

  //In Resting Trigger
  int nRest = GetLocalInt(oPC, "REST_ALLOWED");
  if(nRest == TRUE) nRevMode = TRUE;

  //Near a Bedroll
  object oBedroll = GetNearestObjectByTag("Bedroll",oPC,1);
  if(GetIsObjectValid(oBedroll) == TRUE
    && GetDistanceBetween(oPC,oBedroll) < 3.0
    && GetObjectType(oBedroll) == OBJECT_TYPE_PLACEABLE)
  {
    nRevMode = TRUE;
  }

  //Near a Tent
  object oTent = GetNearestObjectByTag("Tent",oPC,1);
  if(GetIsObjectValid(oTent) == TRUE
    && GetDistanceBetween(oPC,oTent) < 4.0
    && GetObjectType(oTent) == OBJECT_TYPE_PLACEABLE)
  {
    nRevMode = TRUE;
  }

//:: HTF Reversal Mode (Resting Allowed and Bedrolls and Tents)
/******************************************************************************/

/******************************************************************************/
//:: REALISTIC WEATHER SYSTEM

  //Realistic Weather System
  int nWEATHERGLOBAL = GetLocalInt(oMod,"WEATHERGLOBAL");
  if(nWEATHERGLOBAL == 1)
  {
    if(sMatch == "") oMatch = OBJECT_INVALID;

    //Sets the Celsius Temperature to Default if T_VARIABLES is not present
    if(oTVar == OBJECT_INVALID)
    {
      if(oMatch == OBJECT_INVALID) nCelsius = nCDefault;
    }
  }
  else nCelsius = nCDefault;

  //Sets the Area Difficulty Value ( 20 is Minimum )
  if(GetIsObjectValid(oDiff))
  {
    if(nCDefault > nCelsius) SetLocalInt(oPC,sFLocal,nCDefault);
    else SetLocalInt(oPC,sFLocal,nCelsius);
  }
  else SetLocalInt(oPC,sFLocal,20);

  //Sets the Cold Temperature of an Area IF T_VARIABLES or MATCH_ is not present
  if(GetIsObjectValid(oCold)
    && !GetIsObjectValid(oTVar)
    && !GetIsObjectValid(oMatch))
  {
    //Value On Area Can be Used Now (For French Users)
    if(GetName(oCold) == "C_INTENSITY")
    {
      int nCold = GetLocalInt(oArea,"C_INTENSITY");
      SetLocalInt(oPC,sCLocal,nCold);
      nCelsius = nCold;
    }
    else
    {
      int nCold = StringToInt(GetName(oCold));
      SetLocalInt(oPC,sCLocal,nCold);
      nCelsius = nCold;
    }
  }
  else SetLocalInt(oPC,sCLocal,0);//Default Cold Temp

  //Current or Changed Area
  /*
     This Says a Message as to what the Area Temp is Like
     When the Area Tags have Changed.
  */
  string sOArea = GetLocalString(oPC,"AREA_CURRENT");
  if(sATag != sOArea)
  {
    SetLocalString(oPC,"AREA_CURRENT",sATag);

    //Indoor or Outdoor?
    int nNat = GetIsAreaNatural(oArea);

    //Underwater
    object oUWWP = GetNearestObjectByTag("Underwater",oPC);
    if(GetIsObjectValid(oUWWP))
    {
      SendMessageToPC(oPC, UNDERWATER);
    }
    //Outdoor
    else if(nNat == AREA_NATURAL)
    {
      //Now say the proper text for travel info
      if (nCelsius < -30) SendMessageToPC(oPC, COLDCOLDEST);
      if ((nCelsius > -30) && (nCelsius <= -20)) SendMessageToPC(oPC, COLDCOLDER);
      if ((nCelsius > -20) && (nCelsius <= -10)) SendMessageToPC(oPC, COLDCOLD);
      if ((nCelsius > -10) && (nCelsius <= 0)) SendMessageToPC(oPC, COLDMILD);
      if ((nCelsius > 0) && (nCelsius <= 15)) SendMessageToPC(oPC, HEATMILD);
      if ((nCelsius > 15) && (nCelsius <= 25)) SendMessageToPC(oPC, HEATWARM);
      if ((nCelsius > 25) && (nCelsius <= 35)) SendMessageToPC(oPC, HEATWARMER);
      if (nCelsius > 35) SendMessageToPC(oPC, HEATWARMEST);
    }
    else
    {
      //Now say the proper text for travel info
      if (nCelsius < -30)SendMessageToPC(oPC, INDOORCOLDEST);
      if ((nCelsius > -30) && (nCelsius <= -20)) SendMessageToPC(oPC, INDOORCOLDER);
      if ((nCelsius > -20) && (nCelsius <= -10)) SendMessageToPC(oPC, INDOORCOLD);
      if ((nCelsius > -10) && (nCelsius <= 0)) SendMessageToPC(oPC, INDOORMILD);
      if ((nCelsius > 0) && (nCelsius <= 15)) SendMessageToPC(oPC, INDOORMILD);
      if ((nCelsius > 15) && (nCelsius <= 25)) SendMessageToPC(oPC, INDOORWARM);
      if ((nCelsius > 25) && (nCelsius <= 35)) SendMessageToPC(oPC, INDOORWARMER);
      if (nCelsius > 35) SendMessageToPC(oPC, INDOORWARMEST);
    }
  }

//:: REALISTIC WEATHER SYSTEM
/******************************************************************************/

  if(GetIsPC(oPC) == TRUE && GetIsDM(oPC) == FALSE && GetIsDMPossessed(oPC) == FALSE)
  {

/******************************************************************************/
//:: HTF SEGEMENT

    int nTotalIntensity;

    //Color set up for the graphical portion of HTF
    string sRed         = COLORRED;
    string sGreen       = COLORGREEN;
    string s100         = "||||||||||||||||||||||||||||||||||||||||||||||||||";
    string s98          = "|||||||||||||||||||||||||||||||||||||||||||||||||";
    string s96          = "||||||||||||||||||||||||||||||||||||||||||||||||";
    string s94          = "|||||||||||||||||||||||||||||||||||||||||||||||";
    string s92          = "||||||||||||||||||||||||||||||||||||||||||||||";
    string s90          = "|||||||||||||||||||||||||||||||||||||||||||||";
    string s88          = "||||||||||||||||||||||||||||||||||||||||||||";
    string s86          = "|||||||||||||||||||||||||||||||||||||||||||";
    string s84          = "||||||||||||||||||||||||||||||||||||||||||";
    string s82          = "|||||||||||||||||||||||||||||||||||||||||";
    string s80          = "||||||||||||||||||||||||||||||||||||||||";
    string s78          = "|||||||||||||||||||||||||||||||||||||||";
    string s76          = "||||||||||||||||||||||||||||||||||||||";
    string s74          = "|||||||||||||||||||||||||||||||||||||";
    string s72          = "||||||||||||||||||||||||||||||||||||";
    string s70          = "|||||||||||||||||||||||||||||||||||";
    string s68          = "||||||||||||||||||||||||||||||||||";
    string s66          = "|||||||||||||||||||||||||||||||||";
    string s64          = "||||||||||||||||||||||||||||||||";
    string s62          = "|||||||||||||||||||||||||||||||";
    string s60          = "||||||||||||||||||||||||||||||";
    string s58          = "|||||||||||||||||||||||||||||";
    string s56          = "||||||||||||||||||||||||||||";
    string s54          = "|||||||||||||||||||||||||||";
    string s52          = "||||||||||||||||||||||||||";
    string s50          = "|||||||||||||||||||||||||";
    string s48          = "||||||||||||||||||||||||";
    string s46          = "|||||||||||||||||||||||";
    string s44          = "||||||||||||||||||||||";
    string s42          = "|||||||||||||||||||||";
    string s40          = "||||||||||||||||||||";
    string s38          = "|||||||||||||||||||";
    string s36          = "||||||||||||||||||";
    string s34          = "|||||||||||||||||";
    string s32          = "||||||||||||||||";
    string s30          = "|||||||||||||||";
    string s28          = "||||||||||||||";
    string s26          = "|||||||||||||";
    string s24          = "||||||||||||";
    string s22          = "|||||||||||";
    string s20          = "||||||||||";
    string s18          = "|||||||||";
    string s16          = "||||||||";
    string s14          = "|||||||";
    string s12          = "||||||";
    string s10          = "|||||";
    string s8           = "||||";
    string s6           = "|||";
    string s4           = "||";
    string s2           = "|";

    //Sets the intial Total to Area Temp
    nTotalIntensity = nIntensity;

    // Check for Night
    if(GetIsNight() == TRUE) nTotalIntensity = nTotalIntensity + nNight;

    // Check Weather
    if(GetWeather(oArea) == WEATHER_SNOW) nTotalIntensity = nTotalIntensity + nSnow;
    if(GetWeather(oArea) == WEATHER_RAIN) nTotalIntensity = nTotalIntensity + nRain;

    //Checks for Combat
    if(GetIsInCombat(oPC) == TRUE) nTotalIntensity = nTotalIntensity + nCombat;

    //Checks for Armor, Shields, and Clothing
    int nAC = GetArcaneSpellFailure(oPC);
    if(nAC <= 0) nTotalIntensity = nTotalIntensity + nNArmor;
    else if (nAC > 0 && nAC < 20) nTotalIntensity = nTotalIntensity + nCArmor;
    else if (nAC >= 20 && nAC < 40) nTotalIntensity = nTotalIntensity + nLArmor;
    else if (nAC >= 40 && nAC < 60) nTotalIntensity = nTotalIntensity + nMArmor;
    else if (nAC >= 60 && nAC < 80) nTotalIntensity = nTotalIntensity + nHArmor;
    else if (nAC >= 80 && nAC <= 100) nTotalIntensity = nTotalIntensity + nVHArmor;

    //Checks for Special Winter/Cold Armors
    if (sArmor == "LightWinter") nTotalIntensity = nTotalIntensity + 1;
    else if (sArmor == "MediumWinter") nTotalIntensity = nTotalIntensity + 2;
    else if (sArmor == "HeavyWinter") nTotalIntensity = nTotalIntensity + 3;

    //Checks type of Cloak
    if(sCloak == "MediumCloak") nTotalIntensity = nTotalIntensity + nMCloak;
    else if (sCloak == "HeavyCloak") nTotalIntensity = nTotalIntensity + nHCloak;
    else if (oCloak != OBJECT_INVALID) nTotalIntensity = nTotalIntensity + nLCloak;

    //Checks for Helm
    if(sHelm == "WinterHood") nTotalIntensity = nTotalIntensity + nMCloak;
    if(oHelm != OBJECT_INVALID) nTotalIntensity = nTotalIntensity + nHelm;

    //Checks for Winter Boots
    if(sBoots=="WinterBoots") nTotalIntensity = nTotalIntensity + 2;

    //Checks for Campfire nearby
    float fDist;
    if(oFire1 != OBJECT_INVALID)
    {
      fDist = GetDistanceBetween(oFire1,oPC);
      if(fDist < 3.1) nTotalIntensity = nTotalIntensity + 5;
      else if(fDist < 5.1) nTotalIntensity = nTotalIntensity + 4;
      else if(fDist < 8.1) nTotalIntensity = nTotalIntensity + 3;
    }

    //Checks for Cook Spit nearby
    if(oFire2 != OBJECT_INVALID)
    {
      fDist = GetDistanceBetween(oFire2,oPC);
      if(fDist < 3.1) nTotalIntensity = nTotalIntensity + 4;
      else if (fDist < 5.1) nTotalIntensity = nTotalIntensity + 3;
      else if (fDist < 8.1) nTotalIntensity = nTotalIntensity + 2;
    }

    //Checks for Cook Pot nearby
    if(oFire3 != OBJECT_INVALID)
    {
      fDist = GetDistanceBetween(oFire3,oPC);
      if(fDist < 3.1) nTotalIntensity = nTotalIntensity + 3;
      else if (fDist < 5.1) nTotalIntensity = nTotalIntensity + 2;
      else if (fDist < 8.1) nTotalIntensity = nTotalIntensity + 1;
    }

    //Heavy Weapons
    if(IsHeavyMeleeWeapon(oWeapon)) nTotalIntensity = nTotalIntensity + nHWeapon;

    //Medium Weapons
    if(IsMediumMeleeWeapon(oWeapon)) nTotalIntensity = nTotalIntensity + nMWeapon;

    //Light Weapons
    if(IsLightMeleeWeapon(oWeapon)) nTotalIntensity = nTotalIntensity + nLWeapon;

    //Checks for Torches in the left hand
    int nLHT = GetBaseItemType(oLHand);
    if(nLHT == BASE_ITEM_TORCH) nTotalIntensity = nTotalIntensity + 1;
    if(nLHT == BASE_ITEM_SMALLSHIELD) nTotalIntensity = nTotalIntensity + 1;
    if(nLHT == BASE_ITEM_LARGESHIELD) nTotalIntensity = nTotalIntensity + 2;
    if(nLHT == BASE_ITEM_TOWERSHIELD) nTotalIntensity = nTotalIntensity + 3;

    //Apply Weight effects due to Strength
    float fPW;
    int nWINV = GetWeight(oPC);//Weight of all items on Player
    if(nWINV <= 0) nWINV = 1;
    int nSTR = GetAbilityScore(oPC,ABILITY_STRENGTH);//Strength of Player
    if(nSTR > 20) fPW = ((IntToFloat(nWINV) * 0.1)/400.0);//Based on Strength of 20
    else fPW = (IntToFloat(nWINV)/(IntToFloat(nSTR) * 20.0));//Rough Calculated Value
    int nTW = FloatToInt(5.0 * fPW);//The final adder to intensity
    nTotalIntensity = nTotalIntensity + nTW;


    //This is for DB setting of variables (to not make calls to often) and providing
    //the player with Graphical HTF Information
    nLoopCount = nLoopCount + 1;

    //Apply Fatiguing Rate to Hunger, Thirst, Fatigue

    //APPLY FATIGUE EFFECTS TO PLAYER
    if (nTotalIntensity > 0 && nFATIGUESYSTEM == 1)
    {
      float fRate = IntToFloat(nTotalIntensity) * fFMult;//Modifies the Total by Fatigue % Vary Rate
      int nRate = FloatToInt(fRate);
      if(nRate <= 0) nRate = 10;//Just a catch for a Minimum

      int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
      if(nCON > 4) nCON = 4;//Remove supernatural abilities
      nRate = nRate - nCON; //Subtract CON Bonus from total consumption
      int nOldHP = GetLocalInt(oPC,HTFFATIGUE);

      int nNew = nOldHP - nRate;
      if(nNew < 1) nNew = 1;

      if(nRevMode == TRUE)
      {
        if(nRate < 1) nRate = 1;
        if(nRate > 25) nRate = 25;//Cap Reversal
        nNew = nOldHP + nRate;
      }

      SetLocalInt(oPC,HTFFATIGUE,nNew);

      if(nLoopCount == 4)
      {
          float fNew = IntToFloat(nNew);
          float fFatigueHP = IntToFloat(nFatigueHP);
          float fTotal = (fNew/fFatigueHP) * 100;
          int nTotal = FloatToInt(fTotal);

          //Graphics Bar
          if(nTotal >= 100 || nTotal == 99) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s100);
          if(nTotal == 98  || nTotal == 97) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s98 +sRed+ s2);
          if(nTotal == 96  || nTotal == 95) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s96 +sRed+ s4);
          if(nTotal == 94  || nTotal == 93) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s94 +sRed+ s6);
          if(nTotal == 92  || nTotal == 91) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s92 +sRed+ s8);
          if(nTotal == 90  || nTotal == 89) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s90 +sRed+ s10);
          if(nTotal == 88  || nTotal == 87) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s88 +sRed+ s12);
          if(nTotal == 86  || nTotal == 85) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s86 +sRed+ s14);
          if(nTotal == 84  || nTotal == 83) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s84 +sRed+ s16);
          if(nTotal == 82  || nTotal == 81) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s82 +sRed+ s18);
          if(nTotal == 80  || nTotal == 79) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s80 +sRed+ s20);
          if(nTotal == 78  || nTotal == 77) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s78 +sRed+ s22);
          if(nTotal == 76  || nTotal == 75) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s76 +sRed+ s24);
          if(nTotal == 74  || nTotal == 73) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s74 +sRed+ s26);
          if(nTotal == 72  || nTotal == 71) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s72 +sRed+ s28);
          if(nTotal == 70  || nTotal == 69) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s70 +sRed+ s30);
          if(nTotal == 68  || nTotal == 67) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s68 +sRed+ s32);
          if(nTotal == 66  || nTotal == 65) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s66 +sRed+ s34);
          if(nTotal == 64  || nTotal == 63) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s64 +sRed+ s36);
          if(nTotal == 62  || nTotal == 61) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s62 +sRed+ s38);
          if(nTotal == 60  || nTotal == 59) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s60 +sRed+ s40);
          if(nTotal == 58  || nTotal == 57) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s58 +sRed+ s42);
          if(nTotal == 56  || nTotal == 55) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s56 +sRed+ s44);
          if(nTotal == 54  || nTotal == 53) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s54 +sRed+ s46);
          if(nTotal == 52  || nTotal == 51) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s52 +sRed+ s48);
          if(nTotal == 50  || nTotal == 49) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s50 +sRed+ s50);
          if(nTotal == 48  || nTotal == 47) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s48 +sRed+ s52);
          if(nTotal == 46  || nTotal == 45) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s46 +sRed+ s54);
          if(nTotal == 44  || nTotal == 43) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s44 +sRed+ s56);
          if(nTotal == 42  || nTotal == 41) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s42 +sRed+ s58);
          if(nTotal == 40  || nTotal == 39) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s40 +sRed+ s60);
          if(nTotal == 38  || nTotal == 37) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s38 +sRed+ s62);
          if(nTotal == 36  || nTotal == 35) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s36 +sRed+ s64);
          if(nTotal == 34  || nTotal == 33) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s34 +sRed+ s66);
          if(nTotal == 32  || nTotal == 31) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s32 +sRed+ s68);
          if(nTotal == 30  || nTotal == 29) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s30 +sRed+ s70);
          if(nTotal == 28  || nTotal == 27) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s28 +sRed+ s72);
          if(nTotal == 26  || nTotal == 25) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s26 +sRed+ s74);
          if(nTotal == 24  || nTotal == 23) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s24 +sRed+ s76);
          if(nTotal == 22  || nTotal == 21) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s22 +sRed+ s78);
          if(nTotal == 20  || nTotal == 19) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s20 +sRed+ s80);
          if(nTotal == 18  || nTotal == 17) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s18 +sRed+ s82);
          if(nTotal == 16  || nTotal == 15) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s16 +sRed+ s84);
          if(nTotal == 14  || nTotal == 13) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s14 +sRed+ s86);
          if(nTotal == 12  || nTotal == 11) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s12 +sRed+ s88);
          if(nTotal == 10  || nTotal ==  9) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s10 +sRed+ s90);
          if(nTotal ==  8  || nTotal ==  7) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s8 +sRed+ s92);
          if(nTotal ==  6  || nTotal ==  5) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s6 +sRed+ s94);
          if(nTotal ==  4  || nTotal ==  3) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s4 +sRed+ s96);
          if(nTotal ==  2  || nTotal ==  1) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sGreen+ s2 +sRed+ s98);
          if(nTotal <  1) SendMessageToPC(oPC, HTFFATIGUE+ ": " +sRed+ s100);

          //Messages
          if(nTotal >= 50 && nTotal < 60) SendMessageToPC(oPC, TOOTIRED0);
          if(nTotal >= 40 && nTotal < 50)
          {
            SendMessageToPC(oPC, TOOTIRED1);
            SpeakString(YAWN);
            AssignCommand (oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED));
          }
          if(nTotal >= 30 && nTotal < 40)
          {
            SendMessageToPC(oPC, TOOTIRED1);
            SpeakString(YAWN);
            AssignCommand (oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED));
          }
          if(nTotal >= 20 && nTotal < 30)
          {
            SendMessageToPC(oPC, TOOTIRED2);
            SpeakString(YAWN);
            AssignCommand (oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0, 8.0));
          }
          if(nTotal >= 10 && nTotal < 20)
          {
            SendMessageToPC(oPC, TOOTIRED2);
            SpeakString(YAWN);
            MakePlayerFatigued();
            AssignCommand (oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0, 8.0));
          }
          if(nTotal >=  1 && nTotal < 10)
          {
            SendMessageToPC(oPC, TOOTIRED3);
            SendMessageToPC(oPC, NOTENOUGHREST1);
            SpeakString(YAWN);
            AssignCommand (oPC,PlayVoiceChat(VOICE_CHAT_REST,oPC));
            MakePlayerFatigued();
            AssignCommand (oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0, 8.0));
          }
          if(nTotal < 1)
          {
            if(!GetIsPC(oPC)) return;
            effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
            effect eBlind =  EffectBlindness();
            effect eCollapse = EffectSleep();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCollapse, oPC, 15.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 12.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 14.0);
            SendMessageToPC(oPC, COLLAPSEFROMEXHAUSTION);
          }
      }
    }

    //WEAR OFF ALCOHOL EFFECTS FROM PLAYER
    int nAlcTotal = NBDE_GetCampaignInt(sDB,HTFALC,oPC);
    int nAlcCount = NBDE_GetCampaignInt(sDB,"ALCCOUNT",oPC);

    if(nAlcTotal >= 1)
    {
      if(nAlcCount >= 5)
      {
        int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
        if (nCON < 0) nCON = 1;//Minimum is 1....heh...this could be fun for low CON levels =)
        if (nCON > 3) nCON = 3;//Maximum should be 3
        nAlcTotal = nAlcTotal - nCON; //Subtract CON Bonus from Alcohol total
        NBDE_SetCampaignInt(sDB,HTFALC,nAlcTotal,oPC);
        NBDE_SetCampaignInt(sDB,"ALCCOUNT",0,oPC);
      }
      else
      {
        nAlcCount = nAlcCount + 1;
        NBDE_SetCampaignInt(sDB,"ALCCOUNT",0,oPC);
        SetLocalInt(oPC,"ALCCOUNT",0);
      }
    }

    SetLocalInt(oPC,"LOOPCOUNT", nLoopCount);

    if(nLoopCount == 4)
    {
      SetLocalInt(oPC,"LOOPCOUNT", 0);

      //APPLY CONSTITUTION BASED HEALING TO PLAYER (Who is not Bleeding From Dying)
      if(nCONBASEDHEAL == 1 && GetLocalInt(oPC,"BLEED_STATUS") == 0)
      {
        int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
        if (nCON > 4) nCON = 4;//Remove supernatural abilities
        int nMaxHP = GetMaxHitPoints(oPC);
        int nHP = GetCurrentHitPoints(oPC);
        int nHPTotal = nMaxHP - nHP;
        if(nHPTotal > 0)
        {
          effect eHealPC = EffectHeal(nCON);
          ApplyEffectToObject(DURATION_TYPE_INSTANT,eHealPC,oPC);
        }
      }
    }

//:: HTF SEGEMENT
/******************************************************************************/

/******************************************************************************/
//:: COLD EFFECTS SEGEMENT

    nTotalIntensity = 0;
    nCIntensity     = GetLocalInt(oPC,sCLocal);
    int nNetAC      = GetItemACValue(oArmor);
    int nBonus      = IPGetWeaponEnhancementBonus(oArmor, ITEM_PROPERTY_AC_BONUS);
    int nBaseAC     = nNetAC - nBonus;

    //Cold Area are less than Zero
    if(nCelsius < 0)
    {
      effect eDmg;

      if(nCIntensity > 0) nCIntensity = 0;//Min
      if(nCIntensity < -100) nCIntensity = -100;//Max

      nTotalIntensity = nCIntensity;

      //Checks for Armor, Shields, and Clothing
      nAC = GetArcaneSpellFailure(oPC);
      if(nAC <= 0) nTotalIntensity = nTotalIntensity + nCNArmor;
      else if (nAC > 0 && nAC < 20) nTotalIntensity = nTotalIntensity + nCCArmor;
      else if (nAC >= 20 && nAC < 40) nTotalIntensity = nTotalIntensity + nCLArmor;
      else if (nAC >= 40 && nAC < 60) nTotalIntensity = nTotalIntensity + nCMArmor;
      else if (nAC >= 60 && nAC <= 100) nTotalIntensity = nTotalIntensity + nCHArmor;

      //Winter Clothing Bonuses
      if (sArmor == "LightWinter") nTotalIntensity = nTotalIntensity + nWLight;
      else if (sArmor == "MediumWinter") nTotalIntensity = nTotalIntensity + nWMedium;
      else if (sArmor == "HeavyWinter") nTotalIntensity = nTotalIntensity + nWHeavy;

      if(GetIsNight() == TRUE) nTotalIntensity = nTotalIntensity - nCNight;
      if(GetWeather(oArea) == WEATHER_SNOW) nTotalIntensity = nTotalIntensity + 5;
      if(GetWeather(oArea) == WEATHER_RAIN) nTotalIntensity = nTotalIntensity - 5;

      //Checks type of Cloak
      if(sCloak == "MediumCloak") nTotalIntensity = nTotalIntensity + nCMCloak;
      else if(sCloak == "HeavyCloak") nTotalIntensity = nTotalIntensity + nCHCloak;
      else if(oCloak != OBJECT_INVALID) nTotalIntensity = nTotalIntensity + nCLCloak;

      //Checks for Helm
      if(sHelm == "WinterHood") nTotalIntensity = nTotalIntensity + nWhood;
      else if(oHelm != OBJECT_INVALID) nTotalIntensity = nTotalIntensity + nCHelm;

      //Checks for Winter Boots
      if(sBoots == "WinterBoots") nTotalIntensity = nTotalIntensity + nWBoots;

      //Checks for Torch
      if(oLHand!=OBJECT_INVALID)
      {
        if(GetBaseItemType(oLHand) == BASE_ITEM_TORCH) nTotalIntensity = nTotalIntensity + nCTorch;
      }

      //Checks for Campfire nearby
      if(oFire1!=OBJECT_INVALID)
      {
        fDist=GetDistanceBetween(oFire1,oPC);
        if(fDist < 3.1) nTotalIntensity = nTotalIntensity + 15;
        else if(fDist < 5.1) nTotalIntensity = nTotalIntensity + 10;
        else if(fDist < 8.1) nTotalIntensity = nTotalIntensity + 5;
      }

      //Checks for Cook Spit nearby
      if(oFire2!=OBJECT_INVALID)
      {
        fDist=GetDistanceBetween(oFire2,oPC);
        if(fDist < 3.1) nTotalIntensity = nTotalIntensity + 13;
        else if(fDist < 5.1) nTotalIntensity = nTotalIntensity + 8;
        else if (fDist < 8.1) nTotalIntensity = nTotalIntensity + 3;
      }

      //Checks for Cook Pot nearby
      if(oFire3 != OBJECT_INVALID)
      {
        fDist=GetDistanceBetween(oFire3,oPC);
        if(fDist < 3.1) nTotalIntensity = nTotalIntensity + 11;
        else if(fDist < 5.1) nTotalIntensity = nTotalIntensity + 6;
        else if(fDist < 8.1) nTotalIntensity = nTotalIntensity + 1;
      }

      if(nTotalIntensity < 0)
      {
        //Get Level of player to set up a Freezing ratio so everyone freezes at the same rate
        int nPL = GetHitDice(oPC);
        float fFM = ((IntToFloat(nTotalIntensity) * -1.0) * 0.1) * (IntToFloat(nPL) * 0.1);
        int nFM = FloatToInt(fFM);
        if(nFM <= 0) nFM = 1;//Min of 1 Damage

        //Do cold damage
        eDmg = EffectDamage(nFM,DAMAGE_TYPE_COLD,DAMAGE_POWER_PLUS_TWENTY);
        SendMessageToPC(oPC,"You are suffering from the cold. You need some warmer clothing and/or cloak.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oPC);
      }
    }

//:: COLD EFFECTS SEGEMENT
/******************************************************************************/

/******************************************************************************/
//:: DATA UPDATE

    //Verify Data
    int nH = GetLocalInt(oPC,HTFHUNGER);
    int nT = GetLocalInt(oPC,HTFTHIRST);
    int nF = GetLocalInt(oPC,HTFFATIGUE);

    //Something Bad Happened
    if(nH < 1 && nT < 1 && nF < 1)
    {
      //Refrsh DB
      NBDE_SetCampaignInt(sDB,HTFHUNGER,nHungerHP,oPC);
      NBDE_SetCampaignInt(sDB,HTFTHIRST,nThirstHP,oPC);
      NBDE_SetCampaignInt(sDB,HTFFATIGUE,nFatigueHP,oPC);
      NBDE_SetCampaignInt(sDB,HTFALC,0,oPC);

      //Set on Player
      SetLocalInt(oPC,HTFHUNGER,nHungerHP);
      SetLocalInt(oPC,HTFTHIRST,nThirstHP);
      SetLocalInt(oPC,HTFFATIGUE,nFatigueHP);
      SetLocalInt(oPC,HTFALC,0);
    }

    //Update Data
    NBDE_SetCampaignInt(sDB,HTFHUNGER,nH,oPC);
    NBDE_SetCampaignInt(sDB,HTFTHIRST,nT,oPC);
    NBDE_SetCampaignInt(sDB,HTFFATIGUE,nF,oPC);
    SetLocalInt(oPC,HTFHUNGER,nH);
    SetLocalInt(oPC,HTFTHIRST,nT);
    SetLocalInt(oPC,HTFFATIGUE,nF);

//:: DATA UPDATE
/******************************************************************************/

  }
}


