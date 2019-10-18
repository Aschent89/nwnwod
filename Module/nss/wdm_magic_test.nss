////////////////////////////////////////////////////////////////////////////////
//  Dead and Wild Magic System - Tutorial Test
//  wdm_magic_test
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the OnUsed Event of a Switch
//
//  The source script is by Catscan
//
////////////////////////////////////////////////////////////////////////////////

#include "wdm_inc"

void DoStrip()
{
    object oObject = GetFirstObjectInArea();
    while (oObject != OBJECT_INVALID)
    {
      int iType = GetObjectType(oObject);
      switch (iType)
      {
        case OBJECT_TYPE_CREATURE:
        {
          if (GetIsDM(oObject) || GetIsDMPossessed(oObject)) continue;
          else WDM_StripMagic(oObject); break;
        }
        case OBJECT_TYPE_ITEM: WDM_RemoveAllProperties(oObject); break;
      }
      oObject = GetNextObjectInArea();
    }
}

void DoRestore()
{
    object oObject = GetFirstObjectInArea();
    while (oObject != OBJECT_INVALID)
    {
      int iType = GetObjectType(oObject);
      switch (iType)
      {
        case OBJECT_TYPE_CREATURE:
        {
          if (GetIsDM(oObject) || GetIsDMPossessed(oObject)) continue;
          else WDM_RestoreMagic(oObject); break;
        }
        case OBJECT_TYPE_ITEM: WDM_RestoreAllProperties(oObject); break;

      }
      oObject = GetNextObjectInArea();
    }
}

void main()
{
    object oSwitch = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    object oArea = GetArea(oPC);
    string sLight = "LIGHT";
    int nCurStatus = GetLocalInt(oArea,"STATUS");

    object oLight = GetNearestObjectByTag(sLight,oPC);
    DestroyObject(oLight);

    SetLocalInt(oArea,"X2_L_WILD_MAGIC",TRUE);

    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake,oSwitch,RoundsToSeconds(6));

    nCurStatus++;
    if(nCurStatus > 2)nCurStatus = 0;

    string sResRef;
    string sMsg;
    switch (nCurStatus)
    {
      case 0:
        sResRef = "plc_solwhite";
        sMsg = "* Magic works as normal *";
        WDM_SetAreaDeadMagicStatus(oArea, FALSE);
        WDM_SetAreaWildMagicStatus(oArea, FALSE);
        DoRestore();
        break;

      case 1:
        sResRef = "plc_solred";
        sMsg = "* Area is now Wild *";
        WDM_SetAreaDeadMagicStatus(oArea, FALSE);
        WDM_SetAreaWildMagicStatus(oArea, TRUE, 100);
        break;

      case 2:
        sResRef = "plc_solgreen";
        sMsg = "* Area is now Dead *";
        WDM_SetAreaWildMagicStatus(oArea, FALSE);
        WDM_SetAreaDeadMagicStatus(oArea, TRUE, TRUE, TRUE);
        DoStrip();
        break;
    }

    CreateObject(OBJECT_TYPE_PLACEABLE,sResRef,GetLocation(oSwitch),FALSE,sLight);
    SpeakString(sMsg);
    SetLocalInt(oArea,"STATUS",nCurStatus);
}
