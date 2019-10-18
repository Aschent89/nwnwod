////////////////////////////////////////////////////////////////////////////////
//  Dead and Wild Magic System - On Area Exit
//  wdm_ar_onexit
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Area On Exit Event to Restore Magic
//
////////////////////////////////////////////////////////////////////////////////

#include "wdm_inc"

void main()
{
    object oPC = GetExitingObject();
    if(GetIsDM(oPC) || GetIsDMPossessed(oPC)) return;

    //Only run Dead or Wild Magic if Player Entered a Wild or Dead Area
    int nWDMZone = GetCampaignInt("WDM","INWDMZONE",oPC);
    if(nWDMZone == 1)
    {
      SetCampaignInt("WDM","INWDMZONE",0,oPC);
      WDM_RestoreMagic(oPC);
    }
}
