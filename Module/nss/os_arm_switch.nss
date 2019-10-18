////////////////////////////////////////////////////////////////////////////////
//  Olander's Siege System - Arming Switch
//  os_arm_switch
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Switch OnUsed Event of a switch
//
////////////////////////////////////////////////////////////////////////////////

#include "os_inc"

void main()
{
    object oPC      = GetLastUsedBy();
    object oMod     = GetModule();
    object oSwitch  = OBJECT_SELF;
    location lLoc   = GetLocation(oSwitch);
    string sSFaction = GetLocalString(oSwitch,"OAI_FACTION");

    string sSwitch = GetTag(oSwitch);

    //Players Faction and Rank
    string sPCFaction = GetLocalString(oPC,"OAI_FACTION");
    int nPCRank = 40;

//:****************************************************************************/
//: SIEGE SWITCH OPERATION

    //Siege Switch
    if(sSwitch == "SiegeSwitch" && nPCRank >= 4 && sSFaction == sPCFaction)
    {
      int nMode = GetLocalInt(oSwitch,"FIREMODE");
      int nSDown = GetLocalInt(oSwitch,"FIREOFF");

      //Check for Artillery Standing Down Command
      if(nSDown == 1)
      {
        //Siege Artillery Standing Down
        if(nMode == 3)
        {
          SetLocalInt(oSwitch,"FIREMODE",0);
          OS_ActivateSwitch();
          SpeakString("Fire Mode is OFF.");
        }
        return;
      }

      //Check if 10 Seconds Pasted and No Switch Action
      if(nSDown == 0 && nMode == 3)
      {
        nMode = 2;
        SetLocalInt(oSwitch,"FIREMODE",2);
      }

      //Siege Artillery Ready for Battle
      if(nMode == 0)
      {
        SetLocalInt(oSwitch,"FIREMODE",1);
        OS_ActivateSwitch();
        SpeakString("Fire Mode is ON. Use this switch again to Start Siege Artillery.");
      }

      //Siege Artillery Start Firing
      if(nMode == 1)
      {
        SetLocalInt(oSwitch,"FIREMODE",2);
        OS_ActivateSwitch();
        OS_InitiateSiege(oSwitch, lLoc);
      }

      //Siege Artillery Prepare Stand Down
      if(nMode == 2)
      {
        SetLocalInt(oSwitch,"FIREMODE",3);
        SetLocalInt(oSwitch,"FIREOFF",1);
        OS_ActivateSwitch();
        SpeakString("Use this switch again within 10 Seconds to stop Siege Artillery!");
        DelayCommand(10.0,SetLocalInt(oSwitch,"FIREOFF",0));
      }
    }

//: SIEGE SWITCH OPERATION
//:****************************************************************************/
}
