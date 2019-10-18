////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Bandages and Jumping/Climbing Rope
//  ors_mod_onact
//  By Don Anderson
//  dandersonru@msn.com
//
//  Allows Jumping and Climbing from a Climbing Rope in an Outdoor Area
//
//  Place this script in the Module On Activate Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"
#include "oho_inc"

void main()
{
  object oPC = GetItemActivator();
  object oMod = GetModule();
  object oTarget = GetItemActivatedTarget();
  object oItem = GetItemActivated();
  string sTag = GetTag(oItem);
  location lPC = GetLocation(oPC);
  string sDB = ORS_GetDBString();

  //This is Handy for DM/Player/Tester to Change Day/Night
  if(sTag == "DM_DAYNIGHTTOOL")
  {
    int nHour    = GetTimeHour();

    //Set these to your Module Morning and Evening Setting
    int nMorning = 6;
    int nEvening = 18;

    if (nHour >= 18) nHour = nMorning;
    else if (nHour < 18) nHour = nEvening;

    SetTime(nHour,0,0,0);
  }

  //This is Handy for DM/Player/Tester to Change Day/Night
  if(sTag == "PCAppearanceTool")
  {
    int nRace = GetRacialType(oTarget);
    int nDefApp = StringToInt(Get2DAString("racialtypes","Appearance",nRace));
    int nDefPheno;
    int nPheno = GetPhenoType(oTarget);
    if(nPheno == 8 || nPheno == 5) nDefPheno = PHENOTYPE_BIG;
    else {nDefPheno = PHENOTYPE_NORMAL;}
    SetCreatureAppearanceType(oTarget,nDefApp);
    SetPhenoType(nDefPheno,oTarget);
    SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,oTarget);
    SetFootstepType(FOOTSTEP_TYPE_NORMAL,oTarget);
    NBDE_SetCampaignInt(sDB, "ORS_PC_APPEARANCE", nDefApp, oPC);
  }

  if(sTag == "ClimbingRope")
  {
    int nNoJump = FALSE;

    //Under Not Jumping or Climbing Effects
    effect ePar = GetFirstEffect(oPC);
    while(GetIsEffectValid(ePar))
    {
      if(GetEffectType(ePar) == EFFECT_TYPE_PARALYZE
        || GetEffectType(ePar) == EFFECT_TYPE_CUTSCENE_PARALYZE
        || GetEffectType(ePar) == EFFECT_TYPE_BLINDNESS
        || GetEffectType(ePar) == EFFECT_TYPE_FRIGHTENED
        || GetEffectType(ePar) == EFFECT_TYPE_DAZED
        || GetEffectType(ePar) == EFFECT_TYPE_CONFUSED)
      {
        nNoJump = TRUE;
        break;
      }

      ePar = GetNextEffect(oPC);
    }

    //Riding a Horse
    if(OHOPCRidingHorse(oPC))
    {
      nNoJump = TRUE;
    }

    //Hostiles Closer than 10 Meters
    if(IsEnemyInRange(oPC, 10.0))
    {
      nNoJump = TRUE;
    }

    object oTarget = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();
    float fFace = GetFacingFromLocation(lTarget);

    //Now Check to See if we are allowed to jump and climb
    int nAllow = GetLocalInt(oPC,"ALLOWJUMP");
    if(nAllow == 0 || nNoJump == TRUE)
    {
      SendMessageToPC(oPC,"You can not Jump or Climb right now.");
      return;
    }

    //Check for Targetted Something
    if(GetIsObjectValid(oTarget) == TRUE)
    {
      SendMessageToPC(oPC,"You must target the ground to jump or climb.");
      return;
    }

    if(nAllow == 1)
    {
      effect eFly = EffectDisappearAppear(lTarget);
      effect eFlyWind = EffectVisualEffect(VFX_IMP_PULSE_WIND);

      //Duration MUST be 3.0 or higher. Higher for busy areas.
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFly, oPC, 4.0);

      //Gust of wind effect for takeoff! Experimental.
      DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFlyWind, lPC));

      //Jump all the Extra Creatures
      JumpAssociates(oPC);
    }
  }
/*
  if(sTag == "Bandage")
  {
    int nCharges    = GetItemCharges(oItem);
    int nTime       = (GetSkillRank(SKILL_HEAL, oPC) / 4) + 1;//Amount of Time it takes to Dress Wounds
    int nCurHP      = GetCurrentHitPoints(oTarget);
    int nMaxHP      = GetMaxHitPoints(oTarget);
    int nHeal       = GetSkillRank(SKILL_HEAL, oPC);
    int nCON        = GetAbilityModifier(ABILITY_CONSTITUTION,oTarget);//CON of Target is added to Heal Skill
    int nHMin       = 5; //Minimum added to Heal Skill
    int nSkill      = nHeal + nHMin + nCON;//Total Heal Skill

    int nRange      = 10;
    int nEIR        = FALSE; //IsEnemyInRange(oPC, IntToFloat(nRange));
    int nType       = GetObjectType(oTarget);

    //Checks if an enemy is NOT in range and that the target is a creature
    if(nEIR == FALSE && nType == OBJECT_TYPE_CREATURE)
    {
      //Now we get the DC of the Heal and Skill of the Healer
      int nDC = DCHeal(oTarget);
      int nDieRoll = d20();
      if (nDieRoll + nSkill < nDC)
      {
        //We check to see if it is even possible for the Player to heal the wounds
        if (20 + GetSkillRank(SKILL_HEAL, oPC) < nDC)
        {
          SendMessageToPC(oPC, "[DC" + IntToString(nDC) + "]:Your skill in Healing is not sufficient enough to heal these wounds.");
        }
        //If the Player is capable then we tell them that they ruined the bandage.
        else SendMessageToPC(oPC, "[DC" + IntToString(nDC) + "]:You Ruined That Bandage.");
        return;
      }

      //Now we Heal the Target
      if(nSkill > (nMaxHP - nCurHP))
      {
        //We must make sure that we only heal up to the max hit points
        nSkill = nMaxHP - nCurHP;
      }
      effect eHeal = EffectHeal(nSkill);
      effect eVisual = EffectVisualEffect(VFX_IMP_TORNADO);
      DelayCommand(15.0 - (nTime * 1.0) , ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
      DelayCommand(15.0 - (nTime * 1.0) , ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget));
      SendMessageToPC(oPC, "[DC" + IntToString(nDC) + "]:Nicely dressed and finished. You will be healed " + IntToString(nSkill) + " points from this Bandage shortly. Herbs need a little time to set up.");
    }
    //If the Target is not a creature or enemies are present we add 1 charge back to the Bandage
    else
    {
      if(nEIR == TRUE) SendMessageToPC(oPC, "You may not use a Bandage while Enemies are Closer than "+IntToString(nRange)+" Meters");
      else if(nType != OBJECT_TYPE_CREATURE)
      {
        SendMessageToPC(oPC, "Target Must be a Creature.");
        object oNew = CreateItemOnObject(GetResRef(oItem),oPC);
        DestroyObject(oItem);
      }
    }
  }
 */
  //This is Handy for DM/Player/Tester to Change Day/Night
  if(sTag == "ORS_Propector")
  {
    if(IsEnemyInRange(oPC, 30.0))
    {
      SendMessageToPC(oPC,"You may not use the Resource Prospector while Enemies are Closer than "+IntToString(30)+" Meters");
      return;
    }

    //Lore Required
    int nRLore = GetLocalInt(oMod,"OCR_LORE");
    if(nRLore <= 0) nRLore = 10;

    //Player's Lore Skill (Raw Skill)
    int nPLore = GetSkillRank(SKILL_LORE,oPC);

    //Total Natural Herbal Bonuses
    int nHerb = 0;
    if(GetRacialType(oPC) == RACIAL_TYPE_ELF) nHerb = nHerb + 2;
    if(GetClassByPosition(1,oPC) == CLASS_TYPE_DRUID) nHerb = nHerb + 5;
    if(GetClassByPosition(1,oPC) == CLASS_TYPE_RANGER) nHerb = nHerb + 5;

    //Total Natural Ore Bonuses
    int nOre = 0;
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF) nOre = nOre + 5;
    if(GetRacialType(oPC) == RACIAL_TYPE_HUMAN) nOre = nOre + 2;

    int nOCR = 0;int nTHerb; int nTOre;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oPC), TRUE, OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
      nOCR = GetLocalInt(oTarget,"OCR_RESOURCE");

      //Placeable is a Resource
      if(nOCR == 1)
      {
        nTHerb = GetLocalInt(oTarget,"OCR_HERB");
        if(nTHerb == 1)
        {
          if((nPLore + nHerb) >= nRLore)
          {
            SetUseableFlag(oTarget,TRUE);
            DelayCommand(2.0, ExecuteScript("ocr_hb_resource", oTarget));
          }
        }

        nTOre = GetLocalInt(oTarget,"OCR_ORE");
        if(nTOre == 1)
        {
          if((nPLore + nOre) >= nRLore)
          {
            SetUseableFlag(oTarget,TRUE);
            DelayCommand(2.0, ExecuteScript("ocr_hb_resource", oTarget));
          }
        }
      }

      oTarget = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oPC), TRUE, OBJECT_TYPE_PLACEABLE);
    }
  }
/*
  //This is Handy for DM/Player/Tester to Change Day/Night
  if(sTag == "RallyHorn")
  {
    AssignCommand(oPC,PlaySound("as_cv_eulpipe1"));
    AssignCommand(oPC,PlaySound("as_cv_eulpipe2"));
    AssignCommand(oPC,PlaySound("as_cv_eulpipe1"));
  }

  //Guitars  VFX   820
*/
}
