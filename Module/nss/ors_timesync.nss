////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Time Sync
//  ors_timesync
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is for Module Cycle Executions That Require Accuracy
//  This is Executed When the Module Loads
//
////////////////////////////////////////////////////////////////////////////////

void TimeSync(object oMod)
{
    //Cycle Time
    int nCycle = 30;
    float f30MC = IntToFloat(nCycle);

//:****************************************************************************/
//: MODULES HAVING TIMING ISSUES WITH THE CLOCK (MODULE STRESS)

    int nCLOCKSYNC = GetLocalInt(oMod,"CLOCKSYNC");
    if(nCLOCKSYNC == 1)
    {
      //Current Time Info
      int nCurHour = GetTimeHour();
      int nCurMin = GetTimeMinute();
      int nCurSec = GetTimeSecond();
      int nCurMS = GetTimeMillisecond();

      //Clock Sync
      SetTime(nCurHour,nCurMin,nCurSec,nCurMS);
    }

//: MODULES HAVING TIMING ISSUES WITH THE CLOCK (MODULE STRESS)
//:****************************************************************************/

//:****************************************************************************/
//: MODULE TIMED SCRIPTS

    //DB Update
    ExecuteScript("ors_db_update",GetModule());

    //Local Clock
    ExecuteScript("ors_time_local",GetModule());

    //Realistic Weather
    ExecuteScript("orw_mod_user",GetModule());

//: MODULE TIMED SCRIPTS
//:****************************************************************************/

//:****************************************************************************/
//: MODULE LOADED AND RUNNING PROPERLY

    int nRUNNING = GetLocalInt(oMod,"MODULE_RUNNING");
    if(nRUNNING <= 0)
    {
      SetLocalInt(oMod,"MODULE_RUNNING",1);
    }

//: MODULE LOADED AND RUNNING PROPERLY
//:****************************************************************************/

    DelayCommand(f30MC,TimeSync(oMod));
}

void main()
{
    object oMod = GetModule();
    if(GetLocalInt(oMod,"TIMESYNCRUNNING") == 1) return;

    //Start the Time Sync Loop
    SetLocalInt(oMod,"TIMESYNCRUNNING",1);
    DelayCommand(30.0,TimeSync(oMod));
}
