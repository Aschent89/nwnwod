////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - HTF System - HTF On Client Enter
//  ohtf_mod_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Module On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ohtf_inc"

void main()
{
    object oPC          = GetEnteringObject();
    object oMod         = GetModule();
    string sDB          = ORS_GetDBString();
    int nHungerHP       = GetLocalInt(oMod,HTFHUNGER);
    int nThirstHP       = GetLocalInt(oMod,HTFTHIRST);
    int nFatigueHP      = GetLocalInt(oMod,HTFFATIGUE);
    int nHUNGERSYSTEM   = GetLocalInt(oMod,"HUNGERSYSTEM");
    int nFATIGUESYSTEM  = GetLocalInt(oMod,"FATIGUESYSTEM");

    if(GetIsDM(oPC) == TRUE || GetIsDMPossessed(oPC) == TRUE)
    {
      AssignCommand(oMod,ExecuteScript("ohtf_rate",oPC));
      return;
    }

    if(!GetIsPC(oPC)) return;

    //Not in Water Source Trigger
    SetLocalInt(oPC,"WSOURCE",FALSE);
    SetLocalString(oPC,"WSOURCE","");
    SetLocalString(oPC,"WATERBODY","");

    //Verify Data
    int nH = NBDE_GetCampaignInt(sDB,HTFHUNGER,oPC);
    int nT = NBDE_GetCampaignInt(sDB,HTFTHIRST,oPC);
    int nF = NBDE_GetCampaignInt(sDB,HTFFATIGUE,oPC);

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
    else
    {
      //Update Data to Player
      SetLocalInt(oPC,HTFHUNGER,nH);
      SetLocalInt(oPC,HTFTHIRST,nT);
      SetLocalInt(oPC,HTFFATIGUE,nF);
    }
}
