////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_include
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"
#include "nw_i0_generic"
#include "nbde_inc"

//:****************************************************************************/
//: SHARED CONSTANTS

/*
  The constants INSTANT_DEATH and SCALE_PERCENT need explanation -
  they are similar but very different and they work hand in hand.

  INSTANT_DEATH - Normally, if a player is hit by anything - spell, axe,
  whatever, and it takes him to -10 or below, OnPlayerDeath is called, that is,
  OnPlayerDying is completely bypassed. If that's the case, with INSTANT_DEATH
  set to FALSE, instead of processing OnPlayerDeath, OnPlayerDeath is bypassed
  and OnPlayerDying is called (see below).
*/
const int INSTANT_DEATH = FALSE;

/*
   SCALE_PERCENT - if you set it to 1.0f, the INSTANT_DEATH constant is ignored
    and has no effect (instant death is as normal and scaling is skipped).
   If INSTANT_DEATH is TRUE, scaling will only affect players who go from
    positive hp to 0 through -9. All others will die instantly.
   With INSTANT_DEATH set to FALSE, SCALE_PERCENT will affect all hp,
    regardless of how low, with the following effects.
   SCALE_PERCENT = 0.5f, will effectively halve the distance to 0, that is, a
    player taken to -20 hp will still die instantly, but a player with -16 hp
    will start bleeding at -8 hp.
   SCALE_PERCENT = 0.33f, -30 hp will be required for instant death and a
    player who goes into dying at -9 hp will start bleeding at -3 hp.
   SCALE_PERCENT = 0.25f, a player will need to have been taken to -40 hp for
    instant death and a player who goes into dying with -24 hp will start
    bleeding at -6 hp.

   Note: Most "death" fx, spells, etc., bring a player to -11, so if
    INSTANT_DEATH == FALSE, and SCALE_PERCENT is lower than 1.0f, these spells
    and effects will not immediately kill the player, but will start bleeding
    at -6 hp for SCALE_PERCENT = 0.5f and - 4 hp for SCALE_PERCENT = 0.33f.
*/
const float SCALE_PERCENT = 0.33f;

/*
   These constants are for custom factions - if you don't use custom HOSTILE
   factions, you can leave these alone - if you do, create one member of your
   custom HOSTILE faction and place in an inaccessible area and set enter his
   tag here, you may use as many as you like, just make sure you alter the
   number of custom HOSTILE factions and enter one tag name for each creature
   and make sure you place him/her somewher in your module. Do not check the
   "plot" flag on your creature(s) (or this won't work). This will reset the
   reputation of any bleeding player once they become concious back to HOSTILE
   with the custom faction. Make sure the string constant's names are as listed
   below, but with increasing numbers - don't use leading zeroes.
*/

const int    CUSTOM_HOSTILE_FACTIONS  = 0;
const string HOSTILE_FACTION_1        = "Tag_Of_Placeable";
const string HOSTILE_FACTION_2        = "Tag_Of_Placeable";

//Bleed Status
const int BLEED_STATUS_CONSCIOUS     = 0;
const int BLEED_STATUS_STABLE        = 1;
const int BLEED_STATUS_BLEEDING      = 2;
const int BLEED_STATUS_DEAD          = 3;
const int BLEED_STATUS_INSTANT_DEATH = 4;

const float ROUND = 6.0f;

//: SHARED CONSTANTS
//:****************************************************************************/

//:****************************************************************************/
//: ONPLAYER DYING CONSTANTS

/*
  If UNEQUIP_REGEN is TRUE, regeneration items are placed in general inventory
  during bleeding. Setting this to FALSE will leave regen items equiped and
  will always cancel bleeding (player will always stabilize).
*/
const int UNEQUIP_REGEN = TRUE;

/*
  If you don't want the enemies to ignore the bleeding player, alter these
  constants as you see fit.
  if KEEP_ATTACKING is TRUE, you can choose an "Intelligence" DC or a random
  chance based on KEEP_ATTACK_PERCENT
*/
const int KEEP_ATTACKING = TRUE;
const int KEEP_ATTACKING_DC_CHECK = TRUE; // TRUE - use DC, FALSE, use random
const int KEEP_ATTACKING_DC   = 15;
const int KEEP_ATTACK_PERCENT = 25; // 25 = 25%

/*
  If STABILIZE_CON_BONUS is TRUE, this will be added to the stabilization
  check. If STABILIZE_DC_CHECK is TRUE, then a STABILIZE_DC DC check is
  made (adding CON bonus), if STABILIZE_DC_CHECK is FALSE, STABILIZE_PERCENT
  is used and CON bonus is added if CONSTITUTION_BONUS is TRUE.
*/
const int STABILIZE_CON_BONUS = TRUE;
const int STABILIZE_DC_CHECK = FALSE;
const int STABILIZE_DC   = 15;
const int STABILIZE_PERCENT = 0; // 10 = 10%

//: ONPLAYER DYING CONSTANTS
//:****************************************************************************/

//:****************************************************************************/
//: ONPLAYER DEATH CONSTANTS

const int INSTANT_RESPAWN = FALSE;//Delayed Respawn
const int RESPAWN_DURING_COMBAT = FALSE;//Respawn During Combat
const int DROP_BACKPACK = FALSE;//Drop the Back Pack (drop all inventory items into bag)

//: ONPLAYER DEATH CONSTANTS
//:****************************************************************************/

//:****************************************************************************/
//: ONPLAYER RESPAWN CONSTANTS

/*
  With bleeding rules, it hardly seems fair for a player who respawns to
  get back to full hp, no bad fx, etc, while a bleeding player retains all
  these effects. These options allow you to make respawn a little less
  favorable.
  PHB_RAISE_DEAD if set to TRUE, PHB rules for Raise Dead are applied, that is,
  if players are level one, a pseudo permanent 2 point Constitution penalty
  applies, otherwise a level is lost. If set to FALSE, a temporary, 1pt,
  physical (STR, DEX and CON) penalty is applied to all levels and xp loss
  is 5% of level per time died (5 10 15, etc)
*/
const int   PHB_RAISE_DEAD = FALSE;//Level Loss or Pseudo Permanent CON -2
const float PHYSICAL_PENALTY_DURATION = 600.0f;//Seconds (real-time)

//These are used when PHB_RAISE_DEAD is set to FALSE
const int PENALTY_INCREASE = TRUE;//Penalty increases with each death
const int LOSE_LEVEL_PROTECTION = TRUE;//No protection from level loss
const int ONE_HIT_POINT_PER_LEVEL = TRUE;//Player respawns with one hp/level

//Alternate setting
const int REMOVE_EFFECTS = FALSE; // whether or not to remove bad FX on respawn

//: ONPLAYER RESPAWN CONSTANTS
//:****************************************************************************/

//:****************************************************************************/
//: FUNCTIONS

void Fight(object oPlayer);
void RespawnReset(object oPlayer);
void Respawn(object oPlayer);

//BS OnDeath
void PutItemsInPack(object oDead);
void CheckContents(object oBackPack);
void CheckForCombat(object oDead, int nTimesDied);
void ShowDeathGUI(object oDead, int nTimesDied);

//BS OnDying
void ClearMyAttacker(object oDying);
void UnequipRegeneration(object oDying);
void Bleed(object oDying);
void Cry(object oDying);
void runAgain(object oDying);

string OBD_GetDBString()
{
  object oMod = GetModule();
  string sDB = GetLocalString(oMod,"ORS_DATABASE");

  return sDB;
}

void Fight(object oPlayer)
{

   //If Player is Alive Renew Enemies
   if (GetCurrentHitPoints(oPlayer) > 0)
   {
     RespawnReset(oPlayer);
   }

   //Player Not Alive Yet
   else
   {
     if(GetIsObjectValid(oPlayer)) DelayCommand(ROUND, Fight(oPlayer));
   }
}

void RespawnReset(object oPlayer)
{
   //Reset Reputations With Standard Commoner Faction
   if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPlayer) <= 10)
   {
     SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oPlayer);
   }

   //Reset Reputations With Standard Merchant Faction
   if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPlayer) <= 10)
   {
     SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oPlayer);
   }

   //Reset Reputations With Standard Defender Faction
   if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPlayer) <= 10)
   {
     SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oPlayer);
   }

   //Reset Reputations With Standard Hostile Faction
   if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oPlayer) > 10)
   {
     SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oPlayer);
   }
}

void RespawnPortalDelay(object oPC)
{
    string sDB = OBD_GetDBString();
    int nDelay = GetLocalInt(GetModule(),"OBD_PORTAL_DEL");
    int nOld = NBDE_GetCampaignInt(sDB,"OBD_PORTAL_DEL_COUNT",oPC);

    int nCurrent = nOld + 1;
    SetLocalInt(oPC, "OBD_PORTAL_DEL_COUNT", nCurrent);
    NBDE_SetCampaignInt(sDB,"OBD_PORTAL_DEL_COUNT",nCurrent,oPC);

    int nMessage = nDelay - nCurrent;

    if(nMessage > 1)
    {
      FloatingTextStringOnCreature("Afterlife Portal may be used in " + IntToString(nMessage) + " Rounds", oPC, FALSE);
    }
    else
    {
      FloatingTextStringOnCreature("Afterlife Portal Ready", oPC, FALSE);
      SetLocalInt(oPC, "OBD_PORTAL_DEL_COUNT", 0);
      NBDE_SetCampaignInt(sDB,"OBD_PORTAL_DEL_COUNT",0,oPC);
    }
}

void Respawn(object oPC)
{
    object oMod             = GetModule();
    object oSoulRune        = GetItemPossessedBy(oPC,"SoulRune");
    object oTargetHeaven    = GetWaypointByTag("WP_HEAVEN");
    object oTargetHell      = GetWaypointByTag("WP_HELL");
    object oTargetLimbo     = GetWaypointByTag("WP_LIMBO");
    object oTargetPerm      = GetWaypointByTag("WP_PERMDEATH");
    int nPermDeath          = GetLocalInt(oMod,"PERMDEATH");
    int nXPPen              = GetLocalInt(oMod,"XPPEN");
    int nXPC                = GetLocalInt(oMod,"XPC");
    int nXPRate             = GetLocalInt(oMod,"XPRATE");
    int nXPLvl              = GetLocalInt(oMod,"XPLVL");
    int nXPAdder            = GetLocalInt(oMod,"XPADDER");
    int nGPPen              = GetLocalInt(oMod,"GPPEN");
    int nGPRate             = GetLocalInt(oMod,"GPRATE");

    location lTargetHeaven  = GetLocation(oTargetHeaven);
    location lTargetHell    = GetLocation(oTargetHell);
    location lTargetLimbo   = GetLocation(oTargetLimbo);
    location lTargetPerm    = GetLocation(oTargetPerm);

    effect eHeaven  = EffectVisualEffect(VFX_FNF_WORD); // Heaven base respawn effect
    effect eLimbo   = EffectVisualEffect(VFX_FNF_NATURES_BALANCE); // Limbo base respawn effect
    effect eHell    = EffectVisualEffect(VFX_FNF_PWKILL); // Hell base respawn effect
    effect ePerm    = EffectVisualEffect(VFX_IMP_DEATH_L); // Permanent Death base respawn effect
    effect eFX1     = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER); // For Healing at Respawn Area
    effect eFX2     = EffectVisualEffect(VFX_IMP_HEALING_G); //For after Raise Dead effect at Bind Stone or Home
    effect eFX3     = EffectVisualEffect(VFX_IMP_RAISE_DEAD); //For Bind Stone/Home/Death Eternal effect
    effect eFX4     = EffectVisualEffect(VFX_IMP_UNSUMMON); // For leaving the dead corpse at respawn
    effect eFX5     = EffectVisualEffect(VFX_IMP_GOOD_HELP); // Permanent Death Effect
    effect eFX6     = EffectVisualEffect(VFX_IMP_EVIL_HELP); // Permanent Death Effect

    float fDelay = 1.5; // This the delay from respawn button pressed to respawn location

    string sDB = OBD_GetDBString();

    RespawnReset(oPC);
    RespawnPortalDelay(oPC);

    //Set the Player Death Stat's When Permanent Death is ON
    int nHD = GetHitDice(oPC);
    if(nHD > GetLocalInt(oMod,"STARTLIVES"))
    {
      int nStack = GetItemStackSize(oSoulRune);
      if(nStack > 1) SetItemStackSize(oSoulRune,nStack-1);
      else DestroyObject(oSoulRune);
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)), oPC);
    RemoveEffects(oPC);
    SetPlotFlag(oPC, TRUE);
    SetCommandable(FALSE, oPC);

    //Set Current HP Permanantly to PC
    //Bleed Status
    int nBleedStatus = BLEED_STATUS_CONSCIOUS;
    SetLocalInt(oPC,"BLEED_STATUS",nBleedStatus);
    NBDE_SetCampaignInt(sDB,"BLEED_STATUS",nBleedStatus,oPC);

    //Current HP's
    int nHPStatus = GetCurrentHitPoints(oPC);
    SetLocalInt(oPC,"HP",nHPStatus);
    NBDE_SetCampaignInt(sDB,"HP",nHPStatus,oPC);

    //In the King of Hill Arena
    object oKoH = GetNearestObjectByTag("WP_KOH_ARENA",oPC,1);
    if(GetIsObjectValid(oKoH))
    {
      ExecuteScript("ors_koh_respawn",oPC);
      SetLocalInt(oPC,"OBD_FORCE_RESPAWN",0);
      return;
    }

    //In the Capture the Flag Arena
    object oCtF = GetNearestObjectByTag("WP_CTF_ARENA",oPC,1);
    if(GetIsObjectValid(oCtF))
    {
      ExecuteScript("ors_ctf_respawn",oPC);
      SetLocalInt(oPC,"OBD_FORCE_RESPAWN",0);
      return;
    }

    //XP Penalty
    if(nXPPen == 1 && nHD > GetLocalInt(oMod,"STARTLIVES"))
    {
      int nPXP = GetXP(oPC);
      int nHD = GetHitDice(oPC);
      int nPenalty;

      if(nXPC <= 1)
      {
        nPenalty = (nXPLvl * nHD);
      }
      if(nXPC == 2)
      {
        nPenalty = ((nPXP * nXPRate)/ 100);
      }
      if(nXPC >= 3)
      {
        nPenalty = ((nXPLvl * nHD) * (nXPRate + (nXPAdder * nHD)));
      }

      int nMin = ((nHD * (nHD - 1)) / 2) * 1000;
      int nNewXP = nPXP - nPenalty;
      if (nNewXP < nMin) nNewXP = nMin;
      SetXP(oPC, nNewXP);
    }

    //GP Penalty
    if(nGPPen == 1 && nHD > GetLocalInt(oMod,"STARTLIVES"))
    {
      int nPGP = GetGold(oPC);
      int nMax = 50000;//Cap of 50,000 GP
      int nPenalty = ((nPGP * nGPRate)/ 100);
      int nGoldToTake = nPenalty;
      if(nGoldToTake > nMax) nGoldToTake = nMax;
      AssignCommand(oPC, TakeGoldFromCreature(nGoldToTake, oPC, TRUE));
      DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oPC, FALSE));
      DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oPC, FALSE));
    }

    //Reset Forced Respawn
    SetLocalInt(oPC,"OBD_FORCE_RESPAWN",0);

    //If the Player has no Lifes Left then give the Death Deed
    if(!GetIsObjectValid(oSoulRune) && nPermDeath == 1)
    {
      object oDD = CreateItemOnObject("DeathDeed", oPC);

      //Send to Death Eternal
      ClearAllActions(TRUE);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
      DelayCommand(fDelay - 0.1, SetCommandable(TRUE, oPC));
      DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lTargetPerm)));
      DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
      DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
      DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, ePerm, lTargetPerm));
      DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3,  lTargetPerm));
      DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
      DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1,  lTargetPerm));
      DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2,  lTargetPerm));
      DelayCommand(fDelay + 9.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX5,  lTargetPerm));
      DelayCommand(fDelay + 10.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX6,  lTargetPerm));
    }
    else
    {
      //Respawn Locations Resurrect Player and Heal
      if (GetGoodEvilValue(oPC) <= 29)
      {
        //This is the respawn effects for Evil Players
        ClearAllActions(TRUE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
        DelayCommand(fDelay - 0.1, SetCommandable(TRUE, oPC));
        DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lTargetHell)));
        DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
        DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
        DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eHell, lTargetHell));
        DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3,  lTargetHell));
        DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
        DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1,  lTargetHell));
        DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2,  lTargetHell));
      }
      else if ((GetGoodEvilValue(oPC) >= 30) && (GetGoodEvilValue(oPC) <= 70))
      {
        //This is the respawn effects for Neutral Players
        ClearAllActions(TRUE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
        DelayCommand(fDelay - 0.1, SetCommandable(TRUE, oPC));
        DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lTargetLimbo)));
        DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
        DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
        DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eLimbo, lTargetLimbo));
        DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3,  lTargetLimbo));
        DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
        DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1,  lTargetLimbo));
        DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2,  lTargetLimbo));
      }
      else if (GetGoodEvilValue(oPC) >= 71)
      {
        //This is the respawn effects for Good Players
        ClearAllActions(TRUE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
        DelayCommand(fDelay - 0.1, SetCommandable(TRUE, oPC));
        DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lTargetHeaven)));
        DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
        DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
        DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eHeaven, lTargetHeaven));
        DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3,  lTargetHeaven));
        DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
        DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1,  lTargetHeaven));
        DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2,  lTargetHeaven));
      }

      SetPlotFlag(oPC, FALSE);
    }
}

void PutItemsInPack(object oDead)
{
   location lDied      = GetLocation(oDead);
   int      nHasItem   = FALSE;
   object   oItem      = GetFirstItemInInventory(oDead);
   object   oBackPack = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_lootbag6", lDied);

   //Put All General Inventory Items in a Loot Back Pack
   if (GetIsObjectValid(oItem))
   {
     while (GetIsObjectValid(oItem))
     {
       AssignCommand(oBackPack, ActionTakeItem(oItem, oDead));
       oItem = GetNextItemInInventory(oDead);
       nHasItem = TRUE;
     }
   }

   //If the player had at least one item put in the backpack
   if(nHasItem == TRUE) DelayCommand(30.0f, CheckContents(oBackPack));
   else DestroyObject(oBackPack, 0.5f);
}

void CheckContents(object oBackPack)
{
   object oItem = GetFirstItemInInventory(oBackPack);

   if (GetIsObjectValid(oItem))DelayCommand((ROUND * 5.0f), CheckContents(oBackPack));
   else DestroyObject(oBackPack, 0.5f);
}

void CheckForCombat(object oDead, int nTimesDied)
{
   int nAnyOneAlive = FALSE;
   int nInCombat = FALSE;

   object oMember = GetFirstFactionMember(oDead);
   while (GetIsObjectValid(oMember))
   {
     if(oMember != oDead)
     {
       if(nAnyOneAlive == FALSE && GetCurrentHitPoints(oMember) > 0) nAnyOneAlive = TRUE;
       if (GetIsInCombat(oMember)) nInCombat = TRUE;
     }
     oMember = GetNextFactionMember(oMember);
   }

   //Make Them wait if any are alive and in combat
   if(nAnyOneAlive == TRUE && nInCombat == TRUE)
   {
     // Make sure player is still logged in
     if (GetIsObjectValid(oDead))
      {
         SendMessageToPC(oDead, "You may not respawn until your party is " + "not in combat.");
         DelayCommand(ROUND, CheckForCombat(oDead, nTimesDied));
      }
   }

   //Show Death GUI
   else DelayCommand(ROUND, ShowDeathGUI(oDead, nTimesDied));
}

int RespawnForcedDelayCheck(object oDead)
{
    //Player Pressed Respawn or Was Healed Somehow
    if(GetLocalInt(oDead,"OBD_FORCE_RESPAWN") <= 0) return FALSE;
    int nCount = GetLocalInt(oDead,"OBD_FORCE_RESPAWN_COUNT");
    if(nCount <= 0) return FALSE;

    //Update Forced Check
    int nOld = GetLocalInt(oDead,"OBD_FORCE_RESPAWN_COUNT");
    int nCurrent = nOld + 1;
    SetLocalInt(oDead, "OBD_FORCE_RESPAWN_COUNT", nCurrent);

    int nDelay = GetLocalInt(GetModule(),"OBD_FORCE_RESPAWN");
     GetLocalInt(oDead,"OBD_FORCE_RESPAWN_COUNT");

    if(nCurrent >= nDelay)
    {
      SetLocalInt(oDead, "OBD_FORCE_RESPAWN_COUNT", 0);
      return TRUE;
    }
    else
    {
      int nMessage = nDelay - nCurrent;
      FloatingTextStringOnCreature("You will be Forced to Respawn in " + IntToString(nMessage) + " Rounds", oDead, FALSE);
      return FALSE;
    }
}

void RespawnForcedDelay(object oDead)
{
    int nDelay = GetLocalInt(GetModule(),"OBD_FORCE_RESPAWN");

    //Turned Off
    if(nDelay == 0) return;

    //Player Respawned Or Got Healed
    int nRespawn = GetLocalInt(oDead,"OBD_FORCE_RESPAWN");
    if(nRespawn <= 0 || GetCurrentHitPoints(oDead) > 0)
    {
      //Just in Case
      SetLocalInt(oDead, "OBD_FORCE_RESPAWN", 0);
      SetLocalInt(oDead, "OBD_FORCE_RESPAWN_COUNT", 0);
      return;
    }

    //Check if Forced Respawn Needs Processing
    if(RespawnForcedDelayCheck(oDead))
    {
      SetLocalInt(oDead, "OBD_FORCE_RESPAWN", 0);
      SetLocalInt(oDead, "OBD_FORCE_RESPAWN_COUNT", 0);
      Respawn(oDead);
      return;
    }
}

void ShowDeathGUI(object oDead, int nTimesDied)
{
   int nHP = GetCurrentHitPoints(oDead);
   string sDB = OBD_GetDBString();

   //If we got to conscious without respawning - reset bleeding variable
   if (nHP > 0 )
   {
      SetLocalInt(oDead, "OBD_FORCE_RESPAWN", 0);
      SetLocalInt(oDead, "OBD_FORCE_RESPAWN_COUNT", 0);

      SetLocalInt(oDead, "BLEED_STATUS", BLEED_STATUS_CONSCIOUS);
      NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_CONSCIOUS,oDead);
   }
   else if (nHP < -10)
   {
     SetLocalInt(oDead, "OBD_FORCE_RESPAWN", 1);
     SetLocalInt(oDead, "OBD_FORCE_RESPAWN_COUNT", 1);

     //Show Death GUI Panel
     string sDeathPanel = GetLocalString(GetModule(),"DEATHPANEL");
     PopUpDeathGUIPanel(oDead, TRUE, TRUE, 0, sDeathPanel);

     //In case the Player Used the "Wait for Help"
     DelayCommand(60.0f, ShowDeathGUI(oDead, nTimesDied));
   }
}

void ClearMyAttacker(object oDying)
{
   if(KEEP_ATTACKING == TRUE)
   {
     if((KEEP_ATTACKING_DC_CHECK
       && d20() + GetAbilityModifier(ABILITY_INTELLIGENCE, OBJECT_SELF) >= KEEP_ATTACKING_DC)
       || d100() <= KEEP_ATTACK_PERCENT)
     {
       return;
     }
   }

   //Stop Attacking Bleeding Player (Checks for Valid Bleeder Target)
   object oTarget = GetAttackTarget(OBJECT_SELF);
   if(oTarget != oDying)
   {
     if(GetIsObjectValid(oTarget)) return;
     oTarget = GetAttemptedAttackTarget();

     //Bleeder is also not my attempted attack target
     if(oTarget != oDying)
     {
       if(GetIsObjectValid(oTarget)) return;
       if(oTarget != oDying) oTarget = GetAttemptedSpellTarget();
       if(GetIsObjectValid(oTarget)) return;
     }
   }

   //Adjust reputation with attackers and standard hostiles
   AdjustReputation(oDying, OBJECT_SELF, 100);
   SetIsTemporaryFriend(oDying, OBJECT_SELF, TRUE, 0.5);
   SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 100, oDying);

   //Get out of Combat with Bleeder and Restart Combat
   AssignCommand(OBJECT_SELF, ClearAllActions(TRUE));
   AssignCommand(OBJECT_SELF, ActionMoveAwayFromObject(oDying, FALSE, 2.0f));
   AssignCommand(OBJECT_SELF, DetermineCombatRound());
}

void UnequipRegeneration(object oDying)
{
   int nSlot = INVENTORY_SLOT_HEAD;
   object oItem, oNewItem;
   for (; nSlot < NUM_INVENTORY_SLOTS; nSlot++)
   {
     oItem = GetItemInSlot( nSlot, oDying);
     if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION))
     {
       oNewItem = CopyItem(oItem, oDying, TRUE);
       DestroyObject(oItem);
       SendMessageToPC(oDying, "Unequipping " + GetName(oItem));
     }
   }
}

void Bleed(object oDying)
{
  if(!GetIsObjectValid(oDying)) return;

  string sDB = OBD_GetDBString();

  AssignCommand(oDying, ClearAllActions());
  int nHP = GetCurrentHitPoints(oDying);
  int nLastHP = GetLocalInt(oDying, "LAST_HP");

  //Player is Dead
  if (nHP < -10)
  {
    SendMessageToPC(oDying, "You have bled to death.");
    effect eDeath = EffectDeath(FALSE, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oDying);

    SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_DEAD);
    NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_DEAD,oDying);
    SetLocalInt(oDying,"OBD_FORCE_RESPAWN",1);
    return;
  }

  //Player is Alive and Conscious
  if (nHP >= 1)
  {
    SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_CONSCIOUS);
    NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_CONSCIOUS,oDying);
    SetLocalInt(oDying,"OBD_FORCE_RESPAWN",0);
    SendMessageToPC(oDying, "You have regained consciousness.");
    RespawnReset(oDying);
    return;
  }

  //Player is Bleeding
  if (GetLocalInt(oDying, "BLEED_STATUS") == BLEED_STATUS_BLEEDING)
  {
    int nStabilized = FALSE;
    int nConstitutionMod = 0;

    if(STABILIZE_CON_BONUS == TRUE) nConstitutionMod = GetAbilityModifier(ABILITY_CONSTITUTION, oDying);
    if(STABILIZE_DC_CHECK == TRUE) nStabilized = d20() + nConstitutionMod >= STABILIZE_DC;
    else nStabilized = d100() <= STABILIZE_PERCENT + nConstitutionMod;

    if(nStabilized)
    {
      SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_STABLE);
      NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_STABLE,oDying);
      SetLocalInt(oDying,"OBD_FORCE_RESPAWN",0);
      SendMessageToPC(oDying, "You have stabilized.");
    }
  }

  //Player is Alive and Conscious
  if (GetLocalInt(oDying, "BLEED_STATUS") == BLEED_STATUS_STABLE)
  {
    effect eHeal = EffectHeal(1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oDying);
    SendMessageToPC(oDying, "You heal 1 hit point. HP: " + IntToString(nHP + 1));

    //Stabilized
    if(GetCurrentHitPoints(oDying) >= 1)
    {
      SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_CONSCIOUS);
      NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_CONSCIOUS,oDying);
      SetLocalInt(oDying,"OBD_FORCE_RESPAWN",0);
      SendMessageToPC(oDying, "You have regained consciousness.");
      RespawnReset(oDying);
      return;
    }

    runAgain(oDying);
    return;
   }

   //Healed By Someone
   if(nHP > nLastHP)
   {
      SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_STABLE);
      NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_STABLE,oDying);
      SetLocalInt(oDying,"OBD_FORCE_RESPAWN",0);
      SendMessageToPC(oDying, "You have stabilized.");
      AssignCommand(oDying, ClearAllActions());
      DelayCommand(0.5f, AssignCommand(oDying, PlayVoiceChat(VOICE_CHAT_THANKS)));
      runAgain(oDying);
      return;
   }

   //Sanity check
   if(GetLocalInt(oDying, "BLEED_STATUS") != BLEED_STATUS_BLEEDING) return;

   // Apply bleeding damage
   effect eDamage = EffectDamage(1, DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_TWENTY);
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oDying);
   nHP = GetCurrentHitPoints(oDying);
   string sMessage = "You are bleeding to death! HP: " + IntToString(nHP);
   SendMessageToPC(oDying, sMessage);

   //Play Voice Chat
   if(nHP >= -10) Cry(oDying);
   else
   {
     SendMessageToPC(oDying, "You have bled to death.");
     SetLocalInt(oDying,"OBD_FORCE_RESPAWN",0);
     effect eDeath = EffectDeath(FALSE, FALSE);
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oDying);

     SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_DEAD);
     NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_DEAD,oDying);
     return;
   }

   //Continue Bleeding
   runAgain(oDying);
}

void Cry(object oDying)
{
   switch (d6())
   {
     case 1: PlayVoiceChat (VOICE_CHAT_PAIN1,     oDying); break;
     case 2: PlayVoiceChat (VOICE_CHAT_PAIN2,     oDying); break;
     case 3: PlayVoiceChat (VOICE_CHAT_PAIN3,     oDying); break;
     case 4: PlayVoiceChat (VOICE_CHAT_HEALME,    oDying); break;
     case 5: PlayVoiceChat (VOICE_CHAT_NEARDEATH, oDying); break;
     case 6: PlayVoiceChat (VOICE_CHAT_HELP,      oDying); break;
   }
}

void runAgain(object oDying)
{
   SetLocalInt(oDying, "LAST_HP", GetCurrentHitPoints(oDying));
   effect eParalyze = EffectParalyze();
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, oDying, ROUND);
   DelayCommand(ROUND, Bleed(oDying));
}

//void main(){}
