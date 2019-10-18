////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realsitic Systems
//  ors_mod_onlevel
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the Module OnPlayeLevelUp Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"
#include "ccs_inc"
#include "ccs_text"
#include "q_stackable_inc"

void main()
{
  object oPC = GetPCLevellingUp();
  if (!GetIsPC(oPC)) return;
  string sDB = GetLocalString(GetModule(),"ORS_DATABASE");

  int nRelevel = FALSE;

/******************************************************************************/
// CCS Epic Level Trainers

  int nEpic = GetCampaignInt(CCS_DATABASE,"ENABLE_EPIC_LEVELS",oPC);

  //Epic Level Trainers Not Turned On
  if(nEpic == 0)
  {
    //Check to See if Need to be Turned On
    if(CCS_EPIC_LEVEL_CONRTOL)
    {
      SetCampaignInt(CCS_DATABASE,"ENABLE_EPIC_LEVELS",1,oPC);
    }
  }

  //Epic Level Trainers Turned On But Now Need to Trun Off
  if(nEpic == 1)
  {
    //Check to See if Need to be Turned On
    if(!CCS_EPIC_LEVEL_CONRTOL)
    {
      SetCampaignInt(CCS_DATABASE,"ENABLE_EPIC_LEVELS",0,oPC);
    }
  }

/******************************************************************************/
// BANNED FEATS AND OTHER PRELEVEL CHECKS

  //Dev Crit Not Allowed
  int nDCAllow = GetLocalInt(GetModule(),"DEVCRIT");
  if(nDCAllow == 1)
  {
     int nDevCrit = 0;
     //Now Check for DevCrit Feats Chosen at Level Up
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_BASTARDSWORD, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_BATTLEAXE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_CLUB, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DAGGER, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DART, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DIREMACE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DOUBLEAXE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DWAXE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_GREATAXE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_GREATSWORD, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_HALBERD, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_HANDAXE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_HEAVYCROSSBOW, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_HEAVYFLAIL, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_KAMA, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_KATANA, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_KUKRI, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LIGHTCROSSBOW, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LIGHTFLAIL, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LIGHTHAMMER, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LIGHTMACE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LONGBOW, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LONGSWORD, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_MORNINGSTAR, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_QUARTERSTAFF, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_RAPIER, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SCIMITAR, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SCYTHE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SHORTBOW, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SHORTSPEAR, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SHORTSWORD, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SHURIKEN, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SICKLE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SLING, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_THROWINGAXE, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_TWOBLADEDSWORD, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_UNARMED, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_WARHAMMER, oPC)) nDevCrit = TRUE;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_WHIP, oPC)) nDevCrit = TRUE;

     if (nDevCrit == TRUE)
     {
       nRelevel = TRUE;
       SendMessageToPC(oPC,"Devastating Critical is Forbidden! You will be relevelled!");
    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
     }
  }

  //Circle Kick Relevel
  int nCK = 0;
  if(GetHasFeat(FEAT_EPIC_DODGE, oPC)) nCK = TRUE;
  if(nCK == TRUE)
  {
    nRelevel = TRUE;
    SendMessageToPC(oPC,"Epic Dodge is Forbidden! You will be relevelled!");
    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
  }
 // Removal of Epic WIld Shape Dragon
  int nEDS = 0;
  if(GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON, oPC)) nEDS = TRUE;
  if(nEDS == TRUE)
  {
    nRelevel = TRUE;
    SendMessageToPC(oPC,"Epic Dragon Form is Forbidden! You will be relevelled!");
    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
  }
// Removal of Shifter Class
  int nSFT = 0;
  if ((GetLevelByClass(CLASS_TYPE_SHIFTER, oPC))) nSFT = TRUE;
  if(nSFT == TRUE)
  {
    nRelevel = TRUE;
    SendMessageToPC(oPC,"Shifter is Forbidden! You will be relevelled!");
    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
  }

  if ((GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC)))
    {
   if (GetItemPossessedBy(oPC, "pmalllowed")== OBJECT_INVALID)
   {
    nRelevel = TRUE;
    SendMessageToPC(oPC,"You are not allowed Pale Master. You will be relevelled!");
    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
    }
  }

  if ((GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC)))
    {
   if (GetItemPossessedBy(oPC, "rddalllowed")== OBJECT_INVALID)
        {
    nRelevel = TRUE;
    SendMessageToPC(oPC,"You are not allowed Red Dragon Disciple. You will be relevelled!");
    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
        }
    }

  if ((GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)))
    {
   if (GetItemPossessedBy(oPC, "bgalllowed")== OBJECT_INVALID)
        {
    nRelevel = TRUE;
    SendMessageToPC(oPC,"You are not allowed Blackguard. You will be relevelled!");
    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
        }
    }

// No monks above level 19
  int nMK = 0;
  if ((GetLevelByClass(CLASS_TYPE_MONK, oPC)>19)) nMK = TRUE;
  if(nMK == TRUE)
        {
    nRelevel = TRUE;
    SendMessageToPC(oPC,"You have reached the max Monk Levels. You will be relevelled!");
    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
        }


   if (GetItemPossessedBy(oPC, "hunter_leocross")!= OBJECT_INVALID)
   {
        int nCLE = 0;
         if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>16))nCLE = TRUE;
        if(nCLE == TRUE)
          if (GetItemPossessedBy(oPC, "epicclericallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a higher power for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nDRU = 0;
         if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC)>16))nDRU = TRUE;
        if(nDRU == TRUE)
          if (GetItemPossessedBy(oPC, "epicdruidallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a higher power for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nSOR = 0;
         if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>16))nSOR = TRUE;
        if(nSOR == TRUE)
          if (GetItemPossessedBy(oPC, "epicsorcallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a higher power for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nWIZ = 0;
         if ((GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>16))nWIZ = TRUE;
        if(nWIZ == TRUE)
          if (GetItemPossessedBy(oPC, "epicwizallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a higher power for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
          }
     }

   if (GetItemPossessedBy(oPC, "garoucrinosshift")!= OBJECT_INVALID)
   {

        int nDC = 0;
         if ((GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC)>16))nDC = TRUE;
        if(nDC == TRUE)
          if (GetItemPossessedBy(oPC, "epicclericallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nCLE = 0;
         if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>16))nCLE = TRUE;
        if(nCLE == TRUE)
          if (GetItemPossessedBy(oPC, "epicclericallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nDRU = 0;
         if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC)>16))nDRU = TRUE;
        if(nDRU == TRUE)
          if (GetItemPossessedBy(oPC, "epicdruidallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nSOR = 0;
         if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>16))nSOR = TRUE;
        if(nSOR == TRUE)
          if (GetItemPossessedBy(oPC, "epicsorcallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nWIZ = 0;
         if ((GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>16))nWIZ = TRUE;
        if(nWIZ == TRUE)
          if (GetItemPossessedBy(oPC, "epicwizallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
          }
     }

   if (GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_FANGS")!= OBJECT_INVALID)
   {

        int nDC = 0;
         if ((GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC)>16))nDC = TRUE;
        if(nDC == TRUE)
          if (GetItemPossessedBy(oPC, "epicclericallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nCLE = 0;
         if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>16))nCLE = TRUE;
        if(nCLE == TRUE)
          if (GetItemPossessedBy(oPC, "epicclericallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nDRU = 0;
         if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC)>16))nDRU = TRUE;
        if(nDRU == TRUE)
          if (GetItemPossessedBy(oPC, "epicdruidallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nSOR = 0;
         if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>16))nSOR = TRUE;
        if(nSOR == TRUE)
          if (GetItemPossessedBy(oPC, "epicsorcallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nWIZ = 0;
         if ((GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>16))nWIZ = TRUE;
        if(nWIZ == TRUE)
          if (GetItemPossessedBy(oPC, "epicwizallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a spirit for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
          }
     }

// The stuff for non supernaturals

        int nCLE = 0;
         if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>16))nCLE = TRUE;
        if(nCLE == TRUE)
          if (GetItemPossessedBy(oPC, "epicclericallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a higher power for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nDRU = 0;
         if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC)>16))nDRU = TRUE;
        if(nDRU == TRUE)
          if (GetItemPossessedBy(oPC, "epicdruidallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a higher power for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nSOR = 0;
         if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>16))nSOR = TRUE;
        if(nSOR == TRUE)
          if (GetItemPossessedBy(oPC, "epicsorcallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a higher power for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);


          }
        int nWIZ = 0;
         if ((GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>16))nWIZ = TRUE;
        if(nWIZ == TRUE)
          if (GetItemPossessedBy(oPC, "epicwizallow")== OBJECT_INVALID)
          {
             nRelevel = TRUE;
             SendMessageToPC(oPC,"You do not have the proper knowledge to advance. Please seek out a higher power for guidance. You have been Releveled.");

             ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
          }
/******************************************************************************/
// ORS TRAINER REQUIREMENTS (CCS by Darth John...Edited/Fixed by Olander for ORSv5)

  //Current Player Stats
  int nCurLevel = GetHitDice(oPC);
  int nCost = GetLocalInt(oPC, "CCS_GOLDCOST");

  int nPClass1 = NBDE_GetCampaignInt(sDB, "CCS_CLASS1", oPC);
  int nPClass2 = NBDE_GetCampaignInt(sDB, "CCS_CLASS2", oPC);
  int nPClass3 = NBDE_GetCampaignInt(sDB, "CCS_CLASS3", oPC);

  int nLClass1 = NBDE_GetCampaignInt(sDB, "CCS_LEVEL1", oPC);
  int nLClass2 = NBDE_GetCampaignInt(sDB, "CCS_LEVEL2", oPC);
  int nLClass3 = NBDE_GetCampaignInt(sDB, "CCS_LEVEL3", oPC);

  //Current Class Types
  int nClassType1 = GetClassByPosition(1,oPC);
  int nClassType2 = GetClassByPosition(2,oPC);
  int nClassType3 = GetClassByPosition(3,oPC);

  //Current Levels in Each Class
  int nClassLvl1 = GetLevelByClass(nClassType1,oPC);
  int nClassLvl2 = GetLevelByClass(nClassType2,oPC);
  int nClassLvl3 = GetLevelByClass(nClassType3,oPC);

  //Class Trainers
  if(CCS_CHARACTER_LEVEL_CONTROL)
  {
    if(nCurLevel >= CCS_TRAINER_START)
    {
      int nAllow = FALSE;

      int nBTT = GetLocalInt(oPC,"ALLOWLEVEL");

      //XP Continue Rules
      if(CCS_XP_LEVEL_CAP)
      {
        int nNewXP = ((nCurLevel * (nCurLevel-1)) / 2 * 1000) + 1;
        SetXP(oPC, nNewXP);
      }

      //Did Not Go To a Trainer
      if(!nBTT)
      {
        SendMessageToPC(oPC,GAINLEVEL);

        nRelevel = TRUE;
        DeleteLocalInt(oPC,"ALLOWLEVEL");
        BlockAllClasses(oPC);
      }

      //Check New Level vs. Old Level
      if(nClassType1 != CLASS_TYPE_INVALID && nBTT)
      {
        //Level in Base Class
        if(nClassLvl1 > nLClass1)
        {
          //Validate if Class was Not Ok to Level In
          int nVerify = VerifyClass(oPC, nClassType1);
          if(nVerify == FALSE)
          {
            nRelevel = TRUE;
            DeleteLocalInt(oPC,"ALLOWLEVEL");
            BlockAllClasses(oPC);
            SendMessageToPC(oPC,CANTTRAIN);
          }
          else nAllow = TRUE;
        }
      }

      //Check New Level vs. Old Level
      if(nClassType2 != CLASS_TYPE_INVALID && nBTT)
      {
        //Previous Class was Invalid
        if(nLClass2 == 255) nLClass2 = 0;

        //Level in 2nd Class
        if(nClassLvl2 > nLClass2)
        {
          //Validate if Class was Not Ok to Level In
          int nVerify = VerifyClass(oPC, nClassType2);
          if(nVerify == FALSE)
          {
            nRelevel = TRUE;
            DeleteLocalInt(oPC,"ALLOWLEVEL");
            BlockAllClasses(oPC);
            SendMessageToPC(oPC,CANTTRAIN);
          }
          else nAllow = TRUE;
        }
      }

      //Check New Level vs. Old Level
      if(nClassType3 != CLASS_TYPE_INVALID && nBTT)
      {
        //Previous Class was Invalid
        if(nLClass3 == 255) nLClass3 = 0;

        //Level in 3rd Class
        if(nClassLvl3 > nLClass3)
        {
          //Validate if Class was Not Ok to Level In
          int nVerify = VerifyClass(oPC, nClassType3);
          if(nVerify == FALSE)
          {
            nRelevel = TRUE;
            DeleteLocalInt(oPC,"ALLOWLEVEL");
            BlockAllClasses(oPC);
            SendMessageToPC(oPC,CANTTRAIN);
          }
          else nAllow = TRUE;
        }
      }

      //Classes are Ok Allow Progression to Next Level
      if(nAllow == TRUE)
      {
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
    else if(CCS_TRAINER_START && CCS_MULTICLASS_LEVEL_CONTROL)
    {
      EnableFamiliarClasses(oPC);

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
    }
    else if(!CCS_MULTICLASS_LEVEL_CONTROL)
    {
      AllowAllClasses(oPC);

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
    }
    else
    {
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
    }
  }
  else
  {
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

/******************************************************************************/
// RELEVEL PLAYER

  int nCurXP = GetXP(oPC);

  if(nRelevel == TRUE)
  {
    SetLocalInt(oPC,"ORS_LEVELRET",1);

    int nPreXP;

    switch(nCurLevel)
    {
      case  0: nPreXP = 0;break;
      case  1: nPreXP = 0;break;
      case  2: nPreXP = 1;break;
      case  3: nPreXP = 1000;break;
      case  4: nPreXP = 3000;break;
      case  5: nPreXP = 6000;break;
      case  6: nPreXP = 10000;break;
      case  7: nPreXP = 15000;break;
      case  8: nPreXP = 21000;break;
      case  9: nPreXP = 28000;break;
      case 10: nPreXP = 36000;break;
      case 11: nPreXP = 45000;break;
      case 12: nPreXP = 55000;break;
      case 13: nPreXP = 66000;break;
      case 14: nPreXP = 78000;break;
      case 15: nPreXP = 91000;break;
      case 16: nPreXP = 105000;break;
      case 17: nPreXP = 120000;break;
      case 18: nPreXP = 136000;break;
      case 19: nPreXP = 153000;break;
      case 20: nPreXP = 171000;break;
      case 21: nPreXP = 190000;break;
      case 22: nPreXP = 210000;break;
      case 23: nPreXP = 231000;break;
      case 24: nPreXP = 253000;break;
      case 25: nPreXP = 276000;break;
      case 26: nPreXP = 300000;break;
      case 27: nPreXP = 325000;break;
      case 28: nPreXP = 351000;break;
      case 29: nPreXP = 378000;break;
      case 30: nPreXP = 406000;break;
      case 31: nPreXP = 435000;break;
      case 32: nPreXP = 465000;break;
      case 33: nPreXP = 496000;break;
      case 34: nPreXP = 528000;break;
      case 35: nPreXP = 561000;break;
      case 36: nPreXP = 595000;break;
      case 37: nPreXP = 630000;break;
      case 38: nPreXP = 666000;break;
      case 39: nPreXP = 703000;break;
      case 40: nPreXP = 741000;break;
    }

    //Now Set How Much XP to Give Back
    int nRetXP = nCurXP - nPreXP;

    //Now we set the Previous XP
    SetXP(oPC, nPreXP);

    //Return Gold if Went to Trainer
    if(nCost > 0) GiveGoldToCreature(oPC,nCost);
    DeleteLocalInt(oPC, "CCS_GOLDCOST");

    //Now Delay the Returned XP For Relevel
    DelayCommand(5.0,GiveXPToCreature(oPC,nRetXP));
    DelayCommand(5.1,SetLocalInt(oPC,"ORS_LEVELRET",0));

    ActionTakeStackedItemsByTag("vamppoint",oPC, 1);
    ActionTakeStackedItemsByTag("garougnoisepoint",oPC, 1);
    ActionTakeStackedItemsByTag("hunterspoint",oPC, 1);
    ActionTakeStackedItemsByTag("magepoint",oPC, 1);
  }
}
