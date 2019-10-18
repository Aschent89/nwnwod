////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_rest_start
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Module On Rest Event
//
//  This is the resting package for both the Camping and HTF Systems
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

int GetTotalTime()
{
  int nYear = GetCalendarYear();
  int nMonth = GetCalendarMonth();
  int nDay = GetCalendarDay();
  int nHour = GetTimeHour();

  int nTTime = (nYear * 12 * 28 * 24) + ((nMonth - 1) * 28 * 24) + ((nDay - 1) * 24) + nHour;
  return nTTime;
}

void main()
{
    object oPC          = OBJECT_SELF;
    object oMod         = GetModule();
    string sDB          = ORS_GetDBString();

    //From Master Configuration ors_mod_onload
    int nRESTGLOBAL = GetLocalInt(GetModule(),"RESTGLOBAL");
    if(nRESTGLOBAL == 0) return;

    int nPHBRest        = GetLocalInt(oMod,"RESTPHB");//PHB Resting Rules
    int nMinLevel       = GetLocalInt(oMod,"RESTLEVEL");//Level to Start Resting Restrictions
    int nRHours         = GetLocalInt(oMod,"RESTHOURS");//Number of Hours a Player Must Wait Between Rests
    int nPHBHeal        = GetLocalInt(oMod,"RESTHEAL");//Healing on Resting Per HP per level Plus CON
    int nCONBonus       = GetLocalInt(oMod,"RESTCON");//Add HP's equal to the Constitution Ability Score * CON Bonus (0 is Off)
    int nHPPerHD        = GetLocalInt(oMod,"RESTHP");//How many HP's per HD you wish to Heal

    string sS           = "";
    int nHungerHP       = GetLocalInt(oMod,"HUNGER");
    int nThirstHP       = GetLocalInt(oMod,"THIRST");
    int nFatigueHP      = GetLocalInt(oMod,"FATIGUE");
    int nHUNGERSYSTEM   = GetLocalInt(oMod,"HUNGERSYSTEM");
    int nFATIGUESYSTEM  = GetLocalInt(oMod,"FATIGUESYSTEM");
    float fRestrict     = GetLocalFloat(oMod,"RESTRESTRICTIONPERCENT");
    int nHCurrent       = GetLocalInt(oPC,"HUNGER");
    int nTCurrent       = GetLocalInt(oPC,"THIRST");
    int nLRHour         = GetLocalInt(oPC,"LRHOUR");
    int nRAllow         = GetLocalInt(oPC,"REST_ALLOWED");
    int nRestType       = GetLocalInt(oPC,"REST_TYPE");
    int nLevel          = GetHitDice(oPC);
    int nTTime          = GetTotalTime();
    int nMaxHP          = GetMaxHitPoints(oPC);
    int nCurHP          = GetCurrentHitPoints(oPC);
    float fHCanRest     = fRestrict * IntToFloat(nHungerHP);
    float fTCanRest     = fRestrict * IntToFloat(nThirstHP);
    int nAC             = GetArcaneSpellFailure(oPC);
    int nCheck          = 0;
    effect eBad;

    //Set the Current HP Status to PC just in case rest is cancelled
    SetLocalInt(oPC, "STARTRESTHP", nCurHP);

    if(nRestType == 1)
    {
      SetLocalInt(oPC,"REST_START",1);
      AssignCommand(oPC,ActionRest());
    }

//:*****************************************************************************/
//:PHB RULES SETUP

    if(nPHBRest == 1 && nRestType == 1)
    {
      //Check if above Minimum Level
      if(nLevel >= nMinLevel)
      {
        nCheck = (nLRHour + nRHours) - nTTime;

        //Is the Current Time Less than Required
        if(nCheck <= 0)
        {
          //Now we figured out how much to Heal when Resting
          if(nPHBHeal == 1)
          {
            //Configure the CON Bonus to Healing
            int nCON = 0;
            if(nCONBonus == 1)
            {
              int nCAS = GetAbilityScore(oPC,ABILITY_CONSTITUTION);
              if(nCAS < 0) nCAS = 0;
              int nCAM = GetAbilityModifier(ABILITY_CONSTITUTION,oPC);
              if(nCAM < 0) nCAM = 0;

              nCON = nCAS * nCAM;
            }

            //Configure Total New HP's
            int nHeal = (nHPPerHD * nLevel) + nCON +nCurHP;
            SetLocalInt(oPC, "HEALRESTHP", nHeal);
          }
        }

        //Not Allowed to Rest Yet
        if(nCheck > 0)
        {
          if(nCheck > 1) sS = "s";
          SendMessageToPC(oPC,"You must wait " +IntToString(nCheck)+ " hour" +sS+ " before resting again.");
          SetLocalInt(oPC, "REST_ALLOWED", FALSE);
          SetLocalInt(oPC, "TENT", FALSE);
          SetLocalInt(oPC,"REST_MENU",0);
          SetLocalInt(oPC,"REST_TYPE",0);
          SetLocalInt(oPC,"REST_START",0);
          AssignCommand(oPC,ClearAllActions());
          return;
        }
      }
      else
      {
        SetLocalInt(oPC, "HEALRESTHP", nCurHP);
      }
    }

//:PHB RULES SETUP
//:*****************************************************************************/

//:*****************************************************************************/
//:REST EVENT STARTED

    if(nRestType == 1)
    {
      if(nRAllow != TRUE)
      {
        //HTF Hunger and Thirst System
        if(nHUNGERSYSTEM = 1)
        {
          if (IntToFloat(nHCurrent) < fHCanRest)
          {
            SendMessageToPC(oPC,"I will not be able to rest on an empty stomach.");
            SetLocalInt(oPC, "REST_ALLOWED", FALSE);
            SetLocalInt(oPC, "TENT", FALSE);
          }
          if (IntToFloat(nTCurrent) < fTCanRest)
          {
            SendMessageToPC(oPC,"I will not be able to rest while thirsty.");
            SetLocalInt(oPC, "REST_ALLOWED", FALSE);
            SetLocalInt(oPC, "TENT", FALSE);
          }
        }
        FloatingTextStringOnCreature("I can not rest at this time.", oPC);
        AssignCommand(oPC,ClearAllActions());
      }
      else
      {
        //Harkinian's Cohorts
        //object oHench = GetHenchman(oPC);
        //if(GetIsObjectValid(oHench)) ExecuteScript("hench_rest", oHench);

        SetLocalInt(oPC, "RESTING_NOW", TRUE);
        SetLocalInt(oPC, "REST_ALLOWED", FALSE);
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oPC,10.5 + IntToFloat(nLevel)));
        DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_SLEEP),oPC));
        SetLocalInt(oPC, "TENT", FALSE);
      }
    }

//:REST EVENT STARTED
//:*****************************************************************************/

//:*****************************************************************************/
//:REST EVENT CANCELLED

    if(nRestType == 2)
    {
      if(GetLocalInt(oPC, "RESTING_NOW") == TRUE)
      {
        if(nPHBRest == 1 && nPHBHeal == 1)
        {
          //Return Original HP to Player
          int nOrigHP = GetLocalInt(oPC, "STARTRESTHP");
          int nDamage = GetCurrentHitPoints(oPC) - nOrigHP;
          if(nDamage > 0) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage),oPC);
        }
        effect eRest = GetFirstEffect(oPC);
        int nEffectType;
        while(GetIsEffectValid(eRest))
        {
          nEffectType = GetEffectType(eRest);
          if(nEffectType == EFFECT_TYPE_BLINDNESS || nEffectType==VFX_IMP_SLEEP) RemoveEffect(oPC,eRest);
          eRest = GetNextEffect(oPC);
        }

        //Reset Resting
        SetLocalInt(oPC, "RESTING_NOW", FALSE);
        SetLocalInt(oPC,"REST_MENU",0);
        SetLocalInt(oPC,"REST_TYPE",0);
        SetLocalInt(oPC,"REST_START",0);
        DeleteLocalInt(oPC,"STARTRESTHP");
        DeleteLocalInt(oPC,"HEALRESTHP");
      }
    }

//:REST EVENT CANCELLED
//:*****************************************************************************/

//:*****************************************************************************/
//:REST EVENT FINISHED

    if(nRestType == 3)
    {
      if(nPHBRest == 1 && nPHBHeal == 1)
      {
        //Return Original HP to Player
        int nNewHP = GetLocalInt(oPC, "HEALRESTHP");
        int nDamage = GetCurrentHitPoints(oPC) - nNewHP;
        if(nDamage > 0) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage),oPC);
      }

      //HTF Fatigue System
      if(nFATIGUESYSTEM = 1)
      {
        // Checks for Armor, Shields, and Clothing
        if (nAC <= 0)
        {
          nFatigueHP = nFatigueHP - 0;
          SendMessageToPC(oPC, "You slept very nicely.");
        }
        else if (nAC > 0 && nAC < 20)
        {
          nFatigueHP = nFatigueHP - 500;
          SendMessageToPC(oPC, "Your equipped items made you rest slightly uncomfortably.");
        }
        else if (nAC >= 20 && nAC < 40)
        {
          nFatigueHP = nFatigueHP - 1000;
          SendMessageToPC(oPC, "Your equipped items made you rest uncomfortably.");
        }
        else if (nAC >= 40 && nAC < 60)
        {
          nFatigueHP = nFatigueHP - 2000;
          SendMessageToPC(oPC, "Your equipped items made you sleep poorly.");
        }
        else if (nAC >= 60 && nAC < 80)
        {
          nFatigueHP = nFatigueHP - 4000;
          SendMessageToPC(oPC, "Your equipped items made toss and turn all night.");
        }
        else if (nAC >= 80 && nAC <= 100)
        {
          nFatigueHP = nFatigueHP - 6000;
          SendMessageToPC(oPC, "Your equipped items made you very uncomfortable.");
        }
        AssignCommand (oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED));
        SetLocalInt(oPC,"FATIGUE",nFatigueHP);
      }

      //Remove Effects
      effect eRest = GetFirstEffect(oPC);
      int nEffectType;
      while(GetIsEffectValid(eRest))
      {
        nEffectType = GetEffectType(eRest);
        if(nEffectType == EFFECT_TYPE_BLINDNESS || nEffectType==VFX_IMP_SLEEP) RemoveEffect(oPC,eRest);
        eRest = GetNextEffect(oPC);
      }

      //Reset Player Reputations
      ResetReputations(oPC);

      //Export Player
      ExportSingleCharacter(oPC);

      //Freshen the Player
      SetLocalInt(oPC, "RESTING_NOW", FALSE);
      SetLocalInt(oPC,"REST_MENU",0);
      SetLocalInt(oPC,"REST_TYPE",0);
      SetLocalInt(oPC,"REST_START",0);
      SetLocalInt(oPC, "LRHOUR", nTTime);
      DeleteLocalInt(oPC,"STARTRESTHP");
      DeleteLocalInt(oPC,"HEALRESTHP");
      NBDE_SetCampaignInt(sDB,"ALCCOUNT",0,oPC);
      SetLocalInt(oPC, "REST_ALLOWED", FALSE);
      SetLocalInt(oPC, "TENT", FALSE);
      AssignCommand(oPC,ClearAllActions());
    }

//:REST EVENT FINISHED
//:*****************************************************************************/
}
