////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - HTF System - Respawn File
//  ohtf_mod_respawn
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Module On Respawn Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ohtf_inc"

void main()
{
    object oPC          = GetLastRespawnButtonPresser();
    object oMod         = GetModule();
    string sDB          = ORS_GetDBString();
    int nHungerHP       = GetLocalInt(oMod,HTFHUNGER);
    int nThirstHP       = GetLocalInt(oMod,HTFTHIRST);
    int nFatigueHP      = GetLocalInt(oMod,HTFFATIGUE);

    //Gets and checks to see if the Hunger or Fatigue Systems are Enabled
    int nHUNGERSYSTEM = GetLocalInt(oMod,"HUNGERSYSTEM");
    int nFATIGUESYSTEM = GetLocalInt(oMod,"FATIGUESYSTEM");

    //Resets the Player HTF values if Hunger OR Fatigue is Enabled
    if((nHUNGERSYSTEM == 1) || (nFATIGUESYSTEM == 1))
    {
            if(GetSubRace(oPC)!="soulseeker"&&GetSubRace(oPC)!="vampire")
{
      NBDE_SetCampaignInt(sDB,HTFHUNGER,nHungerHP,oPC);
      NBDE_SetCampaignInt(sDB,HTFTHIRST,nThirstHP,oPC);
      NBDE_SetCampaignInt(sDB,HTFFATIGUE,nFatigueHP,oPC);
      NBDE_SetCampaignInt(sDB,HTFALC,0,oPC);

      SetLocalInt(oPC,HTFHUNGER,nHungerHP);
      SetLocalInt(oPC,HTFTHIRST,nThirstHP);
      SetLocalInt(oPC,HTFFATIGUE,nFatigueHP);
      SetLocalInt(oPC,HTFALC,0);
      }
    }
}
