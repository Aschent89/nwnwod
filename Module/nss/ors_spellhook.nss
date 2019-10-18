////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Spell Hook Script
//  ors_spellhook
//  By Don Anderson
//  dandersonru@msn.com
//
//  Cache this script!
//
////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"
#include "NW_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_toollib"
#include "x2_inc_craft"
#include "wdm_inc"
#include "oai_inc_weapstat"
#include "f_vampirespell_h"
//:****************************************************************************/
//: FUNCTIONS

int DetermineDuration()
{
    int nDuration = 1 + d4(1);
    int nSeconds = nDuration;
    int nDOverride = GetLocalInt(GetModule(),"TIMESTOP_DUR");
    if(nDOverride != 0) nSeconds = nDOverride;
    return nSeconds;
}

void TimeStopDelay(object oCaster)
{
    int nDelay = GetLocalInt(GetModule(),"TIMESTOP_DEL");
    float fDelay = IntToFloat(nDelay);
    float Delay1 = fDelay * 0.25;
    string Message1 = IntToString(FloatToInt(Delay1));
    float Delay2 = fDelay * 0.50;
    string Message2 = IntToString(FloatToInt(Delay2));
    float Delay3 = fDelay * 0.75;
    string Message3 = IntToString(FloatToInt(Delay3));
    SetLocalInt(oCaster, "TIMESTOP_DELAY", 1);
    FloatingTextStringOnCreature("Time Stop Recastable In " + IntToString(nDelay) + " seconds", oCaster, FALSE);
    DelayCommand(Delay1, FloatingTextStringOnCreature("Time Stop Recastable In " + Message3 + " seconds", oCaster, FALSE));
    DelayCommand(Delay2, FloatingTextStringOnCreature("Time Stop Recastable In " + Message2 + " seconds", oCaster, FALSE));
    DelayCommand(Delay3, FloatingTextStringOnCreature("Time Stop Recastable In " + Message1 + " seconds", oCaster, FALSE));
    DelayCommand(fDelay, FloatingTextStringOnCreature("Time Stop Ready", oCaster, FALSE));
    DelayCommand(fDelay, DeleteLocalInt(oCaster, "TIMESTOP_DELAY"));
}

void Timestop(object oCaster)
{
    object oArea = GetArea(oCaster);
    int nDuration = DetermineDuration();
    float fDuration = IntToFloat(nDuration);

    //Time Stop is AOE or Area Wide
    int nTSAOE = GetLocalInt(GetModule(),"TSAOE");

    if(nTSAOE == 0)
    {
      object oTarget = GetFirstObjectInArea(oArea);
      while (GetIsObjectValid(oTarget))
      {
        if(GetIsPC(oTarget) == TRUE || GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
          if(GetHasEffect(EFFECT_TYPE_CUTSCENE_PARALYZE,oTarget) == FALSE && oTarget != OBJECT_SELF)
          {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oTarget,fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oTarget,fDuration);
          }
        }
        oTarget = GetNextObjectInArea(oArea);
      }
    }
    else
    {
      //Radius of the Time Stop Spell
      int nRadius = GetLocalInt(GetModule(),"TSRAD");
      float fRadius = IntToFloat(nRadius);

      location lSpell = GetSpellTargetLocation();
      ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_TIME_STOP),OBJECT_SELF);

      //Freeze All Creatures
      object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lSpell,TRUE,OBJECT_TYPE_CREATURE);
      while(oTarget != OBJECT_INVALID)
      {
        if(GetHasEffect(EFFECT_TYPE_CUTSCENE_PARALYZE,oTarget) == FALSE && oTarget != OBJECT_SELF)
        {
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oTarget,fDuration);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oTarget,fDuration);
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lSpell,TRUE,OBJECT_TYPE_CREATURE);
      }
    }
}

void TimestopCheck(object oCaster, int nDuration)
{
    if (nDuration == 0) return;

    nDuration = nDuration - 1;
    float fDuration = IntToFloat(nDuration);
    object oArea = GetArea(oCaster);
    location lCaster = GetLocation(oCaster);

    effect eParalyze = EffectCutsceneParalyze();
    object oTarget = GetFirstObjectInArea(oArea);

    while (GetIsObjectValid(oTarget))
    {
      if(GetIsPC(oTarget) == TRUE || GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
      {
        if(GetIsDM(oTarget) == FALSE)
        {
          if(oTarget != oCaster)
          {
            effect eEffect = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eEffect))
            {
              if(GetEffectType(eEffect) == EFFECT_TYPE_CUTSCENE_PARALYZE)
              {
                SetLocalInt(oTarget, "TIME_STOPPED", 1);
              }
              eEffect = GetNextEffect(oTarget);
            }

            if(GetLocalInt(oTarget, "TIME_STOPPED") == 0)
            {
              FloatingTextStringOnCreature("Time Stopped", oTarget, FALSE);
              AssignCommand(oTarget, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, oTarget, fDuration));
            }

            DeleteLocalInt(oTarget, "TIME_STOPPED");
          }
        }
      }

     oTarget = GetNextObjectInArea(oArea);
   }

   DelayCommand(1.0, TimestopCheck(oCaster, nDuration));
}

void GSStopDelay(object oCaster)
{
    int nDelay = GetLocalInt(GetModule(),"GSANCTUARY_DEL");//In Rounds
    float fDelay = IntToFloat(nDelay);
    float Delay1 = fDelay * 0.25;
    string Message1 = IntToString(FloatToInt(Delay1));
    float Delay2 = fDelay * 0.50;
    string Message2 = IntToString(FloatToInt(Delay2));
    float Delay3 = fDelay * 0.75;
    string Message3 = IntToString(FloatToInt(Delay3));
    SetLocalInt(oCaster, "GSANCTUARY_DELAY", 1);
    SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + IntToString(nDelay) + " seconds");
    DelayCommand(Delay1, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message3 + " seconds"));
    DelayCommand(Delay2, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message2 + " seconds"));
    DelayCommand(Delay3, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message1 + " seconds"));
    DelayCommand(fDelay, SendMessageToPC(oCaster,"Greater Sanctuary Ready"));
    DelayCommand(fDelay, DeleteLocalInt(oCaster, "GSANCTUARY_DELAY"));
}

int ORS_Attacks(int BAB)
{
  if(BAB%5){return BAB/5 + 1;}
  else {return BAB/5;}
}

//: FUNCTIONS
//:****************************************************************************/

void main()
{
  object oMod = GetModule();

  int nSpell = GetSpellId(); // returns the SPELL_* constant of the spell cast
  object oTarget = GetSpellTargetObject();
  location lTarget = GetSpellTargetLocation();
  int nCasterLevel = GetCasterLevel(OBJECT_SELF);
  location lLoc = GetLocation(OBJECT_SELF);
  int nCasterAlignment = GetAlignmentGoodEvil(OBJECT_SELF);
  int nTargetLevel = GetHitDice(oTarget);
  float fDuration=0.0f;
  effect eEffect1,eEffect2,eEffect3;
  int nUndeadR = GetRacialType(oTarget);

  //Undeads
  int IsUndead = FALSE;
  if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) IsUndead = TRUE;

  int nCLEAR = FALSE;
  int nType = GetObjectType(oTarget);
  if(nType == OBJECT_TYPE_ITEM)
  {
    if(CIGetIsCraftFeatBaseItem(oTarget))
    {
      if(GetLocalInt(oMod,"BIOCRAFT") <= 0)
      {
        SetModuleOverrideSpellScriptFinished();
        return;
      }
      else nCLEAR = TRUE;
    }
//Vampire SUbrace check
string sRace= GetSubRace(OBJECT_SELF);
 object oItem;
 int nCheck;
 string sResRef;
 if(sRace == "Vampire")//enter your subrace string here
 {
  oItem = GetItemPossessedBy(OBJECT_SELF, "FALLEN_VAMPIRE_GOOD_BLOOD");//item tag here
  nCheck = GetItemStackSize(oItem);//retrieves the stack size
  if(!GetIsObjectValid(oItem))//if they DO NOT have a valid object
  {
   SetModuleOverrideSpellScriptFinished();//kill the spell and send message
   SendMessageToPC(OBJECT_SELF, "You do not have the to cast that spell.");
  }
  else//else they DO HAVE a valid object
  {
   sResRef = GetResRef(oItem);//get resref of item
   nCheck = nCheck-1;//reduce the stack size int by one
   DestroyObject(oItem);//destroy the stack/single item
    if(nCheck > 0)//if there should be anymore in the stack left
    {
     CreateItemOnObject(sResRef, OBJECT_SELF, nCheck);
    }
   }
  }
  //This should fall on through and complete the spell now, seeing as we shut em
 //off when we checked for Subrace /then/ Item and ended the spell if they did
 //not pass
//Fallen Vampire Script
int iSpell = GetSpellId(); //this is the same as GetLastSpell isn't it?
switch(iSpell)
    {
    case SPELL_LESSER_RESTORATION: nw_s0_lsrestor(); break;
    case SPELL_RESTORATION: nw_s0_restore(); break;
    case SPELL_GREATER_RESTORATION: nw_s0_grrestore(); break;
    case SPELL_HEAL: nw_s0_heal(); break;
    case SPELL_MASS_HEAL: nw_s0_masheal(); break;
    case SPELL_HEALING_CIRCLE: nw_s0_healcirc(); break;
    case SPELL_NEGATIVE_ENERGY_BURST: nw_s0_negburst(); break;
    case SPELL_NEGATIVE_ENERGY_RAY: nw_s0_negray(); break;
    //case SPELLABILITY_PULSE_NEGATIVE: break; //spell abilities do not use the hooks
    //case SPELLABILITY_DRAGON_BREATH_NEGATIVE: break; //spell abilities do not use the hooks
    case SPELL_CURE_CRITICAL_WOUNDS: nw_s0_curcrwn(); break;
    case SPELL_CURE_LIGHT_WOUNDS: nw_s0_curlgtw(); break;
    case SPELL_CURE_MINOR_WOUNDS: nw_s0_curminw(); break;
    case SPELL_CURE_MODERATE_WOUNDS: nw_s0_curmodw(); break;
    case SPELL_CURE_SERIOUS_WOUNDS: nw_s0_curserw(); break;
    case 431: case 432: case 609: case 433: case 610:
    case 434: case 611: case 435: case 612: x0_s0_inflict(); break;
    case SPELL_HARM: nw_s0_harm(); break;
    case SPELL_CIRCLE_OF_DOOM: nw_s0_circdoom(); break;
    case SPELL_HORRID_WILTING: nw_s0_horrwilt(); break;
    case SPELL_SEARING_LIGHT: nw_s0_searlght(); break;
    case SPELL_SUNBEAM: nw_s0_sunbeam(); break;
    case SPELL_SUNBURST: x0_s0_sunburst(); break;
    case SPELL_VAMPIRIC_TOUCH: nw_s0_vamptch(); break;
    //case SPELLABILITY_PULSE_HOLY: break; //spell abilities do not use the hooks
    //case SPELLABILITY_TURN_UNDEAD: break; //spell abilities do not use the hooks
    case SPELL_STONE_BONES: x2_s0_stnbones(); break;
    case SPELL_UNDEATH_TO_DEATH: x2_s0_undeath(); break;
    case SPELL_HEALING_STING: x2_s0_healstng(); break;
    case SPELL_DROWN: x0_s0_drown(); break;
    default: return;
    }
  }

//:****************************************************************************/
//: DEAD AND WILD MAGIC

  if(WDM_HandleMagicZone() == TRUE && nCLEAR == TRUE)
  {
    SetModuleOverrideSpellScriptFinished();
    return;
  }

//: DEAD AND WILD MAGIC
//:****************************************************************************/

  if(nCLEAR == TRUE) return;

  switch(nSpell)
  {

//:****************************************************************************/
//: AREA SPECIFIC TIME STOP

    case SPELL_TIME_STOP:
    {
      //Players Only
      if(!GetIsPC(OBJECT_SELF)) break;

      if(GetLocalInt(oMod,"TIMESTOP") == 1)
      {
        if(GetLocalInt(OBJECT_SELF, "TIMESTOP_DELAY") == 1)
        {
          FloatingTextStringOnCreature("Timestop is not castable yet", OBJECT_SELF, FALSE);
          SetModuleOverrideSpellScriptFinished();
          break;
        }

        int nDelay = GetLocalInt(GetModule(),"TIMESTOP_DEL");
        float fDelay = IntToFloat(nDelay);
        if(nDelay > 0){ DelayCommand(1.0, TimeStopDelay(OBJECT_SELF)); }

        location lTarget = GetSpellTargetLocation();
        effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
        int nDuration = DetermineDuration();

        //Fire cast spell at event for the specified target
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
        Timestop(OBJECT_SELF);
        DelayCommand(1.0, TimestopCheck(OBJECT_SELF, nDuration));

        SetModuleOverrideSpellScriptFinished();
      }
      break;
    }

//: AREA SPECIFIC TIME STOP
//:****************************************************************************/

//:****************************************************************************/
//: GREATER SANCTUARY FIX

    case SPELL_ETHEREALNESS:
    {
      //Players Only
      if(!GetIsPC(OBJECT_SELF)) break;

      if(GetLocalInt(oMod,"GSANCTUARY") == 1)
      {
        if(GetLocalInt(OBJECT_SELF, "GSANCTUARY_DELAY") == 1)
        {
          FloatingTextStringOnCreature("Greater Sanctuary is not castable yet.", OBJECT_SELF, FALSE);
          SetModuleOverrideSpellScriptFinished();
          break;
        }

        //Spell Duration (in rounds)
        int nRoll = d8();
        if(nRoll < 4) nRoll = 4;
        int nDuration = nRoll;
        int nDurCheck = GetLocalInt(oMod,"GSANCTUARY_DUR");
        if(nDurCheck > 0) nDuration = nDurCheck;

        //Casting Delay
        int nDelay = 0;
        int nDelCheck = GetLocalInt(GetModule(),"GSANCTUARY_DEL");
        if(nDelCheck > 0)
        {
          nDuration = nDelCheck;
        }

        if(nDuration > 0)
        {
          if(GetIsPC(oTarget)) GSStopDelay(oTarget);
        }

        effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eSanc = EffectEthereal();

        effect eLink = EffectLinkEffects(eVis, eSanc);
        eLink = EffectLinkEffects(eLink, eDur);

        //Enter Metamagic conditions
        int nMetaMagic = GetMetaMagicFeat();
        if(nMetaMagic == METAMAGIC_EXTEND)
        {
          nDuration = nDuration *2; //Duration is +100%
        }

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ETHEREALNESS, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
        AssignCommand(oTarget, ClearAllActions());

        SetModuleOverrideSpellScriptFinished();
      }
      break;
    }

//: GREATER SANCTUARY FIX
//:****************************************************************************/

//:****************************************************************************/
//: PHB HARM

    case SPELL_HARM:
    {
      if(GetLocalInt(oMod,"PHBHARM") == 1)
      {
        object oCaster = OBJECT_SELF;
        int nCaster = GetHitDice(oCaster);
        object oTarget = GetSpellTargetObject();
        int nDamage, nHarm;
        int nMetaMagic = GetMetaMagicFeat();
        int nTouch = TouchAttackMelee(oTarget);
        effect eVis = EffectVisualEffect(246);
        effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
        effect eHeal, eDam;

        //PHB Max Value
        int nMV = 150;

        int nCHP = GetCurrentHitPoints(oTarget);
        int nMHP = GetMaxHitPoints(oTarget);

        //Determine Amount Cap At Max
        nHarm = 10 * nCaster;
        if(nHarm > nMV) nHarm = nMV;

        //Check for Metamagic Maximized
        if(nMetaMagic == METAMAGIC_MAXIMIZE) nHarm = nMV;

        //Check that the target is undead
        if(IsUndead)
        {
          //Heal Amount
          int nDiff = nMHP - nCHP;
          if(nDiff > nHarm) nHarm = nDiff;

          eHeal = EffectHeal(nHarm);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);

          //Fire cast spell at event for the specified target
          SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM, FALSE));
        }

        else if (nTouch != FALSE)
        {
          if(!GetIsReactionTypeFriendly(oTarget))
          {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM, TRUE));

            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
              //Harm Amount
              if(nCHP < nHarm) nHarm = nCHP - d4(1);

              eDam = EffectDamage(nHarm,DAMAGE_TYPE_NEGATIVE);
              DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
          }
        }

        SetModuleOverrideSpellScriptFinished();
      }
      break;
    }

//: PHB HARM
//:****************************************************************************/

//:****************************************************************************/
//: PHB HEAL AND MASS HEAL

    case SPELL_HEAL:
    {
      if(GetLocalInt(oMod,"PHBHEAL") == 1)
      {
        object oCaster = OBJECT_SELF;
        int nCaster = GetHitDice(oCaster);
        object oTarget = GetSpellTargetObject();
        int nDamage, nHeal;
        int nMetaMagic = GetMetaMagicFeat();
        int nTouch = TouchAttackMelee(oTarget);
        effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
        effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_X);
        effect eHeal, eDam;

        //PHB Max Value
        int nMV = 150;

        int nCHP = GetCurrentHitPoints(oTarget);
        int nMHP = GetMaxHitPoints(oTarget);

        //Determine Amount
        nHeal = 10 * nCaster;
        if(nHeal > nMV) nHeal = nMV;

        //Check for Metamagic Maximized
        if(nMetaMagic == METAMAGIC_MAXIMIZE) nHeal = nMV;

        //Check that the target is undead
        if(IsUndead)
        {
          if(!GetIsReactionTypeFriendly(oTarget))
          {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, TRUE));

            //Make SR check
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
              //Harm Amount
              if(nCHP <= nHeal) nHeal = nCHP - d4(1);

              eDam = EffectDamage(nHeal, DAMAGE_TYPE_POSITIVE);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
          }
        }
        else
        {
          //Fire cast spell at event for the specified target
          SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));

          //Heal Amount
          int nDiff = nMHP - nCHP;
          if(nDiff < nHeal) nHeal = nDiff;

          eHeal = EffectHeal(nHeal);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        }

        SetModuleOverrideSpellScriptFinished();
      }
      break;
    }

    case SPELL_MASS_HEAL:
    {
      if(GetLocalInt(oMod,"PHBHEAL") == 1)
      {
        object oCaster = OBJECT_SELF;
        int nCaster = GetHitDice(oCaster);
        int nDamage, nHeal, nTouch;
        int nMetaMagic = GetMetaMagicFeat();
        effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
        effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
        effect eStrike = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
        effect eHeal, eDam;
        float fDelay;

        //PHB Max Value
        int nMV = 250;

        int nCHP = GetCurrentHitPoints(oTarget);
        int nMHP = GetMaxHitPoints(oTarget);

        //Determine Amount
        nHeal = 10 * nCaster;
        if(nHeal > nMV) nHeal = nMV;

        //Check for Metamagic Maximized
        if(nMetaMagic == METAMAGIC_MAXIMIZE) nHeal = nMV;

        //Apply VFX at Location
        location lLoc =  GetSpellTargetLocation();
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc);

        //Get first target in spell area
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        while(GetIsObjectValid(oTarget))
        {
          fDelay = GetRandomDelay();

          //Check that the target is undead and unfriendly
          if(IsUndead == TRUE && !GetIsReactionTypeFriendly(oTarget))
          {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HEAL, TRUE));

            //Make a touch attack
            nTouch = TouchAttackRanged(oTarget);
            if(nTouch > 0)
            {
              //Make SR check
              if(!MyResistSpell(OBJECT_SELF, oTarget))
              {
                //Harm Amount
                if(nCHP <= nHeal) nHeal = nCHP - d4(1);

                eDam = EffectDamage(nHeal, DAMAGE_TYPE_POSITIVE);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              }
            }
          }

          else
          {
            if(GetIsFriend(oTarget) && IsUndead == FALSE)
            {
              //Fire cast spell at event for the specified target
              SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));

              //Heal Amount
              int nDiff = nMHP - nCHP;
              if(nDiff < nHeal) nHeal = nDiff;

              eHeal = EffectHeal(nHeal);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }
          }

          oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        }

        SetModuleOverrideSpellScriptFinished();
      }
      break;
    }

//: PHB HEAL AND MASS HEAL
//:****************************************************************************/

//:****************************************************************************/
//: CONTINUAL FLAME EXPLOIT FIX (Thanks to CFX for this)

    case SPELL_CONTINUAL_FLAME:
    {
     if(GetLocalInt(oMod,"CFLAME") == 1)
     {
      int nDuration;
      int nMetaMagic;
      object oTarget = GetSpellTargetObject();

      // Handle spell cast on item....
      if((GetObjectType(oTarget) == OBJECT_TYPE_ITEM) && !CIGetIsCraftFeatBaseItem(oTarget))
      {
        // Do not allow casting on not equippable items
        if(!IPGetIsItemEquipable(oTarget))
        {
          // Item must be equipable...
          FloatingTextStrRefOnCreature(83326,OBJECT_SELF);
          SetModuleOverrideSpellScriptFinished();
          return;
        }
        itemproperty ip = ItemPropertyLight (IP_CONST_LIGHTBRIGHTNESS_BRIGHT, IP_CONST_LIGHTCOLOR_WHITE);
        DelayCommand(0.01, IPSafeAddItemProperty(oTarget, ip, HoursToSeconds(1000), X2_IP_ADDPROP_POLICY_KEEP_EXISTING, TRUE, TRUE));
      }
      else
      {
        //Declare major variables
        effect eVis = (EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20));
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = SupernaturalEffect(EffectLinkEffects(eVis, eDur));

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 419, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
      }
      SetModuleOverrideSpellScriptFinished();
     }
     break;
    }

//: CONTINUAL FLAME EXPLOIT FIX
//:****************************************************************************/

//:****************************************************************************/
//: OLANDER'S EPIC SUMMONING

    case SPELL_GATE:
    {
      //Module Config
      if(GetLocalInt(oMod,"GATE") != 1) break;

      // Creature duration
      fDuration = RoundsToSeconds(20);

      effect eSummon;
      effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);

      //Summon the Balrog and apply the VFX impact
      location lSpellTargetLOC = GetSpellTargetLocation();

      if(GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
        GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL) ||
        GetHasSpellEffect(SPELL_HOLY_AURA))
      {
        eSummon = EffectSummonCreature("sum_lbalrog",VFX_FNF_SUMMON_GATE,3.0);
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpellTargetLOC, fDuration));
      }
      else
      {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpellTargetLOC);
        object oLBalrog = CreateObject(OBJECT_TYPE_CREATURE, "hos_lbalrog", GetSpellTargetLocation());
        DestroyObject(oLBalrog,fDuration);
      }

      SetModuleOverrideSpellScriptFinished();
      break;
    }

    case SPELL_EPIC_DRAGON_KNIGHT:
    {
      //Module Config
      if(GetLocalInt(oMod,"EDK") != 1) break;

      // Creature duration
      fDuration=RoundsToSeconds(20);

      effect effect1; effect effect2;

      if(nCasterAlignment==ALIGNMENT_EVIL)
      {
        eEffect2=EffectVisualEffect(VFX_FNF_SUMMON_GATE);
        eEffect1=EffectSummonCreature("sum_dragknight",481,0.0f,TRUE);
      }
      if(nCasterAlignment==ALIGNMENT_GOOD)
      {
        eEffect2=EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
        eEffect1=EffectSummonCreature("sum_cendrial",481,0.0f,TRUE);
      }
      if(nCasterAlignment==ALIGNMENT_NEUTRAL)
      {
        eEffect2=EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
        eEffect1=EffectSummonCreature("sum_treant",481,0.0f,TRUE);
      }

      // Make Dragon Aura Undispellable
      eEffect1=ExtraordinaryEffect(eEffect1);

      ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect1,lTarget,fDuration);
      DelayCommand(1.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect2,lTarget));

      SetModuleOverrideSpellScriptFinished();
      break;
    }

    case SPELL_EPIC_MUMMY_DUST:
    {
      //Module Config
      if(GetLocalInt(oMod,"EMD") != 1) break;

      // Creature duration
      fDuration = RoundsToSeconds(20);
      effect eSummon;
      eSummon = EffectSummonCreature("sum_gmummy",496,1.0f);
      eSummon = ExtraordinaryEffect(eSummon);
      effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
      //Apply the summon visual and summon the undead.
      ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
      ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDuration);

      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: OLANDER'S EPIC SUMMONING
//:****************************************************************************/

//:****************************************************************************/
//: IMPROVED SUMMONING (By Olander)

    case SPELL_SUMMON_CREATURE_I:
    case SPELL_SUMMON_CREATURE_II:
    case SPELL_SUMMON_CREATURE_III:
    case SPELL_SUMMON_CREATURE_IV:
    case SPELL_SUMMON_CREATURE_V:
    case SPELL_SUMMON_CREATURE_VI:
    case SPELL_SUMMON_CREATURE_VII:
    case SPELL_SUMMON_CREATURE_VIII:
    case SPELL_SUMMON_CREATURE_IX:
    {
       //Module Config
       if(GetLocalInt(oMod,"ISUM") != 1) break;

       //Only For Players.
       if(!GetIsPC(OBJECT_SELF)) break;

       // Creature constants
       string sSummon = "";

       //Racial
       int nRace = GetRacialType(OBJECT_SELF);
       string sSubRace = GetSubRace(OBJECT_SELF);

       //Dwarf
       if(nRace == RACIAL_TYPE_DWARF)
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "sum_darbalest";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "sum_darbalest";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "sum_darbalest";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "sum_dbattlerager";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "sum_dbattlerager";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "sum_dbattlerager";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "sum_dstalwart";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "sum_dstalwart";}
         else {sSummon = "sum_dstalwart";}
       }

       //Silvan
       else if(sSubRace == "Silvan Edhel")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "sum_silvanbowman";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "sum_silvanbowman";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "sum_silvanbowman";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "sum_silvanbowman";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "sum_silvanbowman";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "sum_silvanbowman";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "sum_silvanbowman";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "sum_silvanmage";}
         else {sSummon = "sum_silvanmage";}
       }

       //Sindar
       else if(sSubRace == "Sindar Edhel")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "sum_imladrisarch";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "sum_imladrisarch";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "sum_imladrisarch";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "sum_imladriswarr";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "sum_imladriswarr";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "sum_imladriswarr";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "sum_forvenarcher";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "sum_forvenarcher";}
         else {sSummon = "sum_sindarmage";}
       }

       //Arthedain
       if(sSubRace == "Arthedain")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "sum_arthedainarc";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "sum_arthedainarc";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "sum_arthedainarc";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "sum_arthedainfoo";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "sum_arthedainfoo";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "sum_arthedainfoo";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "sum_arthedainsol";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "sum_arthedainsol";}
         else {sSummon = "sum_arthedainsol";}
       }

       //Dunedain
       if(sSubRace == "Dunedain")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "sum_arthedainarc";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "sum_arthedainarc";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "sum_arthedainarc";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "sum_arthedainfoo";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "sum_arthedainfoo";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "sum_arthedainfoo";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "sum_arthedainsol";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "sum_arthedainsol";}
         else {sSummon = "sum_arthedainsol";}
       }

       //Dunlending
       if(sSubRace == "Dunlending")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "me_summdun1";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "me_summdun1";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "me_summdun2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "me_summdun2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "me_summdun2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "me_summdun3";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "me_summdun3";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "me_summdun4";}
         else {sSummon = "me_summdun4";}
       }

       //Gondorian
       if(sSubRace == "Gondorian")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "me_summgondor1";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "me_summgondor1";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "me_summgondor2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "me_summgondor2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "me_summgondor2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "me_summgondor3";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "me_summgondor3";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "me_summgondor4";}
         else {sSummon = "me_summgondor4";}
       }

       //Northman
       if(sSubRace == "Northman")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "me_summnorth1";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "me_summnorth1";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "me_summnorth2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "me_summnorth2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "me_summnorth2";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "me_summnorth3";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "me_summnorth3";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "me_summnorth4";}
         else {sSummon = "me_summnorth4";}
       }

       //Woses
       if(sSubRace == "Woses")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "sum_wildwolf";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "sum_wildwolf";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "sum_forestboar";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "sum_forestboar";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "sum_cougar";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "sum_cougar";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "sum_grizzlybear";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "sum_grizzlybear";}
         else {sSummon = "sum_legendbear";}
       }

       //Hobbit
       if(sSubRace == "Hobbit")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "sum_shiretguard";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "sum_shiretguard";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "sum_shirechief";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "sum_shirechief";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "sum_shirepaladin";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "sum_shirepaladin";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "sum_shirepaladin";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "sum_shireinvento";}
         else {sSummon = "sum_shireinvento";}
       }

/*
       //Template
       if(sSubRace == "SubRace Name")
       {
         if(nSpell==SPELL_SUMMON_CREATURE_I){sSummon = "sum_resref";}
         else if(nSpell==SPELL_SUMMON_CREATURE_II){sSummon = "sum_resref";}
         else if(nSpell==SPELL_SUMMON_CREATURE_III){sSummon = "sum_resref";}
         else if(nSpell==SPELL_SUMMON_CREATURE_IV){sSummon = "sum_resref";}
         else if(nSpell==SPELL_SUMMON_CREATURE_V){sSummon = "sum_resref";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VI){sSummon = "sum_resref";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VII){sSummon = "sum_resref";}
         else if(nSpell==SPELL_SUMMON_CREATURE_VIII){sSummon = "sum_resref";}
         else {sSummon = "sum_resref";}
       }
*/

       // Creature duration (Rounds/Level, 3 Min, 10 Max)
       if(nCasterLevel < 3) nCasterLevel = 3;
       //if(nCasterLevel > 10) nCasterLevel = 10;
       fDuration = RoundsToSeconds(nCasterLevel);
       int nMetaMagic = GetMetaMagicFeat();

       if(nMetaMagic == METAMAGIC_EXTEND)
       {
         fDuration*=2;
       }

       // Create Summon and Visual Effect
       eEffect1=EffectSummonCreature(sSummon);
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect2,lTarget);
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect1,lTarget,fDuration);

       SetModuleOverrideSpellScriptFinished();
       break;
    }

//: IMPROVED SUMMONING
//:****************************************************************************/

//:****************************************************************************/
//: OLANDER'S PLANAR SUMMONING

    case SPELL_GREATER_PLANAR_BINDING:
    case SPELL_LESSER_PLANAR_BINDING:
    case SPELL_PLANAR_ALLY:
    case SPELL_PLANAR_BINDING:
    {
       //Module Config
       if(GetLocalInt(oMod,"IPSUM") != 1) break;

       // Creature constants
       string sSummon = "summon_";

       // Summon Alignment Level Spell Number Constant Creator
       // szFinalSummon2 = "summon_" + <caster_alignment> + "_" + <spell> + "_"
       // example for spell_summon_creature_I casted by good aligned spellcaster:
       // szFinalSummon2 = "summon_good_i_"

       if(nCasterAlignment==ALIGNMENT_EVIL)
       {
         eEffect2=EffectVisualEffect(VFX_FNF_SUMMON_GATE);
         sSummon = "summon_evil";
       }
       else
       {
         eEffect2=EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
         sSummon = "summon_good";
       }

       if(nSpell==SPELL_PLANAR_BINDING){sSummon = sSummon + "_pb";}
       else if(nSpell==SPELL_PLANAR_ALLY){sSummon = sSummon + "_lpb";}
       else if(nSpell==SPELL_LESSER_PLANAR_BINDING){sSummon = sSummon + "_lpb";}
       else if(nSpell==SPELL_GREATER_PLANAR_BINDING){sSummon = sSummon + "_gpb";}
       else {sSummon = sSummon + "_vi";}

       // Creature duration (Rounds/Level, 3 Min, 10 Max)
       //if(nCasterLevel < 3) nCasterLevel = 3;
       //if(nCasterLevel > 10) nCasterLevel = 10;
       fDuration = TurnsToSeconds(nCasterLevel);
       int nMetaMagic = GetMetaMagicFeat();

       if(nMetaMagic == METAMAGIC_EXTEND)
       {
         fDuration*=2;
       }

       // Create Summon and Visual Effect
       eEffect1=EffectSummonCreature(sSummon);
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect2,lTarget);
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect1,lTarget,fDuration);

       SetModuleOverrideSpellScriptFinished();
       break;
    }

//: OLANDER'S PLANAR SUMMONING
//:****************************************************************************/

//:****************************************************************************/
//: PHB RAISE DEAD (THROUGH LOOTABLE CORPSES)

    case SPELL_RAISE_DEAD:
    {
      //Declare major variables
      object oTarget = GetSpellTargetObject();
      effect eRaise = EffectResurrection();
      effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
      if(GetIsDead(oTarget))
      {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAISE_DEAD, FALSE));
        //Apply raise dead effect and VFX impact
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
      }

      // The following lines have been added to support Scrotok's Lootable Corpses script
      // Fire SpellCastAt event for lootable corpse placeables or bones
      // (Raise Dead won't work for bones, but _kb_raise_res" takes care of that)
      if ((GetTag(oTarget) == "invis_corpse_obj") || (GetTag(oTarget) == "loot_bones_obj"))
      {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAISE_DEAD, FALSE));
      }

      //For OUW - Underwater System
      object oUWWP = GetNearestObjectByTag("Underwater",oTarget);
      if(GetIsObjectValid(oUWWP) && GetIsPC(oTarget))
      {
        //Destroy Old Underwater Item
        object oUW = GetItemPossessedBy(oTarget,"UnderWater");
        if(GetIsObjectValid(oUW)) DestroyObject(oUW);

        //Now Make a New Underwater Item
        oUW = CreateItemOnObject("underwater",oTarget);

        //Now Figure out How Many Rounds a Player Can Breath
        int nRounds = 10;
        int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oTarget);
        if(nCON > 4) nCON = 4;//Remove supernatural abilities
        int nTotal = nRounds - nCON;

        //Set Rounds to Underwater Item
        SetLocalInt(oUW,"UNDERWATER_TOT_ROUNDS",nTotal);
        SetLocalInt(oUW,"UNDERWATER_CUR_ROUNDS",nTotal/2);

        ExecuteScript("ouw_main",oTarget);
      }

      //Reset Forced Respawn
      SetLocalInt(oTarget,"OBD_FORCE_RESPAWN",0);

      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: PHB RAISE DEAD (THROUGH LOOTABLE CORPSES)
//:****************************************************************************/

//:****************************************************************************/
//: PHB RESURRECTION(THROUGH LOOTABLE CORPSES)

    case SPELL_RESURRECTION:
    {
      //Get the spell target
      object oTarget = GetSpellTargetObject();
      //Check to make sure the target is dead first
      if (GetIsDead(oTarget))
      {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
        //Declare major variables
        int nHealed = GetMaxHitPoints(oTarget);
        effect eRaise = EffectResurrection();
        effect eHeal = EffectHeal(nHealed + 10);
        effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
        //Apply the heal, raise dead and VFX impact effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
      }

      // The following lines have been added to support Scrotok's Lootable Corpses script
      // Fire SpellCastAt event for lootable corpse placeables or bones
      if ((GetTag(oTarget) == "invis_corpse_obj") || (GetTag(oTarget) == "loot_bones_obj"))
      {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
      }

      //For OUW - Underwater System
      object oUWWP = GetNearestObjectByTag("Underwater",oTarget);
      if(GetIsObjectValid(oUWWP) && GetIsPC(oTarget))
      {
        //Destroy Old Underwater Item
        object oUW = GetItemPossessedBy(oTarget,"UnderWater");
        if(GetIsObjectValid(oUW)) DestroyObject(oUW);

        //Now Make a New Underwater Item
        oUW = CreateItemOnObject("underwater",oTarget);

        //Now Figure out How Many Rounds a Player Can Breath
        int nRounds = 10;
        int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oTarget);
        if(nCON > 4) nCON = 4;//Remove supernatural abilities
        int nTotal = nRounds - nCON;

        //Set Rounds to Underwater Item
        SetLocalInt(oUW,"UNDERWATER_TOT_ROUNDS",nTotal);
        SetLocalInt(oUW,"UNDERWATER_CUR_ROUNDS",nTotal/2);

        ExecuteScript("ouw_main",oTarget);
      }

      //Reset Forced Respawn
      SetLocalInt(oTarget,"OBD_FORCE_RESPAWN",0);

      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: PHB RESURRECTION
//:****************************************************************************/

//:****************************************************************************/
//: POLYMORPH SELF FOR NPC'S ALSO

    case SPELL_POLYMORPH_SELF:
    {
      //Declare major variables
      //Special - if NPC, randomise the nSpell, so it works properly
      int nSpell;
      if(!GetIsPC(OBJECT_SELF) && !GetIsDM(OBJECT_SELF) && !GetIsDMPossessed(OBJECT_SELF))
      {
        nSpell = (Random(5) + 387);
      }
      else
      {
        nSpell = GetSpellId();
      }
      object oTarget = GetSpellTargetObject();
      effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
      effect ePoly;
      int nPoly;
      int nMetaMagic = GetMetaMagicFeat();
      int nDuration = GetCasterLevel(OBJECT_SELF);

      //Enter Metamagic conditions
      if (nMetaMagic == METAMAGIC_EXTEND)
      {
        nDuration = nDuration *2; //Duration is +100%
      }

      //Determine Polymorph subradial type
      if(nSpell == 387)
      {
        nPoly = POLYMORPH_TYPE_GIANT_SPIDER;
      }
      else if (nSpell == 388)
      {
        nPoly = POLYMORPH_TYPE_TROLL;
      }
      else if (nSpell == 389)
      {
        nPoly = POLYMORPH_TYPE_UMBER_HULK;
      }
      else if (nSpell == 390)
      {
        nPoly = POLYMORPH_TYPE_PIXIE;
      }
      else if (nSpell == 391)
      {
        nPoly = POLYMORPH_TYPE_ZOMBIE;
      }
      ePoly = EffectPolymorph(nPoly);
      //Fire cast spell at event for the specified target
      SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_POLYMORPH_SELF, FALSE));

      //Apply the VFX impact and effects
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(nDuration));

      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: POLYMORPH SELF FOR NPC'S ALSO
//:****************************************************************************/

//:****************************************************************************/
//: SHAPECHANGE FOR NPC'S ALSO

    case SPELL_SHAPECHANGE:
    {
      //Declare major variables
      //Special - if NPC, randomise the nSpell, so it works properly
      int nSpell;
      if(!GetIsPC(OBJECT_SELF) && !GetIsDM(OBJECT_SELF) && !GetIsDMPossessed(OBJECT_SELF))
      {
        nSpell = (Random(5) + 392);
      }
      else
      {
        nSpell = GetSpellId();
      }
      object oTarget = GetSpellTargetObject();
      effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
      effect ePoly;
      int nPoly;
      int nMetaMagic = GetMetaMagicFeat();
      int nDuration = GetCasterLevel(OBJECT_SELF);

      //Enter Metamagic conditions
      if (nMetaMagic == METAMAGIC_EXTEND)
      {
        nDuration = nDuration *2; //Duration is +100%
      }

      //Determine Polymorph subradial type
      if(nSpell == 392)
      {
        nPoly = POLYMORPH_TYPE_RED_DRAGON;
      }
      else if (nSpell == 393)
      {
        nPoly = POLYMORPH_TYPE_FIRE_GIANT;
      }
      else if (nSpell == 394)
      {
        nPoly = POLYMORPH_TYPE_BALOR;
      }
      else if (nSpell == 395)
      {
        nPoly = POLYMORPH_TYPE_DEATH_SLAAD;
      }
      else if (nSpell == 396)
      {
        nPoly = POLYMORPH_TYPE_IRON_GOLEM;
      }
      ePoly = EffectPolymorph(nPoly);
      //Fire cast spell at event for the specified target
      SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHAPECHANGE, FALSE));

      //Apply the VFX impact and effects
      ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
      DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(nDuration)));
      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: POLYMORPH SELF FOR NPC'S ALSO
//:****************************************************************************/

//:****************************************************************************/
//: PHB LESSER RESTORATION
// (WILL NOT REMOVE EXTRAORDINARY EFFECTS)

    case SPELL_LESSER_RESTORATION:
    {
      //Declare major variables
      object oTarget = GetSpellTargetObject();
      effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
      effect eBad = GetFirstEffect(oTarget);
      //Search for negative effects
      while(GetIsEffectValid(eBad))
      {
        if(GetEffectSubType(eBad) != SUBTYPE_EXTRAORDINARY)
        {
          if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
              GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
              GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
              GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
              GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
              GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
              GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
              GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE)
          {
              //Remove effect if it is not subracial effect
              if(GetEffectSubType(eBad) == SUBTYPE_SUPERNATURAL)
              {
                if(GetEffectCreator(eBad) != oTarget)
                {
                  RemoveEffect(oTarget, eBad);
                }
              }
              else
              {
                RemoveEffect(oTarget, eBad);
              }
          }
        }
        eBad = GetNextEffect(oTarget);
      }
      //Fire cast spell at event for the specified target
      SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_RESTORATION, FALSE));
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: PHB LESSER RESTORATION
//:****************************************************************************/

//:****************************************************************************/
//: PHB RESTORATION
// (WILL NOT REMOVE EXTRAORDINARY EFFECTS)

    case SPELL_RESTORATION:
    {
      //Declare major variables
      object oTarget = GetSpellTargetObject();
      effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
      int bValid;

      effect eBad = GetFirstEffect(oTarget);
      //Search for negative effects
      while(GetIsEffectValid(eBad))
      {
        if(GetEffectSubType(eBad) != SUBTYPE_EXTRAORDINARY)
        {
            if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
            {
                //Remove effect if it is not subracial effect
                if(GetEffectSubType(eBad) == SUBTYPE_SUPERNATURAL)
                {
                  if(GetEffectCreator(eBad) != oTarget)
                  {
                    RemoveEffect(oTarget, eBad);
                  }
                }
                else
                {
                  RemoveEffect(oTarget, eBad);
                }
            }
        }
        eBad = GetNextEffect(oTarget);
      }
      //Fire cast spell at event for the specified target
      SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: PHB RESTORATION
//:****************************************************************************/

//:****************************************************************************/
//: PHB GREATER RESTORATION
// (WILL NOT REMOVE EXTRAORDINARY EFFECTS)
// (WILL NOT HEAL CONSTRUCTS)

    case SPELL_GREATER_RESTORATION:
    {
      //Declare major variables
      object oTarget = GetSpellTargetObject();
      effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

      effect eBad = GetFirstEffect(oTarget);
      //Search for negative effects
      while(GetIsEffectValid(eBad))
      {
        if(GetEffectSubType(eBad) != SUBTYPE_EXTRAORDINARY)
        {
            if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
                GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
                GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
                GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
                GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
                GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
                GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_SLOW ||
                GetEffectType(eBad) == EFFECT_TYPE_STUNNED)
            {
                //Remove effect if it is not subracial effect
                if(GetEffectSubType(eBad) == SUBTYPE_SUPERNATURAL)
                {
                  if(GetEffectCreator(eBad) != oTarget)
                  {
                    RemoveEffect(oTarget, eBad);
                  }
                }
                else
                {
                  RemoveEffect(oTarget, eBad);
                }
            }
        }
        eBad = GetNextEffect(oTarget);
      }

      //Fire cast spell at event for the specified target
      SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_RESTORATION, FALSE));
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: PHB GREATER RESTORATION
//:****************************************************************************/

//:****************************************************************************/
//: KNOCK (EP Olson Fixes)

    case SPELL_KNOCK:
    {
      object oTarget;
      effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
      oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
      float fDelay;
      int nResist;

      while(GetIsObjectValid(oTarget))
      {
        SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,GetSpellId()));
        fDelay = GetRandomDelay(0.5, 2.5);
        //if(!GetPlotFlag(oTarget) && GetLocked(oTarget))  // EPOlson - plot doors are knockable

        if(GetLocked(oTarget))
        {
          // EPOlson: set local int "X2_FLAG_DOOR_RESIST_KNOCK" for DoorFlag
          nResist =  GetDoorFlag(oTarget,DOOR_FLAG_RESIST_KNOCK);

          // plot is OK, but "requires key" will stop knock (unless key end in = knock)
          if(GetLockKeyRequired(oTarget))
          {
            if(!FindSubString(GetLockKeyTag(oTarget),"knock")) nResist = 1;
          }
          if (nResist == 0)
          {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            AssignCommand(oTarget, ActionUnlockObject(oTarget));
          }
          else if  (nResist == 1)
          {
            FloatingTextStrRefOnCreature(83887,OBJECT_SELF);
          }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
      }
      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: KNOCK
//:****************************************************************************/

//:****************************************************************************/
//: FIND TRAP - Only FINDS the Traps now and Not DESTROY them too (EP Olson Fix)

    case SPELL_FIND_TRAPS:
    {
      effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
      int nCnt = 1;
      object oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER |
             OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
      while(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) <= 30.0)
      {
        if(GetIsTrapped(oTrap))
        {
          SetTrapDetectedBy(oTrap, OBJECT_SELF);
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTrap));
          //DelayCommand(2.0, SetTrapDisabled(oTrap));  // EPOlson: NOT disabled/destroyed
        }
        nCnt++;
        oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
      }

      SetModuleOverrideSpellScriptFinished();
      break;
    }

//: FIND TRAP
//:****************************************************************************/

//:****************************************************************************/
//: TEMPPLATE
    /*
    case SPELL_*****:
    {

      SetModuleOverrideSpellScriptFinished();
      break;
    }
    */
//: TEMPPLATE
//:****************************************************************************/

  }
}
