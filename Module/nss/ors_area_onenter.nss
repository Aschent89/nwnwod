////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Area On Enter
//  ors_area_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the Area On Enter Event
//
//  See Builder's Guide on How to Set Up Each
/*
The Numbers Below are Set as a Variable on the Placeable

ORS_VFX Lighting.....ANY VFX Can be Done

int VFX_DUR_LIGHT_BLUE_5            = 153;
int VFX_DUR_LIGHT_BLUE_10           = 154;
int VFX_DUR_LIGHT_BLUE_15           = 155;
int VFX_DUR_LIGHT_BLUE_20           = 156;
int VFX_DUR_LIGHT_YELLOW_5          = 157;
int VFX_DUR_LIGHT_YELLOW_10         = 158;
int VFX_DUR_LIGHT_YELLOW_15         = 159;
int VFX_DUR_LIGHT_YELLOW_20         = 160;
int VFX_DUR_LIGHT_PURPLE_5          = 161;
int VFX_DUR_LIGHT_PURPLE_10         = 162;
int VFX_DUR_LIGHT_PURPLE_15         = 163;
int VFX_DUR_LIGHT_PURPLE_20         = 164;
int VFX_DUR_LIGHT_RED_5             = 165;
int VFX_DUR_LIGHT_RED_10            = 166;
int VFX_DUR_LIGHT_RED_15            = 167;
int VFX_DUR_LIGHT_RED_20            = 168;
int VFX_DUR_LIGHT_ORANGE_5          = 169;
int VFX_DUR_LIGHT_ORANGE_10         = 170;
int VFX_DUR_LIGHT_ORANGE_15         = 171;
int VFX_DUR_LIGHT_ORANGE_20         = 172;
int VFX_DUR_LIGHT_WHITE_5           = 173;
int VFX_DUR_LIGHT_WHITE_10          = 174;
int VFX_DUR_LIGHT_WHITE_15          = 175;
int VFX_DUR_LIGHT_WHITE_20          = 176;
int VFX_DUR_LIGHT_GREY_5            = 177;
int VFX_DUR_LIGHT_GREY_10           = 178;
int VFX_DUR_LIGHT_GREY_15           = 179;
int VFX_DUR_LIGHT_GREY_20           = 180;
*/
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
  object oPC    = GetEnteringObject();
  object oMod   = GetModule();
  object oArea  = GetArea(oPC);

  //VFX Placeables
  int nVFXOnce = GetLocalInt(oArea,"VFX_RUN_ONCE");
  int nNth = 1;
  object oVFX = GetNearestObjectByTag("VFXPlace",oPC,nNth);
  while(GetIsObjectValid(oVFX) && nVFXOnce == 0)
  {
    SetPlotFlag(oVFX,TRUE);
    SetUseableFlag(oVFX,FALSE);
    AssignCommand(oVFX,ExecuteScript("ors_vfx_place",oVFX));
    nNth++;
    oVFX = GetNearestObjectByTag("VFXPlace",oPC,nNth);
  }
  SetLocalInt(oArea,"VFX_RUN_ONCE",1);

  //Check for Permanent Lights
  int nELight;
  int nRunOnce = GetLocalInt(oArea,"LIGHT_RUN_ONCE");
  nNth = 1;
  object oLight = GetNearestObjectByTag("PermLight",oPC,nNth);
  while(GetIsObjectValid(oLight) && nRunOnce == 0)
  {
    SetPlotFlag(oLight,TRUE);
    SetUseableFlag(oLight,FALSE);
    nELight = GetLocalInt(oLight,"ORS_VFX");
    if(nELight < 1) nELight = VFX_DUR_LIGHT_YELLOW_20;//160
    AssignCommand(oLight,PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    DelayCommand(0.4,SetPlaceableIllumination(oLight, TRUE));
    SetLocalInt(OBJECT_SELF,"NW_L_AMION",1);
    DelayCommand(0.5,RecomputeStaticLighting(oArea));
    effect eLight = EffectVisualEffect(nELight);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oLight));
    nNth++;
    oLight = GetNearestObjectByTag("PermLight",oPC,nNth);
  }
  SetLocalInt(oArea,"LIGHT_RUN_ONCE",1);

  //Check for Street Lights
  int nDayLit = GetLocalInt(oArea,"DAY_LIGHT");
  int nNightLit = GetLocalInt(oArea,"NIGHT_LIGHT");

  if(GetIsDusk() || GetIsNight())
  {
    if(nNightLit == 0)
    {
      //Get All the Street Lights
      nNth = 1;
      object oSL = GetNearestObjectByTag("StreetLight",oPC,nNth);
      while(GetIsObjectValid(oSL))
      {
        SetPlotFlag(oSL,TRUE);
        SetUseableFlag(oSL,FALSE);
        AssignCommand(oSL,ExecuteScript("ors_auto_lights",oSL));
        nNth++;
        if(nNth > 2000) break;//Safety Measure
        oSL = GetObjectByTag("StreetLight",nNth);
      }
    }
    SetLocalInt(oArea,"DAY_LIGHT",0);
    SetLocalInt(oArea,"NIGHT_LIGHT",1);
  }

  if(GetIsDawn() || GetIsDay())
  {
    if(nDayLit == 0)
    {
      //Get All the Street Lights
      nNth = 1;
      object oSL = GetNearestObjectByTag("StreetLight",oPC,nNth);
      while(GetIsObjectValid(oSL))
      {
        AssignCommand(oSL,ExecuteScript("ors_auto_lights",oSL));
        nNth++;
        if(nNth > 2000) break;//Safety Measure
        oSL = GetObjectByTag("StreetLight",nNth);
      }
    }
    SetLocalInt(oArea,"DAY_LIGHT",1);
    SetLocalInt(oArea,"NIGHT_LIGHT",0);
  }

  //Explore Area Waypoint Placed in Area
  object oMapWP = GetNearestObjectByTag("ExlporeArea",oPC,1);
  if(GetIsObjectValid(oMapWP))
  {
    ExploreAreaForPlayer(oArea,oPC);
  }

  //Check for a Player Map
  if(GetIsPC(oPC) || GetIsDMPossessed(oPC))
  {
    string sMExplore = "RegionMap";
    string sWPExplore = "REGION_MAP";

    object oMap = GetFirstItemInInventory(oPC);
    object oWPExplore = GetNearestObjectByTag("REGION_MAP",oPC,1);
    string sName = GetName(oWPExplore);

    string sMap;
    string sTag;
    string sResRef;

    //Now Loop Through Inventory and search for Maps
    while(GetIsObjectValid(oMap))
    {
      sResRef = GetResRef(oMap);
      sMap = GetStringLeft(sTag,4);

      //Found a Map
      if(sMap == "map_")
      {
        sTag = GetTag(oMap);

        //Found our Area Map
        if(sTag == sName)
        {
          ExploreAreaForPlayer(oArea,GetEnteringObject());
          return;
        }
      }
      oMap = GetNextItemInInventory(oPC);
    }
  }

  //Jumping and Climbing and Reset
  if(GetIsPC(oPC) || GetIsDMPossessed(oPC))
  {
    ResetReputations(oPC);

    //Jumping and Climbing Boots
    int nInterior = GetIsAreaInterior(oArea);
    if(nInterior == FALSE)
    {
      SetLocalInt(oPC,"ALLOWJUMP",1);
      SendMessageToPC(oPC,"This is an Outdoor Area. You can Climb or Jump using your Rope here.");
      return;
    }
    if(nInterior == TRUE)
    {
      SetLocalInt(oPC,"ALLOWJUMP",0);
      SendMessageToPC(oPC,"This is an Indoor Area. You can NOT Climb or Jump here.");
      return;
    }
  }
}
