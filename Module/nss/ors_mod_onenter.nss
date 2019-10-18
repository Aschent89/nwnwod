////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Module On Enter
//  ors_mod_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Main On Enter Event.
//  MUST BE ON TOP OF ALL OTHER ONENTER SCRIPTS in  wrap_mod_onenter
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"
#include "oqs_inc"
#include "ccs_inc"

void main()
{
    object oPC  = GetEnteringObject();
    object oMod = GetModule();
    string sDB = GetLocalString(oMod,"ORS_DATABASE");

    //DM Stuff
    ORS_DMStuff(oPC);

    //DMs Finish
    if(GetIsDM(oPC) == TRUE) return;

    //Check to see if the Player is New or not
    int nNewXP = GetXP(oPC);

    //Give Players XP IF they are less than Defined Starting XP
    /*
    NOTE: ORS_NewPlayer is ONLY for New Players....
          players will no longer be new once they have 1001 XP
          Hence why this is here in case YOU decide to Increase
          Starting XP While the Server is Running
    */
    int nXP = GetLocalInt(oMod,"STARTXP");
    int nCurXP = GetXP(oPC);
    if(GetIsPC(oPC) && !GetIsDM(oPC))
    {
      //New Player
      if(nCurXP < nXP && nCurXP <= 1000)
      {
        ORS_NewPlayer(oPC, nCurXP);
      }
      else if(nCurXP < nXP)
      {
        int nGive = nXP - nCurXP;
        GiveXPToCreature(oPC, nGive);
      }
    }

//    //Player Can Not Have more Soul Runes than Maximum
//     ORS_ValidateLifes(oPC);

    //Check for Items with Illegal Properties
    ORS_ValidateIllegalItems(oPC);

    //Check for Library Books
    ORS_LibraryBooks(oPC);

    //Update and/or Create Player Unique ID
    string sPCU = GetCampaignString("UNIQUEIDS","PCU",oPC);
    if(sPCU == "")
    {
      string sPCN = GetName(oPC);
      string sPre = GetStringLeft(sPCN,2);
      int nNum1 = Random(10000) + 1;
      int nNum2 = Random(10000) + 1;
      int nNum3 = Random(10000) + 1;
      int nNum4 = Random(10000) + 1;
      int nAvg  = (nNum1 + nNum2 + nNum3 + nNum4)/4;
      string sID = sPre + IntToString(nAvg);
      SetLocalString(oPC,"PCU",sID);
      SetCampaignString("UNIQUEIDS","PCU",sID,oPC);
    }
    else SetLocalString(oPC,"PCU",sPCU);

    if(AVGetIsSpellCaster(oPC))
    {
      AVRestoreSpells(oPC);
    }

    //Set Up Player Birthday and Start Time
    ORS_PCBirthday(oPC);

    //Give Adventure Gear
    ORS_AdventureGear(oPC);

    //Class Levelling Controls
    if(CCS_CHARACTER_LEVEL_CONTROL)
    {
      if(GetIsPC(oPC))
      {
        BlockAllClasses(oPC);
        if(CCS_TRAINER_START && CCS_MULTICLASS_LEVEL_CONTROL)
        {
          EnableFamiliarClasses(oPC);
        }
        else if(!CCS_MULTICLASS_LEVEL_CONTROL)
        {
          AllowAllClasses(oPC);
        }

        //Verify Current DB
        int nLClass1 = NBDE_GetCampaignInt(sDB, "CCS_LEVEL1", oPC);
        if(nLClass1 < 1)
        {
          //DB Not Set Up

          //Current Class Types
          int nClassType1 = GetClassByPosition(1,oPC);
          int nClassType2 = GetClassByPosition(2,oPC);
          int nClassType3 = GetClassByPosition(3,oPC);

          //Current Levels in Each Class
          int nClassLvl1 = GetLevelByClass(nClassType1,oPC);
          int nClassLvl2 = GetLevelByClass(nClassType2,oPC);
          int nClassLvl3 = GetLevelByClass(nClassType3,oPC);

          //Persistent Classes (For CCS Trainers)
          NBDE_SetCampaignInt(sDB, "CCS_CLASS1", nClassType1, oPC);
          NBDE_SetCampaignInt(sDB, "CCS_CLASS2", nClassType2, oPC);
          NBDE_SetCampaignInt(sDB, "CCS_CLASS3", nClassType3, oPC);

          //Base Class
          NBDE_SetCampaignInt(sDB, "CCS_LEVEL1", nClassLvl1, oPC);

          //2nd Class
          if(nClassType2 < 255) NBDE_SetCampaignInt(sDB, "CCS_LEVEL2", nClassLvl2, oPC);

          //3rd Class
          if(nClassType3 < 255) NBDE_SetCampaignInt(sDB, "CCS_LEVEL3", nClassLvl3, oPC);

          DeleteLocalInt(oPC,"ALLOWLEVEL");
        }
      }
    }

    //Racial Movement Rates
//    int nRacial = GetLocalInt(oMod,"RACIALMOVE");
//    if(nRacial == 1) SetRacialMovementRate(oPC);

    if(GetIsDM(oPC) == FALSE)
    {
      //Rebuild Quest Entries
      RebuildJournalQuestEntries(oPC);
    }

    //Reset Alignments
    ResetReputations(oPC);

    //Timestop and Greater Sanctuary Lockout Log/Crash Fix
    if(GetLocalInt(oPC, "TIMESTOP_DELAY") == 1)
    {
      SendMessageToPC(oPC,"You Logged/Crashed after casting Time Stop. Your lockout time has been refreshed.");
      DelayCommand(1.0, TimeStopDelay(oPC));
    }
    if(GetLocalInt(oPC, "GSANCTUARY_DELAY") == 1)
    {
      SendMessageToPC(oPC,"You Logged/Crashed after casting Greater Sanctuary. Your lockout time has been refreshed.");
      DelayCommand(1.0, GSStopDelay(oPC));
    }

    //Clear Transitioning Local (For Clickless Transitions)
    SetLocalInt(oPC,"ORS_TRANSITIONING",0);
}
