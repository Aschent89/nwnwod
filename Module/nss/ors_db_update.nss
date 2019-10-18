////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Database Updater
//  ors_db_update
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is called from  ors_timesync through  ors_mod_onload.
//  This rely's on a continuous Module Based 30 Second Loop to
//  help improve performance and Timing Issues in High Stress Modules
//
////////////////////////////////////////////////////////////////////////////////

#include "nbde_inc"

void main()
{
  object oMod = GetModule();
  int nDB = GetLocalInt(oMod,"DBCYCLECOUNT");
  int nCycle = 2;

  //Current DM Datasave Mode
  int nDMDS = GetLocalInt(oMod,"ORS_DATASAVE");
  if(nDMDS == 1)
  {
    SendMessageToAllDMs("Database Save Switch was USED. Databases no longer Function!! Please Reload now.");
    return;
  }

  //Update Time DB
  if(nDB == nCycle)
  {
    //Perm Time On
    int nPERMTIME = GetLocalInt(oMod,"PERMTIME");
    if(nPERMTIME == 1)
    {
      SetCampaignInt("TIME","TIMEHOUR",GetTimeHour(),oMod);
      SetCampaignInt("TIME","TIMEDAY",GetCalendarDay(),oMod);
      SetCampaignInt("TIME","TIMEMONTH",GetCalendarMonth(),oMod);
      SetCampaignInt("TIME","TIMEYEAR",GetCalendarYear(),oMod);
    }

    string sORS_DATABASE = GetLocalString(oMod,"ORS_DATABASE");

    //Update DB
    NBDE_FlushCampaignDatabase(sORS_DATABASE);
  }

  nDB++;
  if(nDB > nCycle) nDB = 1;
  SetLocalInt(oMod, "DBCYCLECOUNT", nDB);
}
