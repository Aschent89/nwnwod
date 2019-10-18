
////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - HTF System - HTF Updater
//  ohtf_mod_hb
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the Module Heartbeat Event
//
//  Best Interest...Cache This Script
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oMod = GetModule();

    //HTF System is Off
    int nHTFGLOBAL = GetLocalInt(oMod,"HTFGLOBAL");
    if(nHTFGLOBAL == 0) return;

    //Count Information
    int nHB = GetLocalInt(oMod,"HTFCYCLECOUNT");
    int nCycle = 5;

    //Time to Execute HTF
    if(nHB == nCycle)
    {
      //Now we get each Player on the Server and Run HTF
      object oPC = GetFirstPC();
      while(GetIsObjectValid(oPC))
      {
      if(GetSubRace(oPC)!="SoulSeeker"&&GetSubRace(oPC)!="Vampire")
{
        AssignCommand(oPC,ExecuteScript("ohtf_rate",oPC));
}

if(GetSubRace(oPC)=="SoulSeeker"||GetSubRace(oPC)=="Vampire")
{
        AssignCommand(oPC,ExecuteScript("ohtf_rate2",oPC));
}
        int nDebug = GetLocalInt(oMod,"HTFDEBUG");
        if(nDebug == 1)
        {
          int nH = GetLocalInt(oPC,"HUNGER");
          int nT = GetLocalInt(oPC,"THIRST");
          int nF = GetLocalInt(oPC,"FATIGUE");

          SendMessageToAllDMs("HTF has been run on : "+GetName(oPC)+" H: "+IntToString(nH)+" T: "+IntToString(nT)+" F: "+IntToString(nF));
        }

        oPC = GetNextPC();
      }
    }

    nHB++;
    if(nHB > nCycle) nHB = 1;
    SetLocalInt(oMod, "HTFCYCLECOUNT", nHB);
}
