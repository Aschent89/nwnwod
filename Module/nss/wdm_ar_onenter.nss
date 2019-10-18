////////////////////////////////////////////////////////////////////////////////
//  Dead and Wild Magic System - On Area Enter
//  wdm_ar_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Area On Enter Event to Strip Magic
//
////////////////////////////////////////////////////////////////////////////////

#include "wdm_inc"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    if(GetIsDM(oPC) || GetIsDMPossessed(oPC)) return;

    object oWild = GetNearestObjectByTag("WILDMAGIC",oPC);
    object oDead = GetNearestObjectByTag("DEADMAGIC",oPC);

    //Can not set up an Area that has Both Waypoints placed
    if(GetIsObjectValid(oWild) == TRUE && GetIsObjectValid(oDead) == TRUE) return;

    //Dead and Wild Magic Initialize Area
    int nWDMIni = GetLocalInt(oArea,"WDMINIT");
    if(nWDMIni == 0)
    {
      if(GetIsObjectValid(oWild) == TRUE)
      {
        SetLocalInt(oArea,"X2_L_WILD_MAGIC",TRUE);
        SetCampaignInt("WDM","INWDMZONE",1,oPC);
        SetLocalInt(oArea,"WDMINIT",1);

        string sName = GetName(oWild);
        string sChance = GetStringRight(sName,3);
        int nChance = StringToInt(sChance);
        if(nChance <= 0 || nChance > 100) nChance = 50;

        //Delete Dead Magic Zone Info just in case
        DeleteLocalInt(oArea,WDM_DEADM_ZONE);
        DeleteLocalInt(oArea,WDM_DM_STREFFECTS);
        DeleteLocalInt(oArea,WDM_DM_STRITEMS);

        WDM_SetAreaDeadMagicStatus(oArea, FALSE);
        WDM_SetAreaWildMagicStatus(oArea,TRUE,nChance);
      }

      if(GetIsObjectValid(oDead) == TRUE)
      {
        SetLocalInt(oArea,"X2_L_WILD_MAGIC",TRUE);
        SetCampaignInt("WDM","INWDMZONE",1,oPC);
        SetLocalInt(oArea,"WDMINIT",1);

        string sStrip = GetName(oDead);
        string sEffects = GetSubString(sStrip,10,1);
        string sItems = GetSubString(sStrip,12,1);
        int nEffects = StringToInt(sEffects);
        int nItems = StringToInt(sItems);
        if(nEffects != 0 && nEffects != 1) nEffects = 1;
        if(nItems != 0 && nItems != 1) nItems = 1;

        WDM_SetAreaWildMagicStatus(oArea, FALSE);
        WDM_SetAreaDeadMagicStatus(oArea,TRUE,nEffects,nItems);
      }
    }

    //Only run Dead or Wild Magic if Waypoints exist
    if(GetIsObjectValid(oWild) == TRUE || GetIsObjectValid(oDead) == TRUE) WDM_StripMagic(oPC);
}
