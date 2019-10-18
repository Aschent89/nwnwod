////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_base
//  by Don Anderson
//  dandersonru@msn.com
//
//  Main AI Include File
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_constant"
#include "oai_inc_eqweapon"
#include "oai_modprops_inc"
#include "oai_dice_inc"
#include "x0_i0_petrify"
#include "x0_i0_spells"

/******************************************************************************/
//: FUNCTION DEFINITIONS BY OLANDER

//Sets up the Status of a said condition
void SetStatusCondition(int nCondition, int bValid = TRUE);

//Gets the Status of a said condition
int GetStatusCondition(int nCondition, object oWho = OBJECT_SELF);

//Sets a Battle Condition
void SetBattleCondition(int nCondition, int bValid = TRUE, object oWho = OBJECT_SELF);

//Gets a Battle Condition
int GetBattleCondition(int nCondition, object oWho = OBJECT_SELF);

//Returns TRUE if this Creature has any levels as Cleric or Druid
int OAI_GetIsDivineCaster(object oCreature);

//Returns TRUE if this Creature has any Bard/Wizard/Sorcerer levels
int OAI_GetIsArcane(object oCreature);

//Removes Specific Effects
void OAI_RemoveEffects(object oTarget = OBJECT_SELF,object oFrom = OBJECT_INVALID,
     int nType = -1,int nSubType = -1,int nDurationType = -1,int nSpellId = -1);

//Checks to See if the Same Faction or an Alliance is a Hostile Actor
int OAI_GetIsAlly(object oTarget, int bIncNeutral=FALSE);

//Checks to See really an enemy (not all non-friends are enemies)
int OAI_GetIsEnemy(object oTarget, int bIncNeutral=FALSE);

//Check if attacker or attackee are NEUTRAL (ie. should be no aggression)
int OAI_GetIsNeutral(object oTarget);

// Determine our target for the next combat round.
// Normally, this will be the same target as the last round.
object OAI_AcquireTarget();

//Determines a particular Class Position is a Spell Caster
//Used internally OAI_CanCastSpells
int OAI_ClassIsSpellCaster(int nPos,object oNPC);

//Returns whether a creature is capable of casting spells
int OAI_CanCastSpells(object oNPC);

//Counts up Enemies
void OAI_SetCounts();

//Gets the Area Width for any Area
int GetAreaWidth(object oArea);

//Gets the Area Height for any Area
int GetAreaHeight(object oArea);

//Gets a Random Location in any Area
location RandomLocation(object oArea,int nAir = 1);

//Highlights Targetted Object
void OAI_HighLightObject(object oTarget);

//Highlights Targetted Location
void OAI_HighLightLocation(location lTarget);

/******************************************************************************/
//:: SPELLCASTER FUNCTIONS


/******************************************************************************/
//:: FUNCTIONS FROM Deva Bryson Winblood (RTS - Harvester Of Souls)

// PURPOSE: return TRUE if the target has negative effects
int caiGetHasNegativeEffects(object oTarget);

// PURPOSE: return if the target is petrified
int fnIsPetrified(object oTarget);

// PURPOSE: return a useful to spell to help with target PC
int caiGetAvailableHealPC(object oNPC,object oTarget);

// PURPOSE: Determine best healing spell available for given damage
int caiGetAvailableHeal(object oNPC,int nDamageAmount,int bMUSTHEAL=FALSE);

// PURPOSE: Look for buff spells
int caiGetAvailableBuff(object oNPC,object oTarget);

// PURPOSE: find out what type of charm target this is
int fnGetCharmType(object oTarget);

// PURPOSE: Returns TRUE if the target has spells on them
int fnGetHasSpellDefense(object oTarget);

// PURPOSE RETURN: Combat spell
int caiGetAvailableCombatSpell(object oNPC,object oTarget);

// PURPOSE: To return a defensive spell that oNPC has that is useful to oTarget.
int caiGetAvailableDefensiveSpell(object oNPC,object oTarget);

// PURPOSE: Return spells to counter invisibility, stealth, etc.
int caiProfessionalAntiStealth();

// PURPOSE: Return defensive spells versus specified target
int caiProfessionalDefensive(object oTarget);

// PURPOSE: Return counter magic to spells on target
int caiProfessionalCounter(object oTarget);

// PURPOSE: Return offensive close quarter spell
int caiProfessionalCloseQuarters(object oTarget);

// PURPOSE: Return offensive spells versus the target
int caiProfessionalOffensive(object oTarget);

// PURPOSE: Get the Best Object To Heal
object caiGetBestObjectToHeal(object oMe);

/******************************************************************************/
/******************************************************************************/
            /***** FUNCTIONS FROM BIOWARE AND OLANDER *****/

//Checks for Any Nearby Spell Casters
int OAI_GetCanEnemiesCastSpells();

//Determines and Action After Casting a Spell
int WhatToDoAfterCasting(object oSelf);

//For Trigger Cast Buffs on Spawn
void UseSpellBuffs(object oCreature = OBJECT_SELF);

// ADVANCED BUFF SELF
// Returns TRUE on successful use,  FALSE otherwise.
int OAI_AdvancedBuff(float fDistance, int bInstant = TRUE);

//Cast Aura Effects on Caster
void CastAuras();

//Returns TRUE if Creature Can Use Turning
int OAI_UseTurning();

//Determines what attack type to use when using a Ranged Weapon or passes onto Melee below.
void OAI_Fighting(object oTarget);

//Does the Summon Hordes ability
void OAI_SummonHordes();

//Casts the Resurection or Raise Dead Spell
//Called from OAI_DetermineAllyToRez()
int OAI_CastRezOn(object oTarget);

//Determines an Ally to Rez
int OAI_DetermineAllyToRez();

//Main Trigger Call to Execute Some Spawn Variables
void OAI_CastTriggers();

//Verifies if an NPC is Under Direct Melee Attack
int OAI_IsUnderMeleeAttack(object oWho = OBJECT_SELF);

//Manages an Enemy's AOE
int OAI_ManageEnemyAOE();

//Special Dragon Winged Buffet
//Called from OAI_Dragons(object oFoe)
int OAI_DragonWingBuffet(object oFoe);

//Special Dragon Stomp
//Called from OAI_Dragons(object oFoe)
int OAI_DragonStomp(object oFoe);

//Special Dragon Combat AI
int OAI_Dragons(object oFoe);

//Special Beholder Combat AI
void OAI_Beholders(object oFoe);

//Beholder Special AI Eyeball Ray Attack
void OAI_EyeballRayAttack(object oTarget = OBJECT_SELF);

//Beholder Special AI Beholder Ray Attack
void OAI_BeholderRayAttack(object oTarget = OBJECT_SELF);

//Special Winged Creature Combat AI
int OAI_GetIsWinged(object oCreature);

//Special Winged Creature Combat AI
int OAI_WingedCreature(object oFoe);

//Special Gelatinous Cube AI
void OAI_GelatinousCube(object oFoe);

//Talent for Gelatinous Cube AI
int OAI_CheckEngulf(object oTarget = OBJECT_SELF);

//Engulf anyone within the Gelatinous Cube.
void OAI_Engulf();

//Split All manner of Oozes, Puddings, Jellys, Slimes, and Slithering Trackers
void OAI_DoOozeSplit(object oCreature);

//Spore Multiply
void OAI_DoSporeMultiply(object oCreature);

//Mind Flayer Special Role AI
int OAI_MindFlayerCombat(object oTarget);

//Checks for Mind Flayer Brain Suck Conditions
int OAI_MFGetTargetConditionSucks(object oTarget);

//Special Spider Tactics
int OAI_SpiderTactics(object oTarget);

// Consumes a light source by the given amount
// Compatible with HC torches/lanterns, just doesn't give any message
void OAI_ConsumeTorch(object oLight, int nAmt);

//Vampire Burning in Sunlight
void OAI_VampireHB();

//Troll Hearbeat Functon
void OAI_TrollHB();

//Troll Damaged Function
void OAI_TrollDamaged();

//Troll Spell Cast At Function
void OAI_TrollSpellCastAt();

//Troll Death Function
int OAI_TrollDeath();

//Creates a Field Effect After Suicide Bomber Ignites
void OAI_CreateFieldEffect(location lLoc);

//Olander's Suicide Bombers =O
void OAI_Kaboom(object oCreature);

//Olander's Transforming Creatures
int OAI_Transform(object oCreature);

//Olander's Burrowing Creatures
int OAI_Burrow(object oCreature);

//Breaks the Illusionary Creature
int OAI_BreakIllusion(object oTarget, int nAmDead = FALSE);

//The Main Routine For the Status Caster
void OAI_StatusCaster(object oTarget, int nState = 1);

//The Main Routine For the Attack Caster
void OAI_AttackCaster(object oTarget, int nState = 1);

//The Main Routine For the AOE Caster
void OAI_AOECaster(object oTarget, int nState = 1);

//The Main Routine For the Buffer Caster
void OAI_BufferCaster(object oTarget, int nState = 1);

/******************************************************************************/
//:: SPECIAL FUNCTIONS

//Barbarian Setup
void OAI_SetUpBarbarian(object oCreature);

//Bard Setup
void OAI_SetUpBard(object oCreature);

//Cleric Setup
void OAI_SetUpCleric(object oCreature);

//Druid Setup
void OAI_SetUpDruid(object oCreature);

//Fighter Setup
void OAI_SetUpFighter(object oCreature);

//Monk Setup
void OAI_SetUpMonk(object oCreature);

//Paladin Setup
void OAI_SetUpPaladin(object oCreature);

//Ranger Setup
void OAI_SetUpRanger(object oCreature);

//Rogue Setup
void OAI_SetUpRogue(object oCreature);

//Sorcerer Setup
void OAI_SetUpSorcerer(object oCreature);

//Wizard Setup
void OAI_SetUpWizard(object oCreature);

/******************************************************************************/
//:: MELEE FUNCTIONS

//Checks to See if a Target is In Melee Range
int OAI_GetIsTargetInMeleeRange(object oTarget,object oCreature=OBJECT_SELF);

//OAI Trampling System for Horses and Horsemen (On Damaged Event....does not Work on Players)
void OAI_Trample(object oDamager,object oCreature=OBJECT_SELF);

//OAI Critical System (On Damaged Event....does not Work on Players)
void OAI_Crits(object oDamager,object oCreature=OBJECT_SELF);

//Kills the Creature in Cool Ways
void OAI_CritKills(object oCreature, object oKiller);

//Calcs the Melee Crit Chance Potential
int OAI_MeleeCalcCritChance(object oDamager, object oCreature, object oWeapon);

//Calcs Ranged Weapon Kill Crit Chance
int OAI_RangedCalcKillChance(object oDamager, object oCreature, object oWeapon);

//Determines if Creature is Riding a Horse
int OAI_IsRidingHorse(object oCreature);

//Mounts up the NPC on a Horse
void OAI_MountUp(object oCreature);

//Trample Charge on NPCs
void OAI_TrampleCharge(object oCreature);

//Calcs Trample Chance
int OAI_TrampleCalcKillChance(object oDamager, object oCreature);

//Calcs Falling Off Horse
void OAI_TrampleFallChance(object oDamager, object oCreature);

//Tramples Enemies within 5M Radius
void OAI_Trample(object oDamager,object oCreature=OBJECT_SELF);

//Creature Will Whirlwind if They have the Feat (Based Upon Logic and Chance)
int OAI_TryToWhirl(object oCreature);

//Teleport Move to a Random Location in an Area
void OAI_BlinkMove();

//Teleport Close to the Target and Continue Melee
void OAI_BlinkMelee(object oTarget);

//General Melee Combat
void OAI_MeleeGeneral(object oTarget,object oCreature = OBJECT_SELF);

//Ranged Combat
void OAI_RangedCombat(object oTarget,object oCreature = OBJECT_SELF);

//Religious Melee Combat
void OAI_MeleeDivine(object oTarget,object oCreature = OBJECT_SELF);

//Smite Melee Combat
void OAI_MeleeSmite(object oTarget,object oCreature = OBJECT_SELF);

//Sneak Melee Combat
void OAI_MeleeSneak(object oTarget,object oCreature = OBJECT_SELF);

//Dexterity Melee Combat
void OAI_MeleeDexterity(object oTarget,object oCreature = OBJECT_SELF);

//Weapon Master Melee Combat
void OAI_MeleeWeaponMaster(object oTarget,object oCreature = OBJECT_SELF);

//Palemaster Melee Combat
void OAI_MeleePalemaster(object oTarget,object oCreature = OBJECT_SELF);

//Dragon Disciple Melee Combat
void OAI_MeleeRDD(object oTarget,object oCreature = OBJECT_SELF);

//Shifter Melee Combat
void OAI_MeleeShifter(object oTarget,object oCreature = OBJECT_SELF);

//Monk Melee Combat
void OAI_MeleeMonk(object oTarget,object oCreature = OBJECT_SELF);

//: FUNCTION DEFINITIONS
/******************************************************************************/

/******************************************************************************/
//: TIME FUNCTIONS (By CEREBORN)

int OAI_SPAWN_EPOCH = 1;

// Get the current time (elapsed since the Epoch) in real seconds
int OAI_GetCurrentRealSeconds();

// Convert a calendar (game) time to real seconds
int OAI_CalendarToRealSeconds(int year, int month, int day, int hour, int minute,
    int second);

// Returns number of real seconds in the # of specified (game) years
int OAI_YearsToRealSeconds(int years);

// Returns number of real seconds in the # of specified (game) months
int OAI_MonthsToRealSeconds(int months);

// Returns number of real seconds in the # of specified (game) days
int OAI_DaysToRealSeconds(int days);

// Returns number of real seconds in the # of specified (game) hours
int OAI_HoursToRealSeconds(int hours);

int OAI_YearsToRealSeconds(int years)
{
    return OAI_MonthsToRealSeconds(years*12);
}

int OAI_MonthsToRealSeconds(int months)
{
    return OAI_DaysToRealSeconds(months*28);
}

int OAI_DaysToRealSeconds(int days)
{
    return FloatToInt(HoursToSeconds(days*24));
}

int OAI_HoursToRealSeconds(int hours)
{
    return FloatToInt(HoursToSeconds(hours));
}

int OAI_CalendarToRealSeconds(int year, int month, int day, int hour, int minute,
   int second)
{
    if (year < OAI_SPAWN_EPOCH)
       year = OAI_SPAWN_EPOCH;
    if (month < 1)
       month = 1;
    if (day < 1)
       day = 1;

    return (OAI_YearsToRealSeconds(year-OAI_SPAWN_EPOCH) +
           OAI_MonthsToRealSeconds(month-1) +
           OAI_DaysToRealSeconds(day-1) +
           FloatToInt(HoursToSeconds(hour)) +
           (minute*60) +
           second);
}


int OAI_GetCurrentRealSeconds()
{
    //clockDebug("Converting " + IntToString(GetCalendarYear()) + " " +
    //    IntToString(GetCalendarMonth()) + " " +
    //    IntToString(GetCalendarDay()) + " " +
    //    IntToString(GetTimeHour()) + " " +
    //    IntToString(GetTimeMinute()) + " " +
    //    IntToString(GetTimeSecond()));

    return OAI_CalendarToRealSeconds(GetCalendarYear(), GetCalendarMonth(),
        GetCalendarDay(), GetTimeHour(), GetTimeMinute(), GetTimeSecond());
}

string OAI_RealSecondsToString(int nRealSeconds)
{
    int nMod;
    int nRem;
    string sDateTime = "";

    nMod = nRealSeconds / OAI_YearsToRealSeconds(1);
    nRem = nRealSeconds % OAI_YearsToRealSeconds(1);

    sDateTime = IntToString(nMod + OAI_SPAWN_EPOCH);

    nMod = nRem / OAI_MonthsToRealSeconds(1);
    nRem = nRem % OAI_MonthsToRealSeconds(1);

    sDateTime += " " + IntToString(nMod+1);

    nMod = nRem / OAI_DaysToRealSeconds(1);
    nRem = nRem % OAI_DaysToRealSeconds(1);

    sDateTime += " " + IntToString(nMod+1);

    nMod = nRem / FloatToInt(HoursToSeconds(1));
    nRem = nRem % FloatToInt(HoursToSeconds(1));

    sDateTime += " " + IntToString(nMod) + ":";

    nMod = nRem / 60;
    nRem = nRem % 60;

    if (nMod < 10)
        sDateTime += "0" + IntToString(nMod) + ":";
    else
        sDateTime += IntToString(nMod) + ":";

    if (nRem < 10)
        sDateTime += "0" + IntToString(nRem);
    else
        sDateTime += IntToString(nRem);

    return sDateTime;
}

//: TIME FUNCTIONS (By CEREBORN)
/******************************************************************************/

/******************************************************************************/
//: AI FUNCTIONS

void SetStatusCondition(int nCondition, int bValid = TRUE)
{
  string sSC = IntToString(nCondition);
  if(bValid == TRUE)
  {
    SetLocalInt(OBJECT_SELF, "OAI_" + sSC, nCondition);
  }
  else if(bValid == FALSE)
  {
    SetLocalInt(OBJECT_SELF, "OAI_" + sSC, 0);
  }
}

int GetStatusCondition(int nCondition, object oWho = OBJECT_SELF)
{
  string sSC = IntToString(nCondition);
  int nPlot = GetLocalInt(oWho, "OAI_" + sSC);
  if(nPlot == nCondition) return TRUE;
  return FALSE;
}

void SetBattleCondition(int nCondition, int bValid = TRUE, object oWho = OBJECT_SELF)
{
  string sBC = IntToString(nCondition);
  if(bValid == TRUE)
  {
    SetLocalInt(oWho, "OAI_" + sBC, nCondition);
  }
  else if(bValid == FALSE)
  {
    SetLocalInt(oWho, "OAI_" + sBC, 0);
  }
}

int GetBattleCondition(int nCondition, object oWho = OBJECT_SELF)
{
  string sBC = IntToString(nCondition);
  int nPlot = GetLocalInt(oWho, "OAI_" + sBC);
  if(nPlot == nCondition) return TRUE;
  return FALSE;
}

int OAI_GetIsDivineCaster(object oCreature)
{ // caiGetIsCleric()
  int nClass1 = GetClassByPosition(1,oCreature);
  if (nClass1 == CLASS_TYPE_CLERIC || nClass1 == CLASS_TYPE_DRUID) return TRUE;

  int nClass2 = GetClassByPosition(2,oCreature);
  if (nClass2 == CLASS_TYPE_CLERIC || nClass2 == CLASS_TYPE_DRUID) return TRUE;

  int nClass3 = GetClassByPosition(3,oCreature);
  if (nClass3 == CLASS_TYPE_CLERIC || nClass3 == CLASS_TYPE_DRUID) return TRUE;

  return FALSE;
}

int OAI_GetIsArcane(object oCreature)
{// caiGetIsArcane()
  int nClass1 = GetClassByPosition(1,oCreature);
  if (nClass1 == CLASS_TYPE_WIZARD || nClass1 == CLASS_TYPE_SORCERER || nClass1 == CLASS_TYPE_BARD) return TRUE;

  int nClass2 = GetClassByPosition(2,oCreature);
  if (nClass2 == CLASS_TYPE_WIZARD || nClass2 == CLASS_TYPE_SORCERER || nClass2 == CLASS_TYPE_BARD) return TRUE;

  int nClass3 = GetClassByPosition(3,oCreature);
  if (nClass3 == CLASS_TYPE_WIZARD || nClass3 == CLASS_TYPE_SORCERER || nClass3 == CLASS_TYPE_BARD) return TRUE;

  return FALSE;
}

void OAI_RemoveEffects(object oTarget=OBJECT_SELF,object oFrom=OBJECT_INVALID,
     int nType=-1,int nSubType=-1,int nDurationType=-1,int nSpellId=-1)
{
  effect eEffect = GetFirstEffect(oTarget);
  while(GetIsEffectValid(eEffect))
  {
    if((oFrom == OBJECT_INVALID || GetEffectCreator(eEffect) == oFrom)
      &&(nType==-1 || GetEffectType(eEffect)==nType)
      &&(nSubType==-1 || GetEffectSubType(eEffect)==nSubType)
      &&(nDurationType==-1 || GetEffectDurationType(eEffect)==nDurationType)
      &&(nSpellId==-1 || GetEffectSpellId(eEffect)==nSpellId))
        RemoveEffect(oTarget,eEffect);

    eEffect = GetNextEffect(oTarget);
  }
}

int OAI_GetIsAlly(object oTarget, int bIncNeutral=FALSE)
{
  // Fake target
  if (!GetIsObjectValid(oTarget)) return FALSE;
  // Same faction
  if(GetFactionEqual(oTarget, OBJECT_SELF))
  {
    ClearPersonalReputation(oTarget, OBJECT_SELF);
    ClearPersonalReputation(OBJECT_SELF, oTarget);
    return TRUE;
  }

  //Same Faction/Ally/Axis No Retribution
  string sCheck = GetLocalString(OBJECT_SELF,OAI_FACTION);
  string sTarget = GetLocalString(oTarget,OAI_FACTION);

  // Same Allegience
  if(sCheck == sTarget)
  {
    ClearPersonalReputation(oTarget, OBJECT_SELF);
    ClearPersonalReputation(OBJECT_SELF, oTarget);
    return TRUE;
  }

  // Asked to report neutrals as Allegiences
  if(bIncNeutral && (sCheck == NEUTRAL || sTarget == NEUTRAL))
  {
    ClearPersonalReputation(oTarget, OBJECT_SELF);
    ClearPersonalReputation(OBJECT_SELF, oTarget);
    return TRUE;
  }

  // Not necessarily an enemy but not an allegience
  return FALSE;
}

int OAI_GetIsNeutral(object oTarget)
{
  return GetLocalString(OBJECT_SELF,OAI_FACTION) == NEUTRAL ||
        GetLocalString(oTarget,OAI_FACTION) == NEUTRAL;
}

int OAI_GetIsEnemy(object oTarget, int bIncNeutral=FALSE)
{
  // If a fake target or allied then we are not an enemy
  if (!GetIsObjectValid(oTarget) || OAI_GetIsAlly(oTarget)) return FALSE;

  string sCheck = GetLocalString(OBJECT_SELF,OAI_FACTION);
  string sTarget = GetLocalString(oTarget, OAI_FACTION);

  // Neutrals have no enemies (normally) unless asked to be treated so
  if (sCheck == NEUTRAL  || sTarget == NEUTRAL) return bIncNeutral;

  // Use the normal enemy determination
  return GetIsEnemy(oTarget);
}

object OAI_AcquireTarget()
{
  int nRace=GetRacialType(OBJECT_SELF);
  object oRet=OBJECT_INVALID;
  int nN;
  float fD;
  int nVal = -1; // dk: 4-Jun-2006 Must be at least one to be selected
  object oOb;
  int nThis;
  int nC;
  nN=1;
  oOb=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,OBJECT_SELF,nN,CREATURE_TYPE_IS_ALIVE,TRUE,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
  fD=GetDistanceBetween(oOb,OBJECT_SELF);
  while(oOb!=OBJECT_INVALID&&fD<30.0)
  { // check all nearby targets
    nThis=0;
    nN++;
    if (fD<20.0) nThis++;
    if (fD<15.0) nThis++;
    if (fD<10.0) nThis++;
    if (fD<8.0) nThis++;
    if (fD<5.0) nThis++;
    fD=IntToFloat(GetCurrentHitPoints(oOb))/IntToFloat(GetMaxHitPoints(oOb));
    if (fD<0.51) nThis++;
    if (fD<0.31) nThis++;
    if (fD<0.11) nThis++;
    if (nRace==RACIAL_TYPE_UNDEAD)
    { // see if target is a cleric
      nC=GetClassByPosition(1,oOb);
      if (nC==CLASS_TYPE_CLERIC||nC==CLASS_TYPE_PALADIN||nC==CLASS_TYPE_DIVINECHAMPION||nC==CLASS_TYPE_BLACKGUARD) nThis=nThis+3;
      nC=GetClassByPosition(2,oOb);
      if (nC==CLASS_TYPE_CLERIC||nC==CLASS_TYPE_PALADIN||nC==CLASS_TYPE_DIVINECHAMPION||nC==CLASS_TYPE_BLACKGUARD) nThis=nThis+3;
      nC=GetClassByPosition(3,oOb);
      if (nC==CLASS_TYPE_CLERIC||nC==CLASS_TYPE_PALADIN||nC==CLASS_TYPE_DIVINECHAMPION||nC==CLASS_TYPE_BLACKGUARD) nThis=nThis+3;
    } // see if target is a cleric
    if(nThis>nVal && OAI_GetIsEnemy(oOb))
    { // new best target
      // dk: 4-Jun-2006 I love randomness, 1 in 6 pick a lessor target
      if (nVal < 0 || d6() < 6)
      {
          oRet=oOb;
          nVal=nThis;
      }
    } // new best target
    oOb=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,OBJECT_SELF,nN,CREATURE_TYPE_IS_ALIVE,TRUE,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
    fD=GetDistanceBetween(oOb,OBJECT_SELF);
  } // check all nearby targets

  //We have a best target
  if(GetIsObjectValid(oRet)) return oRet;

  // dk: 23-Jul-2006 If targets are past 30m just grab the first one (only look a little)
  //Get Nearest (upto 3) Perceived (Real) Enemy (not dying associate)
  for (nC = 1; nC <= 3; nC++)
  {
    // Get nearest Enemy according to Bioware
    oRet = GetNearestPerceivedEnemy(OBJECT_SELF, nC);

   // We have a valid target if not a dying Henchmen and is a real Enemy
   if(!GetAssociateState(NW_ASC_MODE_DYING, oRet) && OAI_GetIsEnemy(oRet))
     return oRet;
  }

  // Decent enemy not found
  WhatToDoAfterCasting(OBJECT_SELF);

  return OBJECT_INVALID;
}

int OAI_ClassIsSpellCaster(int nPos,object oNPC)
{
  int nClass=GetClassByPosition(nPos,oNPC);
  int bRet=FALSE;
  switch(nClass)
  {
    case CLASS_TYPE_ARCANE_ARCHER:
    case CLASS_TYPE_BARD:
    case CLASS_TYPE_CLERIC:
    case CLASS_TYPE_DRUID:
    case CLASS_TYPE_FEY:
    case CLASS_TYPE_DRAGONDISCIPLE:
    case CLASS_TYPE_PALADIN:
    case CLASS_TYPE_PALEMASTER:
    case CLASS_TYPE_RANGER:
    case CLASS_TYPE_SHADOWDANCER:
    case CLASS_TYPE_SHIFTER:
    case CLASS_TYPE_SORCERER:
    case CLASS_TYPE_WIZARD: { bRet=TRUE; break; }
    default: { break; }
  }
  return bRet;
}

int OAI_CanCastSpells(object oNPC)
{
  if (OAI_ClassIsSpellCaster(1,oNPC)) return TRUE;
  else if (OAI_ClassIsSpellCaster(2,oNPC)) return TRUE;
  else if (OAI_ClassIsSpellCaster(3,oNPC)) return TRUE;
  return FALSE;
}

void OAI_SetCounts()
{
  object oMe=OBJECT_SELF;
  object oEnemy;
  int nN=1;
  int nUND=0;
  int nOUT=0;
  int nCON=0;
  int nARC=0;
  int nDIV=0;
  int nDRA=0;
  int nRGD=0;
  int nMEL=0;
  int nV,nR;
  object oItem;
  oEnemy=GetNearestCreature(CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,oMe,nN,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,CREATURE_TYPE_IS_ALIVE,TRUE);
  while(GetIsObjectValid(oEnemy))
  { // count enemies
    oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oEnemy);
    nV=IsMeleeWeapon(oItem);
    nR=IsRangedWeapon(oItem);
    if (nV==TRUE) nMEL++;
    if (nR==TRUE) nRGD++;
    if (OAI_GetIsDivineCaster(oEnemy)) nDIV++;
    if (OAI_GetIsArcane(oEnemy)) nARC++;
    nV=GetRacialType(oEnemy);
    if (nV==RACIAL_TYPE_UNDEAD) nUND++;
    else if (nV==RACIAL_TYPE_OUTSIDER) nOUT++;
    else if (nV==RACIAL_TYPE_CONSTRUCT) nCON++;
    else if (nV==RACIAL_TYPE_DRAGON) nDRA++;
    nN++;
    oEnemy=GetNearestCreature(CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,oMe,nN,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,CREATURE_TYPE_IS_ALIVE,TRUE);
  } // count enemies
  SetLocalInt(oMe,"nCAICountUND",nUND);
  SetLocalInt(oMe,"nCAICountOUT",nOUT);
  SetLocalInt(oMe,"nCAICountCON",nCON);
  SetLocalInt(oMe,"nCAICountARC",nARC);
  SetLocalInt(oMe,"nCAICountDIV",nDIV);
  SetLocalInt(oMe,"nCAICountDRA",nDRA);
  SetLocalInt(oMe,"nCAICountRGD",nRGD);
  SetLocalInt(oMe,"nCAICountMEL",nMEL);
}

int OAI_GetCanEnemiesCastSpells()
{
  object oMe=OBJECT_SELF;
  int nN;
  float fD;
  object oOb;
  oOb=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oMe,nN,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,CREATURE_TYPE_IS_ALIVE,TRUE);
  fD=GetDistanceBetween(oMe,oOb);
  while(GetIsObjectValid(oOb)&&fD<25.0)
  {
    if (OAI_CanCastSpells(oOb))
    {
      if(OAI_GetIsEnemy(oOb))
      {
        SetLocalObject(oMe,"OAI_HAS_CASTER",oOb);
        return TRUE;
      }
    }
    nN++;
    oOb=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oMe,nN,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,CREATURE_TYPE_IS_ALIVE,TRUE);
    fD=GetDistanceBetween(oMe,oOb);
  }
  return FALSE;
}

int GetAreaWidth(object oArea)
{
  int nX = 0;
  int nY = 0;
  vector vTile = Vector(0.0, 0.0, 0.0);
  location locTile;
  for (nX = 0; nX < 32; ++nX)
  {
    vTile.x = IntToFloat(nX);
    locTile = Location(oArea, vTile, 0.0);
    int iColor = GetTileMainLight1Color(locTile);
    if (iColor < 0 || iColor > 32) return(nX);
  }
  return 32;
}

int GetAreaHeight(object oArea)
{
  int nX = 0;
  int nY = 0;
  vector vTile = Vector(0.0, 0.0, 0.0);
  location locTile;
  for (nY = 0; nY < 32; ++nY)
  {
    vTile.y = IntToFloat(nY);
    locTile = Location(oArea, vTile, 0.0);
    int iColor = GetTileMainLight1Color(locTile);
    if (iColor < 0 || iColor > 32) return(nY);
  }
  return 32;
}

location RandomLocation(object oArea,int nAir = 1)
{
  location lLoc;
  int nMX = GetAreaWidth(oArea);
  int nMY = GetAreaHeight(oArea);
  int nCX = Random(nMX)*10;
  int nCY = Random(nMY)*10;
  int nDX = Random(10);
  int nDY = Random(10);
  float fDX = IntToFloat(nDX) * 0.1;
  float fDY = IntToFloat(nDY) * 0.1;
  float fCX = IntToFloat(nCX) + fDX;
  float fCY = IntToFloat(nCY) + fDY;
  int nZ;
  float fCZ = 0.0;
  if (nAir == 2)
  {
    nZ = Random(50);
    fCZ = IntToFloat(nZ) * 0.1;
  }
  vector vVec = Vector(fCX,fCY,fCZ);
  lLoc = Location(oArea,vVec,0.0);
  return lLoc;
}

void OAI_HighLightObject(object oTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efx,oTarget,2.0);
}

void OAI_HighLightLocation(location lTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, efx, lTarget, 2.0f);
}

/******************************************************************************/
//:: SPELLCASTER FUNCTIONS

/******************************************************************************/
//:: FUNCTIONS FROM Deva Bryson Winblood (RTS - Harvester Of Souls)

int caiGetHasNegativeEffects(object oTarget)
{ // PURPOSE: return TRUE if the target has negative effects
  effect eE=GetFirstEffect(oTarget);
  int nET;
  while(GetIsEffectValid(eE))
  { // check each effect
    nET=GetEffectType(eE);
    switch(nET)
    {
      case EFFECT_TYPE_BLINDNESS:
      case EFFECT_TYPE_CONFUSED:
      case EFFECT_TYPE_CURSE:
      case EFFECT_TYPE_DAMAGE_DECREASE:
      case EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE:
      case EFFECT_TYPE_DAZED:
      case EFFECT_TYPE_DEAF:
      case EFFECT_TYPE_DISEASE:
      case EFFECT_TYPE_FRIGHTENED:
      case EFFECT_TYPE_MOVEMENT_SPEED_DECREASE:
      case EFFECT_TYPE_NEGATIVELEVEL:
      case EFFECT_TYPE_PARALYZE:
      case EFFECT_TYPE_POISON:
      case EFFECT_TYPE_SILENCE:
      case EFFECT_TYPE_SKILL_DECREASE:
      case EFFECT_TYPE_SPELL_RESISTANCE_DECREASE:
      case EFFECT_TYPE_STUNNED:
      case EFFECT_TYPE_TURN_RESISTANCE_DECREASE:
      case EFFECT_TYPE_ABILITY_DECREASE:
      case EFFECT_TYPE_AC_DECREASE:
      case EFFECT_TYPE_ATTACK_DECREASE: { return TRUE; break; }
      default: break;
    }
    eE=GetNextEffect(oTarget);
  } // check each effect
  return FALSE;
} // caiGetHasNegativeEffects();

int fnIsPetrified(object oTarget)
{ // PURPOSE: return if the target is petrified
  effect eE=GetFirstEffect(oTarget);
  int nET;
  while(GetIsEffectValid(eE))
  { // check each effect
    nET=GetEffectType(eE);
    switch(nET)
    {
      case EFFECT_TYPE_PETRIFY: { return TRUE; break; }
      default: break;
    }
    eE=GetNextEffect(oTarget);
  } // check each effect
  return FALSE;
} // fnIsPetrified()

int caiGetAvailableHealPC(object oNPC,object oTarget)
{ // PURPOSE: return a useful to spell to help with target PC
  int nDMG=GetMaxHitPoints(oTarget)-GetCurrentHitPoints(oTarget);
  int bHasNegativeEffects=caiGetHasNegativeEffects(oTarget);
  if ((GetHasSpellEffect(SPELL_FLESH_TO_STONE,oTarget)||fnIsPetrified(oTarget))&&GetHasSpell(SPELL_STONE_TO_FLESH,oNPC)>0) return SPELL_STONE_TO_FLESH;
  else if (GetIsDead(oTarget)&&GetHasSpell(SPELL_RESURRECTION,oNPC)>0) return SPELL_RESURRECTION;
  else if (GetIsDead(oTarget)&&GetHasSpell(SPELL_RAISE_DEAD,oNPC)>0) return SPELL_RAISE_DEAD;
  else if (GetHasSpellEffect(SPELL_BESTOW_CURSE,oTarget)&&GetHasSpell(SPELL_REMOVE_CURSE,oNPC)>0) return SPELL_REMOVE_CURSE;
  else if (GetHasSpellEffect(SPELL_CONTAGION,oTarget)&&GetHasSpell(SPELL_REMOVE_DISEASE,oNPC)>0) return SPELL_REMOVE_DISEASE;
  else if ((GetHasSpellEffect(SPELL_BLINDNESS_AND_DEAFNESS,oTarget)||GetHasSpellEffect(SPELL_MASS_BLINDNESS_AND_DEAFNESS,oTarget))&&GetHasSpell(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS,oNPC)>0) return SPELL_REMOVE_BLINDNESS_AND_DEAFNESS;
  else if (GetHasSpellEffect(SPELL_FEAR,oTarget)&&GetHasSpell(SPELL_REMOVE_FEAR,oNPC)>0) return SPELL_REMOVE_FEAR;
  else if (GetHasSpellEffect(SPELL_HOLD_PERSON,oTarget)&&GetHasSpell(SPELL_REMOVE_PARALYSIS,oNPC)>0) return SPELL_REMOVE_PARALYSIS;
  else if (bHasNegativeEffects&&GetHasSpell(SPELL_GREATER_RESTORATION,oNPC)>0) return SPELL_GREATER_RESTORATION;
  else if (bHasNegativeEffects&&GetHasSpell(SPELL_RESTORATION,oNPC)>0) return SPELL_RESTORATION;
  else if (bHasNegativeEffects&&GetHasSpell(SPELL_LESSER_RESTORATION,oNPC)>0) return SPELL_LESSER_RESTORATION;
  else if (nDMG>0) return caiGetAvailableHeal(oNPC,nDMG);
  return 0;
} // caiGetAvailableHealPC()

int caiGetAvailableHeal(object oNPC,int nDamageAmount,int bMUSTHEAL=FALSE)
{ // PURPOSE: Determine best healing spell available for given damage
  int nRet=0;
  if (nDamageAmount<4)
  { // minor
    if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
    if (bMUSTHEAL)
    { // need a heal spell
      if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
      else if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
      else if (GetHasSpell(SPELL_HEALING_CIRCLE,oNPC)>0) return SPELL_HEALING_CIRCLE;
      else if (GetHasSpell(SPELL_MASS_HEAL,oNPC)>0) return SPELL_MASS_HEAL;
      else if (GetHasSpell(SPELL_REGENERATE,oNPC)>0) return SPELL_REGENERATE;
    } // need a heal spell
  } // minor
  else if (nDamageAmount<9)
  { // light
    if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
    if (bMUSTHEAL)
    { // need a heal spell
      if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
      else if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
      else if (GetHasSpell(SPELL_HEALING_CIRCLE,oNPC)>0) return SPELL_HEALING_CIRCLE;
      else if (GetHasSpell(SPELL_MASS_HEAL,oNPC)>0) return SPELL_MASS_HEAL;
      else if (GetHasSpell(SPELL_REGENERATE,oNPC)>0) return SPELL_REGENERATE;
    } // need a heal spell
  } // light
  else if (nDamageAmount<16)
  { // moderate
    if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
    if (bMUSTHEAL)
    { // need a heal spell
      if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
      else if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
      else if (GetHasSpell(SPELL_HEALING_CIRCLE,oNPC)>0) return SPELL_HEALING_CIRCLE;
      else if (GetHasSpell(SPELL_MASS_HEAL,oNPC)>0) return SPELL_MASS_HEAL;
      else if (GetHasSpell(SPELL_REGENERATE,oNPC)>0) return SPELL_REGENERATE;
    } // need a heal spell
  } // moderate
  else if (nDamageAmount<31)
  { // serious
    if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
    if (bMUSTHEAL)
    { // need a heal spell
      if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
      else if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
      else if (GetHasSpell(SPELL_HEALING_CIRCLE,oNPC)>0) return SPELL_HEALING_CIRCLE;
      else if (GetHasSpell(SPELL_MASS_HEAL,oNPC)>0) return SPELL_MASS_HEAL;
      else if (GetHasSpell(SPELL_REGENERATE,oNPC)>0) return SPELL_REGENERATE;
    } // need a heal spell
  } // serious
  else if (nDamageAmount<51)
  { // critical
    if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
    if (bMUSTHEAL)
    { // need a heal spell
      if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
      else if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
      else if (GetHasSpell(SPELL_HEALING_CIRCLE,oNPC)>0) return SPELL_HEALING_CIRCLE;
      else if (GetHasSpell(SPELL_MASS_HEAL,oNPC)>0) return SPELL_MASS_HEAL;
      else if (GetHasSpell(SPELL_REGENERATE,oNPC)>0) return SPELL_REGENERATE;
    } // need a heal spell
  } // critical
  else
  { // heal
    if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
    else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
    else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
    if (bMUSTHEAL)
    { // need a heal spell
      if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
      else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
      else if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
      else if (GetHasSpell(SPELL_HEALING_CIRCLE,oNPC)>0) return SPELL_HEALING_CIRCLE;
      else if (GetHasSpell(SPELL_MASS_HEAL,oNPC)>0) return SPELL_MASS_HEAL;
      else if (GetHasSpell(SPELL_REGENERATE,oNPC)>0) return SPELL_REGENERATE;
    } // need a heal spell
  } // heal
  return nRet;
} // caiGetAvailableHeal()

int caiGetAvailableBuff(object oNPC,object oTarget)
{ // PURPOSE: Look for buff spells
  int nRet=0;
  float fCR=GetChallengeRating(oTarget);
  if (GetIsPC(oTarget)) fCR=IntToFloat(GetLevelByPosition(1,oTarget)+GetLevelByPosition(2,oTarget)+GetLevelByPosition(3,oTarget));
  if (fCR<2.0)
  { // lesser buffs
    if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
    { // undead target
      if (GetHasSpell(SPELL_STONE_BONES,oNPC)>0&&GetHasSpellEffect(SPELL_STONE_BONES,oTarget)==FALSE) return SPELL_STONE_BONES;
      else if (GetHasSpell(SPELL_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_RESISTANCE;
      else if (GetHasSpell(SPELL_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_BULLS_STRENGTH;
    } // undead target
    else
    { // not undead
      if (GetHasSpell(SPELL_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_RESISTANCE;
      else if (GetHasSpell(SPELL_BARKSKIN,oNPC)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oTarget)==FALSE) return SPELL_BARKSKIN;
      else if (GetHasSpell(SPELL_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_BULLS_STRENGTH;
      else if (GetHasSpell(SPELL_ENDURANCE,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURANCE,oTarget)==FALSE) return SPELL_ENDURANCE;
      else if (GetHasSpell(SPELL_BLESS,oNPC)>0&&GetHasSpellEffect(SPELL_BLESS,oTarget)==FALSE) return SPELL_BLESS;
      else if (GetHasSpell(SPELL_AID,oNPC)>0&&GetHasSpellEffect(SPELL_AID,oTarget)==FALSE) return SPELL_AID;
    } // not undead
  } // lesser buffs
  else if (fCR<10.0)
  { // medium buffs
    if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
    { // undead target
      if (GetHasSpell(SPELL_STONE_BONES,oNPC)>0&&GetHasSpellEffect(SPELL_STONE_BONES,oTarget)==FALSE) return SPELL_STONE_BONES;
      else if (GetHasSpell(SPELL_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_RESISTANCE;
      else if (GetHasSpell(SPELL_BARKSKIN,oNPC)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oTarget)==FALSE) return SPELL_BARKSKIN;
      else if (GetHasSpell(SPELL_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_BULLS_STRENGTH;
      else if (GetHasSpell(SPELL_ENDURANCE,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURANCE,oTarget)==FALSE) return SPELL_ENDURANCE;
      else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oTarget)==FALSE) return SPELL_ENDURE_ELEMENTS;
      else if (GetHasSpell(SPELL_FLAME_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_FLAME_WEAPON,oTarget)==FALSE) return SPELL_FLAME_WEAPON;
      else if (GetHasSpell(SPELL_HASTE,oNPC)>0&&GetHasSpellEffect(SPELL_HASTE,oTarget)==FALSE) return SPELL_HASTE;
      else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oTarget)==FALSE) return SPELL_MAGIC_VESTMENT;
      else if (GetHasSpell(SPELL_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_STONESKIN,oTarget)==FALSE) return SPELL_STONESKIN;
      else if (GetHasSpell(SPELL_UNHOLY_AURA,oNPC)>0&&GetHasSpellEffect(SPELL_UNHOLY_AURA,oTarget)==FALSE) return SPELL_UNHOLY_AURA;
    } // undead target
    else
    { // not undead
      if (GetHasSpell(SPELL_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_RESISTANCE;
      else if (GetHasSpell(SPELL_BARKSKIN,oNPC)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oTarget)==FALSE) return SPELL_BARKSKIN;
      else if (GetHasSpell(SPELL_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_BULLS_STRENGTH;
      else if (GetHasSpell(SPELL_ENDURANCE,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURANCE,oTarget)==FALSE) return SPELL_ENDURANCE;
      else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oTarget)==FALSE) return SPELL_ENDURE_ELEMENTS;
      else if (GetHasSpell(SPELL_FLAME_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_FLAME_WEAPON,oTarget)==FALSE) return SPELL_FLAME_WEAPON;
      else if (GetHasSpell(SPELL_HASTE,oNPC)>0&&GetHasSpellEffect(SPELL_HASTE,oTarget)==FALSE) return SPELL_HASTE;
      else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oTarget)==FALSE) return SPELL_MAGIC_VESTMENT;
      else if (GetHasSpell(SPELL_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_STONESKIN,oTarget)==FALSE) return SPELL_STONESKIN;
      else if (GetHasSpell(SPELL_UNHOLY_AURA,oNPC)>0&&GetHasSpellEffect(SPELL_UNHOLY_AURA,oTarget)==FALSE) return SPELL_UNHOLY_AURA;
      else if (GetHasSpell(SPELL_GREATER_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oTarget)==FALSE) return SPELL_GREATER_STONESKIN;
      else if (GetHasSpell(SPELL_GREATER_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_GREATER_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_GREATER_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_GREATER_BULLS_STRENGTH;
      else if (GetHasSpell(SPELL_FOXS_CUNNING,oNPC)>0&&GetHasSpellEffect(SPELL_FOXS_CUNNING,oTarget)==FALSE) return SPELL_FOXS_CUNNING;
      else if (GetHasSpell(SPELL_EAGLE_SPLEDOR,oNPC)>0&&GetHasSpellEffect(SPELL_EAGLE_SPLEDOR,oTarget)==FALSE) return SPELL_EAGLE_SPLEDOR;
      else if (GetHasSpell(SPELL_BLESS,oNPC)>0&&GetHasSpellEffect(SPELL_BLESS,oTarget)==FALSE) return SPELL_BLESS;
      else if (GetHasSpell(SPELL_BLESS_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_BLESS_WEAPON,oTarget)==FALSE) return SPELL_BLESS_WEAPON;
      else if (GetHasSpell(SPELL_AID,oNPC)>0&&GetHasSpellEffect(SPELL_AID,oTarget)==FALSE) return SPELL_AID;
      else if (GetHasSpell(SPELL_SEE_INVISIBILITY,oNPC)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oTarget)==FALSE) return SPELL_SEE_INVISIBILITY;
    } // not undead
  } // medium buffs
  else
  { // big buffs
    if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
    { // undead target
      if (GetHasSpell(SPELL_STONE_BONES,oNPC)>0&&GetHasSpellEffect(SPELL_STONE_BONES,oTarget)==FALSE) return SPELL_STONE_BONES;
      else if (GetHasSpell(SPELL_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_RESISTANCE;
      else if (GetHasSpell(SPELL_BARKSKIN,oNPC)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oTarget)==FALSE) return SPELL_BARKSKIN;
      else if (GetHasSpell(SPELL_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_BULLS_STRENGTH;
      else if (GetHasSpell(SPELL_ENDURANCE,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURANCE,oTarget)==FALSE) return SPELL_ENDURANCE;
      else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oTarget)==FALSE) return SPELL_ENDURE_ELEMENTS;
      else if (GetHasSpell(SPELL_FLAME_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_FLAME_WEAPON,oTarget)==FALSE) return SPELL_FLAME_WEAPON;
      else if (GetHasSpell(SPELL_HASTE,oNPC)>0&&GetHasSpellEffect(SPELL_HASTE,oTarget)==FALSE) return SPELL_HASTE;
      else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oTarget)==FALSE) return SPELL_MAGIC_VESTMENT;
      else if (GetHasSpell(SPELL_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_STONESKIN,oTarget)==FALSE) return SPELL_STONESKIN;
      else if (GetHasSpell(SPELL_UNHOLY_AURA,oNPC)>0&&GetHasSpellEffect(SPELL_UNHOLY_AURA,oTarget)==FALSE) return SPELL_UNHOLY_AURA;
      else if (GetHasSpell(SPELL_GREATER_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oTarget)==FALSE) return SPELL_GREATER_STONESKIN;
      else if (GetHasSpell(SPELL_GREATER_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_GREATER_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_GREATER_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_GREATER_BULLS_STRENGTH;
    } // undead target
    else
    { // not undead
      if (GetHasSpell(SPELL_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_RESISTANCE;
      else if (GetHasSpell(SPELL_BARKSKIN,oNPC)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oTarget)==FALSE) return SPELL_BARKSKIN;
      else if (GetHasSpell(SPELL_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_BULLS_STRENGTH;
      else if (GetHasSpell(SPELL_ENDURANCE,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURANCE,oTarget)==FALSE) return SPELL_ENDURANCE;
      else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oTarget)==FALSE) return SPELL_ENDURE_ELEMENTS;
      else if (GetHasSpell(SPELL_FLAME_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_FLAME_WEAPON,oTarget)==FALSE) return SPELL_FLAME_WEAPON;
      else if (GetHasSpell(SPELL_HASTE,oNPC)>0&&GetHasSpellEffect(SPELL_HASTE,oTarget)==FALSE) return SPELL_HASTE;
      else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oTarget)==FALSE) return SPELL_MAGIC_VESTMENT;
      else if (GetHasSpell(SPELL_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_STONESKIN,oTarget)==FALSE) return SPELL_STONESKIN;
      else if (GetHasSpell(SPELL_UNHOLY_AURA,oNPC)>0&&GetHasSpellEffect(SPELL_UNHOLY_AURA,oTarget)==FALSE) return SPELL_UNHOLY_AURA;
      else if (GetHasSpell(SPELL_GREATER_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oTarget)==FALSE) return SPELL_GREATER_STONESKIN;
      else if (GetHasSpell(SPELL_GREATER_MAGIC_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_MAGIC_WEAPON,oTarget)==FALSE) return SPELL_GREATER_MAGIC_WEAPON;
      else if (GetHasSpell(SPELL_GREATER_BULLS_STRENGTH,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_BULLS_STRENGTH,oTarget)==FALSE) return SPELL_GREATER_BULLS_STRENGTH;
      else if (GetHasSpell(SPELL_FOXS_CUNNING,oNPC)>0&&GetHasSpellEffect(SPELL_FOXS_CUNNING,oTarget)==FALSE) return SPELL_FOXS_CUNNING;
      else if (GetHasSpell(SPELL_EAGLE_SPLEDOR,oNPC)>0&&GetHasSpellEffect(SPELL_EAGLE_SPLEDOR,oTarget)==FALSE) return SPELL_EAGLE_SPLEDOR;
      else if (GetHasSpell(SPELL_BLESS,oNPC)>0&&GetHasSpellEffect(SPELL_BLESS,oTarget)==FALSE) return SPELL_BLESS;
      else if (GetHasSpell(SPELL_BLESS_WEAPON,oNPC)>0&&GetHasSpellEffect(SPELL_BLESS_WEAPON,oTarget)==FALSE) return SPELL_BLESS_WEAPON;
      else if (GetHasSpell(SPELL_AID,oNPC)>0&&GetHasSpellEffect(SPELL_AID,oTarget)==FALSE) return SPELL_AID;
      else if (GetHasSpell(SPELL_SEE_INVISIBILITY,oNPC)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oTarget)==FALSE) return SPELL_SEE_INVISIBILITY;
      else if (GetHasSpell(SPELL_MASS_HASTE,oNPC)>0&&GetHasSpellEffect(SPELL_MASS_HASTE,oTarget)==FALSE) return SPELL_MASS_HASTE;
      else if (GetHasSpell(SPELL_OWLS_WISDOM,oNPC)>0&&GetHasSpellEffect(SPELL_OWLS_WISDOM,oTarget)==FALSE) return SPELL_OWLS_WISDOM;
      else if (GetHasSpell(SPELL_SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_SPELL_RESISTANCE;
    } // not undead
  } // big buffs
  return nRet;
} // caiGetAvailableBuff()

int fnGetCharmType(object oTarget)
{ // PURPOSE: find out what type of charm target this is
  int nRT=GetRacialType(oTarget);
  switch(nRT)
  {
    case RACIAL_TYPE_ANIMAL: { return CAI_CHARM_ANIMAL; break; }
    case RACIAL_TYPE_DWARF:
    case RACIAL_TYPE_ELF:
    case RACIAL_TYPE_GNOME:
    case RACIAL_TYPE_HALFELF:
    case RACIAL_TYPE_HALFLING:
    case RACIAL_TYPE_HALFORC:
    case RACIAL_TYPE_HUMAN: { return CAI_CHARM_PERSON; break; }
    case RACIAL_TYPE_BEAST:
    case RACIAL_TYPE_DRAGON:
    case RACIAL_TYPE_FEY:
    case RACIAL_TYPE_GIANT:
    case RACIAL_TYPE_HUMANOID_GOBLINOID:
    case RACIAL_TYPE_HUMANOID_MONSTROUS:
    case RACIAL_TYPE_HUMANOID_ORC:
    case RACIAL_TYPE_HUMANOID_REPTILIAN:
    case RACIAL_TYPE_MAGICAL_BEAST:
    case RACIAL_TYPE_VERMIN: { return CAI_CHARM_MONSTER; break; }
    default: break;
  }
  return CAI_CHARM_NONE;
} // fnGetCharmType()

int fnGetHasSpellDefense(object oTarget)
{ // PURPOSE: Returns TRUE if the target has spells on them
  effect eE=GetFirstEffect(oTarget);
  int nSID;
  object oC;
  while(GetIsEffectValid(eE))
  { // check effects
    nSID=GetEffectSpellId(eE);
    if (nSID!=-1)
    { // spell found
      oC=GetEffectCreator(eE);
      if (oC==oTarget||GetIsFriend(oC)) return TRUE;
    } // spell found
    eE=GetNextEffect(oTarget);
  } // check effects
  return FALSE;
} // fnGetHasSpellDefense()

int caiGetAvailableCombatSpell(object oNPC,object oTarget)
{ // PURPOSE RETURN: Combat spell
  int nRT=GetRacialType(oTarget);
  float fCR=GetChallengeRating(oTarget);
  int bGroup=FALSE;
  int bAlliesNear=FALSE;
  int nCT=fnGetCharmType(oTarget);
  object oMe=oNPC;
  object oOb=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oTarget,1,CREATURE_TYPE_IS_ALIVE,TRUE);
  int bSC=GetLocalInt(oNPC,"bCAISPELLCASTERS");
  float fD=GetDistanceBetween(oNPC,oTarget);
  if (GetIsObjectValid(oOb))
  { // check to see if friends too close for area effect
    if(GetDistanceBetween(oTarget,oOb)<10.0) bAlliesNear=TRUE;
  } // check to see if friends too close for area effect
  oOb=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_FRIEND,oTarget,1,CREATURE_TYPE_IS_ALIVE,TRUE);
  if (GetIsObjectValid(oOb))
  { // check to see if the enemy is in a group
    if (GetDistanceBetween(oTarget,oOb)<6.1) bGroup=TRUE;
  } // check to see if the enemy is in a group
  if (GetIsPC(oTarget))
  { // PC
    if (GetLocalInt(oTarget,"nIsVampire")==TRUE) nRT=RACIAL_TYPE_UNDEAD;
    fCR=IntToFloat(GetLevelByPosition(1,oTarget)+GetLevelByPosition(2,oTarget)+GetLevelByPosition(3,oTarget));
  } // PC
  if (GetDistanceBetween(oNPC,oTarget)<10.0) bAlliesNear=TRUE;
  if (fnGetHasSpellDefense(oTarget)&&d100()<26)
  { // dispelling magic
    if (GetHasSpell(SPELL_MORDENKAINENS_DISJUNCTION,oNPC)>0&&d4()<3) return SPELL_MORDENKAINENS_DISJUNCTION;
    else if (GetHasSpell(SPELL_GREATER_SPELL_BREACH,oNPC)>0&&d4()<3) return SPELL_GREATER_SPELL_BREACH;
    else if (GetHasSpell(SPELL_GREATER_DISPELLING,oNPC)>0) return SPELL_GREATER_DISPELLING;
    else if (GetHasSpell(SPELL_LESSER_SPELL_BREACH,oNPC)>0) return SPELL_LESSER_SPELL_BREACH;
    else if (GetHasSpell(SPELL_DISPEL_MAGIC,oNPC)>0) return SPELL_DISPEL_MAGIC;
    else if (GetHasSpell(SPELL_INVISIBILITY_PURGE,oNPC)>0&&d4()<3) return SPELL_INVISIBILITY_PURGE;
    else if (GetHasSpell(SPELL_LESSER_DISPEL,oNPC)>0) return SPELL_LESSER_DISPEL;
  } // dispelling magic
  if (nRT==RACIAL_TYPE_UNDEAD)
  { // undead enemies
    if (bGroup==TRUE&&!bAlliesNear)
    { // okay to do area attack
      if (fCR<6.1)
      { // low
        if (GetHasSpell(SPELL_SPIKE_GROWTH,oNPC)>0) return SPELL_SPIKE_GROWTH;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_GREASE,oNPC)>0) return SPELL_GREASE;
        else if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_HEALING_CIRCLE,oNPC)>0) return SPELL_HEALING_CIRCLE;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0) return SPELL_SHADOW_CONJURATION_DARKNESS;
      } // low
      else
      { // high
        if (GetHasSpell(SPELL_EPIC_HELLBALL,oNPC)>0&&fD>9.9) return SPELL_EPIC_HELLBALL;
        else if (GetHasSpell(SPELL_MASS_HEAL,oNPC)>0) return SPELL_MASS_HEAL;
        else if (GetHasSpell(SPELL_EPIC_RUIN,oNPC)>0&&fD>9.9) return SPELL_EPIC_RUIN;
        else if (GetHasSpell(SPELL_METEOR_SWARM,oNPC)>0&&fD>9.9) return SPELL_METEOR_SWARM;
        else if (GetHasSpell(SPELL_PRISMATIC_SPRAY,oNPC)>0) return SPELL_PRISMATIC_SPRAY;
        else if (GetHasSpell(SPELL_WAIL_OF_THE_BANSHEE,oNPC)>0) return SPELL_WAIL_OF_THE_BANSHEE;
        else if (GetHasSpell(SPELL_SUNBURST,oNPC)>0) return SPELL_SUNBURST;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_STORM_OF_VENGEANCE,oNPC)>0) return SPELL_STORM_OF_VENGEANCE;
        else if (GetHasSpell(SPELL_POWER_WORD_KILL,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH,oMe)==FALSE) return SPELL_POWER_WORD_KILL;
        else if (GetHasSpell(SPELL_MASS_BLINDNESS_AND_DEAFNESS,oNPC)>0) return SPELL_MASS_BLINDNESS_AND_DEAFNESS;
        else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_INCENDIARY_CLOUD,oNPC)>0&&fD>9.9) return SPELL_INCENDIARY_CLOUD;
        else if (GetHasSpell(SPELL_INFERNO,oNPC)>0) return SPELL_INFERNO;
        else if (GetHasSpell(SPELL_IMPLOSION,oNPC)>0&&fD>9.9) return SPELL_IMPLOSION;
        else if (GetHasSpell(SPELL_ICE_STORM,oNPC)>0&&fD>9.9) return SPELL_ICE_STORM;
        else if (GetHasSpell(SPELL_GREAT_THUNDERCLAP,oNPC)>0) return SPELL_GREAT_THUNDERCLAP;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FIRE_STORM,oNPC)>0&&fD>9.9) return SPELL_FIRE_STORM;
        else if (GetHasSpell(SPELL_EARTHQUAKE,oNPC)>0) return SPELL_EARTHQUAKE;
        else if (GetHasSpell(SPELL_DELAYED_BLAST_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_DELAYED_BLAST_FIREBALL;
        else if (GetHasSpell(SPELL_DESTRUCTION,oNPC)>0) return SPELL_DESTRUCTION;
        else if (GetHasSpell(SPELL_CREEPING_DOOM,oNPC)>0) return SPELL_CREEPING_DOOM;
        else if (GetHasSpell(SPELL_CRUMBLE,oNPC)>0) return SPELL_CRUMBLE;
        else if (GetHasSpell(SPELL_WORD_OF_FAITH,oNPC)>0) return SPELL_WORD_OF_FAITH;
        else if (GetHasSpell(SPELL_CLOUDKILL,oNPC)>0&&fD>9.9) return SPELL_CLOUDKILL;
        else if (GetHasSpell(SPELL_CONE_OF_COLD,oNPC)>0) return SPELL_CONE_OF_COLD;
        else if (GetHasSpell(SPELL_CHAIN_LIGHTNING,oNPC)>0) return SPELL_CHAIN_LIGHTNING;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_BLADE_BARRIER,oNPC)>0) return SPELL_BLADE_BARRIER;
        else if (GetHasSpell(SPELL_BALL_LIGHTNING,oNPC)>0) return SPELL_BALL_LIGHTNING;
        else if (GetHasSpell(SPELL_DIRGE,oNPC)>0) return SPELL_DIRGE;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_EVARDS_BLACK_TENTACLES,oNPC)>0) return SPELL_EVARDS_BLACK_TENTACLES;
        else if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_FLYING_DEBRIS,oNPC)>0) return SPELL_FLYING_DEBRIS;
        else if (GetHasSpell(SPELL_GREASE,oNPC)>0) return SPELL_GREASE;
        else if (GetHasSpell(SPELL_HAMMER_OF_THE_GODS,oNPC)>0) return SPELL_HAMMER_OF_THE_GODS;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SPIKE_GROWTH,oNPC)>0) return SPELL_SPIKE_GROWTH;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0&&fD>9.9) return SPELL_SHADOW_CONJURATION_DARKNESS;
      } // high
    } // okay to do area attack
    if (bGroup==FALSE&&!bAlliesNear)
    { // use non-area unless needed
      if (fCR<6.1)
      { // low
        if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_SEARING_LIGHT,oNPC)>0) return SPELL_SEARING_LIGHT;
        else if (GetHasSpell(SPELL_MAGIC_MISSILE,oNPC)>0) return SPELL_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_BOMBARDMENT,oNPC)>0) return SPELL_BOMBARDMENT;
        else if (GetHasSpell(SPELL_DOOM,oNPC)>0&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
        else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
        else if (GetHasSpell(SPELL_CONTROL_UNDEAD,oNPC)>0&&GetHasSpellEffect(SPELL_CONTROL_UNDEAD,oTarget)==FALSE) return SPELL_CONTROL_UNDEAD;
        else if (GetHasSpell(SPELL_BURNING_HANDS,oNPC)>0) return SPELL_BURNING_HANDS;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT,oNPC)>0&&GetHasSpellEffect(SPELL_RAY_OF_ENFEEBLEMENT,oTarget)==FALSE) return SPELL_RAY_OF_ENFEEBLEMENT;
        else if (GetHasSpell(SPELL_DAZE,oNPC)>0&&d4()<3) return SPELL_DAZE;
        else if (GetHasSpell(SPELL_FLAME_LASH,oNPC)>0) return SPELL_FLAME_LASH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_ICE_DAGGER,oNPC)>0) return SPELL_ICE_DAGGER;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oNPC)>0) return SPELL_MELFS_ACID_ARROW;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_RAY_OF_FROST,oNPC)>0&&d4()<4) return SPELL_RAY_OF_FROST;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SLOW,oNPC)>0&&d4()<3) return SPELL_SLOW;
        else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oNPC)>0) return SPELL_WOUNDING_WHISPERS;
        else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oNPC)>0) return SPELL_ELECTRIC_JOLT;
        else if (GetHasSpell(SPELL_FLAME_ARROW,oNPC)>0) return SPELL_FLAME_ARROW;
        else if (GetHasSpell(SPELL_COLOR_SPRAY,oNPC)>0) return SPELL_COLOR_SPRAY;
        else if (GetHasSpell(SPELL_ACID_SPLASH,oNPC)>0) return SPELL_ACID_SPLASH;
        else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;

        if (GetHasSpell(SPELL_SPIKE_GROWTH,oNPC)>0) return SPELL_SPIKE_GROWTH;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_GREASE,oNPC)>0) return SPELL_GREASE;
        else if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_HEALING_CIRCLE,oNPC)>0) return SPELL_HEALING_CIRCLE;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0) return SPELL_SHADOW_CONJURATION_DARKNESS;
      } // low
      else
      { // high
        if (GetHasSpell(SPELL_UNDEATH_TO_DEATH,oNPC)>0&&GetIsPC(oTarget)==FALSE) return SPELL_UNDEATH_TO_DEATH;
        else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_FIREBRAND,oNPC)>0) return SPELL_FIREBRAND;
        else if (GetHasSpell(SPELL_DOMINATE_PERSON,oNPC)>0&&GetIsPC(oTarget)&&GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget)==FALSE) return SPELL_DOMINATE_PERSON;
        else if (GetHasSpell(SPELL_CONFUSION,oNPC)>0&&GetHasSpellEffect(SPELL_CONFUSION,oTarget)==FALSE&&GetIsPC(oTarget)==TRUE) return SPELL_CONFUSION;
        else if (GetHasSpell(SPELL_HOLD_PERSON,oNPC)>0&&GetIsPC(oTarget)&&GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget)==FALSE) return SPELL_HOLD_PERSON;
        else if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
        else if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_MAGIC_MISSILE,oNPC)>0) return SPELL_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_BOMBARDMENT,oNPC)>0) return SPELL_BOMBARDMENT;
        else if (GetHasSpell(SPELL_BURNING_HANDS,oNPC)>0) return SPELL_BURNING_HANDS;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT,oNPC)>0&&GetHasSpellEffect(SPELL_RAY_OF_ENFEEBLEMENT,oTarget)==FALSE) return SPELL_RAY_OF_ENFEEBLEMENT;
        else if (GetHasSpell(SPELL_DOOM,oNPC)>0&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
        else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
        else if (GetHasSpell(SPELL_FLAME_LASH,oNPC)>0) return SPELL_FLAME_LASH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FLESH_TO_STONE,oNPC)>0) return SPELL_FLESH_TO_STONE;
        else if (GetHasSpell(SPELL_ICE_DAGGER,oNPC)>0) return SPELL_ICE_DAGGER;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oNPC)>0) return SPELL_MELFS_ACID_ARROW;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_RAY_OF_FROST,oNPC)>0&&d4()<4) return SPELL_RAY_OF_FROST;
        else if (GetHasSpell(SPELL_SEARING_LIGHT,oNPC)>0) return SPELL_SEARING_LIGHT;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SLOW,oNPC)>0&&d4()<3) return SPELL_SLOW;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oNPC)>0) return SPELL_WOUNDING_WHISPERS;
        else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oNPC)>0) return SPELL_ELECTRIC_JOLT;
        else if (GetHasSpell(SPELL_FLAME_ARROW,oNPC)>0) return SPELL_FLAME_ARROW;
        else if (GetHasSpell(SPELL_COLOR_SPRAY,oNPC)>0) return SPELL_COLOR_SPRAY;
        else if (GetHasSpell(SPELL_ACID_SPLASH,oNPC)>0) return SPELL_ACID_SPLASH;
        else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;

        if (GetHasSpell(SPELL_EPIC_HELLBALL,oNPC)>0&&fD>9.9) return SPELL_EPIC_HELLBALL;
        else if (GetHasSpell(SPELL_MASS_HEAL,oNPC)>0) return SPELL_MASS_HEAL;
        else if (GetHasSpell(SPELL_EPIC_RUIN,oNPC)>0&&fD>9.9) return SPELL_EPIC_RUIN;
        else if (GetHasSpell(SPELL_METEOR_SWARM,oNPC)>0&&fD>9.9) return SPELL_METEOR_SWARM;
        else if (GetHasSpell(SPELL_PRISMATIC_SPRAY,oNPC)>0) return SPELL_PRISMATIC_SPRAY;
        else if (GetHasSpell(SPELL_WAIL_OF_THE_BANSHEE,oNPC)>0) return SPELL_WAIL_OF_THE_BANSHEE;
        else if (GetHasSpell(SPELL_SUNBURST,oNPC)>0) return SPELL_SUNBURST;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_STORM_OF_VENGEANCE,oNPC)>0) return SPELL_STORM_OF_VENGEANCE;
        else if (GetHasSpell(SPELL_POWER_WORD_KILL,oNPC)>0) return SPELL_POWER_WORD_KILL;
        else if (GetHasSpell(SPELL_MASS_BLINDNESS_AND_DEAFNESS,oNPC)>0) return SPELL_MASS_BLINDNESS_AND_DEAFNESS;
        else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_INCENDIARY_CLOUD,oNPC)>0&&fD>9.9) return SPELL_INCENDIARY_CLOUD;
        else if (GetHasSpell(SPELL_INFERNO,oNPC)>0) return SPELL_INFERNO;
        else if (GetHasSpell(SPELL_IMPLOSION,oNPC)>0&&fD>9.9) return SPELL_IMPLOSION;
        else if (GetHasSpell(SPELL_ICE_STORM,oNPC)>0) return SPELL_ICE_STORM;
        else if (GetHasSpell(SPELL_GREAT_THUNDERCLAP,oNPC)>0) return SPELL_GREAT_THUNDERCLAP;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FIRE_STORM,oNPC)>0&&fD>9.9) return SPELL_FIRE_STORM;
        else if (GetHasSpell(SPELL_EARTHQUAKE,oNPC)>0) return SPELL_EARTHQUAKE;
        else if (GetHasSpell(SPELL_DELAYED_BLAST_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_DELAYED_BLAST_FIREBALL;
        else if (GetHasSpell(SPELL_DESTRUCTION,oNPC)>0) return SPELL_DESTRUCTION;
        else if (GetHasSpell(SPELL_CREEPING_DOOM,oNPC)>0) return SPELL_CREEPING_DOOM;
        else if (GetHasSpell(SPELL_CRUMBLE,oNPC)>0) return SPELL_CRUMBLE;
        else if (GetHasSpell(SPELL_CLOUDKILL,oNPC)>0) return SPELL_CLOUDKILL;
        else if (GetHasSpell(SPELL_CONE_OF_COLD,oNPC)>0) return SPELL_CONE_OF_COLD;
        else if (GetHasSpell(SPELL_WORD_OF_FAITH,oNPC)>0) return SPELL_WORD_OF_FAITH;
        else if (GetHasSpell(SPELL_CHAIN_LIGHTNING,oNPC)>0) return SPELL_CHAIN_LIGHTNING;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_BLADE_BARRIER,oNPC)>0) return SPELL_BLADE_BARRIER;
        else if (GetHasSpell(SPELL_BALL_LIGHTNING,oNPC)>0) return SPELL_BALL_LIGHTNING;
        else if (GetHasSpell(SPELL_DIRGE,oNPC)>0) return SPELL_DIRGE;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_EVARDS_BLACK_TENTACLES,oNPC)>0) return SPELL_EVARDS_BLACK_TENTACLES;
        else if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_FLYING_DEBRIS,oNPC)>0) return SPELL_FLYING_DEBRIS;
        else if (GetHasSpell(SPELL_GREASE,oNPC)>0) return SPELL_GREASE;
        else if (GetHasSpell(SPELL_HAMMER_OF_THE_GODS,oNPC)>0) return SPELL_HAMMER_OF_THE_GODS;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SPIKE_GROWTH,oNPC)>0) return SPELL_SPIKE_GROWTH;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0) return SPELL_SHADOW_CONJURATION_DARKNESS;
      } // high
    } // use non-area unless needed
      if (fCR<6.1)
      { // low
        if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_SEARING_LIGHT,oNPC)>0) return SPELL_SEARING_LIGHT;
        else if (GetHasSpell(SPELL_MAGIC_MISSILE,oNPC)>0) return SPELL_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_DOOM,oNPC)>0&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
        else if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT,oNPC)>0&&GetHasSpellEffect(SPELL_RAY_OF_ENFEEBLEMENT,oTarget)==FALSE) return SPELL_RAY_OF_ENFEEBLEMENT;
        else if (GetHasSpell(SPELL_BOMBARDMENT,oNPC)>0) return SPELL_BOMBARDMENT;
        else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
        else if (GetHasSpell(SPELL_CONTROL_UNDEAD,oNPC)>0&&GetHasSpellEffect(SPELL_CONTROL_UNDEAD,oTarget)==FALSE) return SPELL_CONTROL_UNDEAD;
        else if (GetHasSpell(SPELL_BURNING_HANDS,oNPC)>0) return SPELL_BURNING_HANDS;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_DAZE,oNPC)>0&&d4()<3) return SPELL_DAZE;
        else if (GetHasSpell(SPELL_FLAME_LASH,oNPC)>0) return SPELL_FLAME_LASH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_ICE_DAGGER,oNPC)>0) return SPELL_ICE_DAGGER;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oNPC)>0) return SPELL_MELFS_ACID_ARROW;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_RAY_OF_FROST,oNPC)>0&&d4()<4) return SPELL_RAY_OF_FROST;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SLOW,oNPC)>0&&d4()<3) return SPELL_SLOW;
        else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oNPC)>0) return SPELL_WOUNDING_WHISPERS;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGIC_MISSILE,oNPC)>0) return SPELL_SHADOW_CONJURATION_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oNPC)>0) return SPELL_ELECTRIC_JOLT;
        else if (GetHasSpell(SPELL_FLAME_ARROW,oNPC)>0) return SPELL_FLAME_ARROW;
        else if (GetHasSpell(SPELL_COLOR_SPRAY,oNPC)>0) return SPELL_COLOR_SPRAY;
        else if (GetHasSpell(SPELL_ACID_SPLASH,oNPC)>0) return SPELL_ACID_SPLASH;
        else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW;
      } // low
      else
      { // high
        if (GetHasSpell(SPELL_UNDEATH_TO_DEATH,oNPC)>0&&GetIsPC(oTarget)==FALSE) return SPELL_UNDEATH_TO_DEATH;
        else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_FIREBRAND,oNPC)>0) return SPELL_FIREBRAND;
        else if (GetHasSpell(SPELL_BIGBYS_CRUSHING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_CRUSHING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_CRUSHING_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_CLENCHED_FIST,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_CLENCHED_FIST,oTarget)==FALSE) return SPELL_BIGBYS_CLENCHED_FIST;
        else if (GetHasSpell(SPELL_BIGBYS_GRASPING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_GRASPING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_GRASPING_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_FORCEFUL_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_FORCEFUL_HAND,oTarget)==FALSE) return SPELL_BIGBYS_FORCEFUL_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_INTERPOSING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_INTERPOSING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_INTERPOSING_HAND;
        else if (GetHasSpell(SPELL_DOMINATE_PERSON,oNPC)>0&&GetIsPC(oTarget)&&GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget)==FALSE) return SPELL_DOMINATE_PERSON;
        else if (GetHasSpell(SPELL_CONFUSION,oNPC)>0&&GetHasSpellEffect(SPELL_CONFUSION,oTarget)==FALSE&&GetIsPC(oTarget)==TRUE) return SPELL_CONFUSION;
        else if (GetHasSpell(SPELL_HOLD_PERSON,oNPC)>0&&GetIsPC(oTarget)&&GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget)==FALSE) return SPELL_HOLD_PERSON;
        else if (GetHasSpell(SPELL_HEAL,oNPC)>0) return SPELL_HEAL;
        else if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_MAGIC_MISSILE,oNPC)>0) return SPELL_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_DOOM,oNPC)>0&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
        else if (GetHasSpell(SPELL_BOMBARDMENT,oNPC)>0) return SPELL_BOMBARDMENT;
        else if (GetHasSpell(SPELL_BURNING_HANDS,oNPC)>0) return SPELL_BURNING_HANDS;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oNPC)>0) return SPELL_CURE_MODERATE_WOUNDS;
        else if (GetHasSpell(SPELL_FLAME_LASH,oNPC)>0) return SPELL_FLAME_LASH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FLESH_TO_STONE,oNPC)>0) return SPELL_FLESH_TO_STONE;
        else if (GetHasSpell(SPELL_ICE_DAGGER,oNPC)>0) return SPELL_ICE_DAGGER;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oNPC)>0) return SPELL_MELFS_ACID_ARROW;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_RAY_OF_FROST,oNPC)>0&&d4()<4) return SPELL_RAY_OF_FROST;
        else if (GetHasSpell(SPELL_SEARING_LIGHT,oNPC)>0) return SPELL_SEARING_LIGHT;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SLOW,oNPC)>0&&d4()<3) return SPELL_SLOW;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oNPC)>0) return SPELL_WOUNDING_WHISPERS;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGIC_MISSILE,oNPC)>0) return SPELL_SHADOW_CONJURATION_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oNPC)>0) return SPELL_ELECTRIC_JOLT;
        else if (GetHasSpell(SPELL_FLAME_ARROW,oNPC)>0) return SPELL_FLAME_ARROW;
        else if (GetHasSpell(SPELL_COLOR_SPRAY,oNPC)>0) return SPELL_COLOR_SPRAY;
        else if (GetHasSpell(SPELL_ACID_SPLASH,oNPC)>0) return SPELL_ACID_SPLASH;
        else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oNPC)>0) return SPELL_CURE_SERIOUS_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oNPC)>0) return SPELL_CURE_CRITICAL_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oNPC)>0) return SPELL_CURE_LIGHT_WOUNDS;
        else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oNPC)>0) return SPELL_CURE_MINOR_WOUNDS;
      } // high
  } // undead enemies
  else
  { // not undead enemies
    if (bGroup==TRUE&&!bAlliesNear)
    { // okay to do area attack
      if (fCR<2.1)
      { // very low
        if (GetHasSpell(SPELL_SLEEP,oNPC)>0&&nRT!=RACIAL_TYPE_ELF&&nRT!=RACIAL_TYPE_CONSTRUCT&&GetIsImmune(oTarget,IMMUNITY_TYPE_SLEEP,oMe)==FALSE) return SPELL_SLEEP;
        else if (GetHasSpell(SPELL_SCARE,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_FEAR,oMe)==FALSE) return SPELL_SCARE;
        else if (GetHasSpell(SPELL_BANE,oNPC)>0&&GetHasSpellEffect(SPELL_BANE,oTarget)==FALSE) return SPELL_BANE;
        else if (GetHasSpell(SPELL_STINKING_CLOUD,oNPC)>0&&fD>9.9) return SPELL_STINKING_CLOUD;
        else if (GetHasSpell(SPELL_SPIKE_GROWTH,oNPC)>0&&fD>9.9) return SPELL_SPIKE_GROWTH;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_FEAR,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_FEAR,oMe)==FALSE) return SPELL_FEAR;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_CLOUD_OF_BEWILDERMENT,oNPC)>0&&fD>9.9&&GetIsImmune(oTarget,IMMUNITY_TYPE_CONFUSED,oMe)==FALSE) return SPELL_CLOUD_OF_BEWILDERMENT;
        else if (GetHasSpell(SPELL_GREASE,oNPC)>0) return SPELL_GREASE;
        else if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0) return SPELL_SHADOW_CONJURATION_DARKNESS;
      } // very low
      else if (fCR<6.1)
      { // low
        if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_SCINTILLATING_SPHERE,oNPC)>0) return SPELL_SCINTILLATING_SPHERE;
        else if (GetHasSpell(SPELL_HAMMER_OF_THE_GODS,oNPC)>0) return SPELL_HAMMER_OF_THE_GODS;
        else if (GetHasSpell(SPELL_STINKING_CLOUD,oNPC)>0&&fD>9.9) return SPELL_STINKING_CLOUD;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_WEIRD,oNPC)>0) return SPELL_WEIRD;
        else if (GetHasSpell(SPELL_CONE_OF_COLD,oNPC)>0) return SPELL_CONE_OF_COLD;
        else if (GetHasSpell(SPELL_CLOUDKILL,oNPC)>0&&fD>9.9) return SPELL_CLOUDKILL;
        else if (GetHasSpell(SPELL_ACID_FOG,oNPC)>0) return SPELL_ACID_FOG;
        else if (GetHasSpell(SPELL_FEAR,oNPC)>0) return SPELL_FEAR;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_CLOUD_OF_BEWILDERMENT,oNPC)>0&&fD>9.9&&GetIsImmune(oTarget,IMMUNITY_TYPE_CONFUSED,oMe)==FALSE) return SPELL_CLOUD_OF_BEWILDERMENT;
        else if (GetHasSpell(SPELL_CHAIN_LIGHTNING,oNPC)>0) return SPELL_CHAIN_LIGHTNING;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_EVARDS_BLACK_TENTACLES,oNPC)>0) return SPELL_EVARDS_BLACK_TENTACLES;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0) return SPELL_SHADOW_CONJURATION_DARKNESS;
      } // low
      else
      { // high
        if (GetHasSpell(SPELL_EPIC_HELLBALL,oNPC)>0&&fD>9.9) return SPELL_EPIC_HELLBALL;
        else if (GetHasSpell(SPELL_EPIC_RUIN,oNPC)>0&&fD>9.9) return SPELL_EPIC_RUIN;
        else if (GetHasSpell(SPELL_METEOR_SWARM,oNPC)>0&&fD>9.9) return SPELL_METEOR_SWARM;
        else if (GetHasSpell(SPELL_PRISMATIC_SPRAY,oNPC)>0) return SPELL_PRISMATIC_SPRAY;
        else if (GetHasSpell(SPELL_WAIL_OF_THE_BANSHEE,oNPC)>0) return SPELL_WAIL_OF_THE_BANSHEE;
        else if (GetHasSpell(SPELL_SUNBURST,oNPC)>0) return SPELL_SUNBURST;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_STORM_OF_VENGEANCE,oNPC)>0) return SPELL_STORM_OF_VENGEANCE;
        else if (GetHasSpell(SPELL_SPHERE_OF_CHAOS,oNPC)>0) return SPELL_SPHERE_OF_CHAOS;
        else if (GetHasSpell(SPELL_POWER_WORD_KILL,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH,oMe)==FALSE) return SPELL_POWER_WORD_KILL;
        else if (GetHasSpell(SPELL_NEGATIVE_ENERGY_BURST,oNPC)>0) return SPELL_NEGATIVE_ENERGY_BURST;
        else if (GetHasSpell(SPELL_MASS_BLINDNESS_AND_DEAFNESS,oNPC)>0) return SPELL_MASS_BLINDNESS_AND_DEAFNESS;
        else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_INCENDIARY_CLOUD,oNPC)>0&&fD>9.9) return SPELL_INCENDIARY_CLOUD;
        else if (GetHasSpell(SPELL_INFERNO,oNPC)>0) return SPELL_INFERNO;
        else if (GetHasSpell(SPELL_IMPLOSION,oNPC)>0&&fD>9.9) return SPELL_IMPLOSION;
        else if (GetHasSpell(SPELL_ICE_STORM,oNPC)>0&&fD>9.9) return SPELL_ICE_STORM;
        else if (GetHasSpell(SPELL_GREAT_THUNDERCLAP,oNPC)>0) return SPELL_GREAT_THUNDERCLAP;
        else if (GetHasSpell(SPELL_WEIRD,oNPC)>0) return SPELL_WEIRD;
        else if (GetHasSpell(SPELL_WORD_OF_FAITH,oNPC)>0) return SPELL_WORD_OF_FAITH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FIRE_STORM,oNPC)>0&&fD>9.9) return SPELL_FIRE_STORM;
        else if (GetHasSpell(SPELL_EARTHQUAKE,oNPC)>0) return SPELL_EARTHQUAKE;
        else if (GetHasSpell(SPELL_DELAYED_BLAST_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_DELAYED_BLAST_FIREBALL;
        else if (GetHasSpell(SPELL_DESTRUCTION,oNPC)>0) return SPELL_DESTRUCTION;
        else if (GetHasSpell(SPELL_CREEPING_DOOM,oNPC)>0) return SPELL_CREEPING_DOOM;
        else if (GetHasSpell(SPELL_CRUMBLE,oNPC)>0) return SPELL_CRUMBLE;
        else if (GetHasSpell(SPELL_CLOUDKILL,oNPC)>0&&fD>9.9) return SPELL_CLOUDKILL;
        else if (GetHasSpell(SPELL_CONE_OF_COLD,oNPC)>0) return SPELL_CONE_OF_COLD;
        else if (GetHasSpell(SPELL_CHAIN_LIGHTNING,oNPC)>0) return SPELL_CHAIN_LIGHTNING;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_BLADE_BARRIER,oNPC)>0) return SPELL_BLADE_BARRIER;
        else if (GetHasSpell(SPELL_BALL_LIGHTNING,oNPC)>0) return SPELL_BALL_LIGHTNING;
        else if (GetHasSpell(SPELL_CLOUD_OF_BEWILDERMENT,oNPC)>0&&fD>9.9&&GetIsImmune(oTarget,IMMUNITY_TYPE_CONFUSED,oMe)==FALSE) return SPELL_CLOUD_OF_BEWILDERMENT;
        else if (GetHasSpell(SPELL_DARKNESS,oNPC)>0) return SPELL_DARKNESS;
        else if (GetHasSpell(SPELL_DIRGE,oNPC)>0) return SPELL_DIRGE;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_EVARDS_BLACK_TENTACLES,oNPC)>0) return SPELL_EVARDS_BLACK_TENTACLES;
        else if (GetHasSpell(SPELL_FEAR,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_FEAR,oMe)==FALSE) return SPELL_FEAR;
        else if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_FLYING_DEBRIS,oNPC)>0) return SPELL_FLYING_DEBRIS;
        else if (GetHasSpell(SPELL_GREASE,oNPC)>0) return SPELL_GREASE;
        else if (GetHasSpell(SPELL_HAMMER_OF_THE_GODS,oNPC)>0) return SPELL_HAMMER_OF_THE_GODS;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SPIKE_GROWTH,oNPC)>0) return SPELL_SPIKE_GROWTH;
        else if (GetHasSpell(SPELL_STINKING_CLOUD,oNPC)>0&&fD>9.9) return SPELL_STINKING_CLOUD;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0) return SPELL_SHADOW_CONJURATION_DARKNESS;
       } // high
    } // okay to do area attack
    if (bGroup==FALSE&&!bAlliesNear)
    { // use non-area unless needed
      if (fCR<6.1)
      { // low
        if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_MAGIC_MISSILE,oNPC)>0) return SPELL_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_BESTOW_CURSE,oNPC)>0&&d4()<3) return SPELL_BESTOW_CURSE;
        else if (GetHasSpell(SPELL_BANE,oNPC)>0&&GetHasSpellEffect(SPELL_BANE,oTarget)==FALSE) return SPELL_BANE;
        else if (GetHasSpell(SPELL_BLINDNESS_AND_DEAFNESS,oNPC)>0&&d4()<3) return SPELL_BLINDNESS_AND_DEAFNESS;
        else if (GetHasSpell(SPELL_DOOM,oNPC)>0&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
        else if (GetHasSpell(SPELL_BOMBARDMENT,oNPC)>0) return SPELL_BOMBARDMENT;
        else if (GetHasSpell(SPELL_BURNING_HANDS,oNPC)>0) return SPELL_BURNING_HANDS;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_INFLICT_MODERATE_WOUNDS,oNPC)>0) return SPELL_INFLICT_MODERATE_WOUNDS;
        else if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT,oNPC)>0&&GetHasSpellEffect(SPELL_RAY_OF_ENFEEBLEMENT,oTarget)==FALSE) return SPELL_RAY_OF_ENFEEBLEMENT;
        else if (GetHasSpell(SPELL_DAZE,oNPC)>0&&d4()<3) return SPELL_DAZE;
        else if (GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_PERSON||nCT==CAI_CHARM_ANIMAL)&&GetHasSpellEffect(SPELL_CHARM_PERSON_OR_ANIMAL,oTarget)==FALSE) return SPELL_CHARM_PERSON_OR_ANIMAL;
        else if (GetHasSpell(SPELL_CHARM_PERSON,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_PERSON)&&GetHasSpellEffect(SPELL_CHARM_PERSON,oTarget)==FALSE) return SPELL_CHARM_PERSON;
        else if (GetHasSpell(SPELL_CHARM_MONSTER,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_MONSTER)&&GetHasSpellEffect(SPELL_CHARM_MONSTER,oTarget)==FALSE) return SPELL_CHARM_MONSTER;
        else if (GetHasSpell(SPELL_FLAME_LASH,oNPC)>0) return SPELL_FLAME_LASH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FLESH_TO_STONE,oNPC)>0) return SPELL_FLESH_TO_STONE;
        else if (GetHasSpell(SPELL_GHOUL_TOUCH,oNPC)>0&&d4()<3) return SPELL_GHOUL_TOUCH;
        else if (GetHasSpell(SPELL_ICE_DAGGER,oNPC)>0) return SPELL_ICE_DAGGER;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oNPC)>0) return SPELL_MELFS_ACID_ARROW;
        else if (GetHasSpell(SPELL_NEGATIVE_ENERGY_RAY,oNPC)>0) return SPELL_NEGATIVE_ENERGY_RAY;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_RAY_OF_FROST,oNPC)>0&&d4()<4) return SPELL_RAY_OF_FROST;
        else if (GetHasSpell(SPELL_SEARING_LIGHT,oNPC)>0) return SPELL_SEARING_LIGHT;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SLOW,oNPC)>0&&d4()<3) return SPELL_SLOW;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_VAMPIRIC_TOUCH,oNPC)>0&&d4()<3) return SPELL_VAMPIRIC_TOUCH;
        else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oNPC)>0) return SPELL_WOUNDING_WHISPERS;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGIC_MISSILE,oNPC)>0) return SPELL_SHADOW_CONJURATION_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oNPC)>0) return SPELL_ELECTRIC_JOLT;
        else if (GetHasSpell(SPELL_FLAME_ARROW,oNPC)>0) return SPELL_FLAME_ARROW;
        else if (GetHasSpell(SPELL_COLOR_SPRAY,oNPC)>0) return SPELL_COLOR_SPRAY;
        else if (GetHasSpell(SPELL_ACID_SPLASH,oNPC)>0) return SPELL_ACID_SPLASH;
        else if (GetHasSpell(SPELL_INFLICT_SERIOUS_WOUNDS,oNPC)>0) return SPELL_INFLICT_SERIOUS_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_CRITICAL_WOUNDS,oNPC)>0) return SPELL_INFLICT_CRITICAL_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_LIGHT_WOUNDS,oNPC)>0) return SPELL_INFLICT_LIGHT_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_MINOR_WOUNDS,oNPC)>0) return SPELL_INFLICT_MINOR_WOUNDS;
        else if (GetHasSpell(SPELL_POISON,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_POISON,oMe)==FALSE) return SPELL_POISON;
        else if (GetHasSpell(SPELL_TASHAS_HIDEOUS_LAUGHTER,oNPC)>0) return SPELL_TASHAS_HIDEOUS_LAUGHTER;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW;

        if (GetHasSpell(SPELL_SLEEP,oNPC)>0&&nRT!=RACIAL_TYPE_ELF&&nRT!=RACIAL_TYPE_CONSTRUCT) return SPELL_SLEEP;
        else if (GetHasSpell(SPELL_SCARE,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_FEAR,oMe)==FALSE) return SPELL_SCARE;
        else if (GetHasSpell(SPELL_STINKING_CLOUD,oNPC)>0&&fD>9.9) return SPELL_STINKING_CLOUD;
        else if (GetHasSpell(SPELL_SPIKE_GROWTH,oNPC)>0&&fD>9.9) return SPELL_SPIKE_GROWTH;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_FEAR,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_FEAR,oMe)==FALSE) return SPELL_FEAR;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_CLOUD_OF_BEWILDERMENT,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CONFUSED,oMe)==FALSE) return SPELL_CLOUD_OF_BEWILDERMENT;
        else if (GetHasSpell(SPELL_GREASE,oNPC)>0) return SPELL_GREASE;
        else if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0) return SPELL_SHADOW_CONJURATION_DARKNESS;
      } // low
      else
      { // high
        if (GetHasSpell(SPELL_POWER_WORD_KILL,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH,oMe)==FALSE) return SPELL_POWER_WORD_KILL;
        else if (GetHasSpell(SPELL_SLAY_LIVING,oNPC)>0&&d4()<3&&GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH,oMe)==FALSE) return SPELL_SLAY_LIVING;
        else if (GetHasSpell(SPELL_SILENCE,oNPC)>0&&d4()<2) return SPELL_SILENCE;
        else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_HORRID_WILTING,oNPC)>0) return SPELL_HORRID_WILTING;
        else if (GetHasSpell(SPELL_FLESH_TO_STONE,oNPC)>0) return SPELL_FLESH_TO_STONE;
        else if (GetHasSpell(SPELL_FINGER_OF_DEATH,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH,oMe)==FALSE) return SPELL_FINGER_OF_DEATH;
        else if (GetHasSpell(SPELL_BIGBYS_CRUSHING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_CRUSHING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_CRUSHING_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_CLENCHED_FIST,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_CLENCHED_FIST,oTarget)==FALSE) return SPELL_BIGBYS_CLENCHED_FIST;
        else if (GetHasSpell(SPELL_BIGBYS_GRASPING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_GRASPING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_GRASPING_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_FORCEFUL_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_FORCEFUL_HAND,oTarget)==FALSE) return SPELL_BIGBYS_FORCEFUL_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_INTERPOSING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_INTERPOSING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_INTERPOSING_HAND;
        else if (GetHasSpell(SPELL_DROWN,oNPC)>0) return SPELL_DROWN;
        else if (GetHasSpell(SPELL_BANISHMENT,oNPC)>0&&nRT==RACIAL_TYPE_OUTSIDER&&d4()<3) return SPELL_BANISHMENT;
        else if (GetHasSpell(SPELL_DISMISSAL,oNPC)>0&&nRT==RACIAL_TYPE_OUTSIDER&&d4()<3) return SPELL_DISMISSAL;
        else if (GetHasSpell(SPELL_ENERGY_DRAIN,oNPC)>0) return SPELL_ENERGY_DRAIN;
        else if (GetHasSpell(SPELL_PHANTASMAL_KILLER,oNPC)>0) return SPELL_PHANTASMAL_KILLER;
        else if (GetHasSpell(SPELL_ENERVATION,oNPC)>0) return SPELL_ENERVATION;
        else if (GetHasSpell(SPELL_FIREBRAND,oNPC)>0) return SPELL_FIREBRAND;
        else if (GetHasSpell(SPELL_INFESTATION_OF_MAGGOTS,oNPC)>0&&GetHasSpellEffect(SPELL_INFESTATION_OF_MAGGOTS,oTarget)==FALSE&&GetIsImmune(oTarget,IMMUNITY_TYPE_DISEASE,oMe)==FALSE) return SPELL_INFESTATION_OF_MAGGOTS;
        else if (GetHasSpell(SPELL_CONTAGION,oNPC)>0&&GetHasSpellEffect(SPELL_CONTAGION,oTarget)==FALSE&&GetIsImmune(oTarget,IMMUNITY_TYPE_DISEASE,oMe)==FALSE) return SPELL_CONTAGION;
        else if (GetHasSpell(SPELL_DOMINATE_PERSON,oNPC)>0&&GetIsPC(oTarget)&&GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget)==FALSE) return SPELL_DOMINATE_PERSON;
        else if (GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_PERSON||nCT==CAI_CHARM_ANIMAL)&&GetHasSpellEffect(SPELL_CHARM_PERSON_OR_ANIMAL,oTarget)==FALSE) return SPELL_CHARM_PERSON_OR_ANIMAL;
        else if (GetHasSpell(SPELL_CHARM_PERSON,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_PERSON)&&GetHasSpellEffect(SPELL_CHARM_PERSON,oTarget)==FALSE) return SPELL_CHARM_PERSON;
        else if (GetHasSpell(SPELL_CHARM_MONSTER,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_MONSTER)&&GetHasSpellEffect(SPELL_CHARM_MONSTER,oTarget)==FALSE) return SPELL_CHARM_MONSTER;
        else if (GetHasSpell(SPELL_CONFUSION,oNPC)>0&&GetHasSpellEffect(SPELL_CONFUSION,oTarget)==FALSE&&GetIsImmune(oTarget,IMMUNITY_TYPE_CONFUSED,oMe)==FALSE) return SPELL_CONFUSION;
        else if (GetHasSpell(SPELL_HOLD_PERSON,oNPC)>0&&GetIsPC(oTarget)&&GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget)==FALSE) return SPELL_HOLD_PERSON;
        else if (GetHasSpell(SPELL_HARM,oNPC)>0) return SPELL_HARM;
        else if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_MAGIC_MISSILE,oNPC)>0) return SPELL_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_BESTOW_CURSE,oNPC)>0&&d4()<3) return SPELL_BESTOW_CURSE;
        else if (GetHasSpell(SPELL_BLINDNESS_AND_DEAFNESS,oNPC)>0&&d4()<3) return SPELL_BLINDNESS_AND_DEAFNESS;
        else if (GetHasSpell(SPELL_BOMBARDMENT,oNPC)>0) return SPELL_BOMBARDMENT;
        else if (GetHasSpell(SPELL_BURNING_HANDS,oNPC)>0) return SPELL_BURNING_HANDS;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_INFLICT_MODERATE_WOUNDS,oNPC)>0) return SPELL_INFLICT_MODERATE_WOUNDS;
        else if (GetHasSpell(SPELL_DAZE,oNPC)>0&&d4()<3&&GetIsImmune(oTarget,IMMUNITY_TYPE_DAZED,oMe)==FALSE) return SPELL_DAZE;
        else if (GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL,oNPC)>0&&d4()<2) return SPELL_CHARM_PERSON_OR_ANIMAL;
        else if (GetHasSpell(SPELL_FLAME_LASH,oNPC)>0) return SPELL_FLAME_LASH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FLESH_TO_STONE,oNPC)>0) return SPELL_FLESH_TO_STONE;
        else if (GetHasSpell(SPELL_GHOUL_TOUCH,oNPC)>0&&d4()<3) return SPELL_GHOUL_TOUCH;
        else if (GetHasSpell(SPELL_ICE_DAGGER,oNPC)>0) return SPELL_ICE_DAGGER;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_DOOM,oNPC)>0&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
        else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oNPC)>0) return SPELL_MELFS_ACID_ARROW;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW;
        else if (GetHasSpell(SPELL_NEGATIVE_ENERGY_RAY,oNPC)>0) return SPELL_NEGATIVE_ENERGY_RAY;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_RAY_OF_FROST,oNPC)>0&&d4()<4) return SPELL_RAY_OF_FROST;
        else if (GetHasSpell(SPELL_SEARING_LIGHT,oNPC)>0) return SPELL_SEARING_LIGHT;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGIC_MISSILE,oNPC)>0) return SPELL_SHADOW_CONJURATION_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SLOW,oNPC)>0&&d4()<3) return SPELL_SLOW;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_VAMPIRIC_TOUCH,oNPC)>0&&d4()<3) return SPELL_VAMPIRIC_TOUCH;
        else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oNPC)>0) return SPELL_WOUNDING_WHISPERS;
        else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oNPC)>0) return SPELL_ELECTRIC_JOLT;
        else if (GetHasSpell(SPELL_FLAME_ARROW,oNPC)>0) return SPELL_FLAME_ARROW;
        else if (GetHasSpell(SPELL_COLOR_SPRAY,oNPC)>0) return SPELL_COLOR_SPRAY;
        else if (GetHasSpell(SPELL_ACID_SPLASH,oNPC)>0) return SPELL_ACID_SPLASH;
        else if (GetHasSpell(SPELL_INFLICT_SERIOUS_WOUNDS,oNPC)>0) return SPELL_INFLICT_SERIOUS_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_CRITICAL_WOUNDS,oNPC)>0) return SPELL_INFLICT_CRITICAL_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_LIGHT_WOUNDS,oNPC)>0) return SPELL_INFLICT_LIGHT_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_MINOR_WOUNDS,oNPC)>0) return SPELL_INFLICT_MINOR_WOUNDS;
        else if (GetHasSpell(SPELL_POISON,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_POISON,oMe)==FALSE) return SPELL_POISON;


        if (GetHasSpell(SPELL_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_FIREBALL;
        else if (GetHasSpell(SPELL_SHADES_FIREBALL,oNPC)>0&&fD>9.9) return SPELL_SHADES_FIREBALL;
        else if (GetHasSpell(SPELL_SCINTILLATING_SPHERE,oNPC)>0) return SPELL_SCINTILLATING_SPHERE;
        else if (GetHasSpell(SPELL_HAMMER_OF_THE_GODS,oNPC)>0) return SPELL_HAMMER_OF_THE_GODS;
        else if (GetHasSpell(SPELL_STINKING_CLOUD,oNPC)>0&&fD>9.9) return SPELL_STINKING_CLOUD;
        else if (GetHasSpell(SPELL_WALL_OF_FIRE,oNPC)>0&&fD>9.9) return SPELL_WALL_OF_FIRE;
        else if (GetHasSpell(SPELL_CONE_OF_COLD,oNPC)>0) return SPELL_CONE_OF_COLD;
        else if (GetHasSpell(SPELL_CLOUDKILL,oNPC)>0&&fD>9.9) return SPELL_CLOUDKILL;
        else if (GetHasSpell(SPELL_WEIRD,oNPC)>0) return SPELL_WEIRD;
        else if (GetHasSpell(SPELL_ACID_FOG,oNPC)>0) return SPELL_ACID_FOG;
        else if (GetHasSpell(SPELL_FEAR,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_FEAR,oMe)==FALSE) return SPELL_FEAR;
        else if (GetHasSpell(SPELL_WORD_OF_FAITH,oNPC)>0) return SPELL_WORD_OF_FAITH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_CLOUD_OF_BEWILDERMENT,oNPC)>0&&fD>9.9&&GetIsImmune(oTarget,IMMUNITY_TYPE_CONFUSED,oMe)==FALSE) return SPELL_CLOUD_OF_BEWILDERMENT;
        else if (GetHasSpell(SPELL_CHAIN_LIGHTNING,oNPC)>0) return SPELL_CHAIN_LIGHTNING;
        else if (GetHasSpell(SPELL_ENTANGLE,oNPC)>0) return SPELL_ENTANGLE;
        else if (GetHasSpell(SPELL_EVARDS_BLACK_TENTACLES,oNPC)>0) return SPELL_EVARDS_BLACK_TENTACLES;
        else if (GetHasSpell(SPELL_WEB,oNPC)>0) return SPELL_WEB;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_WEB,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_WEB;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_DARKNESS,oNPC)>0) return SPELL_SHADOW_CONJURATION_DARKNESS;
      } // high
    } // use non-area unless needed
      if (fCR<6.1)
      { // low
        if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_MAGIC_MISSILE,oNPC)>0) return SPELL_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_BESTOW_CURSE,oNPC)>0&&d4()<3) return SPELL_BESTOW_CURSE;
        else if (GetHasSpell(SPELL_BLINDNESS_AND_DEAFNESS,oNPC)>0&&d4()<3) return SPELL_BLINDNESS_AND_DEAFNESS;
        else if (GetHasSpell(SPELL_DOOM,oNPC)>0&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
        else if (GetHasSpell(SPELL_BANE,oNPC)>0&&GetHasSpellEffect(SPELL_BANE,oTarget)==FALSE) return SPELL_BANE;
        else if (GetHasSpell(SPELL_BOMBARDMENT,oNPC)>0) return SPELL_BOMBARDMENT;
        else if (GetHasSpell(SPELL_BURNING_HANDS,oNPC)>0) return SPELL_BURNING_HANDS;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_INFLICT_MODERATE_WOUNDS,oNPC)>0) return SPELL_INFLICT_MODERATE_WOUNDS;
        else if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT,oNPC)>0&&GetHasSpellEffect(SPELL_RAY_OF_ENFEEBLEMENT,oTarget)==FALSE) return SPELL_RAY_OF_ENFEEBLEMENT;
        else if (GetHasSpell(SPELL_DAZE,oNPC)>0&&d4()<3&&GetIsImmune(oTarget,IMMUNITY_TYPE_DAZED,oMe)==FALSE) return SPELL_DAZE;
        else if (GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_PERSON||nCT==CAI_CHARM_ANIMAL)&&GetHasSpellEffect(SPELL_CHARM_PERSON_OR_ANIMAL,oTarget)==FALSE) return SPELL_CHARM_PERSON_OR_ANIMAL;
        else if (GetHasSpell(SPELL_CHARM_PERSON,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_PERSON)&&GetHasSpellEffect(SPELL_CHARM_PERSON,oTarget)==FALSE) return SPELL_CHARM_PERSON;
        else if (GetHasSpell(SPELL_CHARM_MONSTER,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_MONSTER)&&GetHasSpellEffect(SPELL_CHARM_MONSTER,oTarget)==FALSE) return SPELL_CHARM_MONSTER;        else if (GetHasSpell(SPELL_FLAME_LASH,oNPC)>0) return SPELL_FLAME_LASH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FLESH_TO_STONE,oNPC)>0) return SPELL_FLESH_TO_STONE;
        else if (GetHasSpell(SPELL_GHOUL_TOUCH,oNPC)>0&&d4()<3) return SPELL_GHOUL_TOUCH;
        else if (GetHasSpell(SPELL_ICE_DAGGER,oNPC)>0) return SPELL_ICE_DAGGER;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oNPC)>0) return SPELL_MELFS_ACID_ARROW;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW;
        else if (GetHasSpell(SPELL_NEGATIVE_ENERGY_RAY,oNPC)>0) return SPELL_NEGATIVE_ENERGY_RAY;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_RAY_OF_FROST,oNPC)>0&&d4()<4) return SPELL_RAY_OF_FROST;
        else if (GetHasSpell(SPELL_SEARING_LIGHT,oNPC)>0) return SPELL_SEARING_LIGHT;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SLOW,oNPC)>0&&d4()<3) return SPELL_SLOW;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_VAMPIRIC_TOUCH,oNPC)>0&&d4()<3) return SPELL_VAMPIRIC_TOUCH;
        else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oNPC)>0) return SPELL_WOUNDING_WHISPERS;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGIC_MISSILE,oNPC)>0) return SPELL_SHADOW_CONJURATION_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oNPC)>0) return SPELL_ELECTRIC_JOLT;
        else if (GetHasSpell(SPELL_FLAME_ARROW,oNPC)>0) return SPELL_FLAME_ARROW;
        else if (GetHasSpell(SPELL_COLOR_SPRAY,oNPC)>0) return SPELL_COLOR_SPRAY;
        else if (GetHasSpell(SPELL_ACID_SPLASH,oNPC)>0) return SPELL_ACID_SPLASH;
        else if (GetHasSpell(SPELL_INFLICT_SERIOUS_WOUNDS,oNPC)>0) return SPELL_INFLICT_SERIOUS_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_CRITICAL_WOUNDS,oNPC)>0) return SPELL_INFLICT_CRITICAL_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_LIGHT_WOUNDS,oNPC)>0) return SPELL_INFLICT_LIGHT_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_MINOR_WOUNDS,oNPC)>0) return SPELL_INFLICT_MINOR_WOUNDS;
        else if (GetHasSpell(SPELL_POISON,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_POISON,oMe)==FALSE) return SPELL_POISON;
        else if (GetHasSpell(SPELL_TASHAS_HIDEOUS_LAUGHTER,oNPC)>0) return SPELL_TASHAS_HIDEOUS_LAUGHTER;
      } // low
      else
      {
        if (GetHasSpell(SPELL_POWER_WORD_KILL,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH,oMe)==FALSE) return SPELL_POWER_WORD_KILL;
        else if (GetHasSpell(SPELL_SLAY_LIVING,oNPC)>0&&d4()<3&&GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH,oMe)==FALSE) return SPELL_SLAY_LIVING;
        else if (GetHasSpell(SPELL_SILENCE,oNPC)>0&&d4()<2) return SPELL_SILENCE;
        else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_HORRID_WILTING,oNPC)>0) return SPELL_HORRID_WILTING;
        else if (GetHasSpell(SPELL_FLESH_TO_STONE,oNPC)>0) return SPELL_FLESH_TO_STONE;
        else if (GetHasSpell(SPELL_FINGER_OF_DEATH,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH,oMe)==FALSE) return SPELL_FINGER_OF_DEATH;
        else if (GetHasSpell(SPELL_BIGBYS_CRUSHING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_CRUSHING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_CRUSHING_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_CLENCHED_FIST,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_CLENCHED_FIST,oTarget)==FALSE) return SPELL_BIGBYS_CLENCHED_FIST;
        else if (GetHasSpell(SPELL_BIGBYS_GRASPING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_GRASPING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_GRASPING_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_FORCEFUL_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_FORCEFUL_HAND,oTarget)==FALSE) return SPELL_BIGBYS_FORCEFUL_HAND;
        else if (GetHasSpell(SPELL_BIGBYS_INTERPOSING_HAND,oNPC)>0&&GetHasSpellEffect(SPELL_BIGBYS_INTERPOSING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_INTERPOSING_HAND;
        else if (GetHasSpell(SPELL_FEEBLEMIND,oNPC)>0&&GetHasSpellEffect(SPELL_FEEBLEMIND,oTarget)==FALSE) return SPELL_FEEBLEMIND;
        else if (GetHasSpell(SPELL_DROWN,oNPC)>0) return SPELL_DROWN;
        else if (GetHasSpell(SPELL_BANISHMENT,oNPC)>0&&nRT==RACIAL_TYPE_OUTSIDER&&d4()<3) return SPELL_BANISHMENT;
        else if (GetHasSpell(SPELL_DISMISSAL,oNPC)>0&&nRT==RACIAL_TYPE_OUTSIDER&&d4()<3) return SPELL_DISMISSAL;
        else if (GetHasSpell(SPELL_ENERGY_DRAIN,oNPC)>0) return SPELL_ENERGY_DRAIN;
        else if (GetHasSpell(SPELL_PHANTASMAL_KILLER,oNPC)>0) return SPELL_PHANTASMAL_KILLER;
        else if (GetHasSpell(SPELL_ENERVATION,oNPC)>0) return SPELL_ENERVATION;
        else if (GetHasSpell(SPELL_FIREBRAND,oNPC)>0) return SPELL_FIREBRAND;
        else if (GetHasSpell(SPELL_INFESTATION_OF_MAGGOTS,oNPC)>0&&GetHasSpellEffect(SPELL_INFESTATION_OF_MAGGOTS,oTarget)==FALSE&&GetIsImmune(oTarget,IMMUNITY_TYPE_DISEASE,oMe)==FALSE) return SPELL_INFESTATION_OF_MAGGOTS;
        else if (GetHasSpell(SPELL_CONTAGION,oNPC)>0&&GetHasSpellEffect(SPELL_CONTAGION,oTarget)==FALSE&&GetIsImmune(oTarget,IMMUNITY_TYPE_DISEASE,oMe)==FALSE) return SPELL_CONTAGION;
        else if (GetHasSpell(SPELL_DOMINATE_PERSON,oNPC)>0&&GetIsPC(oTarget)&&GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget)==FALSE) return SPELL_DOMINATE_PERSON;
        else if (GetHasSpell(SPELL_CONFUSION,oNPC)>0&&GetHasSpellEffect(SPELL_CONFUSION,oTarget)==FALSE&&GetIsImmune(oTarget,IMMUNITY_TYPE_CONFUSED,oMe)==FALSE) return SPELL_CONFUSION;
        else if (GetHasSpell(SPELL_HOLD_PERSON,oNPC)>0&&GetIsPC(oTarget)&&GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget)==FALSE) return SPELL_HOLD_PERSON;
        else if (GetHasSpell(SPELL_HARM,oNPC)>0) return SPELL_HARM;
        else if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oNPC)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
        else if (GetHasSpell(SPELL_DOOM,oNPC)>0&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
        else if (GetHasSpell(SPELL_MAGIC_MISSILE,oNPC)>0) return SPELL_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_BESTOW_CURSE,oNPC)>0&&d4()<3) return SPELL_BESTOW_CURSE;
        else if (GetHasSpell(SPELL_BLINDNESS_AND_DEAFNESS,oNPC)>0&&d4()<3) return SPELL_BLINDNESS_AND_DEAFNESS;
        else if (GetHasSpell(SPELL_BOMBARDMENT,oNPC)>0) return SPELL_BOMBARDMENT;
        else if (GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_PERSON||nCT==CAI_CHARM_ANIMAL)&&GetHasSpellEffect(SPELL_CHARM_PERSON_OR_ANIMAL,oTarget)==FALSE) return SPELL_CHARM_PERSON_OR_ANIMAL;
        else if (GetHasSpell(SPELL_CHARM_PERSON,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_PERSON)&&GetHasSpellEffect(SPELL_CHARM_PERSON,oTarget)==FALSE) return SPELL_CHARM_PERSON;
        else if (GetHasSpell(SPELL_CHARM_MONSTER,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_CHARM,oMe)==FALSE&&(nCT==CAI_CHARM_MONSTER)&&GetHasSpellEffect(SPELL_CHARM_MONSTER,oTarget)==FALSE) return SPELL_CHARM_MONSTER;
        else if (GetHasSpell(SPELL_BURNING_HANDS,oNPC)>0) return SPELL_BURNING_HANDS;
        else if (GetHasSpell(SPELL_CALL_LIGHTNING,oNPC)>0) return SPELL_CALL_LIGHTNING;
        else if (GetHasSpell(SPELL_INFLICT_MODERATE_WOUNDS,oNPC)>0) return SPELL_INFLICT_MODERATE_WOUNDS;
        else if (GetHasSpell(SPELL_DAZE,oNPC)>0&&d4()<3&&GetIsImmune(oTarget,IMMUNITY_TYPE_DAZED,oMe)==FALSE) return SPELL_DAZE;
        else if (GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL,oNPC)>0&&d4()<2) return SPELL_CHARM_PERSON_OR_ANIMAL;
        else if (GetHasSpell(SPELL_FLAME_LASH,oNPC)>0) return SPELL_FLAME_LASH;
        else if (GetHasSpell(SPELL_FLAME_STRIKE,oNPC)>0) return SPELL_FLAME_STRIKE;
        else if (GetHasSpell(SPELL_FLESH_TO_STONE,oNPC)>0) return SPELL_FLESH_TO_STONE;
        else if (GetHasSpell(SPELL_GHOUL_TOUCH,oNPC)>0&&d4()<3) return SPELL_GHOUL_TOUCH;
        else if (GetHasSpell(SPELL_ICE_DAGGER,oNPC)>0) return SPELL_ICE_DAGGER;
        else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oNPC)>0) return SPELL_LIGHTNING_BOLT;
        else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oNPC)>0) return SPELL_MELFS_ACID_ARROW;
        else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW,oNPC)>0) return SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW;
        else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGIC_MISSILE,oNPC)>0) return SPELL_SHADOW_CONJURATION_MAGIC_MISSILE;
        else if (GetHasSpell(SPELL_NEGATIVE_ENERGY_RAY,oNPC)>0) return SPELL_NEGATIVE_ENERGY_RAY;
        else if (GetHasSpell(SPELL_QUILLFIRE,oNPC)>0) return SPELL_QUILLFIRE;
        else if (GetHasSpell(SPELL_RAY_OF_FROST,oNPC)>0&&d4()<4) return SPELL_RAY_OF_FROST;
        else if (GetHasSpell(SPELL_SEARING_LIGHT,oNPC)>0) return SPELL_SEARING_LIGHT;
        else if (GetHasSpell(SPELL_SOUND_BURST,oNPC)>0) return SPELL_SOUND_BURST;
        else if (GetHasSpell(SPELL_SLOW,oNPC)>0&&d4()<3) return SPELL_SLOW;
        else if (GetHasSpell(SPELL_SUNBEAM,oNPC)>0) return SPELL_SUNBEAM;
        else if (GetHasSpell(SPELL_VAMPIRIC_TOUCH,oNPC)>0&&d4()<3) return SPELL_VAMPIRIC_TOUCH;
        else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oNPC)>0) return SPELL_WOUNDING_WHISPERS;
        else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oNPC)>0) return SPELL_ELECTRIC_JOLT;
        else if (GetHasSpell(SPELL_FLAME_ARROW,oNPC)>0) return SPELL_FLAME_ARROW;
        else if (GetHasSpell(SPELL_COLOR_SPRAY,oNPC)>0) return SPELL_COLOR_SPRAY;
        else if (GetHasSpell(SPELL_ACID_SPLASH,oNPC)>0) return SPELL_ACID_SPLASH;
        else if (GetHasSpell(SPELL_INFLICT_SERIOUS_WOUNDS,oNPC)>0) return SPELL_INFLICT_SERIOUS_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_CRITICAL_WOUNDS,oNPC)>0) return SPELL_INFLICT_CRITICAL_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_LIGHT_WOUNDS,oNPC)>0) return SPELL_INFLICT_LIGHT_WOUNDS;
        else if (GetHasSpell(SPELL_INFLICT_MINOR_WOUNDS,oNPC)>0) return SPELL_INFLICT_MINOR_WOUNDS;
        else if (GetHasSpell(SPELL_POISON,oNPC)>0&&GetIsImmune(oTarget,IMMUNITY_TYPE_POISON,oMe)==FALSE) return SPELL_POISON;
        else if (GetHasSpell(SPELL_WEIRD,oNPC)>0) return SPELL_WEIRD;
      } // high
  } // not undead enemies
  return 0;
} // caiGetAvailableCombatSpell()

int caiGetAvailableDefensiveSpell(object oNPC,object oTarget)
{ // PURPOSE: To return a defensive spell that oNPC has that is useful to oTarget.
  int bSC=GetLocalInt(oNPC,"bCAISPELLCASTERS");
  if (oNPC==oTarget)
  { // self
    if(GetHasSpell(SPELL_ETHEREAL_VISAGE,oNPC)>0&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oTarget)==FALSE) return SPELL_ETHEREAL_VISAGE;
    else if(GetHasSpell(SPELL_PREMONITION,oNPC)>0&&GetHasSpellEffect(SPELL_PREMONITION,oTarget)==FALSE) return SPELL_PREMONITION;
    else if(GetHasSpell(SPELL_GREATER_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oTarget)==FALSE) return SPELL_GREATER_STONESKIN;
    else if(GetHasSpell(SPELL_GREATER_SPELL_MANTLE,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oTarget)==FALSE&&bSC) return SPELL_GREATER_SPELL_MANTLE;
    else if(GetHasSpell(SPELL_EPIC_MAGE_ARMOR,oNPC)>0&&GetHasSpellEffect(SPELL_EPIC_MAGE_ARMOR,oTarget)==FALSE) return SPELL_EPIC_MAGE_ARMOR;
    else if(GetHasSpell(SPELL_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_STONESKIN,oTarget)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oTarget)==FALSE) return SPELL_STONESKIN;
    else if(GetHasSpell(SPELL_SPELL_MANTLE,oNPC)>0&&GetHasSpellEffect(SPELL_SPELL_MANTLE,oTarget)==FALSE&&bSC&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oTarget)==FALSE) return SPELL_SPELL_MANTLE;
    else if(GetHasSpell(SPELL_DEATH_WARD,oNPC)>0&&GetHasSpellEffect(SPELL_DEATH_WARD,oTarget)==FALSE) return SPELL_DEATH_WARD;
    else if(GetHasSpell(SPELL_GHOSTLY_VISAGE,oNPC)>0&&GetHasSpellEffect(SPELL_GHOSTLY_VISAGE,oTarget)==FALSE&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oTarget)==FALSE) return SPELL_GHOSTLY_VISAGE;
    else if(GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY,oNPC)>0&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oTarget)==FALSE&&bSC) return SPELL_GLOBE_OF_INVULNERABILITY;
    else if(GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oNPC)>0&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oTarget)==FALSE&&bSC&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oTarget)==FALSE) return SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_CLOAK_OF_CHAOS,oNPC)>0&&GetHasSpellEffect(SPELL_CLOAK_OF_CHAOS,oTarget)==FALSE) return SPELL_CLOAK_OF_CHAOS;
    else if(GetHasSpell(SPELL_NEGATIVE_ENERGY_PROTECTION,oNPC)>0&&GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION,oTarget)==FALSE) return SPELL_NEGATIVE_ENERGY_PROTECTION;
    else if(GetHasSpell(SPELL_MIND_BLANK,oNPC)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oTarget)==FALSE&&bSC) return SPELL_MIND_BLANK;
    else if(GetHasSpell(SPELL_LESSER_MIND_BLANK,oNPC)>0&&GetHasSpellEffect(SPELL_LESSER_MIND_BLANK,oTarget)==FALSE&&bSC&&GetHasSpellEffect(SPELL_MIND_BLANK,oTarget)==FALSE) return SPELL_LESSER_MIND_BLANK;
    else if(GetHasSpell(SPELL_TRUE_SEEING,oNPC)>0&&GetHasSpellEffect(SPELL_TRUE_SEEING,oTarget)==FALSE&&bSC) return SPELL_TRUE_SEEING;
    else if(GetHasSpell(SPELL_SEE_INVISIBILITY,oNPC)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oTarget)==FALSE&&GetHasSpellEffect(SPELL_TRUE_SEEING,oTarget)==FALSE) return SPELL_SEE_INVISIBILITY;
    else if(GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT,oNPC)>0&&GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT,oTarget)==FALSE&&bSC) return SPELL_FREEDOM_OF_MOVEMENT;
    else if(GetHasSpell(SPELL_PRAYER,oNPC)>0&&GetHasSpellEffect(SPELL_PRAYER,oTarget)==FALSE) return SPELL_PRAYER;
    else if(GetHasSpell(SPELL_IMPROVED_INVISIBILITY,oNPC)>0&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oTarget)==FALSE) return SPELL_IMPROVED_INVISIBILITY;
    else if(GetHasSpell(SPELL_INVISIBILITY,oNPC)>0&&GetHasSpellEffect(SPELL_INVISIBILITY,oTarget)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oTarget)==FALSE) return SPELL_INVISIBILITY;
    else if(GetHasSpell(SPELL_LESSER_SPELL_MANTLE,oNPC)>0&&GetHasSpellEffect(SPELL_LESSER_SPELL_MANTLE,oTarget)==FALSE&&bSC&&GetHasSpellEffect(SPELL_SPELL_MANTLE,oTarget)==FALSE&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oTarget)==FALSE) return SPELL_LESSER_SPELL_MANTLE;
    else if(GetHasSpell(SPELL_DISPLACEMENT,oNPC)>0&&GetHasSpellEffect(SPELL_DISPLACEMENT,oTarget)==FALSE) return SPELL_DISPLACEMENT;
    else if(GetHasSpell(SPELL_ELEMENTAL_SHIELD,oNPC)>0&&GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD,oTarget)==FALSE) return SPELL_ELEMENTAL_SHIELD;
    else if(GetHasSpell(SPELL_ENTROPIC_SHIELD,oNPC)>0&&GetHasSpellEffect(SPELL_ENTROPIC_SHIELD,oTarget)==FALSE) return SPELL_ENTROPIC_SHIELD;
    else if(GetHasSpell(SPELL_SHIELD,oNPC)>0&&GetHasSpellEffect(SPELL_SHIELD,oTarget)==FALSE) return SPELL_SHIELD;
    else if(GetHasSpell(SPELL_MAGE_ARMOR,oNPC)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oTarget)==FALSE&&GetHasSpellEffect(SPELL_EPIC_MAGE_ARMOR,oTarget)==FALSE) return SPELL_MAGE_ARMOR;
    else if(GetHasSpell(SPELL_REGENERATE,oNPC)>0&&GetHasSpellEffect(SPELL_REGENERATE,oTarget)==FALSE) return SPELL_REGENERATE;
    else if(GetHasSpell(SPELL_BARKSKIN,oNPC)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oTarget)==FALSE) return SPELL_BARKSKIN;
    else if(GetHasSpell(SPELL_SHIELD_OF_FAITH,oNPC)>0&&GetHasSpellEffect(SPELL_SHIELD_OF_FAITH,oTarget)==FALSE) return SPELL_SHIELD_OF_FAITH;
    else if(GetHasSpell(SPELL_SHIELD_OF_LAW,oNPC)>0&&GetHasSpellEffect(SPELL_SHIELD_OF_LAW,oTarget)==FALSE) return SPELL_SHIELD_OF_LAW;
    else if(GetHasSpell(SPELL_NEGATIVE_ENERGY_PROTECTION,oNPC)>0&&GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION,oTarget)==FALSE) return SPELL_NEGATIVE_ENERGY_PROTECTION;
    else if(GetHasSpell(SPELL_ENDURE_ELEMENTS,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oTarget)==FALSE&&bSC) return SPELL_ENDURE_ELEMENTS;
    else if(GetHasSpell(SPELL_PROTECTION_FROM_EVIL,oNPC)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL,oTarget)==FALSE&&GetAlignmentGoodEvil(oTarget)!=ALIGNMENT_EVIL) return SPELL_PROTECTION_FROM_EVIL;
    else if(GetHasSpell(SPELL_PROTECTION_FROM_GOOD,oNPC)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_GOOD,oTarget)==FALSE&&GetAlignmentGoodEvil(oTarget)!=ALIGNMENT_GOOD) return SPELL_PROTECTION_FROM_GOOD;
    else if(GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_EVIL,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL,oTarget)==FALSE&&GetAlignmentGoodEvil(oTarget)!=ALIGNMENT_EVIL) return SPELL_MAGIC_CIRCLE_AGAINST_EVIL;
    else if(GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_GOOD,oNPC)>0&&GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_GOOD,oTarget)==FALSE&&GetAlignmentGoodEvil(oTarget)!=ALIGNMENT_GOOD) return SPELL_MAGIC_CIRCLE_AGAINST_GOOD;
    else if(GetHasSpell(SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oTarget)==FALSE&&bSC) return SPELL_RESISTANCE;
    else if(GetHasSpell(SPELL_BLESS,oNPC)>0&&GetHasSpellEffect(SPELL_BLESS,oTarget)==FALSE) return SPELL_BLESS;
    else if(GetHasSpell(SPELL_IRONGUTS,oNPC)>0&&GetHasSpellEffect(SPELL_IRONGUTS,oTarget)==FALSE) return SPELL_IRONGUTS;
    else if(GetHasSpell(SPELL_SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_CATS_GRACE,oNPC)>0&&GetHasSpellEffect(SPELL_CATS_GRACE,oTarget)==FALSE) return SPELL_CATS_GRACE;
    else if (GetHasSpell(SPELL_SHADES_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oTarget)==FALSE) return SPELL_SHADES_STONESKIN;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oNPC)>0&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oTarget)==FALSE) return SPELL_SHADOW_CONJURATION_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oNPC)>0&&bSC&&GetHasSpellEffect(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oTarget)==FALSE) return SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oNPC)>0&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oTarget)==FALSE) return SPELL_SHADOW_CONJURATION_INIVSIBILITY;
    else if (GetHasSpell(SPELL_SHADOW_SHIELD,oNPC)&&bSC&&GetHasSpellEffect(SPELL_SHADOW_SHIELD,oTarget)==FALSE>0) return SPELL_SHADOW_SHIELD;
    else if(GetHasSpell(SPELL_PROTECTION_FROM_SPELLS,oNPC)>0&&bSC&&GetHasSpellEffect(SPELL_PROTECTION_FROM_SPELLS,oTarget)==FALSE) return SPELL_PROTECTION_FROM_SPELLS;
  } // self
  else
  { // other
    if(GetHasSpell(SPELL_GREATER_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oTarget)==FALSE) return SPELL_GREATER_STONESKIN;
    else if(GetHasSpell(SPELL_STONESKIN,oNPC)>0&&GetHasSpellEffect(SPELL_STONESKIN,oTarget)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oTarget)==FALSE) return SPELL_STONESKIN;
    else if(GetHasSpell(SPELL_NEGATIVE_ENERGY_PROTECTION,oNPC)>0&&GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION,oTarget)==FALSE) return SPELL_NEGATIVE_ENERGY_PROTECTION;
    else if(GetHasSpell(SPELL_MIND_BLANK,oNPC)>0&&bSC&&GetHasSpellEffect(SPELL_MIND_BLANK,oTarget)==FALSE) return SPELL_MIND_BLANK;
    else if(GetHasSpell(SPELL_TRUE_SEEING,oNPC)>0&&bSC&&GetHasSpellEffect(SPELL_TRUE_SEEING,oTarget)==FALSE) return SPELL_TRUE_SEEING;
    else if(GetHasSpell(SPELL_SEE_INVISIBILITY,oNPC)>0&&bSC&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oTarget)==FALSE&&GetHasSpellEffect(SPELL_TRUE_SEEING,oTarget)==FALSE) return SPELL_SEE_INVISIBILITY;
    else if(GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT,oNPC)>0&&bSC&&GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT,oTarget)==FALSE) return SPELL_FREEDOM_OF_MOVEMENT;
    else if(GetHasSpell(SPELL_IMPROVED_INVISIBILITY,oNPC)>0&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oTarget)==FALSE) return SPELL_IMPROVED_INVISIBILITY;
    else if(GetHasSpell(SPELL_INVISIBILITY,oNPC)>0&&GetHasSpellEffect(SPELL_INVISIBILITY,oTarget)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oTarget)==FALSE) return SPELL_INVISIBILITY;
    else if(GetHasSpell(SPELL_REGENERATE,oNPC)>0&&GetHasSpellEffect(SPELL_REGENERATE,oTarget)==FALSE) return SPELL_REGENERATE;
    else if(GetHasSpell(SPELL_BARKSKIN,oNPC)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oTarget)==FALSE) return SPELL_BARKSKIN;
    else if(GetHasSpell(SPELL_SHIELD_OF_FAITH,oNPC)>0&&GetHasSpellEffect(SPELL_SHIELD_OF_FAITH,oTarget)==FALSE) return SPELL_SHIELD_OF_FAITH;
    else if(GetHasSpell(SPELL_DEATH_WARD,oNPC)>0&&GetHasSpellEffect(SPELL_DEATH_WARD,oTarget)==FALSE) return SPELL_DEATH_WARD;
    else if(GetHasSpell(SPELL_DISPLACEMENT,oNPC)>0&&GetHasSpellEffect(SPELL_DISPLACEMENT,oTarget)==FALSE) return SPELL_DISPLACEMENT;
    else if(GetHasSpell(SPELL_ENDURE_ELEMENTS,oNPC)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oTarget)==FALSE) return SPELL_ENDURE_ELEMENTS;
    else if(GetHasSpell(SPELL_PROTECTION_FROM_EVIL,oNPC)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL,oTarget)==FALSE&&GetAlignmentGoodEvil(oTarget)!=ALIGNMENT_EVIL) return SPELL_PROTECTION_FROM_EVIL;
    else if(GetHasSpell(SPELL_PROTECTION_FROM_GOOD,oNPC)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_GOOD,oTarget)==FALSE&&GetAlignmentGoodEvil(oTarget)!=ALIGNMENT_GOOD) return SPELL_PROTECTION_FROM_GOOD;
    else if(GetHasSpell(SPELL_RESIST_ELEMENTS,oNPC)>0&&GetHasSpellEffect(SPELL_RESIST_ELEMENTS,oTarget)==FALSE) return SPELL_RESIST_ELEMENTS;
    else if(GetHasSpell(SPELL_RESISTANCE,oNPC)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_RESISTANCE;
    else if(GetHasSpell(SPELL_BLESS,oNPC)>0&&GetHasSpellEffect(SPELL_BLESS,oTarget)==FALSE) return SPELL_BLESS;
    else if(GetHasSpell(SPELL_IRONGUTS,oNPC)>0&&GetHasSpellEffect(SPELL_IRONGUTS,oTarget)==FALSE) return SPELL_IRONGUTS;
    else if(GetHasSpell(SPELL_SPELL_RESISTANCE,oNPC)>0&&bSC&&GetHasSpellEffect(SPELL_SPELL_RESISTANCE,oTarget)==FALSE) return SPELL_SPELL_RESISTANCE;
    else if(GetHasSpell(SPELL_PROTECTION_FROM_SPELLS,oNPC)>0&&bSC&&GetHasSpellEffect(SPELL_PROTECTION_FROM_SPELLS,oTarget)==FALSE) return SPELL_PROTECTION_FROM_SPELLS;
  } // other
  return 0;
} // caiGetAvailableDefensiveSpell()

int caiProfessionalAntiStealth()
{ // PURPOSE: Return spells to counter invisibility, stealth, etc.
  object oMe=OBJECT_SELF;
  if (GetHasSpell(SPELL_TRUE_SEEING,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_SEEING,oMe)==FALSE) return SPELL_TRUE_SEEING;
  else if (GetHasSpell(SPELL_SEE_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oMe)==FALSE) return SPELL_SEE_INVISIBILITY;
  else if (GetHasSpell(SPELL_INVISIBILITY_PURGE,oMe)>0) return SPELL_INVISIBILITY_PURGE;
  else if (GetHasSpell(SPELL_PREMONITION,oMe)>0&&GetHasSpellEffect(SPELL_PREMONITION,oMe)==FALSE) return SPELL_PREMONITION;
  else if (GetHasSpell(SPELL_DEATH_WARD,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_WARD,oMe)==FALSE) return SPELL_DEATH_WARD;
  else if (GetHasSpell(SPELL_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_MIND_BLANK;
  else if (GetHasSpell(SPELL_LESSER_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_MIND_BLANK,oMe)==FALSE) return SPELL_LESSER_MIND_BLANK;
  else if (GetHasSpell(SPELL_SANCTUARY,oMe)>0&&GetHasSpellEffect(SPELL_SANCTUARY,oMe)==FALSE) return SPELL_SANCTUARY;
  return 0;
} // caiProfessionalAntiStealth()

int caiProfessionalDefensive(object oTarget)
{ // PURPOSE: Return defensive spells versus specified target
  object oMe=OBJECT_SELF;
  int nUND=GetLocalInt(oMe,"nCAICountUND");
  int nOUT=GetLocalInt(oMe,"nCAICountOUT");
  int nCON=GetLocalInt(oMe,"nCAICountCON");
  int nARC=GetLocalInt(oMe,"nCAICountARC");
  int nDIV=GetLocalInt(oMe,"nCAICountDIV");
  int nDRA=GetLocalInt(oMe,"nCAICountDRA");
  int nRGD=GetLocalInt(oMe,"nCAICountRGD");
  int nMEL=GetLocalInt(oMe,"nCAICountMEL");
  int nRT=GetRacialType(oTarget);
  object oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
  int nAGE=GetAlignmentGoodEvil(oMe);
  int nALC=GetAlignmentLawChaos(oMe);
  if (nDRA>0)
  { // dragons are near
    if (GetHasSpell(SPELL_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_MIND_BLANK;
    else if (GetHasSpell(SPELL_LESSER_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE&&GetHasSpellEffect(SPELL_LESSER_MIND_BLANK,oMe)==FALSE) return SPELL_LESSER_MIND_BLANK;
    else if (GetHasSpell(SPELL_PREMONITION,oMe)>0&&GetHasSpellEffect(SPELL_PREMONITION,oMe)==FALSE) return SPELL_PREMONITION;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS,oMe)==FALSE) return SPELL_ENDURE_ELEMENTS;
    else if (GetHasSpell(SPELL_RESIST_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_RESIST_ELEMENTS,oMe)==FALSE&&GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS,oMe)==FALSE) return SPELL_ENDURE_ELEMENTS;
    else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oMe)==FALSE&&GetHasSpellEffect(SPELL_RESIST_ELEMENTS,oMe)==FALSE&&GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS,oMe)==FALSE) return SPELL_ENDURE_ELEMENTS;
  } // dragons are near
  if (nRGD>0)
  { // ranged
    if (GetHasSpell(SPELL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD,oMe)==FALSE) return SPELL_SHIELD;
  } // ranged
  if (nARC>0)
  { // arcane opponents
    if (GetHasSpell(SPELL_GREATER_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_GREATER_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_TIME_STOP,oMe)>0&&GetHasSpellEffect(SPELL_TIME_STOP,oMe)==FALSE&&d4()==1) return SPELL_TIME_STOP;
    else if (GetHasSpell(SPELL_PREMONITION,oMe)>0&&GetHasSpellEffect(SPELL_PREMONITION,oMe)==FALSE) return SPELL_PREMONITION;
    else if (GetHasSpell(SPELL_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_MIND_BLANK;
    else if (GetHasSpell(SPELLABILITY_AURA_PROTECTION,oMe)>0&&GetHasSpellEffect(SPELLABILITY_AURA_PROTECTION,oMe)==FALSE) return SPELLABILITY_AURA_PROTECTION;
    else if (GetHasSpell(SPELL_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_TRUE_SEEING,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_SEEING,oMe)==FALSE) return SPELL_TRUE_SEEING;
    else if (GetHasSpell(SPELL_SHADOW_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_SHIELD,oMe)==FALSE) return SPELL_SHADOW_SHIELD;
    else if (GetHasSpell(SPELL_REGENERATE,oMe)>0&&GetHasSpellEffect(SPELL_REGENERATE,oMe)==FALSE) return SPELL_REGENERATE;
    else if (GetHasSpell(SPELL_AURA_OF_VITALITY,oMe)>0&&GetHasSpellEffect(SPELL_AURA_OF_VITALITY,oMe)==FALSE) return SPELL_AURA_OF_VITALITY;
    else if (GetHasSpell(SPELL_ETHEREAL_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_ETHEREAL_VISAGE;
    else if (GetHasSpell(SPELL_GREATER_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_GREATER_STONESKIN;
    else if (GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY,oMe)>0&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DEATH,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DEATH,oMe)==FALSE) return SPELL_CIRCLE_OF_DEATH;
    else if (GetHasSpell(SPELL_SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_SPELL_RESISTANCE,oMe)==FALSE) return SPELL_SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_MONSTROUS_REGENERATION,oMe)>0&&GetHasSpellEffect(SPELL_MONSTROUS_REGENERATION,oMe)==FALSE) return SPELL_MONSTROUS_REGENERATION;
    else if (GetHasSpell(SPELL_LESSER_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_LESSER_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_LESSER_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_MIND_BLANK,oMe)==FALSE&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_LESSER_MIND_BLANK;
    else if (GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)>0&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DOOM,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DOOM,oMe)==FALSE) return SPELL_CIRCLE_OF_DOOM;
    else if (GetHasSpell(SPELL_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_STONESKIN;
    else if (GetHasSpell(SPELL_DEATH_WARD,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_WARD,oMe)==FALSE) return SPELL_DEATH_WARD;
    else if (GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT,oMe)>0&&GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT,oMe)==FALSE) return SPELL_FREEDOM_OF_MOVEMENT;
    else if (GetHasSpell(SPELL_IMPROVED_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_IMPROVED_INVISIBILITY;
    else if (GetHasSpell(SPELL_MASS_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_MASS_CAMOFLAGE;
    else if (GetHasSpell(SPELL_DIVINE_POWER,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_POWER,oMe)==FALSE) return SPELL_DIVINE_POWER;
    else if (GetHasSpell(SPELL_ELEMENTAL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD,oMe)==FALSE) return SPELL_ELEMENTAL_SHIELD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS,oMe)==FALSE) return SPELL_PROTECTION_FROM_ELEMENTS;
    else if (GetHasSpell(SPELL_PRAYER,oMe)>0&&GetHasSpellEffect(SPELL_PRAYER,oMe)==FALSE) return SPELL_PRAYER;
    else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oMe)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oMe)==FALSE&&d4()<3) return SPELL_MAGIC_VESTMENT;
    else if (GetHasSpell(SPELL_INVISIBILITY_SPHERE,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY_SPHERE;
    else if (GetHasSpell(SPELL_HASTE,oMe)>0&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_HASTE;
    else if (GetHasSpell(SPELL_DISPLACEMENT,oMe)>0&&GetHasSpellEffect(SPELL_DISPLACEMENT,oMe)==FALSE) return SPELL_DISPLACEMENT;
    else if (GetHasSpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)>0&&GetHasSpellEffect(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)==FALSE&&d4()<3) return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
    else if (GetHasSpell(SPELL_SEE_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oMe)==FALSE) return SPELL_SEE_INVISIBILITY;
    else if (GetHasSpell(SPELL_RESIST_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_RESIST_ELEMENTS,oMe)==FALSE) return SPELL_RESIST_ELEMENTS;
    else if (GetHasSpell(SPELL_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_INIVSIBILITY;
    else if (GetHasSpell(SPELL_GHOSTLY_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_GHOSTLY_VISAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_GHOSTLY_VISAGE;
    else if (GetHasSpell(SPELL_DEATH_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_ARMOR,oMe)==FALSE) return SPELL_DEATH_ARMOR;
    else if (GetHasSpell(SPELL_SHADES_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_SHADES_STONESKIN;
    else if (GetHasSpell(SPELL_BARKSKIN,oMe)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_BARKSKIN;
    else if (GetHasSpell(SPELL_AURAOFGLORY,oMe)>0&&GetHasSpellEffect(SPELL_AURAOFGLORY,oMe)==FALSE) return SPELL_AURAOFGLORY;
    else if (GetHasSpell(SPELL_AID,oMe)>0&&GetHasSpellEffect(SPELL_AID,oMe)==FALSE) return SPELL_AID;
    else if (GetHasSpell(SPELL_TRUE_STRIKE,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_STRIKE,oMe)==FALSE) return SPELL_TRUE_STRIKE;
    else if (GetHasSpell(SPELL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD,oMe)==FALSE) return SPELL_SHIELD;
    else if (GetHasSpell(SPELL_SHIELD_OF_FAITH,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD_OF_FAITH,oMe)==FALSE) return SPELL_SHIELD_OF_FAITH;
    else if (GetHasSpell(SPELL_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE) return SPELL_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SANCTUARY,oMe)>0&&GetHasSpellEffect(SPELL_SANCTUARY,oMe)==FALSE&&d4()==1) return SPELL_SANCTUARY;
    else if (GetHasSpell(SPELL_IRONGUTS,oMe)>0&&GetHasSpellEffect(SPELL_IRONGUTS,oMe)==FALSE) return SPELL_IRONGUTS;
    else if (GetHasSpell(SPELL_EXPEDITIOUS_RETREAT,oMe)>0&&GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT,oMe)==FALSE&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_EXPEDITIOUS_RETREAT;
    else if (GetHasSpell(SPELL_ENTROPIC_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ENTROPIC_SHIELD,oMe)==FALSE) return SPELL_ENTROPIC_SHIELD;
    else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oMe)==FALSE) return SPELL_ENDURE_ELEMENTS;
    else if (GetHasSpell(SPELL_DIVINE_FAVOR,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_FAVOR,oMe)==FALSE) return SPELL_DIVINE_FAVOR;
    else if (GetHasSpell(SPELL_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_VINE_MINE_CAMOUFLAGE;
    else if (GetHasSpell(SPELL_VINE_MINE_CAMOUFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_VINE_MINE_CAMOUFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_CAMOFLAGE;
    else if (GetHasSpell(SPELL_BLESS_WEAPON,oMe)>0&&GetHasSpellEffect(SPELL_BLESS_WEAPON,oMe)==FALSE) return SPELL_BLESS_WEAPON;
    else if (GetHasSpell(SPELL_BLESS,oMe)>0&&GetHasSpellEffect(SPELL_BLESS,oMe)==FALSE) return SPELL_BLESS;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_EVIL,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL,oMe)==FALSE&&nAGE!=ALIGNMENT_EVIL) return SPELL_PROTECTION_FROM_EVIL;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_GOOD,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_GOOD,oMe)==FALSE&&nAGE!=ALIGNMENT_GOOD) return SPELL_PROTECTION_FROM_GOOD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_LAW,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_LAW,oMe)==FALSE&&nALC!=ALIGNMENT_LAWFUL) return SPELL_PROTECTION_FROM_LAW;
    else if (GetHasSpell(SPELL_PROTECTION__FROM_CHAOS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION__FROM_CHAOS,oMe)==FALSE&&nALC!=ALIGNMENT_CHAOTIC) return SPELL_PROTECTION__FROM_CHAOS;
    else if (GetHasSpell(SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oMe)==FALSE) return SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_VIRTUE,oMe)>0&&GetHasSpellEffect(SPELL_VIRTUE,oMe)==FALSE) return SPELL_VIRTUE;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_SPELLS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_SPELLS,oMe)==FALSE) return SPELL_PROTECTION_FROM_SPELLS;
  } // arcane opponents
  if (nDIV>0)
  { // divine opponents
    if (GetHasSpell(SPELL_GREATER_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_GREATER_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_TIME_STOP,oMe)>0&&GetHasSpellEffect(SPELL_TIME_STOP,oMe)==FALSE&&d4()==1) return SPELL_TIME_STOP;
    else if (GetHasSpell(SPELL_PREMONITION,oMe)>0&&GetHasSpellEffect(SPELL_PREMONITION,oMe)==FALSE) return SPELL_PREMONITION;
    else if (GetHasSpell(SPELL_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_MIND_BLANK;
    else if (GetHasSpell(SPELLABILITY_AURA_PROTECTION,oMe)>0&&GetHasSpellEffect(SPELLABILITY_AURA_PROTECTION,oMe)==FALSE) return SPELLABILITY_AURA_PROTECTION;
    else if (GetHasSpell(SPELL_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_TRUE_SEEING,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_SEEING,oMe)==FALSE) return SPELL_TRUE_SEEING;
    else if (GetHasSpell(SPELL_SHADOW_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_SHIELD,oMe)==FALSE) return SPELL_SHADOW_SHIELD;
    else if (GetHasSpell(SPELL_REGENERATE,oMe)>0&&GetHasSpellEffect(SPELL_REGENERATE,oMe)==FALSE) return SPELL_REGENERATE;
    else if (GetHasSpell(SPELL_AURA_OF_VITALITY,oMe)>0&&GetHasSpellEffect(SPELL_AURA_OF_VITALITY,oMe)==FALSE) return SPELL_AURA_OF_VITALITY;
    else if (GetHasSpell(SPELL_ETHEREAL_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_ETHEREAL_VISAGE;
    else if (GetHasSpell(SPELL_GREATER_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_GREATER_STONESKIN;
    else if (GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY,oMe)>0&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DEATH,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DEATH,oMe)==FALSE) return SPELL_CIRCLE_OF_DEATH;
    else if (GetHasSpell(SPELL_SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_SPELL_RESISTANCE,oMe)==FALSE) return SPELL_SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_MONSTROUS_REGENERATION,oMe)>0&&GetHasSpellEffect(SPELL_MONSTROUS_REGENERATION,oMe)==FALSE) return SPELL_MONSTROUS_REGENERATION;
    else if (GetHasSpell(SPELL_LESSER_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_LESSER_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_LESSER_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_MIND_BLANK,oMe)==FALSE&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_LESSER_MIND_BLANK;
    else if (GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)>0&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DOOM,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DOOM,oMe)==FALSE) return SPELL_CIRCLE_OF_DOOM;
    else if (GetHasSpell(SPELL_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_STONESKIN;
    else if (GetHasSpell(SPELL_DEATH_WARD,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_WARD,oMe)==FALSE) return SPELL_DEATH_WARD;
    else if (GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT,oMe)>0&&GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT,oMe)==FALSE) return SPELL_FREEDOM_OF_MOVEMENT;
    else if (GetHasSpell(SPELL_IMPROVED_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_IMPROVED_INVISIBILITY;
    else if (GetHasSpell(SPELL_MASS_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_MASS_CAMOFLAGE;
    else if (GetHasSpell(SPELL_DIVINE_POWER,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_POWER,oMe)==FALSE) return SPELL_DIVINE_POWER;
    else if (GetHasSpell(SPELL_ELEMENTAL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD,oMe)==FALSE) return SPELL_ELEMENTAL_SHIELD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS,oMe)==FALSE) return SPELL_PROTECTION_FROM_ELEMENTS;
    else if (GetHasSpell(SPELL_PRAYER,oMe)>0&&GetHasSpellEffect(SPELL_PRAYER,oMe)==FALSE) return SPELL_PRAYER;
    else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oMe)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oMe)==FALSE&&d4()<3) return SPELL_MAGIC_VESTMENT;
    else if (GetHasSpell(SPELL_INVISIBILITY_SPHERE,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY_SPHERE;
    else if (GetHasSpell(SPELL_HASTE,oMe)>0&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_HASTE;
    else if (GetHasSpell(SPELL_DISPLACEMENT,oMe)>0&&GetHasSpellEffect(SPELL_DISPLACEMENT,oMe)==FALSE) return SPELL_DISPLACEMENT;
    else if (GetHasSpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)>0&&GetHasSpellEffect(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)==FALSE&&d4()<3) return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
    else if (GetHasSpell(SPELL_SEE_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oMe)==FALSE) return SPELL_SEE_INVISIBILITY;
    else if (GetHasSpell(SPELL_RESIST_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_RESIST_ELEMENTS,oMe)==FALSE) return SPELL_RESIST_ELEMENTS;
    else if (GetHasSpell(SPELL_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_INIVSIBILITY;
    else if (GetHasSpell(SPELL_GHOSTLY_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_GHOSTLY_VISAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_GHOSTLY_VISAGE;
    else if (GetHasSpell(SPELL_DEATH_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_ARMOR,oMe)==FALSE) return SPELL_DEATH_ARMOR;
    else if (GetHasSpell(SPELL_BULLS_STRENGTH,oMe)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oMe)==FALSE) return SPELL_BULLS_STRENGTH;
    else if (GetHasSpell(SPELL_CATS_GRACE,oMe)>0&&GetHasSpellEffect(SPELL_CATS_GRACE,oMe)==FALSE) return SPELL_CATS_GRACE;
    else if (GetHasSpell(SPELL_SHADES_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_SHADES_STONESKIN;
    else if (GetHasSpell(SPELL_BARKSKIN,oMe)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_BARKSKIN;
    else if (GetHasSpell(SPELL_AURAOFGLORY,oMe)>0&&GetHasSpellEffect(SPELL_AURAOFGLORY,oMe)==FALSE) return SPELL_AURAOFGLORY;
    else if (GetHasSpell(SPELL_AID,oMe)>0&&GetHasSpellEffect(SPELL_AID,oMe)==FALSE) return SPELL_AID;
    else if (GetHasSpell(SPELL_TRUE_STRIKE,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_STRIKE,oMe)==FALSE) return SPELL_TRUE_STRIKE;
    else if (GetHasSpell(SPELL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD,oMe)==FALSE) return SPELL_SHIELD;
    else if (GetHasSpell(SPELL_SHIELD_OF_FAITH,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD_OF_FAITH,oMe)==FALSE) return SPELL_SHIELD_OF_FAITH;
    else if (GetHasSpell(SPELL_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE) return SPELL_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SANCTUARY,oMe)>0&&GetHasSpellEffect(SPELL_SANCTUARY,oMe)==FALSE&&d4()==1) return SPELL_SANCTUARY;
    else if (GetHasSpell(SPELL_IRONGUTS,oMe)>0&&GetHasSpellEffect(SPELL_IRONGUTS,oMe)==FALSE) return SPELL_IRONGUTS;
    else if (GetHasSpell(SPELL_EXPEDITIOUS_RETREAT,oMe)>0&&GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT,oMe)==FALSE&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_EXPEDITIOUS_RETREAT;
    else if (GetHasSpell(SPELL_ENTROPIC_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ENTROPIC_SHIELD,oMe)==FALSE) return SPELL_ENTROPIC_SHIELD;
    else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oMe)==FALSE) return SPELL_ENDURE_ELEMENTS;
    else if (GetHasSpell(SPELL_DIVINE_FAVOR,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_FAVOR,oMe)==FALSE) return SPELL_DIVINE_FAVOR;
    else if (GetHasSpell(SPELL_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_VINE_MINE_CAMOUFLAGE;
    else if (GetHasSpell(SPELL_VINE_MINE_CAMOUFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_VINE_MINE_CAMOUFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_CAMOFLAGE;
    else if (GetHasSpell(SPELL_BLESS_WEAPON,oMe)>0&&GetHasSpellEffect(SPELL_BLESS_WEAPON,oMe)==FALSE) return SPELL_BLESS_WEAPON;
    else if (GetHasSpell(SPELL_BLESS,oMe)>0&&GetHasSpellEffect(SPELL_BLESS,oMe)==FALSE) return SPELL_BLESS;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_EVIL,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL,oMe)==FALSE&&nAGE!=ALIGNMENT_EVIL) return SPELL_PROTECTION_FROM_EVIL;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_GOOD,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_GOOD,oMe)==FALSE&&nAGE!=ALIGNMENT_GOOD) return SPELL_PROTECTION_FROM_GOOD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_LAW,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_LAW,oMe)==FALSE&&nALC!=ALIGNMENT_LAWFUL) return SPELL_PROTECTION_FROM_LAW;
    else if (GetHasSpell(SPELL_PROTECTION__FROM_CHAOS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION__FROM_CHAOS,oMe)==FALSE&&nALC!=ALIGNMENT_CHAOTIC) return SPELL_PROTECTION__FROM_CHAOS;
    else if (GetHasSpell(SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oMe)==FALSE) return SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_VIRTUE,oMe)>0&&GetHasSpellEffect(SPELL_VIRTUE,oMe)==FALSE) return SPELL_VIRTUE;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_SPELLS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_SPELLS,oMe)==FALSE) return SPELL_PROTECTION_FROM_SPELLS;
  } // divine opponents
  if (nUND>0)
  { // undead opponents
    if (GetHasSpell(SPELL_PREMONITION,oMe)>0&&GetHasSpellEffect(SPELL_PREMONITION,oMe)==FALSE) return SPELL_PREMONITION;
    else if (GetHasSpell(SPELL_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_MIND_BLANK;
    else if (GetHasSpell(SPELLABILITY_AURA_PROTECTION,oMe)>0&&GetHasSpellEffect(SPELLABILITY_AURA_PROTECTION,oMe)==FALSE) return SPELLABILITY_AURA_PROTECTION;
    else if (GetHasSpell(SPELL_TRUE_SEEING,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_SEEING,oMe)==FALSE) return SPELL_TRUE_SEEING;
    else if (GetHasSpell(SPELL_SHADOW_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_SHIELD,oMe)==FALSE) return SPELL_SHADOW_SHIELD;
    else if (GetHasSpell(SPELL_REGENERATE,oMe)>0&&GetHasSpellEffect(SPELL_REGENERATE,oMe)==FALSE) return SPELL_REGENERATE;
    else if (GetHasSpell(SPELL_AURA_OF_VITALITY,oMe)>0&&GetHasSpellEffect(SPELL_AURA_OF_VITALITY,oMe)==FALSE) return SPELL_AURA_OF_VITALITY;
    else if (GetHasSpell(SPELL_ETHEREAL_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_ETHEREAL_VISAGE;
    else if (GetHasSpell(SPELL_GREATER_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_GREATER_STONESKIN;
    else if (GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY,oMe)>0&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DEATH,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DEATH,oMe)==FALSE) return SPELL_CIRCLE_OF_DEATH;
    else if (GetHasSpell(SPELL_MONSTROUS_REGENERATION,oMe)>0&&GetHasSpellEffect(SPELL_MONSTROUS_REGENERATION,oMe)==FALSE) return SPELL_MONSTROUS_REGENERATION;
    else if (GetHasSpell(SPELL_LESSER_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_MIND_BLANK,oMe)==FALSE&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_LESSER_MIND_BLANK;
    else if (GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)>0&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DOOM,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DOOM,oMe)==FALSE) return SPELL_CIRCLE_OF_DOOM;
    else if (GetHasSpell(SPELL_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_STONESKIN;
    else if (GetHasSpell(SPELL_DEATH_WARD,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_WARD,oMe)==FALSE) return SPELL_DEATH_WARD;
    else if (GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT,oMe)>0&&GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT,oMe)==FALSE) return SPELL_FREEDOM_OF_MOVEMENT;
    else if (GetHasSpell(SPELL_IMPROVED_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_IMPROVED_INVISIBILITY;
    else if (GetHasSpell(SPELL_MASS_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_MASS_CAMOFLAGE;
    else if (GetHasSpell(SPELL_DIVINE_POWER,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_POWER,oMe)==FALSE) return SPELL_DIVINE_POWER;
    else if (GetHasSpell(SPELL_ELEMENTAL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD,oMe)==FALSE) return SPELL_ELEMENTAL_SHIELD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS,oMe)==FALSE) return SPELL_PROTECTION_FROM_ELEMENTS;
    else if (GetHasSpell(SPELL_PRAYER,oMe)>0&&GetHasSpellEffect(SPELL_PRAYER,oMe)==FALSE) return SPELL_PRAYER;
    else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oMe)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oMe)==FALSE&&d4()<3) return SPELL_MAGIC_VESTMENT;
    else if (GetHasSpell(SPELL_INVISIBILITY_SPHERE,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY_SPHERE;
    else if (GetHasSpell(SPELL_HASTE,oMe)>0&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_HASTE;
    else if (GetHasSpell(SPELL_DISPLACEMENT,oMe)>0&&GetHasSpellEffect(SPELL_DISPLACEMENT,oMe)==FALSE) return SPELL_DISPLACEMENT;
    else if (GetHasSpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)>0&&GetHasSpellEffect(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)==FALSE&&d4()<3) return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
    else if (GetHasSpell(SPELL_SEE_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oMe)==FALSE) return SPELL_SEE_INVISIBILITY;
    else if (GetHasSpell(SPELL_RESIST_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_RESIST_ELEMENTS,oMe)==FALSE) return SPELL_RESIST_ELEMENTS;
    else if (GetHasSpell(SPELL_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_INIVSIBILITY;
    else if (GetHasSpell(SPELL_GHOSTLY_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_GHOSTLY_VISAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_GHOSTLY_VISAGE;
    else if (GetHasSpell(SPELL_DEATH_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_ARMOR,oMe)==FALSE) return SPELL_DEATH_ARMOR;
    else if (GetHasSpell(SPELL_CATS_GRACE,oMe)>0&&GetHasSpellEffect(SPELL_CATS_GRACE,oMe)==FALSE) return SPELL_CATS_GRACE;
    else if (GetHasSpell(SPELL_SHADES_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_SHADES_STONESKIN;
    else if (GetHasSpell(SPELL_BARKSKIN,oMe)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_BARKSKIN;
    else if (GetHasSpell(SPELL_AURAOFGLORY,oMe)>0&&GetHasSpellEffect(SPELL_AURAOFGLORY,oMe)==FALSE) return SPELL_AURAOFGLORY;
    else if (GetHasSpell(SPELL_AID,oMe)>0&&GetHasSpellEffect(SPELL_AID,oMe)==FALSE) return SPELL_AID;
    else if (GetHasSpell(SPELL_TRUE_STRIKE,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_STRIKE,oMe)==FALSE) return SPELL_TRUE_STRIKE;
    else if (GetHasSpell(SPELL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD,oMe)==FALSE) return SPELL_SHIELD;
    else if (GetHasSpell(SPELL_SHIELD_OF_FAITH,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD_OF_FAITH,oMe)==FALSE) return SPELL_SHIELD_OF_FAITH;
    else if (GetHasSpell(SPELL_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE) return SPELL_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SANCTUARY,oMe)>0&&GetHasSpellEffect(SPELL_SANCTUARY,oMe)==FALSE&&d4()==1) return SPELL_SANCTUARY;
    else if (GetHasSpell(SPELL_IRONGUTS,oMe)>0&&GetHasSpellEffect(SPELL_IRONGUTS,oMe)==FALSE) return SPELL_IRONGUTS;
    else if (GetHasSpell(SPELL_EXPEDITIOUS_RETREAT,oMe)>0&&GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT,oMe)==FALSE&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_EXPEDITIOUS_RETREAT;
    else if (GetHasSpell(SPELL_ENTROPIC_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ENTROPIC_SHIELD,oMe)==FALSE) return SPELL_ENTROPIC_SHIELD;
    else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oMe)==FALSE) return SPELL_ENDURE_ELEMENTS;
    else if (GetHasSpell(SPELL_DIVINE_FAVOR,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_FAVOR,oMe)==FALSE) return SPELL_DIVINE_FAVOR;
    else if (GetHasSpell(SPELL_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_VINE_MINE_CAMOUFLAGE;
    else if (GetHasSpell(SPELL_VINE_MINE_CAMOUFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_VINE_MINE_CAMOUFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_CAMOFLAGE;
    else if (GetHasSpell(SPELL_BLESS_WEAPON,oMe)>0&&GetHasSpellEffect(SPELL_BLESS_WEAPON,oMe)==FALSE) return SPELL_BLESS_WEAPON;
    else if (GetHasSpell(SPELL_BLESS,oMe)>0&&GetHasSpellEffect(SPELL_BLESS,oMe)==FALSE) return SPELL_BLESS;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_EVIL,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL,oMe)==FALSE&&nAGE!=ALIGNMENT_EVIL) return SPELL_PROTECTION_FROM_EVIL;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_GOOD,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_GOOD,oMe)==FALSE&&nAGE!=ALIGNMENT_GOOD) return SPELL_PROTECTION_FROM_GOOD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_LAW,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_LAW,oMe)==FALSE&&nALC!=ALIGNMENT_LAWFUL) return SPELL_PROTECTION_FROM_LAW;
    else if (GetHasSpell(SPELL_PROTECTION__FROM_CHAOS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION__FROM_CHAOS,oMe)==FALSE&&nALC!=ALIGNMENT_CHAOTIC) return SPELL_PROTECTION__FROM_CHAOS;
    else if (GetHasSpell(SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oMe)==FALSE) return SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_VIRTUE,oMe)>0&&GetHasSpellEffect(SPELL_VIRTUE,oMe)==FALSE) return SPELL_VIRTUE;
  } // undead opponents
  if (nOUT>0)
  { // outsider opponents
    if (GetHasSpell(SPELL_GREATER_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_GREATER_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_TIME_STOP,oMe)>0&&GetHasSpellEffect(SPELL_TIME_STOP,oMe)==FALSE&&d4()==1) return SPELL_TIME_STOP;
    else if (GetHasSpell(SPELL_PREMONITION,oMe)>0&&GetHasSpellEffect(SPELL_PREMONITION,oMe)==FALSE) return SPELL_PREMONITION;
    else if (GetHasSpell(SPELL_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_MIND_BLANK;
    else if (GetHasSpell(SPELLABILITY_AURA_PROTECTION,oMe)>0&&GetHasSpellEffect(SPELLABILITY_AURA_PROTECTION,oMe)==FALSE) return SPELLABILITY_AURA_PROTECTION;
    else if (GetHasSpell(SPELL_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_TRUE_SEEING,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_SEEING,oMe)==FALSE) return SPELL_TRUE_SEEING;
    else if (GetHasSpell(SPELL_SHADOW_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_SHIELD,oMe)==FALSE) return SPELL_SHADOW_SHIELD;
    else if (GetHasSpell(SPELL_REGENERATE,oMe)>0&&GetHasSpellEffect(SPELL_REGENERATE,oMe)==FALSE) return SPELL_REGENERATE;
    else if (GetHasSpell(SPELL_AURA_OF_VITALITY,oMe)>0&&GetHasSpellEffect(SPELL_AURA_OF_VITALITY,oMe)==FALSE) return SPELL_AURA_OF_VITALITY;
    else if (GetHasSpell(SPELL_ETHEREAL_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_ETHEREAL_VISAGE;
    else if (GetHasSpell(SPELL_GREATER_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_GREATER_STONESKIN;
    else if (GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY,oMe)>0&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DEATH,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DEATH,oMe)==FALSE) return SPELL_CIRCLE_OF_DEATH;
    else if (GetHasSpell(SPELL_SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_SPELL_RESISTANCE,oMe)==FALSE) return SPELL_SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_MONSTROUS_REGENERATION,oMe)>0&&GetHasSpellEffect(SPELL_MONSTROUS_REGENERATION,oMe)==FALSE) return SPELL_MONSTROUS_REGENERATION;
    else if (GetHasSpell(SPELL_LESSER_SPELL_MANTLE,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_SPELL_MANTLE,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE,oMe)==FALSE) return SPELL_LESSER_SPELL_MANTLE;
    else if (GetHasSpell(SPELL_LESSER_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_MIND_BLANK,oMe)==FALSE&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_LESSER_MIND_BLANK;
    else if (GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)>0&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
    else if (GetHasSpell(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY,oMe)==FALSE) return SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DOOM,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DOOM,oMe)==FALSE) return SPELL_CIRCLE_OF_DOOM;
    else if (GetHasSpell(SPELL_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_STONESKIN;
    else if (GetHasSpell(SPELL_DEATH_WARD,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_WARD,oMe)==FALSE) return SPELL_DEATH_WARD;
    else if (GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT,oMe)>0&&GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT,oMe)==FALSE) return SPELL_FREEDOM_OF_MOVEMENT;
    else if (GetHasSpell(SPELL_IMPROVED_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_IMPROVED_INVISIBILITY;
    else if (GetHasSpell(SPELL_MASS_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_MASS_CAMOFLAGE;
    else if (GetHasSpell(SPELL_DIVINE_POWER,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_POWER,oMe)==FALSE) return SPELL_DIVINE_POWER;
    else if (GetHasSpell(SPELL_ELEMENTAL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD,oMe)==FALSE) return SPELL_ELEMENTAL_SHIELD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS,oMe)==FALSE) return SPELL_PROTECTION_FROM_ELEMENTS;
    else if (GetHasSpell(SPELL_PRAYER,oMe)>0&&GetHasSpellEffect(SPELL_PRAYER,oMe)==FALSE) return SPELL_PRAYER;
    else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oMe)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oMe)==FALSE&&d4()<3) return SPELL_MAGIC_VESTMENT;
    else if (GetHasSpell(SPELL_INVISIBILITY_SPHERE,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY_SPHERE;
    else if (GetHasSpell(SPELL_HASTE,oMe)>0&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_HASTE;
    else if (GetHasSpell(SPELL_DISPLACEMENT,oMe)>0&&GetHasSpellEffect(SPELL_DISPLACEMENT,oMe)==FALSE) return SPELL_DISPLACEMENT;
    else if (GetHasSpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)>0&&GetHasSpellEffect(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)==FALSE&&d4()<3) return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
    else if (GetHasSpell(SPELL_SEE_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oMe)==FALSE) return SPELL_SEE_INVISIBILITY;
    else if (GetHasSpell(SPELL_RESIST_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_RESIST_ELEMENTS,oMe)==FALSE) return SPELL_RESIST_ELEMENTS;
    else if (GetHasSpell(SPELL_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_INIVSIBILITY;
    else if (GetHasSpell(SPELL_GHOSTLY_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_GHOSTLY_VISAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_GHOSTLY_VISAGE;
    else if (GetHasSpell(SPELL_DEATH_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_ARMOR,oMe)==FALSE) return SPELL_DEATH_ARMOR;
    else if (GetHasSpell(SPELL_BULLS_STRENGTH,oMe)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oMe)==FALSE) return SPELL_BULLS_STRENGTH;
    else if (GetHasSpell(SPELL_CATS_GRACE,oMe)>0&&GetHasSpellEffect(SPELL_CATS_GRACE,oMe)==FALSE) return SPELL_CATS_GRACE;
    else if (GetHasSpell(SPELL_SHADES_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_SHADES_STONESKIN;
    else if (GetHasSpell(SPELL_BARKSKIN,oMe)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_BARKSKIN;
    else if (GetHasSpell(SPELL_AURAOFGLORY,oMe)>0&&GetHasSpellEffect(SPELL_AURAOFGLORY,oMe)==FALSE) return SPELL_AURAOFGLORY;
    else if (GetHasSpell(SPELL_AID,oMe)>0&&GetHasSpellEffect(SPELL_AID,oMe)==FALSE) return SPELL_AID;
    else if (GetHasSpell(SPELL_TRUE_STRIKE,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_STRIKE,oMe)==FALSE) return SPELL_TRUE_STRIKE;
    else if (GetHasSpell(SPELL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD,oMe)==FALSE) return SPELL_SHIELD;
    else if (GetHasSpell(SPELL_SHIELD_OF_FAITH,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD_OF_FAITH,oMe)==FALSE) return SPELL_SHIELD_OF_FAITH;
    else if (GetHasSpell(SPELL_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE) return SPELL_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SANCTUARY,oMe)>0&&GetHasSpellEffect(SPELL_SANCTUARY,oMe)==FALSE&&d4()==1) return SPELL_SANCTUARY;
    else if (GetHasSpell(SPELL_IRONGUTS,oMe)>0&&GetHasSpellEffect(SPELL_IRONGUTS,oMe)==FALSE) return SPELL_IRONGUTS;
    else if (GetHasSpell(SPELL_EXPEDITIOUS_RETREAT,oMe)>0&&GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT,oMe)==FALSE&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_EXPEDITIOUS_RETREAT;
    else if (GetHasSpell(SPELL_ENTROPIC_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ENTROPIC_SHIELD,oMe)==FALSE) return SPELL_ENTROPIC_SHIELD;
    else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oMe)==FALSE) return SPELL_ENDURE_ELEMENTS;
    else if (GetHasSpell(SPELL_DIVINE_FAVOR,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_FAVOR,oMe)==FALSE) return SPELL_DIVINE_FAVOR;
    else if (GetHasSpell(SPELL_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_VINE_MINE_CAMOUFLAGE;
    else if (GetHasSpell(SPELL_VINE_MINE_CAMOUFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_VINE_MINE_CAMOUFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_CAMOFLAGE;
    else if (GetHasSpell(SPELL_BLESS_WEAPON,oMe)>0&&GetHasSpellEffect(SPELL_BLESS_WEAPON,oMe)==FALSE) return SPELL_BLESS_WEAPON;
    else if (GetHasSpell(SPELL_BLESS,oMe)>0&&GetHasSpellEffect(SPELL_BLESS,oMe)==FALSE) return SPELL_BLESS;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_EVIL,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL,oMe)==FALSE&&nAGE!=ALIGNMENT_EVIL) return SPELL_PROTECTION_FROM_EVIL;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_GOOD,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_GOOD,oMe)==FALSE&&nAGE!=ALIGNMENT_GOOD) return SPELL_PROTECTION_FROM_GOOD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_LAW,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_LAW,oMe)==FALSE&&nALC!=ALIGNMENT_LAWFUL) return SPELL_PROTECTION_FROM_LAW;
    else if (GetHasSpell(SPELL_PROTECTION__FROM_CHAOS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION__FROM_CHAOS,oMe)==FALSE&&nALC!=ALIGNMENT_CHAOTIC) return SPELL_PROTECTION__FROM_CHAOS;
    else if (GetHasSpell(SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oMe)==FALSE) return SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_VIRTUE,oMe)>0&&GetHasSpellEffect(SPELL_VIRTUE,oMe)==FALSE) return SPELL_VIRTUE;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_SPELLS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_SPELLS,oMe)==FALSE) return SPELL_PROTECTION_FROM_SPELLS;
  } // outsider opponents
  if (nRT==RACIAL_TYPE_UNDEAD)
  { // undead target
    if (GetHasSpell(SPELL_NEGATIVE_ENERGY_PROTECTION,oMe)>0&&GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION,oMe)==FALSE) return SPELL_NEGATIVE_ENERGY_PROTECTION;
  } // undead target
  else
  { // other target
    if (GetHasSpell(SPELL_CATS_GRACE,oMe)>0&&GetHasSpellEffect(SPELL_CATS_GRACE,oMe)==FALSE) return SPELL_CATS_GRACE;
    else if (GetHasSpell(SPELL_FOXS_CUNNING,oMe)>0&&GetHasSpellEffect(SPELL_FOXS_CUNNING,oMe)==FALSE) return SPELL_FOXS_CUNNING;
    else if (GetHasSpell(SPELL_OWLS_WISDOM,oMe)>0&&GetHasSpellEffect(SPELL_OWLS_WISDOM,oMe)==FALSE) return SPELL_OWLS_WISDOM;
    else if (GetHasSpell(SPELL_ONE_WITH_THE_LAND,oMe)>0&&GetHasSpellEffect(SPELL_ONE_WITH_THE_LAND,oMe)==FALSE) return SPELL_ONE_WITH_THE_LAND;
    else if (GetHasSpell(SPELL_TIME_STOP,oMe)>0&&GetHasSpellEffect(SPELL_TIME_STOP,oMe)==FALSE&&d4()==1) return SPELL_TIME_STOP;
    else if (GetHasSpell(SPELL_PREMONITION,oMe)>0&&GetHasSpellEffect(SPELL_PREMONITION,oMe)==FALSE) return SPELL_PREMONITION;
    else if (GetHasSpell(SPELL_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_MIND_BLANK;
    else if (GetHasSpell(SPELLABILITY_AURA_PROTECTION,oMe)>0&&GetHasSpellEffect(SPELLABILITY_AURA_PROTECTION,oMe)==FALSE) return SPELLABILITY_AURA_PROTECTION;
    else if (GetHasSpell(SPELL_TRUE_SEEING,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_SEEING,oMe)==FALSE) return SPELL_TRUE_SEEING;
    else if (GetHasSpell(SPELL_SHADOW_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_SHIELD,oMe)==FALSE) return SPELL_SHADOW_SHIELD;
    else if (GetHasSpell(SPELL_REGENERATE,oMe)>0&&GetHasSpellEffect(SPELL_REGENERATE,oMe)==FALSE) return SPELL_REGENERATE;
    else if (GetHasSpell(SPELL_AURA_OF_VITALITY,oMe)>0&&GetHasSpellEffect(SPELL_AURA_OF_VITALITY,oMe)==FALSE) return SPELL_AURA_OF_VITALITY;
    else if (GetHasSpell(SPELL_ETHEREAL_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_ETHEREAL_VISAGE;
    else if (GetHasSpell(SPELL_GREATER_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_GREATER_STONESKIN;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DEATH,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DEATH,oMe)==FALSE) return SPELL_CIRCLE_OF_DEATH;
    else if (GetHasSpell(SPELL_SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_SPELL_RESISTANCE,oMe)==FALSE) return SPELL_SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_MONSTROUS_REGENERATION,oMe)>0&&GetHasSpellEffect(SPELL_MONSTROUS_REGENERATION,oMe)==FALSE) return SPELL_MONSTROUS_REGENERATION;
    else if (GetHasSpell(SPELL_LESSER_MIND_BLANK,oMe)>0&&GetHasSpellEffect(SPELL_LESSER_MIND_BLANK,oMe)==FALSE&&GetHasSpellEffect(SPELL_MIND_BLANK,oMe)==FALSE) return SPELL_LESSER_MIND_BLANK;
    else if (GetHasSpell(SPELL_CIRCLE_OF_DOOM,oMe)>0&&GetHasSpellEffect(SPELL_CIRCLE_OF_DOOM,oMe)==FALSE) return SPELL_CIRCLE_OF_DOOM;
    else if (GetHasSpell(SPELL_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_STONESKIN;
    else if (GetHasSpell(SPELL_DEATH_WARD,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_WARD,oMe)==FALSE) return SPELL_DEATH_WARD;
    else if (GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT,oMe)>0&&GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT,oMe)==FALSE) return SPELL_FREEDOM_OF_MOVEMENT;
    else if (GetHasSpell(SPELL_IMPROVED_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_IMPROVED_INVISIBILITY;
    else if (GetHasSpell(SPELL_MASS_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_MASS_CAMOFLAGE;
    else if (GetHasSpell(SPELL_DIVINE_POWER,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_POWER,oMe)==FALSE) return SPELL_DIVINE_POWER;
    else if (GetHasSpell(SPELL_ELEMENTAL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD,oMe)==FALSE) return SPELL_ELEMENTAL_SHIELD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS,oMe)==FALSE) return SPELL_PROTECTION_FROM_ELEMENTS;
    else if (GetHasSpell(SPELL_PRAYER,oMe)>0&&GetHasSpellEffect(SPELL_PRAYER,oMe)==FALSE) return SPELL_PRAYER;
    else if (GetHasSpell(SPELL_MAGIC_VESTMENT,oMe)>0&&GetHasSpellEffect(SPELL_MAGIC_VESTMENT,oMe)==FALSE&&d4()<3) return SPELL_MAGIC_VESTMENT;
    else if (GetHasSpell(SPELL_INVISIBILITY_SPHERE,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY_SPHERE;
    else if (GetHasSpell(SPELL_HASTE,oMe)>0&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_HASTE;
    else if (GetHasSpell(SPELL_DISPLACEMENT,oMe)>0&&GetHasSpellEffect(SPELL_DISPLACEMENT,oMe)==FALSE) return SPELL_DISPLACEMENT;
    else if (GetHasSpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)>0&&GetHasSpellEffect(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oMe)==FALSE&&d4()<3) return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
    else if (GetHasSpell(SPELL_SEE_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SEE_INVISIBILITY,oMe)==FALSE) return SPELL_SEE_INVISIBILITY;
    else if (GetHasSpell(SPELL_RESIST_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_RESIST_ELEMENTS,oMe)==FALSE) return SPELL_RESIST_ELEMENTS;
    else if (GetHasSpell(SPELL_INVISIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_INVISIBILITY;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)>0&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_INIVSIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY,oMe)==FALSE&&GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE,oMe)==FALSE&&GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_INIVSIBILITY;
    else if (GetHasSpell(SPELL_GHOSTLY_VISAGE,oMe)>0&&GetHasSpellEffect(SPELL_GHOSTLY_VISAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_ETHEREAL_VISAGE,oMe)==FALSE) return SPELL_GHOSTLY_VISAGE;
    else if (GetHasSpell(SPELL_DEATH_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_DEATH_ARMOR,oMe)==FALSE) return SPELL_DEATH_ARMOR;
    else if (GetHasSpell(SPELL_BULLS_STRENGTH,oMe)>0&&GetHasSpellEffect(SPELL_BULLS_STRENGTH,oMe)==FALSE) return SPELL_BULLS_STRENGTH;
    else if (GetHasSpell(SPELL_CATS_GRACE,oMe)>0&&GetHasSpellEffect(SPELL_CATS_GRACE,oMe)==FALSE) return SPELL_CATS_GRACE;
    else if (GetHasSpell(SPELL_SHADES_STONESKIN,oMe)>0&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_SHADES_STONESKIN;
    else if (GetHasSpell(SPELL_BARKSKIN,oMe)>0&&GetHasSpellEffect(SPELL_BARKSKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADES_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_STONESKIN,oMe)==FALSE&&GetHasSpellEffect(SPELL_GREATER_STONESKIN,oMe)==FALSE) return SPELL_BARKSKIN;
    else if (GetHasSpell(SPELL_AURAOFGLORY,oMe)>0&&GetHasSpellEffect(SPELL_AURAOFGLORY,oMe)==FALSE) return SPELL_AURAOFGLORY;
    else if (GetHasSpell(SPELL_AID,oMe)>0&&GetHasSpellEffect(SPELL_AID,oMe)==FALSE) return SPELL_AID;
    else if (GetHasSpell(SPELL_TRUE_STRIKE,oMe)>0&&GetHasSpellEffect(SPELL_TRUE_STRIKE,oMe)==FALSE) return SPELL_TRUE_STRIKE;
    else if (GetHasSpell(SPELL_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD,oMe)==FALSE) return SPELL_SHIELD;
    else if (GetHasSpell(SPELL_SHIELD_OF_FAITH,oMe)>0&&GetHasSpellEffect(SPELL_SHIELD_OF_FAITH,oMe)==FALSE) return SPELL_SHIELD_OF_FAITH;
    else if (GetHasSpell(SPELL_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE) return SPELL_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)>0&&GetHasSpellEffect(SPELL_MAGE_ARMOR,oMe)==FALSE&&GetHasSpellEffect(SPELL_SHADOW_CONJURATION_MAGE_ARMOR,oMe)==FALSE) return SPELL_SHADOW_CONJURATION_MAGE_ARMOR;
    else if (GetHasSpell(SPELL_SANCTUARY,oMe)>0&&GetHasSpellEffect(SPELL_SANCTUARY,oMe)==FALSE&&d4()==1) return SPELL_SANCTUARY;
    else if (GetHasSpell(SPELL_IRONGUTS,oMe)>0&&GetHasSpellEffect(SPELL_IRONGUTS,oMe)==FALSE) return SPELL_IRONGUTS;
    else if (GetHasSpell(SPELL_EXPEDITIOUS_RETREAT,oMe)>0&&GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT,oMe)==FALSE&&GetHasSpellEffect(SPELL_HASTE,oMe)==FALSE) return SPELL_EXPEDITIOUS_RETREAT;
    else if (GetHasSpell(SPELL_ENTROPIC_SHIELD,oMe)>0&&GetHasSpellEffect(SPELL_ENTROPIC_SHIELD,oMe)==FALSE) return SPELL_ENTROPIC_SHIELD;
    else if (GetHasSpell(SPELL_ENDURE_ELEMENTS,oMe)>0&&GetHasSpellEffect(SPELL_ENDURE_ELEMENTS,oMe)==FALSE) return SPELL_ENDURE_ELEMENTS;
    else if (GetHasSpell(SPELL_DIVINE_FAVOR,oMe)>0&&GetHasSpellEffect(SPELL_DIVINE_FAVOR,oMe)==FALSE) return SPELL_DIVINE_FAVOR;
    else if (GetHasSpell(SPELL_CAMOFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_VINE_MINE_CAMOUFLAGE;
    else if (GetHasSpell(SPELL_VINE_MINE_CAMOUFLAGE,oMe)>0&&GetHasSpellEffect(SPELL_VINE_MINE_CAMOUFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_CAMOFLAGE,oMe)==FALSE&&GetHasSpellEffect(SPELL_MASS_CAMOFLAGE,oMe)==FALSE) return SPELL_CAMOFLAGE;
    else if (GetHasSpell(SPELL_BLESS_WEAPON,oMe)>0&&GetHasSpellEffect(SPELL_BLESS_WEAPON,oMe)==FALSE) return SPELL_BLESS_WEAPON;
    else if (GetHasSpell(SPELL_BLESS,oMe)>0&&GetHasSpellEffect(SPELL_BLESS,oMe)==FALSE) return SPELL_BLESS;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_EVIL,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL,oMe)==FALSE&&nAGE!=ALIGNMENT_EVIL) return SPELL_PROTECTION_FROM_EVIL;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_GOOD,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_GOOD,oMe)==FALSE&&nAGE!=ALIGNMENT_GOOD) return SPELL_PROTECTION_FROM_GOOD;
    else if (GetHasSpell(SPELL_PROTECTION_FROM_LAW,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION_FROM_LAW,oMe)==FALSE&&nALC!=ALIGNMENT_LAWFUL) return SPELL_PROTECTION_FROM_LAW;
    else if (GetHasSpell(SPELL_PROTECTION__FROM_CHAOS,oMe)>0&&GetHasSpellEffect(SPELL_PROTECTION__FROM_CHAOS,oMe)==FALSE&&nALC!=ALIGNMENT_CHAOTIC) return SPELL_PROTECTION__FROM_CHAOS;
    else if (GetHasSpell(SPELL_RESISTANCE,oMe)>0&&GetHasSpellEffect(SPELL_RESISTANCE,oMe)==FALSE) return SPELL_RESISTANCE;
    else if (GetHasSpell(SPELL_VIRTUE,oMe)>0&&GetHasSpellEffect(SPELL_VIRTUE,oMe)==FALSE) return SPELL_VIRTUE;
  } // other target
  return 0;
} // caiProfessionalDefensive()

int caiProfessionalCounter(object oTarget)
{ // PURPOSE: Return counter magic to spells on target
  object oMe=OBJECT_SELF;
  if (GetHasSpell(SPELL_MORDENKAINENS_DISJUNCTION,oMe)>0) return SPELL_MORDENKAINENS_DISJUNCTION;
  else if (GetHasSpell(SPELL_GREATER_SPELL_BREACH,oMe)>0&&d4()<3) return SPELL_GREATER_SPELL_BREACH;
  else if (GetHasSpell(SPELL_GREATER_DISPELLING,oMe)>0) return SPELL_GREATER_DISPELLING;
  else if (GetHasSpell(SPELL_LESSER_SPELL_BREACH,oMe)>0&&d4()<3) return SPELL_LESSER_SPELL_BREACH;
  else if (GetHasSpell(SPELL_DISPEL_MAGIC,oMe)>0) return SPELL_DISPEL_MAGIC;
  else if (GetHasSpell(SPELL_LESSER_DISPEL,oMe)>0) return SPELL_LESSER_DISPEL;
  return 0;
} // caiProfessionalCounter()

int caiProfessionalCloseQuarters(object oTarget)
{ // PURPOSE: Return offensive close quarter spell
  int nRT=GetRacialType(oTarget);
  object oMe=OBJECT_SELF;
  if (GetMaster(oTarget)!=oTarget&&GetIsObjectValid(GetMaster(oTarget))&&GetAssociateType(oTarget)==ASSOCIATE_TYPE_SUMMONED)
  { // summoned
    if (GetHasSpell(SPELL_BANISHMENT,oMe)>0&&d4()<3) return SPELL_BANISHMENT;
    else if (GetHasSpell(SPELL_DISMISSAL,oMe)>0&&d4()<3) return SPELL_DISMISSAL;
  } // summoned
  if (nRT==RACIAL_TYPE_UNDEAD||GetLocalInt(oTarget,"nIsVampire")==TRUE)
  { // undead
    if (GetHasSpell(SPELL_BIGBYS_CRUSHING_HAND,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_CRUSHING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_CRUSHING_HAND;
    else if (GetHasSpell(SPELL_BIGBYS_CLENCHED_FIST,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_CLENCHED_FIST,oTarget)==FALSE) return SPELL_BIGBYS_CLENCHED_FIST;
    else if (GetHasSpell(SPELL_WORD_OF_FAITH,oMe)>0&&d4()<3) return SPELL_WORD_OF_FAITH;
    else if (GetHasSpell(SPELL_UNDEATH_TO_DEATH,oMe)>0) return SPELL_UNDEATH_TO_DEATH;
    else if (GetHasSpell(SPELL_CONTROL_UNDEAD,oMe)>0&&GetHasSpellEffect(SPELL_CONTROL_UNDEAD,oTarget)==FALSE) return SPELL_BIGBYS_CRUSHING_HAND;
    else if (GetHasSpell(SPELL_BIGBYS_GRASPING_HAND,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_GRASPING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_GRASPING_HAND;
    else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oMe)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
    else if (GetHasSpell(SPELL_CHAIN_LIGHTNING,oMe)>0) return SPELL_CHAIN_LIGHTNING;
    else if (GetHasSpell(SPELL_HEAL,oMe)>0) return SPELL_HEAL;
    else if (GetHasSpell(SPELL_BIGBYS_FORCEFUL_HAND,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_FORCEFUL_HAND,oTarget)==FALSE) return SPELL_BIGBYS_FORCEFUL_HAND;
    else if (GetHasSpell(SPELL_FIREBRAND,oMe)>0) return SPELL_FIREBRAND;
    else if (GetHasSpell(SPELL_BALL_LIGHTNING,oMe)>0) return SPELL_BALL_LIGHTNING;
    else if (GetHasSpell(SPELL_BIGBYS_INTERPOSING_HAND,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_INTERPOSING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_INTERPOSING_HAND;
    else if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oMe)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
    else if (GetHasSpell(SPELL_HAMMER_OF_THE_GODS,oMe)>0) return SPELL_HAMMER_OF_THE_GODS;
    else if (GetHasSpell(SPELL_BESTOW_CURSE,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BESTOW_CURSE,oTarget)==FALSE) return SPELL_BESTOW_CURSE;
    else if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oMe)>0) return SPELL_CURE_CRITICAL_WOUNDS;
    else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oMe)>0) return SPELL_WOUNDING_WHISPERS;
    else if (GetHasSpell(SPELL_SEARING_LIGHT,oMe)>0) return SPELL_SEARING_LIGHT;
    else if (GetHasSpell(SPELL_SLOW,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_SLOW,oTarget)==FALSE) return SPELL_SLOW;
    else if (GetHasSpell(SPELL_QUILLFIRE,oMe)>0) return SPELL_QUILLFIRE;
    else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oMe)>0&&d4()<3) return SPELL_LIGHTNING_BOLT;
    else if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS,oMe)>0) return SPELL_CURE_SERIOUS_WOUNDS;
    else if (GetHasSpell(SPELL_SOUND_BURST,oMe)>0) return SPELL_SOUND_BURST;
    else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oMe)>0) return SPELL_MELFS_ACID_ARROW;
    else if (GetHasSpell(SPELL_GEDLEES_ELECTRIC_LOOP,oMe)>0) return SPELL_GEDLEES_ELECTRIC_LOOP;
    else if (GetHasSpell(SPELL_FLAME_LASH,oMe)>0) return SPELL_FLAME_LASH;
    else if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS,oMe)>0) return SPELL_CURE_MODERATE_WOUNDS;
    else if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_RAY_OF_ENFEEBLEMENT,oTarget)==FALSE) return SPELL_RAY_OF_ENFEEBLEMENT;
    else if (GetHasSpell(SPELL_MAGIC_MISSILE,oMe)>0) return SPELL_MAGIC_MISSILE;
    else if (GetHasSpell(SPELL_ICE_DAGGER,oMe)>0) return SPELL_ICE_DAGGER;
    else if (GetHasSpell(SPELL_DOOM,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
    else if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS,oMe)>0) return SPELL_CURE_LIGHT_WOUNDS;
    else if (GetHasSpell(SPELL_BURNING_HANDS,oMe)>0) return SPELL_BURNING_HANDS;
    else if (GetHasSpell(SPELL_BANE,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BANE,oTarget)==FALSE) return SPELL_BANE;
    else if (GetHasSpell(SPELL_RAY_OF_FROST,oMe)>0) return SPELL_RAY_OF_FROST;
    else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oMe)>0) return SPELL_ELECTRIC_JOLT;
    else if (GetHasSpell(SPELL_ACID_SPLASH,oMe)>0) return SPELL_ACID_SPLASH;
    else if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS,oMe)>0) return SPELL_CURE_MINOR_WOUNDS;
  } // undead
  else if (nRT==RACIAL_TYPE_CONSTRUCT)
  { // construct

  } // construct
  else
  { // other
    if (GetHasSpell(SPELL_BIGBYS_CRUSHING_HAND,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_CRUSHING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_CRUSHING_HAND;
    else if (GetHasSpell(SPELL_BIGBYS_CLENCHED_FIST,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_CLENCHED_FIST,oTarget)==FALSE) return SPELL_BIGBYS_CLENCHED_FIST;
    else if (GetHasSpell(SPELL_WORD_OF_FAITH,oMe)>0&&d4()<3) return SPELL_WORD_OF_FAITH;
    else if (GetHasSpell(SPELL_BIGBYS_GRASPING_HAND,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_GRASPING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_GRASPING_HAND;
    else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oMe)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
    else if (GetHasSpell(SPELL_CHAIN_LIGHTNING,oMe)>0) return SPELL_CHAIN_LIGHTNING;
    else if (GetHasSpell(SPELL_HARM,oMe)>0) return SPELL_HARM;
    else if (GetHasSpell(SPELL_BIGBYS_FORCEFUL_HAND,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_FORCEFUL_HAND,oTarget)==FALSE) return SPELL_BIGBYS_FORCEFUL_HAND;
    else if (GetHasSpell(SPELL_FIREBRAND,oMe)>0) return SPELL_FIREBRAND;
    else if (GetHasSpell(SPELL_BALL_LIGHTNING,oMe)>0) return SPELL_BALL_LIGHTNING;
    else if (GetHasSpell(SPELL_BIGBYS_INTERPOSING_HAND,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BIGBYS_INTERPOSING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_INTERPOSING_HAND;
    else if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM,oMe)>0) return SPELL_ISAACS_LESSER_MISSILE_STORM;
    else if (GetHasSpell(SPELL_HAMMER_OF_THE_GODS,oMe)>0) return SPELL_HAMMER_OF_THE_GODS;
    else if (GetHasSpell(SPELL_BESTOW_CURSE,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BESTOW_CURSE,oTarget)==FALSE) return SPELL_BESTOW_CURSE;
    else if (GetHasSpell(SPELL_INFLICT_CRITICAL_WOUNDS,oMe)>0) return SPELL_INFLICT_CRITICAL_WOUNDS;
    else if (GetHasSpell(SPELL_WOUNDING_WHISPERS,oMe)>0) return SPELL_WOUNDING_WHISPERS;
    else if (GetHasSpell(SPELL_SEARING_LIGHT,oMe)>0) return SPELL_SEARING_LIGHT;
    else if (GetHasSpell(SPELL_SLOW,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_SLOW,oTarget)==FALSE) return SPELL_SLOW;
    else if (GetHasSpell(SPELL_QUILLFIRE,oMe)>0) return SPELL_QUILLFIRE;
    else if (GetHasSpell(SPELL_LIGHTNING_BOLT,oMe)>0&&d4()<3) return SPELL_LIGHTNING_BOLT;
    else if (GetHasSpell(SPELL_INFLICT_SERIOUS_WOUNDS,oMe)>0) return SPELL_INFLICT_SERIOUS_WOUNDS;
    else if (GetHasSpell(SPELL_SOUND_BURST,oMe)>0) return SPELL_SOUND_BURST;
    else if (GetHasSpell(SPELL_MELFS_ACID_ARROW,oMe)>0) return SPELL_MELFS_ACID_ARROW;
    else if (GetHasSpell(SPELL_GEDLEES_ELECTRIC_LOOP,oMe)>0) return SPELL_GEDLEES_ELECTRIC_LOOP;
    else if (GetHasSpell(SPELL_FLAME_LASH,oMe)>0) return SPELL_FLAME_LASH;
    else if (GetHasSpell(SPELL_INFLICT_MODERATE_WOUNDS,oMe)>0) return SPELL_INFLICT_MODERATE_WOUNDS;
    else if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_RAY_OF_ENFEEBLEMENT,oTarget)==FALSE) return SPELL_RAY_OF_ENFEEBLEMENT;
    else if (GetHasSpell(SPELL_MAGIC_MISSILE,oMe)>0) return SPELL_MAGIC_MISSILE;
    else if (GetHasSpell(SPELL_ICE_DAGGER,oMe)>0) return SPELL_ICE_DAGGER;
    else if (GetHasSpell(SPELL_DOOM,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_DOOM,oTarget)==FALSE) return SPELL_DOOM;
    else if (GetHasSpell(SPELL_INFLICT_LIGHT_WOUNDS,oMe)>0) return SPELL_INFLICT_LIGHT_WOUNDS;
    else if (GetHasSpell(SPELL_BURNING_HANDS,oMe)>0) return SPELL_BURNING_HANDS;
    else if (GetHasSpell(SPELL_BANE,oMe)>0&&d4()<3&&GetHasSpellEffect(SPELL_BANE,oTarget)==FALSE) return SPELL_BANE;
    else if (GetHasSpell(SPELL_RAY_OF_FROST,oMe)>0) return SPELL_RAY_OF_FROST;
    else if (GetHasSpell(SPELL_ELECTRIC_JOLT,oMe)>0) return SPELL_ELECTRIC_JOLT;
    else if (GetHasSpell(SPELL_ACID_SPLASH,oMe)>0) return SPELL_ACID_SPLASH;
    else if (GetHasSpell(SPELL_INFLICT_MINOR_WOUNDS,oMe)>0) return SPELL_INFLICT_MINOR_WOUNDS;
  } // other
  return 0;
} // caiProfessionalCloseQuarters()

int caiProfessionalOffensive(object oTarget)
{ // PURPOSE: Return offensive spells versus the target
  object oMe=OBJECT_SELF;
  int nRT=GetRacialType(oTarget);
  object oAlly;
  int bNoArea=FALSE;
  int nCT=fnGetCharmType(oTarget);
  if (GetDistanceBetween(oMe,oTarget)<3.1) return caiProfessionalCloseQuarters(oTarget);
  oAlly=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oTarget,1,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);
  if (GetIsObjectValid(oAlly)&&oAlly!=oMe&&GetIsFriend(oAlly)&&GetDistanceBetween(oTarget,oAlly)<6.0) bNoArea=TRUE;
  if (GetMaster(oTarget)!=oTarget&&GetIsObjectValid(GetMaster(oTarget))&&GetAssociateType(oTarget)==ASSOCIATE_TYPE_SUMMONED)
  { // summoned
    if (GetHasSpell(SPELL_BANISHMENT,oMe)>0&&d4()<3) return SPELL_BANISHMENT;
    else if (GetHasSpell(SPELL_DISMISSAL,oMe)>0&&d4()<3) return SPELL_DISMISSAL;
  } // summoned
  if (nRT==RACIAL_TYPE_UNDEAD||GetLocalInt(oTarget,"nIsVampire")==TRUE)
  { // undead
    if (bNoArea)
    { // no area spells
    } // no area spells
    else
    { // any spells
    } // any spells
  } // undead
  else if (nRT==RACIAL_TYPE_CONSTRUCT)
  { // construct
    if (bNoArea)
    { // no area spells
    } // no area spells
    else
    { // any spells
    } // any spells
  } // construct
  else
  { // other
    if (bNoArea)
    { // no area spells
    } // no area spells
    else
    { // any spells
      if (GetHasSpell(SPELL_METEOR_SWARM,oMe)>0) return SPELL_METEOR_SWARM;
      else if (GetHasSpell(SPELL_STORM_OF_VENGEANCE,oMe)>0) return SPELL_STORM_OF_VENGEANCE;
      else if (GetHasSpell(SPELL_IMPLOSION,oMe)>0) return SPELL_IMPLOSION;
      else if (GetHasSpell(SPELL_POWER_WORD_KILL,oMe)>0) return SPELL_POWER_WORD_KILL;
      else if (GetHasSpell(SPELL_WAIL_OF_THE_BANSHEE,oMe)>0) return SPELL_WAIL_OF_THE_BANSHEE;
      else if (GetHasSpell(SPELL_ENERGY_DRAIN,oMe)>0&&d4()<3) return SPELL_ENERGY_DRAIN;
      else if (GetHasSpell(SPELL_POWER_WORD_KILL,oMe)>0) return SPELL_POWER_WORD_KILL;
      else if (GetHasSpell(SPELL_BIGBYS_CRUSHING_HAND,oMe)>0&&GetHasSpellEffect(SPELL_BIGBYS_CRUSHING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_CRUSHING_HAND;
      else if (GetHasSpell(SPELL_DOMINATE_MONSTER,oMe)>0&&GetHasSpellEffect(SPELL_DOMINATE_MONSTER,oTarget)==FALSE&&nCT==CAI_CHARM_MONSTER) return SPELL_DOMINATE_MONSTER;
      else if (GetHasSpell(SPELL_SUNBURST,oMe)>0) return SPELL_SUNBURST;
      else if (GetHasSpell(SPELL_SUNBEAM,oMe)>0) return SPELL_SUNBEAM;
      else if (GetHasSpell(SPELL_INCENDIARY_CLOUD,oMe)>0) return SPELL_INCENDIARY_CLOUD;
      else if (GetHasSpell(SPELL_FIRE_STORM,oMe)>0) return SPELL_FIRE_STORM;
      else if (GetHasSpell(SPELL_EARTHQUAKE,oMe)>0) return SPELL_EARTHQUAKE;
      else if (GetHasSpell(SPELL_MASS_CHARM,oMe)>0&&GetHasSpellEffect(SPELL_MASS_CHARM,oTarget)==FALSE) return SPELL_MASS_CHARM;
      else if (GetHasSpell(SPELL_MASS_BLINDNESS_AND_DEAFNESS,oMe)>0&&GetHasSpellEffect(SPELL_MASS_BLINDNESS_AND_DEAFNESS,oTarget)==FALSE) return SPELL_MASS_BLINDNESS_AND_DEAFNESS;
      else if (GetHasSpell(SPELL_BIGBYS_CLENCHED_FIST,oMe)>0&&GetHasSpellEffect(SPELL_BIGBYS_CLENCHED_FIST,oTarget)==FALSE) return SPELL_BIGBYS_CLENCHED_FIST;
      else if (GetHasSpell(SPELL_HORRID_WILTING,oMe)>0) return SPELL_HORRID_WILTING;
      else if (GetHasSpell(SPELL_DELAYED_BLAST_FIREBALL,oMe)>0) return SPELL_DELAYED_BLAST_FIREBALL;
      else if (GetHasSpell(SPELL_FIRE_STORM,oMe)>0) return SPELL_FIRE_STORM;
      else if (GetHasSpell(SPELL_WORD_OF_FAITH,oMe)>0&&d4()<3) return SPELL_WORD_OF_FAITH;
      else if (GetHasSpell(SPELL_PRISMATIC_SPRAY,oMe)>0) return SPELL_PRISMATIC_SPRAY;
      else if (GetHasSpell(SPELL_POWER_WORD_STUN,oMe)>0&&d4()<3) return SPELL_POWER_WORD_STUN;
      else if (GetHasSpell(SPELL_FINGER_OF_DEATH,oMe)>0) return SPELL_FINGER_OF_DEATH;
      else if (GetHasSpell(SPELL_DESTRUCTION,oMe)>0) return SPELL_DESTRUCTION;
      else if (GetHasSpell(SPELL_CREEPING_DOOM,oMe)>0) return SPELL_CREEPING_DOOM;
      else if (GetHasSpell(SPELL_BIGBYS_GRASPING_HAND,oMe)>0&&GetHasSpellEffect(SPELL_BIGBYS_GRASPING_HAND,oTarget)==FALSE) return SPELL_BIGBYS_GRASPING_HAND;
      else if (GetHasSpell(SPELL_ACID_FOG,oMe)>0) return SPELL_ACID_FOG;
      else if (GetHasSpell(SPELL_BLADE_BARRIER,oMe)>0) return SPELL_BLADE_BARRIER;
      else if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM,oMe)>0) return SPELL_ISAACS_GREATER_MISSILE_STORM;
      else if (GetHasSpell(SPELL_CHAIN_LIGHTNING,oMe)>0) return SPELL_CHAIN_LIGHTNING;
      else if (GetHasSpell(SPELL_FLESH_TO_STONE,oMe)>0&&GetHasSpellEffect(SPELL_FLESH_TO_STONE,oTarget)==FALSE) return SPELL_FLESH_TO_STONE;
      else if (GetHasSpell(SPELL_BIGBYS_FORCEFUL_HAND,oMe)>0&&GetHasSpellEffect(SPELL_BIGBYS_FORCEFUL_HAND,oTarget)==FALSE) return SPELL_BIGBYS_FORCEFUL_HAND;


    } // any spells
  } // other
  return 0;
} // caiProfessionalOffensive()

object caiGetBestObjectToHeal(object oMe)
{
  int nN=1;

  object oBest=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_FRIEND,oMe,1,CREATURE_TYPE_IS_ALIVE,TRUE);
  if(GetIsObjectValid(oBest))
  {
    if(GetDistanceBetween(oMe,oBest) < 10.1)
    {
      oBest=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_FRIEND,oMe,d6(),CREATURE_TYPE_IS_ALIVE,TRUE);
      while((GetIsObjectValid(oBest)==FALSE||(GetDistanceBetween(oBest,oMe)<10.1&&GetDistanceBetween(oBest,oMe)!=0.0))&&nN<4)
      {
        nN++;
        oBest=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_FRIEND,oMe,d6(),CREATURE_TYPE_IS_ALIVE,TRUE);
      }

      if(GetIsObjectValid(oBest)==FALSE)
      {
        oBest=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_FRIEND,oMe,1,CREATURE_TYPE_IS_ALIVE,TRUE);
      }

      if(GetIsObjectValid(oBest))
      {
        nN=GetMaxHitPoints(oBest)-GetCurrentHitPoints(oBest);
        if((nN>0 || GetIsDead(oBest)))
        {
          return oBest;
        }
      }
      return OBJECT_INVALID;
    }
    return OBJECT_INVALID;
  }
  return OBJECT_INVALID;
}

//:: FUNCTIONS FROM Deva Bryson Winblood (RTS - Harvester Of Souls)
/******************************************************************************/

/******************************************************************************/
//:: FUNCTIONS FROM BIOWARE AND OLANDER

int WhatToDoAfterCasting(object oSelf)
{
  object oNearest = GetNearestSeenEnemy();

  if(GetIsObjectValid(oNearest))
  {
    ActionMoveAwayFromObject(oNearest, TRUE, 5.0);
    if (OAI_GetIsEnemy(oNearest))
      DelayCommand(2.0,DetermineCombatRound(oNearest));
    return TRUE;
  }

  return FALSE;
}

void UseSpellBuffs(object oCreature = OBJECT_SELF)
{
  SetBattleCondition(OAI_FAST_BUFF_COMPLETE,FALSE);
  SetBattleCondition(OAI_FAST_BUFF_RANDOM,FALSE);

  int iX;
  int HowMany = 0;
  int iCounter = 0;
  int iRandomMode;

  //Fast Buff Complete
  if(GetBattleCondition(OAI_FAST_BUFF_COMPLETE))
  {
    iRandomMode = FALSE;
    HowMany = 1;
    iCounter = 0;
  }

  //Fast Buff Random
  else if(GetBattleCondition(OAI_FAST_BUFF_RANDOM))
  {
    iRandomMode = TRUE;
    HowMany = ((Random(MyHD) + 1) / 4);
    if(HowMany > 4) HowMany = 4;
  }

  //Essential Buffs
  if(GetLevelByClass(CLASS_TYPE_BARD))
  {
    while (iCounter < HowMany)
    {
      iCounter++;
      if(iRandomMode) iX = Random(18);
      switch (iX)
      {
        case 0:  if(TrySpell(SPELL_AMPLIFY, OBJECT_SELF)) if(iRandomMode) break;
        case 1:  if(TrySpell(SPELL_BULLS_STRENGTH, OBJECT_SELF)) if(iRandomMode) break;
        case 2:  if(TrySpell(SPELL_CATS_GRACE, OBJECT_SELF)) if(iRandomMode) break;
        case 3:  if(TrySpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 4:  if(TrySpell(SPELL_CLARITY, OBJECT_SELF)) if(iRandomMode) break;
        case 5:  if(TrySpell(SPELL_DISPLACEMENT, OBJECT_SELF)) if(iRandomMode) break;
        case 6:  if(TrySpell(SPELL_EAGLE_SPLEDOR, OBJECT_SELF)) if(iRandomMode) break;
        case 7:  if(TrySpell(SPELL_ENERGY_BUFFER, OBJECT_SELF)) if(iRandomMode) break;
        case 8:  if(TrySpell(SPELL_ETHEREAL_VISAGE, OBJECT_SELF)) if(iRandomMode) break;
        case 9:  if(TrySpell(SPELL_FOXS_CUNNING, OBJECT_SELF)) if(iRandomMode) break;
        case 10: if(TrySpell(SPELL_GHOSTLY_VISAGE, OBJECT_SELF)) if(iRandomMode) break;
        case 11: if(TrySpell(SPELL_HASTE, OBJECT_SELF)) if(iRandomMode) break;
        case 12: if(TrySpell(SPELL_IMPROVED_INVISIBILITY, OBJECT_SELF)) if(iRandomMode) break;
        case 13: if(TrySpell(SPELL_INVISIBILITY, OBJECT_SELF)) if(iRandomMode) break;
        case 14: if(TrySpell(SPELL_MAGE_ARMOR, OBJECT_SELF)) if(iRandomMode) break;
        case 15: if(TrySpell(SPELL_OWLS_WISDOM, OBJECT_SELF)) if(iRandomMode) break;
        case 16: if(TrySpell(SPELL_RESISTANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 17: if(TrySpell(EFFECT_TYPE_ULTRAVISION, OBJECT_SELF)) if(iRandomMode) break;
      }
    }
    return;
  }

  //Essential Buffs
  if(GetLevelByClass(CLASS_TYPE_CLERIC))
  {
    while (iCounter < HowMany)
    {
      iCounter++;
      if(iRandomMode) iX = Random(23);
      switch (iX)
      {
        case 0:  if(TrySpell(SPELL_AID, OBJECT_SELF)) if(iRandomMode) break;
        case 1:  if(TrySpell(SPELL_BATTLETIDE, OBJECT_SELF)) if(iRandomMode) break;
        case 2:  if(TrySpell(SPELL_BLESS, OBJECT_SELF)) if(iRandomMode) break;
        case 3:  if(TrySpell(SPELL_BULLS_STRENGTH, OBJECT_SELF)) if(iRandomMode) break;
        case 4:  if(TrySpell(SPELL_CLARITY, OBJECT_SELF)) if(iRandomMode) break;
        case 5:  if(TrySpell(SPELL_DEATH_WARD, OBJECT_SELF)) if(iRandomMode) break;
        case 6:  if(TrySpell(SPELL_EAGLE_SPLEDOR, OBJECT_SELF)) if(iRandomMode) break;
        case 7:  if(TrySpell(SPELL_ENDURANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 8:  if(TrySpell(SPELL_ENDURE_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 9:  if(TrySpell(SPELL_ENTROPIC_SHIELD, OBJECT_SELF)) if(iRandomMode) break;
        case 10: if(TrySpell(SPELL_FOXS_CUNNING, OBJECT_SELF)) if(iRandomMode) break;
        case 11: if(TrySpell(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF)) if(iRandomMode) break;
        case 12: if(TrySpell(SPELL_OWLS_WISDOM, OBJECT_SELF)) if(iRandomMode) break;
        case 13: if(TrySpell(SPELL_PRAYER, OBJECT_SELF)) if(iRandomMode) break;
        case 14: if(TrySpell(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 15: if(TrySpell(SPELL_REGENERATE, OBJECT_SELF)) if(iRandomMode) break;
        case 16: if(TrySpell(SPELL_RESIST_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 17: if(TrySpell(SPELL_RESISTANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 18: if(TrySpell(SPELL_SHIELD_OF_FAITH, OBJECT_SELF)) if(iRandomMode) break;
        case 19: if(TrySpell(SPELL_SPELL_RESISTANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 20: if(TrySpell(SPELL_TRUE_SEEING, OBJECT_SELF)) if(iRandomMode) break;
        case 21: if(TrySpell(EFFECT_TYPE_ULTRAVISION, OBJECT_SELF)) if(iRandomMode) break;
        case 22: if(TrySpell(SPELL_VIRTUE, OBJECT_SELF)) if(iRandomMode) break;
      }
    }
    return;
  }

  //Essential Buffs
  if(GetLevelByClass(CLASS_TYPE_DRUID))
  {
    while (iCounter < HowMany)
    {
      iCounter++;
      if(iRandomMode) iX = Random(20);
      switch (iX)
      {
        case 0:  if(TrySpell(SPELL_AURA_OF_VITALITY, OBJECT_SELF)) if(iRandomMode) break;
        case 1:  if(TrySpell(SPELL_BARKSKIN, OBJECT_SELF)) if(iRandomMode) break;
        case 2:  if(TrySpell(SPELL_BULLS_STRENGTH, OBJECT_SELF)) if(iRandomMode) break;
        case 3:  if(TrySpell(SPELL_DEATH_WARD, OBJECT_SELF)) if(iRandomMode) break;
        case 4:  if(TrySpell(SPELL_ENDURE_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 5:  if(TrySpell(SPELL_ENERGY_BUFFER, OBJECT_SELF)) if(iRandomMode) break;
        case 6:  if(TrySpell(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF)) if(iRandomMode) break;
        case 7:  if(TrySpell(SPELL_GREATER_STONESKIN, OBJECT_SELF)) if(iRandomMode) break;
        case 8:  if(TrySpell(SPELL_ONE_WITH_THE_LAND, OBJECT_SELF)) if(iRandomMode) break;
        case 9:  if(TrySpell(438, OBJECT_SELF)) if(iRandomMode) break; //Owl's Insight
        case 10: if(TrySpell(SPELL_PREMONITION, OBJECT_SELF)) if(iRandomMode) break;
        case 11: if(TrySpell(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 12: if(TrySpell(SPELL_REGENERATE, OBJECT_SELF)) if(iRandomMode) break;
        case 13: if(TrySpell(SPELL_RESIST_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 14: if(TrySpell(SPELL_RESISTANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 15: if(TrySpell(SPELL_SPELL_RESISTANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 16: if(TrySpell(SPELL_STONESKIN, OBJECT_SELF)) if(iRandomMode) break;
        case 17: if(TrySpell(SPELL_TRUE_SEEING, OBJECT_SELF)) if(iRandomMode) break;
        case 18: if(TrySpell(EFFECT_TYPE_ULTRAVISION, OBJECT_SELF)) if(iRandomMode) break;
        case 19: if(TrySpell(SPELL_VIRTUE, OBJECT_SELF)) if(iRandomMode) break;
      }
    }
    return;
  }

  //Essential Buffs
  if(GetLevelByClass(CLASS_TYPE_PALADIN))
  {
    while (iCounter < HowMany)
    {
      iCounter++;
      if(iRandomMode) iX = Random(13);
      switch (iX)
      {
        case 0:  if(TrySpell(SPELL_AID, OBJECT_SELF)) if(iRandomMode) break;
        case 1:  if(TrySpell(SPELL_AURAOFGLORY, OBJECT_SELF)) if(iRandomMode) break;
        case 2:  if(TrySpell(SPELL_BLESS, OBJECT_SELF)) if(iRandomMode) break;
        case 3:  if(TrySpell(SPELL_BULLS_STRENGTH, OBJECT_SELF)) if(iRandomMode) break;
        case 4:  if(TrySpell(SPELL_CAMOFLAGE, OBJECT_SELF)) if(iRandomMode) break;
        case 5:  if(TrySpell(SPELL_DEATH_WARD, OBJECT_SELF)) if(iRandomMode) break;
        case 6:  if(TrySpell(SPELL_EAGLE_SPLEDOR, OBJECT_SELF)) if(iRandomMode) break;
        case 7:  if(TrySpell(SPELL_ENDURE_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 8:  if(TrySpell(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF)) if(iRandomMode) break;
        case 9:  if(TrySpell(SPELL_PRAYER, OBJECT_SELF)) if(iRandomMode) break;
        case 10: if(TrySpell(SPELL_RESIST_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 11: if(TrySpell(SPELL_RESISTANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 12: if(TrySpell(SPELL_VIRTUE, OBJECT_SELF)) if(iRandomMode) break;
      }
    }
    return;
  }

  //Essential Buffs
  if(GetLevelByClass(CLASS_TYPE_RANGER))
  {
    while (iCounter < HowMany)
    {
      iCounter++;
      if(iRandomMode) iX = Random(8);
      switch (iX)
      {
        case 0:  if(TrySpell(SPELL_AID, OBJECT_SELF)) if(iRandomMode) break;
        case 1:  if(TrySpell(SPELL_CAMOFLAGE, OBJECT_SELF)) if(iRandomMode) break;
        case 2:  if(TrySpell(SPELL_CATS_GRACE, OBJECT_SELF)) if(iRandomMode) break;
        case 3:  if(TrySpell(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF)) if(iRandomMode) break;
        case 4:  if(TrySpell(SPELL_ONE_WITH_THE_LAND, OBJECT_SELF)) if(iRandomMode) break;
        case 5:  if(TrySpell(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 6:  if(TrySpell(SPELL_RESIST_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 7:  if(TrySpell(EFFECT_TYPE_ULTRAVISION, OBJECT_SELF)) if(iRandomMode) break;
      }
    }
    return;
  }

  //Essential Buffs
  if(GetLevelByClass(CLASS_TYPE_SORCERER) || GetLevelByClass(CLASS_TYPE_WIZARD))
  {
    while (iCounter < HowMany)
    {
      iCounter++;
      if(iRandomMode) iX = Random(37);
      switch (iX)
      {
        case 0:  if(TrySpell(SPELL_BULLS_STRENGTH, OBJECT_SELF)) if(iRandomMode) break;
        case 1:  if(TrySpell(SPELL_CATS_GRACE, OBJECT_SELF)) if(iRandomMode) break;
        case 2:  if(TrySpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 3:  if(TrySpell(SPELL_CLARITY, OBJECT_SELF)) if(iRandomMode) break;
        case 4:  if(TrySpell(SPELL_DEATH_ARMOR, OBJECT_SELF)) if(iRandomMode) break;
        case 5:  if(TrySpell(SPELL_DISPLACEMENT, OBJECT_SELF)) if(iRandomMode) break;
        case 6:  if(TrySpell(SPELL_EAGLE_SPLEDOR, OBJECT_SELF)) if(iRandomMode) break;
        case 7:  if(TrySpell(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF)) if(iRandomMode) break;
        case 8:  if(TrySpell(SPELL_ENDURANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 9:  if(TrySpell(SPELL_ENDURE_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 10: if(TrySpell(SPELL_ENERGY_BUFFER, OBJECT_SELF)) if(iRandomMode) break;
        case 11: if(TrySpell(SPELL_ETHEREAL_VISAGE, OBJECT_SELF)) if(iRandomMode) break;
        case 12: if(TrySpell(SPELL_FOXS_CUNNING, OBJECT_SELF)) if(iRandomMode) break;
        case 13: if(TrySpell(SPELL_GHOSTLY_VISAGE, OBJECT_SELF)) if(iRandomMode) break;
        case 14: if(TrySpell(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF)) if(iRandomMode) break;
        case 15: if(TrySpell(SPELL_GREATER_STONESKIN, OBJECT_SELF)) if(iRandomMode) break;
        case 16: if(TrySpell(SPELL_HASTE, OBJECT_SELF)) if(iRandomMode) break;
        case 17: if(TrySpell(SPELL_IMPROVED_INVISIBILITY, OBJECT_SELF)) if(iRandomMode) break;
        case 18: if(TrySpell(SPELL_INVISIBILITY, OBJECT_SELF)) if(iRandomMode) break;
        case 19: if(TrySpell(SPELL_IRONGUTS, OBJECT_SELF)) if(iRandomMode) break;
        case 20: if(TrySpell(SPELL_LESSER_MIND_BLANK, OBJECT_SELF)) if(iRandomMode) break;
        case 21: if(TrySpell(SPELL_LESSER_SPELL_MANTLE, OBJECT_SELF)) if(iRandomMode) break;
        case 22: if(TrySpell(SPELL_MAGE_ARMOR, OBJECT_SELF)) if(iRandomMode) break;
        case 23: if(TrySpell(SPELL_MIND_BLANK, OBJECT_SELF)) if(iRandomMode) break;
        case 24: if(TrySpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, OBJECT_SELF)) if(iRandomMode) break;
        case 25: if(TrySpell(SPELL_OWLS_WISDOM, OBJECT_SELF)) if(iRandomMode) break;
        case 26: if(TrySpell(SPELL_PREMONITION, OBJECT_SELF)) if(iRandomMode) break;
        case 27: if(TrySpell(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 28: if(TrySpell(SPELL_PROTECTION_FROM_SPELLS, OBJECT_SELF)) if(iRandomMode) break;
        case 29: if(TrySpell(SPELL_RESIST_ELEMENTS, OBJECT_SELF)) if(iRandomMode) break;
        case 30: if(TrySpell(SPELL_RESISTANCE, OBJECT_SELF)) if(iRandomMode) break;
        case 31: if(TrySpell(SPELL_SHADOW_SHIELD, OBJECT_SELF)) if(iRandomMode) break;
        case 32: if(TrySpell(SPELL_SHIELD, OBJECT_SELF)) if(iRandomMode) break;
        case 33: if(TrySpell(SPELL_SPELL_MANTLE, OBJECT_SELF)) if(iRandomMode) break;
        case 34: if(TrySpell(SPELL_STONESKIN, OBJECT_SELF)) if(iRandomMode) break;
        case 35: if(TrySpell(SPELL_TRUE_SEEING, OBJECT_SELF)) if(iRandomMode) break;
        case 36: if(TrySpell(EFFECT_TYPE_ULTRAVISION, OBJECT_SELF)) if(iRandomMode) break;
      }
    }
    return;
  }
}

int OAI_AdvancedBuff(float fDistance, int bInstant = TRUE)
{
  SetBattleCondition(OAI_FAST_BUFF_ADVANCED,FALSE);

  object oNPC = GetNearestEnemy();
  if(GetIsObjectValid(oNPC))
  {
    if(GetDistanceToObject(oNPC) <= fDistance)
    {
      if(!GetIsFighting(OBJECT_SELF))
      {
        ClearAllActions();

        //Combat Protections
        if(GetHasSpell(SPELL_PREMONITION) && !GetHasSpellEffect(SPELL_PREMONITION))
        {
          ActionCastSpellAtObject(SPELL_PREMONITION, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_GREATER_STONESKIN)&& !GetHasSpellEffect(SPELL_GREATER_STONESKIN))
        {
          ActionCastSpellAtObject(SPELL_GREATER_STONESKIN, OBJECT_SELF, METAMAGIC_NONE, 0, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_STONESKIN)&& !GetHasSpellEffect(SPELL_STONESKIN))
        {
          ActionCastSpellAtObject(SPELL_STONESKIN, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }

        //Visage Protections
        if(GetHasSpell(SPELL_SHADOW_SHIELD)&& !GetHasSpellEffect(SPELL_SHADOW_SHIELD))
        {
          ActionCastSpellAtObject(SPELL_SHADOW_SHIELD, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_ETHEREAL_VISAGE)&& !GetHasSpellEffect(SPELL_ETHEREAL_VISAGE))
        {
          ActionCastSpellAtObject(SPELL_ETHEREAL_VISAGE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_GHOSTLY_VISAGE)&& !GetHasSpellEffect(SPELL_GHOSTLY_VISAGE))
        {
          ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }

        //Mantle Protections
        if(GetHasSpell(SPELL_GREATER_SPELL_MANTLE)&& !GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE))
        {
          ActionCastSpellAtObject(SPELL_GREATER_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SPELL_MANTLE)&& !GetHasSpellEffect(SPELL_SPELL_MANTLE))
        {
          ActionCastSpellAtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_LESSER_SPELL_BREACH)&& !GetHasSpellEffect(SPELL_LESSER_SPELL_BREACH))
        {
          ActionCastSpellAtObject(SPELL_LESSER_SPELL_BREACH, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }

        // Globes
        if(GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY)&& !GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY))
        {
          ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY)&& !GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY))
        {
          ActionCastSpellAtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }

        //Misc Protections
        if(GetHasSpell(SPELL_ELEMENTAL_SHIELD)&& !GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD))
        {
          ActionCastSpellAtObject(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if (GetHasSpell(SPELL_MESTILS_ACID_SHEATH)&& !GetHasSpellEffect(SPELL_MESTILS_ACID_SHEATH))
        {
          ActionCastSpellAtObject(SPELL_MESTILS_ACID_SHEATH, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if (GetHasSpell(SPELL_DEATH_ARMOR)&& !GetHasSpellEffect(SPELL_DEATH_ARMOR))
        {
          ActionCastSpellAtObject(SPELL_DEATH_ARMOR, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }

        //Elemental Protections
        if(GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS)&& !GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS))
        {
          ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_RESIST_ELEMENTS)&& !GetHasSpellEffect(SPELL_RESIST_ELEMENTS))
        {
          ActionCastSpellAtObject(SPELL_RESIST_ELEMENTS, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_ENDURE_ELEMENTS)&& !GetHasSpellEffect(SPELL_ENDURE_ELEMENTS))
        {
          ActionCastSpellAtObject(SPELL_ENDURE_ELEMENTS, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }

        //Mental Protections
        if(GetHasSpell(SPELL_MIND_BLANK)&& !GetHasSpellEffect(SPELL_MIND_BLANK))
        {
          ActionCastSpellAtObject(SPELL_MIND_BLANK, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_LESSER_MIND_BLANK)&& !GetHasSpellEffect(SPELL_LESSER_MIND_BLANK))
        {
          ActionCastSpellAtObject(SPELL_LESSER_MIND_BLANK, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_CLARITY)&& !GetHasSpellEffect(SPELL_CLARITY))
        {
          ActionCastSpellAtObject(SPELL_CLARITY, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }

        //Summon Ally
        if(GetHasSpell(SPELL_BLACK_BLADE_OF_DISASTER))
        {
          ActionCastSpellAtLocation(SPELL_BLACK_BLADE_OF_DISASTER, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_IX))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_IX, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_VIII))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_VIII, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_VII))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_VII, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_VI))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_VI, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_V))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_V, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_IV))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_IV, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_III))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_III, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_II))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_II, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }
        else if(GetHasSpell(SPELL_SUMMON_CREATURE_I))
        {
          ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_I, GetLocation(OBJECT_SELF), METAMAGIC_NONE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
        }

        return TRUE;
      }
    }
  }

  return FALSE;
}

void CastAuras()
{
  TrySpell(SPELLABILITY_AURA_MENACE, OBJECT_SELF);
  TrySpell(SPELLABILITY_AURA_UNNATURAL, OBJECT_SELF);
  TrySpell(SPELLABILITY_TYRANT_FOG_MIST, OBJECT_SELF);

  TrySpell(SPELLABILITY_AURA_FIRE, OBJECT_SELF);
  TrySpell(SPELLABILITY_AURA_ELECTRICITY, OBJECT_SELF);
  TrySpell(SPELLABILITY_AURA_COLD, OBJECT_SELF);
  TrySpell(SPELLABILITY_AURA_FEAR, OBJECT_SELF);
  TrySpell(SPELLABILITY_AURA_PROTECTION, OBJECT_SELF);

  TrySpell(SPELLABILITY_AURA_BLINDING, OBJECT_SELF);
  TrySpell(SPELLABILITY_AURA_STUN, OBJECT_SELF);

  TrySpell(SPELLABILITY_AURA_UNEARTHLY_VISAGE, OBJECT_SELF);
  TrySpell(SPELLABILITY_DRAGON_FEAR, OBJECT_SELF);

  SetBattleCondition(OAI_CAST_AURAS_NOW,FALSE);
}

int OAI_UseTurning()
{
  int nCount;
  if(GetHasFeat(FEAT_TURN_UNDEAD))
  {
    object oUndead = GetNearestPerceivedEnemy();
    int nHD = GetHitDice(oUndead);
    if(GetHasEffect(EFFECT_TYPE_TURNED, oUndead) || GetHitDice(OBJECT_SELF) <= nHD) return FALSE;

    int nElemental = GetHasFeat(FEAT_AIR_DOMAIN_POWER)
        + GetHasFeat(FEAT_EARTH_DOMAIN_POWER)
        + GetHasFeat(FEAT_FIRE_DOMAIN_POWER)
        + GetHasFeat(FEAT_WATER_DOMAIN_POWER);

    int nVermin = GetHasFeat(FEAT_PLANT_DOMAIN_POWER)
        + GetHasFeat(FEAT_ANIMAL_COMPANION);

    int nConstructs = GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER);

    int nOutsider = GetHasFeat(FEAT_GOOD_DOMAIN_POWER)
        + GetHasFeat(FEAT_EVIL_DOMAIN_POWER)
        + GetHasFeat(854);// planar turning

    if(nElemental == TRUE) nCount += GetRacialTypeCount(RACIAL_TYPE_ELEMENTAL);

    if(nVermin == TRUE) nCount += GetRacialTypeCount(RACIAL_TYPE_VERMIN);

    if(nOutsider == TRUE) nCount += GetRacialTypeCount(RACIAL_TYPE_OUTSIDER);

    if(nConstructs == TRUE) nCount += GetRacialTypeCount(RACIAL_TYPE_CONSTRUCT);

    nCount += GetRacialTypeCount(RACIAL_TYPE_UNDEAD);

    if(nCount > 0)
    {
      ClearAllActions();
      ActionUseFeat(FEAT_TURN_UNDEAD, OBJECT_SELF);
      return TRUE;
    }
  }
  return FALSE;
}

void OAI_Fighting(object oTarget)
{
  switch(Random(64))
  {
    case 0: PlayVoiceChat(VOICE_CHAT_TAUNT); break;
    case 1: PlayVoiceChat(VOICE_CHAT_THREATEN); break;
    case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
    case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
    case 4: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
    case 5: PlayVoiceChat(VOICE_CHAT_GATTACK1); break;
    case 6: PlayVoiceChat(VOICE_CHAT_GATTACK2); break;
    case 7: PlayVoiceChat(VOICE_CHAT_GATTACK3); break;
  }

  int nAC = GetAC(oTarget);
  float fAttack;
  int nAttack = GetHitDice(OBJECT_SELF);

  fAttack = (IntToFloat(nAttack) * 0.75) + IntToFloat(GetAbilityModifier(ABILITY_STRENGTH));
  int nDiff = nAC - nAttack;

  ClearAllActions();
  if(OAI_IsOutOfAmmo()) OAI_EquipAppropriateWeapons(oTarget);

  if(GetBattleCondition(OAI_BLINK_SELF))
  {
    if(Random(100) >= GetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE")) OAI_BlinkMelee(oTarget);
  }

  //For Harpers
  if(GetHasFeat(FEAT_TYMORAS_SMILE) && !GetHasSpellEffect(478))
  {
    ActionUseFeat(FEAT_TYMORAS_SMILE, OBJECT_SELF);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_TYMORAS_SMILE);
  }

  //For Smiters
  if(GetStatusCondition(OAI_I_CAN_SMITE_MELEE))
  {
    if(GetDistanceToObject(oTarget) < 5.0 && d3() == 1)
    {
      OAI_MeleeSmite(oTarget);
      return;
    }
  }

  //For Divine Combat
  if(GetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE))
  {
    if(GetDistanceToObject(oTarget) < 5.0 && d2() == 1)
    {
      OAI_MeleeDivine(oTarget);
      return;
    }
  }

  //For the Ambushers
  if(GetStatusCondition(OAI_I_CAN_SNEAK_MELEE))
  {
    if(GetDistanceToObject(oTarget) < 5.0 && d2() == 1)
    {
      OAI_MeleeSneak(oTarget);
      return;
    }
  }

  //For the Weaponmasters
  if(GetStatusCondition(OAI_I_CAN_WM_MELEE))
  {
    if(GetDistanceToObject(oTarget) < 5.0 && d2() == 1)
    {
      OAI_MeleeWeaponMaster(oTarget);
      return;
    }
  }

  //Palemasters Always Try to Fight like a Palemaster
  if(GetStatusCondition(OAI_I_CAN_PM_MELEE)){ OAI_MeleePalemaster(oTarget); return;}

  //For the Red Dragon Disciples
  if(GetStatusCondition(OAI_I_CAN_RDD_MELEE))
  {
    if(GetDistanceToObject(oTarget) < 5.0 && d2() == 1)
    {
      OAI_MeleeRDD(oTarget);
      return;
    }
  }

  //Shifters Always Fight Like a Shifter
  if(GetStatusCondition(OAI_I_CAN_SHIFTER_MELEE)){ OAI_MeleeShifter(oTarget); return;}

  //For Ranged Attacks
  if(GetStatusCondition(OAI_I_CAN_FIGHT_RANGED))
  {
    if(GetDistanceToObject(oTarget) > 5.0 || GetHasFeat(FEAT_POINT_BLANK_SHOT))
    {
      OAI_RangedCombat(oTarget);
      return;
    }
  }

  //Monks Always Fight Like Monks
  if(GetStatusCondition(OAI_I_CAN_MONK_MELEE)){ OAI_MeleeMonk(oTarget); return;}

  //General Fight Stuff
  OAI_MeleeGeneral(oTarget);
}

void OAI_SummonHordes()
{
  string sResRef = GetLocalString(OBJECT_SELF, "OAI_SUMMON");
  if(GetStringLength(sResRef) < 1) return;
  if(Random(100) < GetLocalInt(OBJECT_SELF, "OAI_SUMMON_FAILURE")) return;
  int iX, iY;
  vector vMe = GetPosition(OBJECT_SELF);
  while(iX==0 && iY==0)
  {
    iX = (Random(3) - 1) * 15;
    iY = (Random(3) - 1) * 15;
  }
  vMe.x += IntToFloat(iX);
  vMe.y += IntToFloat(iY);
  location lNew = Location(oArea, vMe, GetFacing(OBJECT_SELF));
  object oNew = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lNew);
  ExecuteScript("oai_entercombat", oNew);
}

int OAI_CastRezOn(object oTarget)
{
  if(GetHasSpell(SPELL_RESURRECTION, oTarget))
  {
    ActionCastSpellAtObject(SPELL_RESURRECTION, oTarget);
    if(d2() == 1) ActionDoCommand(PlayVoiceChat(VOICE_CHAT_THANKS, oTarget));
    return TRUE;
  }
  if(GetHasSpell(SPELL_RAISE_DEAD, oTarget))
  {
    ActionCastSpellAtObject(SPELL_RAISE_DEAD, oTarget);
    if(d2() == 1) ActionDoCommand(PlayVoiceChat(VOICE_CHAT_THANKS, oTarget));
    return TRUE;
  }

  //No Spells...So Nor More Checks
  SetStatusCondition(OAI_I_CAN_RAISE_DEAD, FALSE);
  return FALSE;
}

int OAI_DetermineAllyToRez()
{
  if(!GetStatusCondition(OAI_I_CAN_RAISE_DEAD)) return FALSE;
  object oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, FALSE);

  //For Henchman Death Objects
  string sDOTag = GetTag(oAlly);
  if(sDOTag == "HB_HenchDead")
  {
    if(OAI_CastRezOn(oAlly)) return TRUE;
    return FALSE;
  }

  if(GetIsObjectValid(oAlly) && GetDistanceToObject(oAlly) < 30.0)
  {
    if(OAI_CastRezOn(oAlly)) return TRUE;
  }
  return FALSE;
}

void OAI_CastTriggers()
{
  if(GetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST)) return;
  SetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST);

  //Battlecries!
  switch (Random(12))
  {
    case 0: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
    case 1: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
    case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
    case 3: PlayVoiceChat(VOICE_CHAT_ATTACK); break;
  }

  //Setting the following variable automatically casts the auras
  if(GetBattleCondition(OAI_CAST_AURAS_NOW)) CastAuras();

  //Buffing Flags
  if(GetBattleCondition(OAI_FAST_BUFF_COMPLETE)) UseSpellBuffs();
  if(GetBattleCondition(OAI_FAST_BUFF_ADVANCED)) OAI_AdvancedBuff(40.0);
  if(GetBattleCondition(OAI_FAST_BUFF_RANDOM)) UseSpellBuffs();

  //Cast Summoning Creature
  if(GetBattleCondition(OAI_FAST_BUFF_SUMMON))
  {
    if(TalentSummonAllies() == TRUE) { SetStatusCondition(OAI_I_CAN_SUMMON, FALSE); }
    else SetStatusCondition(OAI_I_CAN_SUMMON, FALSE);
  }

  //If the NPC Has Polymorph it Will Do It
  if(!GetHasEffect(EFFECT_TYPE_POLYMORPH, OBJECT_SELF))
  {
    if(GetStatusCondition(OAI_I_CAN_POLYMORPH))
    {
      //Shifters Do Their Own Thing
      if(!GetStatusCondition(OAI_I_CAN_SHIFTER_MELEE))
      {
        //Manual Shapechange Setting
        int nPoly = GetLocalInt(OBJECT_SELF, "OAI_SHAPECHANGE");
        if(nPoly > 0)
        {
          effect eShape = SupernaturalEffect(EffectPolymorph(GetLocalInt(OBJECT_SELF, "OAI_SHAPECHANGE") - 1));
          effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
          DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eShape, OBJECT_SELF));
          DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF)));
          DeleteLocalInt(OBJECT_SELF, "OAI_SHAPECHANGE");
          SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
        }
        else
        {
          if(TrySpell(SPELL_POLYMORPH_SELF))
          {
            SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
          }
        }
      }
    }
  }
}

int OAI_IsUnderMeleeAttack(object oWho = OBJECT_SELF)
{
  int nNth = 1;
  object oTarget = GetNearestEnemy(oWho,nNth);
  while(GetIsObjectValid(oTarget) && GetDistanceBetween(oWho, oTarget) < 3.0)
  {
    nNth++;
    if(GetAttackTarget(oTarget) == oWho) return TRUE;
    oTarget = GetNearestEnemy(oWho,nNth);
  }
  return FALSE;
}

int OAI_ManageEnemyAOE()
{
  object oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT);
  if(!GetIsObjectValid(oAOE) || GetDistanceToObject(oAOE) > 40.0) return FALSE;
  object oO = GetAreaOfEffectCreator(oAOE);

  if(GetIsObjectValid(oO) && !GetIsEnemy(oO))
  {
    oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, OBJECT_SELF, 2);
    if(!GetIsObjectValid(oAOE) || GetDistanceToObject(oAOE) > 40.0) return FALSE;
    object oO = GetAreaOfEffectCreator(oAOE);
    if(GetIsObjectValid(oO) && !GetIsEnemy(oO))
    {
      oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, OBJECT_SELF, 3);
      if(!GetIsObjectValid(oAOE) || GetDistanceToObject(oAOE) > 40.0) return FALSE;
      object oO = GetAreaOfEffectCreator(oAOE);
      if(GetIsObjectValid(oO) && !GetIsEnemy(oO)) return FALSE;
    }
  }

  location lTarget = GetLocation(oAOE);

  if(GetHasSpell(SPELL_GUST_OF_WIND, OBJECT_SELF))
  {
    ActionCastSpellAtLocation(SPELL_GUST_OF_WIND,lTarget);
    ActionDoCommand(DetermineCombatRound());
    return TRUE;
  }

  if(GetHasSpell(SPELL_MORDENKAINENS_DISJUNCTION, OBJECT_SELF))
  {
    ActionCastSpellAtLocation(SPELL_MORDENKAINENS_DISJUNCTION,lTarget);
    ActionDoCommand(DetermineCombatRound());
    return TRUE;
  }

  if(GetHasSpell(SPELL_GREATER_DISPELLING, OBJECT_SELF))
  {
    ActionCastSpellAtLocation(SPELL_GREATER_DISPELLING,lTarget);
    ActionDoCommand(DetermineCombatRound());
    return TRUE;
  }

  if(GetHasSpell(SPELL_DISPEL_MAGIC, OBJECT_SELF))
  {
    ActionCastSpellAtLocation(SPELL_DISPEL_MAGIC,lTarget);
    ActionDoCommand(DetermineCombatRound());
    return TRUE;
  }

  if(GetHasSpell(SPELL_LESSER_DISPEL, OBJECT_SELF))
  {
    ActionCastSpellAtLocation(SPELL_LESSER_DISPEL,lTarget);
    ActionDoCommand(DetermineCombatRound());
    return TRUE;
  }
  return FALSE;
}

int OAI_DragonWingBuffet(object oFoe)
{
  if(GetCreatureSize(oFoe) == CREATURE_SIZE_HUGE
    || GetDistanceToObject(oFoe) > RADIUS_SIZE_GARGANTUAN) return FALSE;

  location lSelf = GetLocation(OBJECT_SELF);

  effect eKnockDown = EffectKnockdown();
  int nDC = GetHitDice(OBJECT_SELF);
  int nDamage = Random(nDC) * 3;

  effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
  effect eBuffet = EffectAppear();
  effect eFlyWind = EffectVisualEffect(VFX_IMP_PULSE_WIND);
  effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
  float fDelay;

  //Buffet
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eBuffet, OBJECT_SELF);

  //Gust of wind effect
  DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFlyWind, lSelf));

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lSelf);
  while(GetIsObjectValid(oTarget))
  {
    fDelay = GetDistanceToObject(oTarget)/20.0;
    if(!GetIsFriend(oTarget))
    {
      if(GetCreatureSize(oTarget) < CREATURE_SIZE_HUGE)
      {
        if(!ReflexSave(oTarget, nDC))
        {
          FloatingTextStringOnCreature("**Dragon Winged Buffet!!!**",oTarget);
          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oTarget));
          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockDown, oTarget, 6.0));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lSelf);
  }

  return TRUE;
}

int OAI_DragonStomp(object oFoe)
{
  location lFly = GetLocation(OBJECT_SELF);
  location lFlyTo = GetLocation(oFoe);

  effect eKnockDown = EffectKnockdown();
  int nDC = GetHitDice(OBJECT_SELF);
  int nDamage = Random(nDC) * 6;

  effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
  effect eFly = EffectDisappearAppear(lFlyTo);
  effect eFlyWind = EffectVisualEffect(VFX_IMP_PULSE_WIND);
  effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
  float fDelay = 4.0;

  //Fly To Target
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFly, OBJECT_SELF, fDelay);

  //Gust of wind effect
  DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFlyWind, lFly));

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lFlyTo);
  while(GetIsObjectValid(oTarget))
  {
    if(!GetIsFriend(oTarget))
    {
      if(!ReflexSave(oTarget, nDC))
      {
        FloatingTextStringOnCreature("**Dragon Stomp!!!**",oTarget);
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockDown, oTarget, 12.0));
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lFlyTo);
  }

  return TRUE;
}

int OAI_Dragons(object oFoe)
{
  int nWing = GetLocalInt(OBJECT_SELF, "OAI_WING_BUFFET");
  nWing++;
  SetLocalInt(OBJECT_SELF, "OAI_WING_BUFFET", nWing);

  int nStomp = GetLocalInt(OBJECT_SELF, "OAI_DRAGON_STOMP");
  nStomp++;
  SetLocalInt(OBJECT_SELF, "OAI_DRAGON_STOMP", nStomp);

  switch (Random(64))
  {
    case 0: PlayVoiceChat(VOICE_CHAT_TAUNT); break;
    case 1: PlayVoiceChat(VOICE_CHAT_THREATEN); break;
    case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
    case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
    case 4: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
    case 5: PlayVoiceChat(VOICE_CHAT_GATTACK1); break;
    case 6: PlayVoiceChat(VOICE_CHAT_GATTACK2); break;
    case 7: PlayVoiceChat(VOICE_CHAT_GATTACK3); break;
  }

  //Anti-Undead Combat
  if(GetRacialType(oFoe) == RACIAL_TYPE_UNDEAD)
  {
    if(TrySpell(SPELL_MASS_HEAL,oFoe)) return TRUE;
    if(TrySpell(SPELL_HEAL,oFoe)) return TRUE;
    if(TrySpell(SPELL_CURE_CRITICAL_WOUNDS,oFoe)) return TRUE;
    if(TrySpell(SPELL_CURE_SERIOUS_WOUNDS,oFoe)) return TRUE;
    if(TrySpell(SPELL_CURE_MODERATE_WOUNDS,oFoe)) return TRUE;
  }

  if(TalentAdvancedProtectSelf() == TRUE) return TRUE;

  //Dragon Winged Buffet
  if(nWing > 20)
  {
    SetLocalInt(OBJECT_SELF, "OAI_WING_BUFFET", 0);

    if(OAI_DragonWingBuffet(oFoe))
    {
      DetermineCombatRound(oFoe);
      return TRUE;
    }
  }

  //Dragon Stomp/Crush
  float fStomp = GetDistanceBetween(OBJECT_SELF,oFoe);
  if(nStomp > 30 && fStomp > 20.0)
  {
    SetLocalInt(OBJECT_SELF, "OAI_DRAGON_STOMP", 0);

    if(OAI_DragonStomp(oFoe)) return TRUE;
  }

  if(TalentDragonCombat(oFoe) == TRUE)
  {
    DetermineCombatRound(oFoe);
    return TRUE;
  }

  DetermineCombatRound(oFoe);

  return TRUE;
}

void OAI_Beholders(object oFoe)
{
  int D2 = d2();

  switch (Random(64))
  {
    case 0: PlayVoiceChat(VOICE_CHAT_TAUNT); break;
    case 1: PlayVoiceChat(VOICE_CHAT_THREATEN); break;
    case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
    case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
    case 4: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
    case 5: PlayVoiceChat(VOICE_CHAT_GATTACK1); break;
    case 6: PlayVoiceChat(VOICE_CHAT_GATTACK2); break;
    case 7: PlayVoiceChat(VOICE_CHAT_GATTACK3); break;
  }

  //Special Beholder Attacks
  if(D2 == 1 && (GetHasSpell(SPELLABILITY_EYEBALL_COLD_RAY)
    || GetHasSpell(SPELLABILITY_EYEBALL_WOUND_RAY)
    || GetHasSpell(SPELLABILITY_EYEBALL_FIRE_RAY)))
  {
     OAI_EyeballRayAttack(oFoe);
     return;
  }

  if(D2 == 2 && (GetHasSpell(SPELLABILITY_BEHOLDER_SPECIAL_SPELL_AI)))
  {
    OAI_BeholderRayAttack(oFoe);
    return;
  }

  //Get the Auras Up
  CastAuras();

  //Spells
  DetermineCombatRound(oFoe);
}

void OAI_EyeballRayAttack(object oTarget = OBJECT_SELF)
{
  if(!GetHasSpell(SPELLABILITY_EYEBALL_COLD_RAY)
    && !GetHasSpell(SPELLABILITY_EYEBALL_WOUND_RAY)
    && !GetHasSpell(SPELLABILITY_EYEBALL_FIRE_RAY))
      return;

  int nMax = d3();
  int nNum,nRay;
  int nTally = 1;

  //Try to fire a randomly chosen ray.
  while(nTally <= nMax)
  {
    nNum = d3();
    switch(nNum)
    {
      case 1: nRay = SPELLABILITY_EYEBALL_COLD_RAY; break;
      case 2: nRay = SPELLABILITY_EYEBALL_WOUND_RAY; break;
      case 3: nRay = SPELLABILITY_EYEBALL_FIRE_RAY; break;
    }

    nTally++;

    if(TrySpell(nRay, oTarget)) return;
  }
}

void OAI_BeholderRayAttack(object oTarget = OBJECT_SELF)
{
  if(!GetHasSpell(SPELLABILITY_BEHOLDER_SPECIAL_SPELL_AI)) return;

  TrySpell(SPELLABILITY_BEHOLDER_ANTIMAGIC_CONE, oTarget);

  int nMax = d3();
  int nNum,nRay;
  int nTally = 1;

  //Try to fire a randomly chosen ray.
  while(nTally <= nMax)
  {
    nNum = Random(7) + 1;
    switch(nNum)
    {
      case 1: nRay = SPELLABILITY_BEHOLDER_DEATH_RAY; break;
      case 2: nRay = SPELLABILITY_BEHOLDER_SLOW_RAY; break;
      case 3: nRay = SPELLABILITY_BEHOLDER_PETRIFY_RAY; break;
      case 4: nRay = SPELLABILITY_BEHOLDER_KNOCKDOWN_RAY; break;
      case 5: nRay = SPELLABILITY_BEHOLDER_CHARM_RAY; break;
      case 6: nRay = SPELLABILITY_BEHOLDER_WOUND_RAY; break;
      case 7: nRay = SPELLABILITY_BEHOLDER_FEAR_RAY; break;
    }

    nTally++;

    if(TrySpell(nRay, oTarget)) return;
  }

  DecrementRemainingSpellUses(OBJECT_SELF, SPELLABILITY_BEHOLDER_SPECIAL_SPELL_AI);
}

int OAI_JumpCreature(object oFoe)
{
  location lJump = GetLocation(OBJECT_SELF);
  location lJumpTo = GetLocation(oFoe);

  effect eJump = EffectDisappearAppear(lJumpTo);
  effect eJumpWind = EffectVisualEffect(VFX_IMP_PULSE_WIND);
  float fDelay = 3.0;

  //Jump to Enemy
  ClearAllActions();
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eJump, OBJECT_SELF, fDelay);

  //Gust of wind effect
  DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eJumpWind, lJump));

  DetermineCombatRound(oFoe);

  return TRUE;
}

int OAI_WingedCreature(object oFoe)
{
  //Fly to Enemy
  float fFly = GetDistanceBetween(OBJECT_SELF,oFoe);
  if(fFly > 20.0)
  {
    location lFly = GetLocation(OBJECT_SELF);
    location lFlyTo = GetLocation(oFoe);

    effect eFly = EffectDisappearAppear(lFlyTo);
    effect eFlyWind = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    float fDelay = 4.0;

    //Fly To Target
    ClearAllActions();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFly, OBJECT_SELF, fDelay);

    //Gust of wind effect
    DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFlyWind, lFly));

    return TRUE;
  }

  DetermineCombatRound(oFoe);

  return TRUE;
}

/******************************************************************************/
//:: OAI CUBE, OOZES, SLIMES, PUDDINGS

void OAI_GelatinousCube(object oFoe)
{
  if(OAI_CheckEngulf(oFoe)) return;

  DetermineCombatRound(oFoe);
}

int OAI_CheckEngulf(object oTarget = OBJECT_SELF)
{
  if(!OAI_GetIsTargetInMeleeRange(oTarget)) return FALSE;

  //Move directly on top of target.
  ClearAllActions();
  ActionMoveToLocation(GetLocation(oTarget),TRUE);
  ActionDoCommand(OAI_Engulf());

  return TRUE;
}

int  OAI_DoCubeParalyze(object oTarget, object oSource, int nSaveDC = 16)
{
  if(GetIsImmune(oTarget,IMMUNITY_TYPE_PARALYSIS) )
  {
    return FALSE;
  }

  if(FortitudeSave(oTarget,nSaveDC, SAVING_THROW_TYPE_POISON,oSource) == 0)
  {
    effect ePara =  EffectParalyze();
    effect eDur = EffectVisualEffect(VFX_DUR_PARALYZED);
    ePara = EffectLinkEffects(eDur,ePara);
    ePara = EffectLinkEffects(EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),ePara);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePara,oTarget,RoundsToSeconds(3+d3())); // not 3 d6, thats not fun
    return TRUE;
  }
  else
  {
    effect eSave = EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSave,oTarget);
  }

  return FALSE;
}

void OAI_EngulfAndDamage(object oTarget, object oSource)
{
  if (ReflexSave(oTarget, 13 + GetHitDice(oSource) - 4, SAVING_THROW_TYPE_NONE,oSource) == 0)
  {
    FloatingTextStrRefOnCreature(84610,oTarget); // * Engulfed
    int nDamage = d6(1);

    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
    if(!GetIsImmune(oTarget,IMMUNITY_TYPE_PARALYSIS) )
    {
      if(OAI_DoCubeParalyze(oTarget,oSource,16))
      {
        FloatingTextStrRefOnCreature(84609,oTarget);
      }
    }
  }
  else
  {
    effect eSave = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSave,oTarget);
  }
}

void OAI_Engulf()
{
  location lLoc = GetLocation(OBJECT_SELF);

  object oVictim = GetFirstObjectInShape(SHAPE_CUBE,4.0f,lLoc,TRUE, OBJECT_TYPE_CREATURE);
  while (GetIsObjectValid(oVictim))
  {
    if(oVictim != OBJECT_SELF)
    {
      OAI_EngulfAndDamage(oVictim,OBJECT_SELF);
    }
    oVictim = GetNextObjectInShape(SHAPE_CUBE,4.0f,lLoc,TRUE, OBJECT_TYPE_CREATURE);
  }
}

void OAI_DoOozeSplit(object oCreature)
{
  int nApp = GetAppearanceType(oCreature);
  string sResRef = GetResRef(oCreature);
  int nHitDice = GetHitDice(oCreature);
  int nDamage; int nNewApp;

  effect ePoof1 = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);
  effect ePoof2 = EffectVisualEffect(VFX_COM_CHUNK_GREEN_SMALL);
  effect eLevelDown, eDamage;

  object oClone1;
  object oClone2;

  location lSpawn = GetLocation(oCreature);

  int nNoSplit = FALSE;

  //Find Next Size Down
  if(nApp == 393) nNoSplit = TRUE;
  if(nApp == 394) nNewApp = 396;
  if(nApp == 396) nNewApp = 398;
  if(nApp == 394) nNoSplit = TRUE;
  if(nApp == 1455) nNewApp = 1454;
  if(nApp == 1454) nNewApp = 1453;
  if(nApp == 1453) nNoSplit = TRUE;
  if(nApp == 1458) nNewApp = 1457;
  if(nApp == 1457) nNewApp = 1456;
  if(nApp == 1456) nNoSplit = TRUE;
  if(nApp == 1461) nNewApp = 1460;
  if(nApp == 1460) nNewApp = 1459;
  if(nApp == 1459) nNoSplit = TRUE;
  if(nApp == 1464) nNewApp = 1463;
  if(nApp == 1463) nNewApp = 1462;
  if(nApp == 1462) nNoSplit = TRUE;
  if(nApp == 1467) nNewApp = 1466;
  if(nApp == 1466) nNewApp = 1465;
  if(nApp == 1465) nNoSplit = TRUE;
  if(nApp == 1470) nNewApp = 1469;
  if(nApp == 1469) nNewApp = 1468;
  if(nApp == 1467) nNoSplit = TRUE;
  if(nApp == 1473) nNewApp = 1472;
  if(nApp == 1472) nNewApp = 1471;
  if(nApp == 1471) nNoSplit = TRUE;
  if(nApp == 1476) nNewApp = 1475;
  if(nApp == 1475) nNewApp = 1474;
  if(nApp == 1474) nNoSplit = TRUE;
  if(nApp == 1479) nNewApp = 1478;
  if(nApp == 1478) nNewApp = 1477;
  if(nApp == 1477) nNoSplit = TRUE;
  if(nApp == 1482) nNewApp = 1481;
  if(nApp == 1481) nNewApp = 1480;
  if(nApp == 1480) nNoSplit = TRUE;
  if(nApp == 1485) nNewApp = 1484;
  if(nApp == 1484) nNewApp = 1483;
  if(nApp == 1483) nNoSplit = TRUE;

  //Destroy Orginal Creature
  AssignCommand(oCreature, ClearAllActions(TRUE));
  DestroyObject(oCreature);

  if(nNoSplit == TRUE) return;

  //Create Clones
  oClone1 = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lSpawn, TRUE);
  oClone2 = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lSpawn, TRUE);
  nHitDice = nHitDice - 2;

  //Set Appearance of New Clones
  SetCreatureAppearanceType(oClone1,nNewApp);
  SetCreatureAppearanceType(oClone2,nNewApp);

  if((GetIsObjectValid(oClone1))&&(GetIsObjectValid(oClone2)))
  {
    nDamage = GetCurrentHitPoints(oClone1)/2;
    eDamage = EffectDamage(nDamage);

    //Apply Split Effect
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePoof1, lSpawn);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoof2, oClone1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoof2, oClone2);

    //Reduce the hitpoints of the Jellies and take away a level
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oClone1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oClone2);

    //If the Level of the monster is greater than 1 reduce it by a level
    eLevelDown = EffectNegativeLevel(nHitDice, TRUE);
    if(nHitDice > 0)
    {
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eLevelDown, oClone1);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eLevelDown, oClone2);
    }
  }
}

void OAI_DoSporeMultiply(object oCreature)
{
  //Only Do Once
  int nDone = GetLocalInt(oCreature,"OAI_SPORE");
  if(nDone > 0) return;

  int nApp = GetAppearanceType(oCreature);
  int nSpores = 0;

  string sResRef = GetResRef(oCreature);
  string sAncient = OAI_SPORE_LARGE;
  string sAged = OAI_SPORE_MED;
  string sYoung = OAI_SPORE_SMALL;

  effect ePoof1 = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
  effect ePoof2 = EffectVisualEffect(VFX_COM_CHUNK_YELLOW_SMALL);

  location lCreature = GetLocation(oCreature);

  //Qty of Spores
  if(nApp == 1057) nSpores = 4;
  if(nApp == 1055) nSpores = 2;
  if(nApp == 1056) nSpores = 0;

  //Mycon Spasms
  AssignCommand(oCreature, ClearAllActions(TRUE));
  AssignCommand(oCreature,ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM,2.0,2.0));
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePoof1, lCreature);

  //Only Do Once
  SetLocalInt(oCreature,"OAI_SPORE",1);

  //Create Spores
  object oArea = GetArea(oCreature);
  int nSlot; int D4; location lLoc; object oSpore;
  for(nSlot = 1; nSlot <= nSpores; nSlot++)
  {
    lLoc = GetRandomLocation(oArea,oCreature,5.0);
    oSpore = CreateObject(OBJECT_TYPE_CREATURE, sYoung, lLoc, TRUE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePoof2, lLoc);

    //Only Do Once
    SetLocalInt(oSpore,"OAI_SPORE",1);
  }
}

//:: OAI CUBE, OOZES, SLIMES, PUDDINGS
/******************************************************************************/

/******************************************************************************/
//:: TROLL CODE BY PSYCHO AND OLANDER

void OAI_ConsumeTorch(object oLight, int nAmt)
{
    // Complies with HC 3.3 torches/lanterns (in fact copied and mofied from hcr 3.3)
    // Get burn limit.
    int nBurnLimit = GetLocalInt(GetModule(), "BURNTORCH");
    if(!nBurnLimit) nBurnLimit = 2;   // Default to Two hours

    // Convert to number of rounds of burning
    nBurnLimit *= FloatToInt(HoursToSeconds(1) / 6.0);

    // Get the newly adjusted burn count for this light source
    int nBurnCount = GetLocalInt(oLight, "BURNCOUNT") + nAmt;
    int nMask = GetModPropertyForItem(oLight, PROP_LIGHT, PROPV_LIGHT);

    // Are we fully consumed
    if (nBurnCount >= nBurnLimit)
    {
      // Torches are gone, lanterns unweild
      if (nMask & PROPV_TORCH)
      {
        if (GetIsPC(OBJECT_SELF)) SendMessageToPC(OBJECT_SELF, "Your torch is now exhausted!");
        DestroyObject(oLight);
      }
      else
      {
        if (GetIsPC(OBJECT_SELF)) SendMessageToPC(OBJECT_SELF, "Your lantern is out of oil!");
        ActionUnequipItem(oLight);
      }
    }
    else SetLocalInt(oLight, "BURNCOUNT", nBurnCount);
}

void OAI_VampireHB()
{
  //Vampires Combust in Direct Sunlight
  int nVampires = GetLocalInt(GetModule(),"VBURN");
  if(nVampires == 1)
  {
    effect eDam = EffectDamage(20, DAMAGE_TYPE_FIRE);
    effect eVis = EffectVisualEffect(498);
    effect eDis = EffectDisappear();
    effect ePul = EffectVisualEffect(VFX_IMP_PULSE_WIND);

    int nDay = GetIsDay();
    int nInt = GetIsAreaInterior(GetArea(OBJECT_SELF));
    float fDelay = IntToFloat(d6(1));
    if(fDelay < 3.0) fDelay = 3.0;

    //Burning The Vampire
    if(nDay == TRUE && nInt == FALSE)
    {
      ClearAllActions(TRUE);
      PlayVoiceChat(VOICE_CHAT_PAIN1);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, 30.0);
      ActionRandomWalk();
      PlayVoiceChat(VOICE_CHAT_PAIN1);
      PlayVoiceChat(VOICE_CHAT_PAIN2);
      PlayVoiceChat(VOICE_CHAT_PAIN3);
      //SetCommandable(FALSE);
      DelayCommand(fDelay - 1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF));
      DelayCommand(fDelay - 0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, ePul, OBJECT_SELF));
      DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDis, OBJECT_SELF));
    }
  }
}

void OAI_TrollHB()
{
  //Trolls Turn to Stone in Daylight Can Not be Destroyed
  int nTrolls = GetLocalInt(GetModule(),"TROLLS");
  if(nTrolls == 1)
  {
    int nPetrify = GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF);
    int nDay = GetIsDay();
    int nInt = GetIsAreaInterior(GetArea(OBJECT_SELF));

    if(nPetrify == FALSE && nDay == TRUE && nInt == FALSE)
    {
      Petrify(OBJECT_SELF);
      effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    }

    if(nPetrify == TRUE && nDay == FALSE && nInt == FALSE)
    {
      Depetrify(OBJECT_SELF);
      effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    }
  }
}

void OAI_TrollDamaged()
{
  object oLastAttacker = GetLastDamager();
  object oLastSpellCaster = GetLocalObject(OBJECT_SELF, "OAI_LASTSPELLCASTER");
  if(GetIsObjectValid(oLastSpellCaster)) oLastAttacker = oLastSpellCaster;

  int nCHP = GetCurrentHitPoints();
  int nFire = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
  int nAcid = GetDamageDealtByType(DAMAGE_TYPE_ACID);

  int nKill = FALSE;
  if(nFire > nCHP) nKill = TRUE;
  if(nAcid > nCHP) nKill = TRUE;
  if((nFire + nAcid) > nCHP) nKill = TRUE;

  //Allow the Kill of the Troll
  if(nKill == TRUE)
  {
    //Set this Damager as Killer
    SetLocalObject(OBJECT_SELF,"OAI_TROLL_KILLER",oLastAttacker);

    //Destroy Regen Troll Skin
    object oOSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR);
    if(GetIsObjectValid(oOSkin))
    {
      DestroyObject(oOSkin);
    }
  }

  //Now Delete The Spellcaster Object
  DeleteLocalObject(OBJECT_SELF,"OAI_LASTSPELLCASTER");
}

void OAI_TrollSpellCastAt()
{
  object oLastSpellCaster = GetLastSpellCaster();
  int bSpellIsHarmful = GetLastSpellHarmful();

  //Spell Cast at Troll Did Damage
  if(bSpellIsHarmful == TRUE)
  {
    SetLocalObject(OBJECT_SELF, "OAI_LASTSPELLCASTER", oLastSpellCaster);
  }
}

void RaiseAndKill(object oTroll)
{
  //Raise the troll
  ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oTroll, 0.0f);

  // Set the Troll alight
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_FLAME_M), oTroll, 17.0);

  //Only to die at the hands of the burner
  ApplyEffectToObject(DURATION_TYPE_INSTANT,
      EffectDamage(GetMaxHitPoints(oTroll)*2,
      DAMAGE_TYPE_FIRE,
      DAMAGE_POWER_PLUS_TEN),
      oTroll,
      0.0f);
}

void BurnTheTroll(location lDeadTrollLoc)
{
  //Set As Burnt
  SetLocalInt(OBJECT_SELF, "OAI_BURNED", TRUE);

  //Create the Burning Troll and Remove With Timer
  object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lDeadTrollLoc, TRUE);
  AssignCommand(GetArea(oFlame), DelayCommand(17.0, DestroyObject(oFlame)));
}

void BurnTrollCorpse(object oLight, object oShield, location lDeadTrollLoc)
{
  //Wield the light source if required
  if(GetIsObjectValid(oLight))
  {
    ActionEquipItem(oLight, INVENTORY_SLOT_LEFTHAND);
    ActionWait(0.5);
  }

  ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0);
  ActionDoCommand(BurnTheTroll(lDeadTrollLoc));

  if(GetIsObjectValid(oLight))
  {
    //Consume the Torch/Lantern (say 10 rounds worth)
    OAI_ConsumeTorch(oLight, 10);
    if(GetIsObjectValid(oShield)) ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND);
    else ActionUnequipItem(oLight);
  }

  //Stop other actions for a while
  ActionDoCommand(SetCommandable(TRUE));
  SetCommandable(FALSE);
}

void TrollRaise(object oLastAttacker)
{
  //Can not be raised if the corpse has been burnt
  if(GetLocalInt(OBJECT_SELF, "OAI_BURNED")) return;

  object oAttackingGroupMember = GetFirstFactionMember(oLastAttacker, TRUE);
  while(oAttackingGroupMember != OBJECT_INVALID)
  {
    DelayCommand(6.0, SendMessageToPC(oAttackingGroupMember, "The Troll is not dead yet!"));
    oAttackingGroupMember = GetNextFactionMember(oLastAttacker, TRUE);
  }

  ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), OBJECT_SELF, 0.0f);
  SetIsDestroyable(TRUE, FALSE, FALSE);

  //When the Troll "comes back to life" have it attack the last attacker
  AssignCommand(OBJECT_SELF, ActionAttack(oLastAttacker));
}

int OAI_TrollDeath()
{
  object oLastKiller = GetLastKiller();

  // dk: 23-May-2006
  // Its all over if we have been burned
  if(GetLocalInt(OBJECT_SELF, "OAI_BURNED")) return TRUE;

  //Last Killer is a DM
  if(GetIsDM(oLastKiller) == TRUE)
  {
    SetIsDestroyable(TRUE, FALSE, FALSE);
    DestroyObject(OBJECT_SELF);
    return TRUE;
  }

  location lDTLoc = GetLocation(OBJECT_SELF);

  int nCHP = GetCurrentHitPoints();
  int nFire = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
  int nAcid = GetDamageDealtByType(DAMAGE_TYPE_ACID);

  int nKill = FALSE;
  if(nFire > nCHP) nKill = TRUE;
  if(nAcid > nCHP) nKill = TRUE;
  if((nFire + nAcid) > nCHP) nKill = TRUE;

  //Kill the Troll
  if(nKill == TRUE)
  {
    //Set this Damager as Killer
    SetLocalObject(OBJECT_SELF,"OAI_TROLL_KILLER",oLastKiller);

    //Destroy Regen Troll Skin
    object oOSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR);
    if(GetIsObjectValid(oOSkin))
    {
      DestroyObject(oOSkin);
    }

    // set the Troll ablaze and kill it for good by burning its corpse
    BurnTheTroll(lDTLoc);
    return TRUE;
  }

  //Torch Checks for Burning
  else
  {
    // if the last attacker that damaged the troll is carrying a torch
    // and is within 5 feet of the troll
    // dk: 28-Dec-2005 ALl light sources now use oai_modprops_inc
    // Weild a torch if we are not yet weilding a light source
    object oLight = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oLastKiller);
    object oShield = oLight;    // In case we want to rewield it later
    int bNeedToWield = FALSE;
    if(!GetModPropertyForItem(oLight, PROP_LIGHT, PROPV_LIGHT))
    {
      oLight = GetModItemWithProperty(oLastKiller, PROP_LIGHT, PROPV_TORCH);

      // If not wielding yet, then we need to wield it if we are going to burn the troll
      bNeedToWield = GetIsObjectValid(oLight);
    }
    if (GetIsObjectValid(oLight)
      && (GetDistanceBetweenLocations(GetLocation(oLastKiller), lDTLoc) <= 5.0 ))
    {
      // Wield the light source if needed
      if(!bNeedToWield)
      {
        oLight = OBJECT_INVALID;
        oShield = OBJECT_INVALID;
      }

      // Set the Troll ablaze, kill it for good by burning its corpse
      AssignCommand(oLastKiller, ClearAllActions(TRUE));
      AssignCommand(oLastKiller, ActionDoCommand(BurnTrollCorpse(oLight, oShield, lDTLoc)));
      return TRUE;
    }

    //Troll is allowed to Regen
    else
    {
      SetIsDestroyable(FALSE, TRUE, TRUE);

      // dk: 23-May-2006 Do all this at once later on
      // Arrange for the troll to get up again soon
      DelayCommand(6.5, TrollRaise(oLastKiller));
      return FALSE;
    }
  }

  return FALSE;
}

/******************************************************************************/
//:: OLANDER'S SUICIDE BOMBERS

void OAI_CreateFieldEffect(location lLoc)
{
    //Create a Scorchmark
    object oScorch = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_weathmark",lLoc);
    DelayCommand(60.0,DestroyObject(oScorch));

    //Create a Dust Plume
    object oPlume = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_dustplume",lLoc);
    DelayCommand(20.0,DestroyObject(oPlume));

    //Create a Small Flame
    object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamemedium",lLoc);
    DelayCommand(15.0,DestroyObject(oFlame));

    //Create Oil Marker
    object oOil = CreateObject(OBJECT_TYPE_PLACEABLE,"siegeoilmarker",lLoc);
    DelayCommand(30.0,DestroyObject(oOil));
}

void OAI_Kaboom(object oCreature)
{
    //Already Pressed the Detonator
    if(GetLocalInt(oCreature,"DETONATE") == TRUE) return;

    //Not Close Enough to An Enemy
    object oEnemy = GetNearestSeenEnemy();
    float fDist = GetDistanceToObject(oEnemy);

    //Greater than 10 Meters try to get closer
    if(GetIsObjectValid(oEnemy) && fDist > 10.0)
    {
      ActionMoveToObject(oEnemy,TRUE, 3.0);
      return;
    }

    //Press the Detonator
    location lLoc = GetLocation(oCreature);
    SetLocalInt(oCreature,"DETONATE",TRUE);

    float fRadius = 15.0;//Keg Blast Radius
    int nFireDam = d20(5)+20;//These things are Dangerous LOL
    int nConcDam = d10(5)+10;//Concussion Damage
    int nPierDam = d10(5)+10;//Piercing Spray Damage
    effect eFire = EffectDamage(nFireDam, DAMAGE_TYPE_FIRE, DAMAGE_POWER_PLUS_TWENTY);
    effect eConc = EffectDamage(nConcDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_FIVE);
    effect ePierce = EffectDamage(nPierDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_FIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    float fDelay = 0.5;

    //Make Explosion
    effect eBoom1 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom1, lLoc);
    effect eBoom2 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
    DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom2, lLoc));

    //Make Scorchmark on Ground
    OAI_CreateFieldEffect(lLoc);
    effect eDest = EffectDeath(TRUE,TRUE);
    DelayCommand(0.3,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDest,oCreature));
    PlaySound("sim_explsun");

    //Now we apply damage to things in the Blast Radius
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
       //Check For Doors
       if(GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
       {
         if (!GetPlotFlag(oTarget))
         {
           // Apply effects to the currently selected target.
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
         }
       }
       //Check for other Siege Kegs (Olander's Siege)
       if (GetTag(oTarget) == "SiegeKeg")
       {
         int nKegDam = 20;
         effect eKeg = EffectDamage(nKegDam, DAMAGE_TYPE_FIRE);
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKeg, oTarget));
       }
       //Check for other Placeables
       if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE
          && (GetTag(oTarget) != "SiegeKeg"
          ||  GetTag(oTarget) != "WeatheringScorchMark"
          ||  GetTag(oTarget) != "FlameMedium"
          ||  GetTag(oTarget) != "DustPlume"
          ||  GetTag(oTarget) != "ShaftofLightWhite"
          ||  GetTag(oTarget) != "SiegeOilMarker"))
       {
         if (!GetPlotFlag(oTarget))
         {
           // Apply effects to the currently selected target.
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
         }
       }
       if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
       {
         //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
         //int nReflex = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePierce, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 3.0));
       }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

int OAI_Transform(object oCreature)
{
  //First We Check For Nearest Player (No Need for Other Creatures)
  object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
  string sPlace = GetLocalString(oCreature,"OAI_TRANSFORM_PLACE");
  if(sPlace == "") return FALSE;

  //If a Player is Leaving.....Transform to Placeable
  if(GetDistanceToObject(oPC) > 20.0)
  {
    //Visual Effect
    effect eVis = EffectVisualEffect(354);
    location lLoc = GetLocation(oCreature);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, lLoc, 2.0);

    //Placeable
    object oPlace = CreateObject(OBJECT_TYPE_PLACEABLE, sPlace, lLoc);
    SetUseableFlag(oPlace,FALSE);

    //Set ResRef of Creature to Placeable for Later
    string sCRR = GetResRef(oCreature);
    SetLocalString(oPlace,"OAI_TRANSFORM_CREATURE",sCRR);
    DelayCommand(2.0, ExecuteScript("oai_hb_resource", oPlace));

    //Destroy the Creature
    SetPlotFlag(oCreature, FALSE);
    DelayCommand(0.5, DestroyObject(oCreature));

    return TRUE;
  }

  return FALSE;
}

int OAI_Burrow(object oCreature)
{
  /*
  Burrowing works Just Like Transform Except that the Creature Does not Pop in an Out
  Just based upon distance.

  //First We Check For Nearest Player (No Need for Other Creatures)
  object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
  string sPlace = GetLocalString(oCreature,"OAI_TRANSFORM_PLACE");
  if(sPlace == "") return FALSE;

  //If a Player is Leaving.....Transform to Placeable
  if(GetDistanceToObject(oPC) > 20.0)
  {
    //Visual Effect
    effect eVis = EffectVisualEffect(354);
    location lLoc = GetLocation(oCreature);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, lLoc, 2.0);

    //Placeable
    object oPlace = CreateObject(OBJECT_TYPE_PLACEABLE, sPlace, lLoc);
    SetUseableFlag(oPlace,FALSE);

    //Set ResRef of Creature to Placeable for Later
    string sCRR = GetResRef(oCreature);
    SetLocalString(oPlace,"OAI_TRANSFORM_CREATURE",sCRR);
    DelayCommand(2.0, ExecuteScript("oai_hb_resource", oPlace));

    //Destroy the Creature
    SetPlotFlag(oCreature, FALSE);
    DelayCommand(0.5, DestroyObject(oCreature));

    return TRUE;
  }

  return FALSE;
  */

  return TRUE;
}

/******************************************************************************/

int OAI_BreakIllusion(object oTarget, int nAmDead = FALSE)
{
  //Has Illusion
  int nHasIllusion = GetLocalInt(oTarget,"OAI_HAS_ILLUSION");
  if(nHasIllusion == FALSE) return FALSE;

  //Illusionary DC Roll
  int nDC = GetLocalInt(oTarget, "OAI_ILLUSION_DC");
  if(WillSave(OBJECT_SELF, nDC) != 1) return FALSE;

  object oPC;
  int nReal = GetLocalInt(oTarget, "OAI_REAL_SELF");
  string sName = GetName(oTarget);

  ClearAllActions(TRUE);

  effect eFX = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFX, OBJECT_SELF);

  //Creature is Dead
  if(nAmDead)
  {
    SetCreatureAppearanceType(oTarget,nReal);

    oPC = GetFirstFactionMember(OBJECT_SELF, TRUE);
    while(GetIsObjectValid(oPC))
    {
      if(GetArea(oPC) == oArea) FloatingTextStringOnCreature("The illusionary " + sName + " fades away, its creator is dead upon the ground.", oPC, FALSE);
      oPC = GetNextFactionMember(OBJECT_SELF, TRUE);
    }
    return TRUE;
  }

  //Creature is Still Alive
  else
  {
    if(d2()==1) PlayVoiceChat(VOICE_CHAT_BADIDEA, oTarget);
    SetCreatureAppearanceType(oTarget,nReal);

    oPC = GetFirstFactionMember(OBJECT_SELF, TRUE);
    while(GetIsObjectValid(oPC))
    {
      if(GetArea(oPC) == oArea)
      {
        if(oPC == OBJECT_SELF)
        {
          FloatingTextStringOnCreature("You realized " + sName + " was merely an illusion, causing it to melt away.", oPC, FALSE);
        }
        else
        {
          FloatingTextStringOnCreature(GetName(OBJECT_SELF) + " realized " + sName + " is merely an illusion, causing it to melt away.", oPC, FALSE);
        }
      }
      oPC = GetNextFactionMember(OBJECT_SELF, TRUE);
    }
    return TRUE;
  }
  return FALSE;
}

void OAI_StatusCaster(object oTarget, int nState = 1)
{
   object oMe=OBJECT_SELF;
   if(nState > 2) nState = 1;

   int bOverrideStates=FALSE;
   int nN;
   object oItem;

   //Invisible Target
   if(GetObjectSeen(oTarget)==FALSE && GetDistanceBetween(oTarget,oMe) < 20.0)
   {
     nN=caiProfessionalAntiStealth();
     if (nN!=0)
     {
       bOverrideStates=TRUE;
       AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
       nState = 9;
     }
   }

   if(!bOverrideStates)
   {
     //Close Quarters AI
     if(GetDistanceBetween(oMe,oTarget) < 3.5)
     {
       nN = caiProfessionalCloseQuarters(oTarget);
       if(nN!=0)
       {
         AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
         nState = 9;
       }
       else nState = 2;

       //Defensive
       if(nState == 2)
       {
         nN=caiProfessionalDefensive(oTarget);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 10; //Combat State
       }
     }
     else
     {
       //Defensive
       if(nState == 1)
       {
         nN=caiProfessionalDefensive(oTarget);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 2;
       }

       //Offensive (AOE)
       if(nState == 2)
       {
         nN=caiProfessionalOffensive(oTarget);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
           nState = 9;
         }
         else nState == 3;
       }

       //Familiars and Animal Companions
       if(nState == 3)
       {
         //Check for familiars or animal companions to summon
         if(GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oMe,1))==FALSE&&GetHasFeat(FEAT_SUMMON_FAMILIAR))
         {
           AssignCommand(oMe,ActionCastSpellAtObject(SPELLABILITY_SUMMON_FAMILIAR,oMe));
           AssignCommand(oMe,ActionDoCommand(DecrementRemainingFeatUses(oMe,FEAT_SUMMON_FAMILIAR)));
           nState = 9;
         }
         else if(GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oMe,1))==FALSE&&GetHasFeat(FEAT_ANIMAL_COMPANION))
         {
           AssignCommand(oMe,ActionCastSpellAtObject(SPELLABILITY_SUMMON_ANIMAL_COMPANION,oMe));
           AssignCommand(oMe,ActionDoCommand(DecrementRemainingFeatUses(oMe,FEAT_ANIMAL_COMPANION)));
           nState = 9;
         }
         else
         {
            nState == 4;
         }
       }
       else nState == 4;

       //Offensive Counters
       if(nState == 4)
       {
         //Verify The Defense
         if(fnGetHasSpellDefense(oTarget))
         {
           nN=caiProfessionalCounter(oTarget);
           if(nN!=0)
           {
             AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
             nState = 9;
           }
           else nState == 5;
         }
         else nState == 5;
       }

       //Offensive (Standard)
       if(nState == 5)
       {
         nN=caiGetAvailableCombatSpell(oMe,oTarget);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
           nState = 9;
         }
         else nState == 6;
       }

       //Defensive
       if(nState == 6)
       {
         nN=caiGetAvailableDefensiveSpell(oMe,oMe);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 10;
       }

       //What to Do After Casting
       if(nState == 9)
       {
         if(WhatToDoAfterCasting(oMe)) return;
         else nState == 10;
       }

       //Fall Through General Attack
       if(nState == 10) AssignCommand(oMe,OAI_WrapperActionAttack(oTarget));
     }
   }
}

void OAI_AttackCaster(object oTarget, int nState = 1)
{
   object oMe=OBJECT_SELF;
   if(nState > 2) nState = 1;

   int bOverrideStates=FALSE;
   int nN;
   object oItem;

   //Invisible Target
   if(GetObjectSeen(oTarget)==FALSE && GetDistanceBetween(oTarget,oMe) < 20.0)
   {
     nN=caiProfessionalAntiStealth();
     if (nN!=0)
     {
       bOverrideStates=TRUE;
       AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
       nState = 9;
     }
   }

   if(!bOverrideStates)
   {
     if(nState > 0)//Just Keeps the Format =)
     {
       //Defensive
       if(nState == 1)
       {
         nN=caiGetAvailableDefensiveSpell(oMe,oMe);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 2;
       }

       //Offensive (Standard)
       if(nState == 2)
       {
         nN=caiGetAvailableCombatSpell(oMe,oTarget);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 3;
       }

       //Offensive Counters
       if(nState == 4)
       {
         //Verify The Defense
         if(fnGetHasSpellDefense(oTarget))
         {
           nN=caiProfessionalCounter(oTarget);
           if(nN!=0)
           {
             AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
             nState = 9;
           }
           else nState == 10;
         }
         else nState == 10;
       }

       //What to Do After Casting
       if(nState == 9)
       {
         if(WhatToDoAfterCasting(oMe)) return;
         else nState == 10;
       }

       //Fall Through General Attack
       if(nState == 10) AssignCommand(oMe,OAI_WrapperActionAttack(oTarget));
     }
   }
}

void OAI_AOECaster(object oTarget, int nState = 1)
{
   object oMe=OBJECT_SELF;
   if(nState > 2) nState = 1;

   int bOverrideStates=FALSE;
   int nN;
   object oItem;

   //Invisible Target
   if(GetObjectSeen(oTarget)==FALSE && GetDistanceBetween(oTarget,oMe) < 20.0)
   {
     nN=caiProfessionalAntiStealth();
     if(nN!=0)
     {
       bOverrideStates=TRUE;
       AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
       nState = 9;
     }
   }

   if(!bOverrideStates)
   {
     if(nState > 0)//Just Keeps the Format =)
     {
       //Defensive
       if(nState == 1)
       {
         nN=caiGetAvailableDefensiveSpell(oMe,oMe);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 2;
       }

       //Offensive (AOE)
       if(nState == 2)
       {
         nN=caiProfessionalOffensive(oTarget);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
           nState = 9;
         }
         else nState == 3;
       }

       //Offensive (Standard)
       if(nState == 3)
       {
         nN=caiGetAvailableCombatSpell(oMe,oTarget);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
           nState = 9;
         }
         else nState == 4;
       }

       //Offensive Counters
       if(nState == 4)
       {
         //Verify The Defense
         if(fnGetHasSpellDefense(oTarget))
         {
           nN=caiProfessionalCounter(oTarget);
           if(nN!=0)
           {
             AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
             nState = 9;
           }
           else nState == 10;
         }
         else nState == 10;
       }
       else nState == 10;

       //What to Do After Casting
       if(nState == 9)
       {
         if(WhatToDoAfterCasting(oMe)) return;
         else nState == 10;
       }

       //Fall Through General Attack
       if(nState == 10) AssignCommand(oMe,OAI_WrapperActionAttack(oTarget));
     }
   }
}

void OAI_BufferCaster(object oTarget, int nState = 1)
{
   object oMe=OBJECT_SELF;
   if(nState > 2) nState = 1;

   int bOverrideStates=FALSE;
   int nN;
   object oItem;

   //Invisible Target
   if(GetObjectSeen(oTarget)==FALSE && GetDistanceBetween(oTarget,oMe) < 20.0)
   {
     nN=caiProfessionalAntiStealth();
     if (nN!=0)
     {
       bOverrideStates=TRUE;
       AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
       nState = 9;
     }
   }

   if(!bOverrideStates)
   {
     //Close Quarters AI
     if(GetDistanceBetween(oMe,oTarget) < 3.5)
     {
       nN = caiProfessionalCloseQuarters(oTarget);
       if(nN!=0)
       {
         AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
         nState = 9;
       }
       else nState = 2;

       //Defensive
       if(nState == 2)
       {
         nN=caiProfessionalDefensive(oTarget);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 10; //Combat State
       }
     }
     else
     {
       object oBest = caiGetBestObjectToHeal(oMe);

       //Heal Someone
       if(nState == 1)
       {
         int nStatus = GetCurrentHitPoints(oBest) * 2;
         int nBase = GetMaxHitPoints(oBest);
         if(nStatus < nBase)
         {
           if(GetIsPC(oBest)) nN=caiGetAvailableHealPC(oMe,oBest);
           else if(GetIsDead(oBest)==FALSE) nN=caiGetAvailableHeal(oMe,nN);
           if(nN!=0)
           {
             AssignCommand(oMe,ActionCastSpellAtObject(nN,oBest));
             nState = 9;
           }
           else nState == 2;
         }
         else nState == 2;
       }

       //Heal Myself
       if(nState == 2)
       {
         int nStatus = GetCurrentHitPoints(oMe) * 2;
         int nBase = GetMaxHitPoints(oMe);
         if(nStatus < nBase)
         {
           nN=caiGetAvailableHeal(oMe,nN,TRUE);
           if(nN!=0)
           {
             AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
             nState = 9;
           }
           else nState == 3;
         }
         else nState == 3;
       }

       //Defensive
       if(nState == 3)
       {
         nN=caiGetAvailableDefensiveSpell(oMe,oBest);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oBest));
           nState = 9;
         }
         else nState == 4;
       }

       //Buffing
       if(nState == 4)
       {
         nN=caiGetAvailableBuff(oMe,oBest);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oBest));
           nState = 9;
         }
         else nState == 5;
       }

       //Defensive
       if(nState == 5)
       {
         nN=caiGetAvailableDefensiveSpell(oMe,oMe);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 6;
       }

       //Buffing
       if(nState == 6)
       {
         nN=caiGetAvailableBuff(oMe,oMe);
         if(nN!=0)
         {
           AssignCommand(oMe,ActionCastSpellAtObject(nN,oMe));
           nState = 9;
         }
         else nState == 7;
       }

       //Offensive Counters
       if(nState == 7)
       {
         //Verify The Defense
         if(fnGetHasSpellDefense(oTarget))
         {
           nN=caiProfessionalCounter(oTarget);
           if(nN!=0)
           {
             AssignCommand(oMe,ActionCastSpellAtObject(nN,oTarget));
             nState = 9;
           }
           else nState == 10;
         }
         else nState == 10;
       }
       else nState == 10;

       //What to Do After Casting
       if(nState == 9)
       {
         if(WhatToDoAfterCasting(oMe)) return;
         else nState == 10;
       }

       //Fall Through General Attack
       if(nState == 10) AssignCommand(oMe,OAI_WrapperActionAttack(oTarget));
     }
   }
}

int OAI_GetIsTargetInMeleeRange(object oTarget,object oCreature=OBJECT_SELF)
{
    if(GetDistanceBetween(oTarget,oCreature) <= 3.3) return TRUE;
    return FALSE;
}

void OAI_Crits(object oDamager,object oCreature=OBJECT_SELF)
{
  //Critical System Turned OFF
  if (GetLocalInt(GetModule(),"OAICRIT") == 0) return;

  int nRoll = uroll();
  if (nRoll < 91) return;           // 10% max chance for any critical

  // These two numbers need to be tweaked to suite your tastes
  /*
   * NOTE: If we limit chance to 110 then 90-95 will be glancing critical for highly
   *       skilled characters and 96+ will almost alway be a kill giving us 5% chance
   *       of each. Has a nice feel to it. Remember these criticals are in addition to
   *       the standard critical hits so we don't want them occuring all the time. Which
   *       is why 201 is a good heavy threshold. Its still in reach of a novice and never
   *       guaranteed (over a glancing critical that is, keep reading).
   *
   * Also: The lower critical for kill shots is okay as player level is not counted,
   *       only weapon base and some feats are counted allowing the chance add for a
   *       kill shot to max out at around 90-100 with a min of 15 which again gives a
   *       max kill chance of about 5%. These numbers have worked well so far.
   */
  int nCritThreshold = 171;         // # needed to score a critical hit
  int nCritKillThreshold = 201;     // # needed to score a killing critical hit
  int nKC;

  //Weapon (Creature Weapons NOT Counted!! Just does not fit)
  object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oDamager);
  if(GetIsObjectValid(oWeapon) == FALSE)
  {
    //No Weapon....Check For Glove or Bracer
    oWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,oDamager);
    if(GetIsObjectValid(oWeapon) == FALSE) return;
  }

  //Valid Weapon....Need Body Location
  /*
    1 - 2   => Head
    3       => Neck
    4 - 5   => Chest
    6 - 7   => Waist
    8       => Groin
    9 - 11  => Right Arm
    12 - 14 => Left Arm
    15 - 17 => Right Leg
    18 - 20 => Left Leg
  */
  int nBodyPart = d20(1);

  // Color Variables
  string RED = "<có  >";
  string GRAY = "<c°°°>";

  //VFX Blood
  effect eSBlood = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
  effect eMBlood = EffectVisualEffect(VFX_COM_CHUNK_RED_MEDIUM);

  //Vermin for Green Blood
  int nCRace = GetRacialType(oCreature);
  if(nCRace == RACIAL_TYPE_VERMIN)
  {
    eSBlood = EffectVisualEffect(VFX_COM_CHUNK_GREEN_SMALL);
    eMBlood = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);
  }

  //Ranged
  int nRanged = IsRangedWeapon(oWeapon);
  if(nRanged == TRUE)
  {
    nKC = OAI_RangedCalcKillChance(oDamager, oCreature, oWeapon);
    if(nKC == 0) return;

    if (GetIsPC(oDamager))
        SendMessageToPC(oDamager, "nRoll = " + IntToString(nRoll) + " nSkill = " + IntToString(nKC));
    if(nRoll + nKC >= nCritThreshold)
    {
      //Message
      AssignCommand(oCreature,SpeakString(RED+"Kill shot!!"));

      //Apply Visual
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

      OAI_CritKills(oCreature, oDamager);
      return;
    }

    return;
  }

  int nWeapon = GetBaseItemType(oWeapon);
  int nType = (StringToInt(Get2DAString("baseitems","WeaponType",nWeapon)));

  //Calculate Critical Chance
  nKC = OAI_MeleeCalcCritChance(oDamager, oCreature, oWeapon);
  if(nKC == 0) return;        // No chance allowed
  if (GetIsPC(oDamager))
        SendMessageToPC(oDamager, "nRoll = " + IntToString(nRoll) + " nSkill = " + IntToString(nKC));
  nRoll += nKC;

  // No critical threshold then finish here
  if(nRoll < nCritThreshold) return;

  //Heavy or Glancing
  int nHit = 1;
  if (nRoll >= nCritKillThreshold)
        nHit = 2;

/******************************************************************************/
//:: HEAD

    if(nBodyPart >= 1 && nBodyPart <= 2)
    {
      //Piercing
      if(nType == 1 || nType == 4)
      {
        //Helmets
        if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature)) == BASE_ITEM_HELMET)
        {
          if(nHit == 2) DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature));
          nHit = 1;
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+PHEAD_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+PHEAD_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+PHEAD_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+HEAD_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+HEAD_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oCreature, HoursToSeconds(4));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }

      //Budgeoning
      if(nType == 2)
      {
        //Helmets
        if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature)) == BASE_ITEM_HELMET)
        {
          if(nHit == 2) DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature));
          nHit = 1;
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+BHEAD_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+BHEAD_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+BHEAD_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+HEAD_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+HEAD_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oCreature, HoursToSeconds(4));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }

      //Slashing
      if(nType == 3 || nType == 4)
      {
        //Helmets
        if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature)) == BASE_ITEM_HELMET)
        {
          if(nHit == 2) DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature));
          nHit = 1;
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+SHEAD_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+SHEAD_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+SHEAD_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+HEAD_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+HEAD_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oCreature, HoursToSeconds(4));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }
    }

/******************************************************************************/
//:: NECK

    if(nBodyPart == 3)
    {
      //Piercing
      if(nType == 1 || nType == 4)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+PNECK_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+PNECK_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+PNECK_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+NECK_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+NECK_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, 3.0);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }

      //Budgeoning
      if(nType == 2)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+BNECK_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+BNECK_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+BNECK_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+NECK_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+NECK_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, 3.0);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }

      //Slashing
      if(nType == 3 || nType == 4)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+SNECK_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+SNECK_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+SNECK_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+NECK_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+NECK_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, 3.0);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }
    }

/******************************************************************************/
//:: CHEST

    if(nBodyPart >= 4 && nBodyPart <= 5)
    {
      //Piercing
      if(nType == 1 || nType == 4)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+PCHEST_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+PCHEST_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+PCHEST_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+CHEST_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+CHEST_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, 3.0);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }

      //Budgeoning
      if(nType == 2)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+BCHEST_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+BCHEST_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+BCHEST_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+CHEST_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+CHEST_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, 3.0);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }

      //Slashing
      if(nType == 3 || nType == 4)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+SCHEST_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+SCHEST_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+SCHEST_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+CHEST_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+CHEST_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, 3.0);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }
    }

/******************************************************************************/
//:: WAIST

    if(nBodyPart >= 6 && nBodyPart <= 7)
    {
      //Piercing
      if(nType == 1 || nType == 4)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+PWAIST_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+PWAIST_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+PWAIST_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+WAIST_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+WAIST_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }

      //Budgeoning
      if(nType == 2)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+BWAIST_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+BWAIST_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+BWAIST_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+WAIST_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+WAIST_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }

      //Slashing
      if(nType == 3 || nType == 4)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+SWAIST_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+SWAIST_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+SWAIST_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

          //Apply Death Effects
          OAI_CritKills(oCreature, oDamager);
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+WAIST_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+WAIST_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }
    }

/******************************************************************************/
//:: RIGHT ARM

    if(nBodyPart >= 9 && nBodyPart <= 11)
    {
      //Piercing
      if(nType == 1 || nType == 4)
      {
        //Weapon
        object oCWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature);
        if(GetIsObjectValid(oCWeapon) == TRUE)
        {
          if(nHit == 2)
          {
            //Drops Weapon
            CreateObject(OBJECT_TYPE_ITEM, GetResRef(oCWeapon), GetLocation(oCreature));
            DestroyObject(oCWeapon, 0.5);
          }
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+PARM_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+PARM_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+PARM_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_PIERCING), oCreature));
        }

        return;
      }

      //Budgeoning
      if(nType == 2)
      {
        //Weapon
        object oCWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature);
        if(GetIsObjectValid(oCWeapon) == TRUE)
        {
          if(nHit == 2)
          {
            //Drops Weapon
            CreateObject(OBJECT_TYPE_ITEM, GetResRef(oCWeapon), GetLocation(oCreature));
            DestroyObject(oCWeapon, 0.5);
          }
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+BARM_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+BARM_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+BARM_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
        }

        return;
      }

      //Slashing
      if(nType == 3 || nType == 4)
      {
        //Weapon
        object oCWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature);
        if(GetIsObjectValid(oCWeapon) == TRUE)
        {
          if(nHit == 2)
          {
            //Drops Weapon
            CreateObject(OBJECT_TYPE_ITEM, GetResRef(oCWeapon), GetLocation(oCreature));
            DestroyObject(oCWeapon, 0.5);
          }
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+SARM_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+SARM_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+SARM_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_SLASHING), oCreature));
        }

        return;
      }
    }

/******************************************************************************/
//:: LEFT ARM

    if(nBodyPart >= 12 && nBodyPart <= 14)
    {
      //Piercing
      if(nType == 1 || nType == 4)
      {
        //Shield
        if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature)) == TRUE)
        {
          if(nHit == 2)
          {
            object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature);
            int nShield = GetBaseItemType(oShield);
            if(nShield == BASE_ITEM_LARGESHIELD
              || nShield == BASE_ITEM_SMALLSHIELD
              || nShield == BASE_ITEM_TOWERSHIELD)
            {
              //Destroy Shield
              DestroyObject(oShield, 0.5);
              nHit = 1;
            }
          }
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+PARM_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+PARM_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+PARM_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }

      //Budgeoning
      if(nType == 2)
      {
        //Shield
        if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature)) == TRUE)
        {
          if(nHit == 2)
          {
            object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature);
            int nShield = GetBaseItemType(oShield);
            if(nShield == BASE_ITEM_LARGESHIELD
              || nShield == BASE_ITEM_SMALLSHIELD
              || nShield == BASE_ITEM_TOWERSHIELD)
            {
              //Destroy Shield
              DestroyObject(oShield, 0.5);
              nHit = 1;
            }
          }
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+BARM_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+BARM_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+BARM_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }

      //Slashing
      if(nType == 3 || nType == 4)
      {
        //Shield
        if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature)) == TRUE)
        {
          if(nHit == 2)
          {
            object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature);
            int nShield = GetBaseItemType(oShield);
            if(nShield == BASE_ITEM_LARGESHIELD
              || nShield == BASE_ITEM_SMALLSHIELD
              || nShield == BASE_ITEM_TOWERSHIELD)
            {
              //Destroy Shield
              DestroyObject(oShield, 0.5);
              nHit = 1;
            }
          }
        }

        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+SARM_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+SARM_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+SARM_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+ARM_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
        }

        return;
      }
    }

/******************************************************************************/
//:: LEGS

    if(nBodyPart >= 15 && nBodyPart <= 20)
    {
      //Piercing
      if(nType == 1 || nType == 4)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+PLEG_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+PLEG_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+PLEG_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+LEG_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+LEG_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_PIERCING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }

      //Budgeoning
      if(nType == 2)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+BLEG_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+BLEG_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+BLEG_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+LEG_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+LEG_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }

      //Slashing
      if(nType == 3 || nType == 4)
      {
        //Heavy Hit
        if(nHit == 2)
        {
          //Apply Voice Chat
          PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

          AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

          int nD3 = d3(1);
          switch(nD3)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+SLEG_HEAVY1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+SLEG_HEAVY2)); break;
            case 3: AssignCommand(oCreature,SpeakString(GRAY+SLEG_HEAVY3)); break;
          }

          //Apply Visual
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }
        else
        {
          AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

          int nD2 = d2(1);
          switch(nD2)
          {
            case 1: AssignCommand(oCreature,SpeakString(GRAY+LEG_GLANCE1)); break;
            case 2: AssignCommand(oCreature,SpeakString(GRAY+LEG_GLANCE2)); break;
          }

          //Apply Additional Damage
          AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_SLASHING), oCreature));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, RoundsToSeconds(1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
        }

        return;
      }
    }
}


void OAI_CritKills(object oCreature, object oKiller)
{
  AssignCommand(oCreature, ClearAllActions(TRUE));

  int nD4 = d4(1);
  int nCHP = GetCurrentHitPoints(oCreature);

  //Fall Over Dead
  if(nD4 == 1)
  {
    //PlayVoiceChat(VOICE_CHAT_DEATH, oCreature);
    DelayCommand(0.5, AssignCommand(oKiller, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nCHP + 1), oCreature)));
  }

  //Spasm Death
  if(nD4 == 2)
  {
    ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 3.0);
    //PlayVoiceChat(VOICE_CHAT_DEATH, oCreature);
    DelayCommand(0.5, AssignCommand(oKiller, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nCHP + 1), oCreature)));
  }

  //Kneel Death
  if(nD4 == 3)
  {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectKnockdown(), oCreature);
    //PlayVoiceChat(VOICE_CHAT_DEATH, oCreature);
    DelayCommand(0.5, AssignCommand(oKiller, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nCHP + 1), oCreature)));
  }

  //Fall Face Down Death
  if(nD4 == 4)
  {
    ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 3.0);
    //PlayVoiceChat(VOICE_CHAT_DEATH, oCreature);
    DelayCommand(0.5, AssignCommand(oKiller, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nCHP + 1), oCreature)));
  }
}

// Max should be 110, min can be negative, openended roll + this > limit = critical hit
int OAI_MeleeCalcCritChance(object oDamager, object oCreature, object oWeapon)
{
    int nWeapon = GetBaseItemType(oWeapon);
    int nChance = 0;
    int nDSize = GetCreatureSize(oDamager);
    int nCSize = GetCreatureSize(oCreature);
    int nCRace = GetRacialType(oCreature);

    //IMMUNTIES/RESISTANCES TO CRITS
    if(nCRace == RACIAL_TYPE_DRAGON) return 0;
    if(nCRace == RACIAL_TYPE_UNDEAD) return 0;
    if(nCRace == RACIAL_TYPE_OUTSIDER) return 0;
    if(nCRace == RACIAL_TYPE_CONSTRUCT) return 0;
    if(nCRace == RACIAL_TYPE_ELEMENTAL) return 0;
    if(GetIsImmune(oCreature,IMMUNITY_TYPE_CRITICAL_HIT) == TRUE) return 0;

    // First add is Lvl (max at 10) multiplied by points per class (1..6)
    int nPos, nLvl, nClass;
    for (nPos = 1; nPos <= 3; nPos++)
    {
        nLvl = GetLevelByPosition(nPos, oDamager);
        if (nLvl > 0)
        {
            nClass = GetClassByPosition(nPos, oDamager);
            int nPoints = 0;
            switch (nClass)
            {
                case CLASS_TYPE_WEAPON_MASTER:
                case CLASS_TYPE_DRAGON:
                    nPoints = 7; break;
                case CLASS_TYPE_BARBARIAN:
                case CLASS_TYPE_DWARVEN_DEFENDER:
                case CLASS_TYPE_FIGHTER:
                case CLASS_TYPE_MONK:
                case CLASS_TYPE_CONSTRUCT:
                    nPoints = 6; break;
                case CLASS_TYPE_BLACKGUARD:
                case CLASS_TYPE_DIVINE_CHAMPION:
                case CLASS_TYPE_PALADIN:
                case CLASS_TYPE_RANGER:
                case CLASS_TYPE_ELEMENTAL:
                case CLASS_TYPE_GIANT:
                    nPoints = 5; break;
                case CLASS_TYPE_ASSASSIN:
                case CLASS_TYPE_ROGUE:
                case CLASS_TYPE_MAGICAL_BEAST:
                case CLASS_TYPE_OUTSIDER:
                case CLASS_TYPE_SHAPECHANGER:
                    nPoints = 4; break;
                case CLASS_TYPE_SHIFTER:
                case CLASS_TYPE_BARD:
                    nPoints = 3; break;
                case CLASS_TYPE_ABERRATION:
                case CLASS_TYPE_MONSTROUS:
                case CLASS_TYPE_UNDEAD:
                case CLASS_TYPE_VERMIN:
                    nPoints = 2; break;
                default:
                    nPoints = 1;
            }
            // Only count 10 levels max (don't learn anything new after level 10)
            if (nLvl > 10) nLvl = 10;
            nChance += nLvl * nPoints;
        }
    }
    // Restrict total bonus from levels to 80 to allow for specialisations to take us to 110
    // Size bonuses are an extra benefit
    if (nChance > 80) nChance = 80;

    //WEAPON FOCUS/SPECIALIZATION
    // dk: 11-Dec-2005 Replaced code and ammended with following chunk
    int nFeat = 0, nSpec = 0, nCrit = 0;
    switch (nWeapon)
    {
        case BASE_ITEM_BASTARDSWORD:
            nFeat = FEAT_WEAPON_FOCUS_BASTARD_SWORD; nSpec = FEAT_WEAPON_SPECIALIZATION_BASTARD_SWORD;
            nCrit = FEAT_IMPROVED_CRITICAL_BASTARD_SWORD; break;
        case BASE_ITEM_BATTLEAXE:
            nFeat = FEAT_WEAPON_FOCUS_BATTLE_AXE; nSpec = FEAT_WEAPON_SPECIALIZATION_BATTLE_AXE;
            nCrit = FEAT_IMPROVED_CRITICAL_BATTLE_AXE; break;
        case BASE_ITEM_CLUB:
            nFeat = FEAT_WEAPON_FOCUS_CLUB; nSpec = FEAT_WEAPON_SPECIALIZATION_CLUB;
            nCrit = FEAT_IMPROVED_CRITICAL_CLUB; break;
        case BASE_ITEM_CREATUREITEM:
            nFeat = FEAT_WEAPON_FOCUS_CREATURE; nSpec = FEAT_WEAPON_SPECIALIZATION_CREATURE;
            nCrit = FEAT_IMPROVED_CRITICAL_CREATURE; break;
        case BASE_ITEM_DAGGER:
            nFeat = FEAT_WEAPON_FOCUS_DAGGER; nSpec = FEAT_WEAPON_SPECIALIZATION_DAGGER;
            nCrit = FEAT_IMPROVED_CRITICAL_DAGGER; break;
        case BASE_ITEM_DIREMACE:
            nFeat = FEAT_WEAPON_FOCUS_DIRE_MACE; nSpec = FEAT_WEAPON_SPECIALIZATION_DIRE_MACE;
            nCrit = FEAT_IMPROVED_CRITICAL_DIRE_MACE; break;
        case BASE_ITEM_DOUBLEAXE:
            nFeat = FEAT_WEAPON_FOCUS_DOUBLE_AXE; nSpec = FEAT_WEAPON_SPECIALIZATION_DOUBLE_AXE;
            nCrit = FEAT_IMPROVED_CRITICAL_DOUBLE_AXE; break;
        case BASE_ITEM_DWARVENWARAXE:
            nFeat = FEAT_WEAPON_FOCUS_DWAXE; nSpec = FEAT_WEAPON_SPECIALIZATION_DWAXE;
            nCrit = FEAT_IMPROVED_CRITICAL_DWAXE; break;
        case BASE_ITEM_GREATAXE:
            nFeat = FEAT_WEAPON_FOCUS_GREAT_AXE; nSpec = FEAT_WEAPON_SPECIALIZATION_GREAT_AXE;
            nCrit = FEAT_IMPROVED_CRITICAL_GREAT_AXE; break;
        case BASE_ITEM_GREATSWORD:
            nFeat = FEAT_WEAPON_FOCUS_GREAT_SWORD; nSpec = FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD;
            nCrit = FEAT_IMPROVED_CRITICAL_GREAT_SWORD; break;
        case BASE_ITEM_HALBERD:
            nFeat = FEAT_WEAPON_FOCUS_HALBERD; nSpec = FEAT_WEAPON_SPECIALIZATION_HALBERD;
            nCrit = FEAT_IMPROVED_CRITICAL_HALBERD; break;
        case BASE_ITEM_HANDAXE:
            nFeat = FEAT_WEAPON_FOCUS_HAND_AXE; nSpec = FEAT_WEAPON_SPECIALIZATION_HAND_AXE;
            nCrit = FEAT_IMPROVED_CRITICAL_HAND_AXE; break;
        case BASE_ITEM_HEAVYFLAIL:
            nFeat = FEAT_WEAPON_FOCUS_HEAVY_FLAIL; nSpec = FEAT_WEAPON_SPECIALIZATION_HEAVY_FLAIL;
            nCrit = FEAT_IMPROVED_CRITICAL_HEAVY_FLAIL; break;
        case BASE_ITEM_KAMA:
            nFeat = FEAT_WEAPON_FOCUS_KAMA; nSpec = FEAT_WEAPON_SPECIALIZATION_KAMA;
            nCrit = FEAT_IMPROVED_CRITICAL_KAMA; break;
        case BASE_ITEM_KATANA:
            nFeat = FEAT_WEAPON_FOCUS_KATANA; nSpec = FEAT_WEAPON_SPECIALIZATION_KATANA;
            nCrit = FEAT_IMPROVED_CRITICAL_KATANA; break;
        case BASE_ITEM_KUKRI:
            nFeat = FEAT_WEAPON_FOCUS_KUKRI; nSpec = FEAT_WEAPON_SPECIALIZATION_KUKRI;
            nCrit = FEAT_IMPROVED_CRITICAL_KUKRI; break;
        case BASE_ITEM_LIGHTFLAIL:
            nFeat = FEAT_WEAPON_FOCUS_LIGHT_FLAIL; nSpec = FEAT_WEAPON_SPECIALIZATION_LIGHT_FLAIL;
            nCrit = FEAT_IMPROVED_CRITICAL_LIGHT_FLAIL; break;
        case BASE_ITEM_LIGHTHAMMER:
            nFeat = FEAT_WEAPON_FOCUS_LIGHT_HAMMER; nSpec = FEAT_WEAPON_SPECIALIZATION_LIGHT_HAMMER;
            nCrit = FEAT_IMPROVED_CRITICAL_LIGHT_HAMMER; break;
        case BASE_ITEM_LIGHTMACE:
            nFeat = FEAT_WEAPON_FOCUS_LIGHT_MACE; nSpec = FEAT_WEAPON_SPECIALIZATION_LIGHT_MACE;
            nCrit = FEAT_IMPROVED_CRITICAL_LIGHT_MACE; break;
        case BASE_ITEM_LONGSWORD:
            nFeat = FEAT_WEAPON_FOCUS_LONG_SWORD; nSpec = FEAT_WEAPON_SPECIALIZATION_LONG_SWORD;
            nCrit = FEAT_IMPROVED_CRITICAL_LONG_SWORD; break;
        case BASE_ITEM_MORNINGSTAR:
            nFeat = FEAT_WEAPON_FOCUS_MORNING_STAR; nSpec = FEAT_WEAPON_SPECIALIZATION_MORNING_STAR;
            nCrit = FEAT_IMPROVED_CRITICAL_MORNING_STAR; break;
        case BASE_ITEM_RAPIER:
            nFeat = FEAT_WEAPON_FOCUS_RAPIER; nSpec = FEAT_WEAPON_SPECIALIZATION_RAPIER;
            nCrit = FEAT_IMPROVED_CRITICAL_RAPIER; break;
        case BASE_ITEM_SCIMITAR:
            nFeat = FEAT_WEAPON_FOCUS_SCIMITAR; nSpec = FEAT_WEAPON_SPECIALIZATION_SCIMITAR;
            nCrit = FEAT_IMPROVED_CRITICAL_SCIMITAR; break;
        case BASE_ITEM_SCYTHE:
            nFeat = FEAT_WEAPON_FOCUS_SCYTHE; nSpec = FEAT_WEAPON_SPECIALIZATION_SCYTHE;
            nCrit = FEAT_IMPROVED_CRITICAL_SCYTHE; break;
        case BASE_ITEM_SHORTSWORD:
            nFeat = FEAT_WEAPON_FOCUS_SHORT_SWORD; nSpec = FEAT_WEAPON_SPECIALIZATION_SHORT_SWORD;
            nCrit = FEAT_IMPROVED_CRITICAL_SHORT_SWORD; break;
        case BASE_ITEM_SICKLE:
            nFeat = FEAT_WEAPON_FOCUS_SICKLE; nSpec = FEAT_WEAPON_SPECIALIZATION_SICKLE;
            nCrit = FEAT_IMPROVED_CRITICAL_SICKLE; break;
        case BASE_ITEM_SHORTSPEAR:
            nFeat = FEAT_WEAPON_FOCUS_SPEAR; nSpec = FEAT_WEAPON_SPECIALIZATION_SPEAR;
            nCrit = FEAT_IMPROVED_CRITICAL_SPEAR; break;
        case BASE_ITEM_QUARTERSTAFF:
            nFeat = FEAT_WEAPON_FOCUS_STAFF; nSpec = FEAT_WEAPON_SPECIALIZATION_STAFF;
            nCrit = FEAT_IMPROVED_CRITICAL_STAFF; break;
        case BASE_ITEM_TWOBLADEDSWORD:
            nFeat = FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD; nSpec = FEAT_WEAPON_SPECIALIZATION_TWO_BLADED_SWORD;
            nCrit = FEAT_IMPROVED_CRITICAL_TWO_BLADED_SWORD; break;
        case BASE_ITEM_GLOVES:
            nFeat = FEAT_WEAPON_FOCUS_UNARMED_STRIKE; nSpec = FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE;
            nCrit = FEAT_IMPROVED_CRITICAL_UNARMED_STRIKE; break;
        case BASE_ITEM_WARHAMMER:
            nFeat = FEAT_WEAPON_FOCUS_WAR_HAMMER; nSpec = FEAT_WEAPON_SPECIALIZATION_WAR_HAMMER;
            nCrit = FEAT_IMPROVED_CRITICAL_WAR_HAMMER; break;
        case BASE_ITEM_WHIP:
            nFeat = FEAT_WEAPON_FOCUS_WHIP; nSpec = FEAT_WEAPON_SPECIALIZATION_WHIP;
            nCrit = FEAT_IMPROVED_CRITICAL_WHIP;
    }

    if (GetHasFeat(nFeat, oDamager))
        nChance += 10;  // Focus bonus
    if (GetHasFeat(nSpec, oDamager))
        nChance += 15;  // Weapon Spec bonus
    if (GetHasFeat(nCrit, oDamager))
        nChance += 15;  // Improved Critical bonus

    // Here Max Chance is 110 which means 5% chance of glancing and 5% of heavy criticals
    // The size bonuses below now vary from
    //      40 when tiny attacked huge
    // through to
    //      165 when huge hits tiny but will be reduced back to 110 anyway

    //DAMAGER SIZE ADJUSTMENTS
    if(nDSize == CREATURE_SIZE_HUGE)  {nChance +=  40;}
    if(nDSize == CREATURE_SIZE_LARGE) {nChance +=  20;}
    if(nDSize == CREATURE_SIZE_MEDIUM){nChance +=   0;}
    if(nDSize == CREATURE_SIZE_SMALL) {nChance += -15;}
    if(nDSize == CREATURE_SIZE_TINY)  {nChance += -30;}

    //CREATURE SIZE ADJUSTMENTS
    if(nCSize == CREATURE_SIZE_HUGE)  {nChance += -40;}
    if(nCSize == CREATURE_SIZE_LARGE) {nChance += -20;}
    if(nCSize == CREATURE_SIZE_MEDIUM){nChance +=   0;}
    if(nCSize == CREATURE_SIZE_SMALL) {nChance +=  15;}
    if(nCSize == CREATURE_SIZE_TINY)  {nChance +=  30;}

    // We limit max chance to 110 so that 90-95 won't get a heavy critical
    // if allowed to be more then 110 there will never be glancing criticals
    // and simple 10% heavy criticals (assuming the numbers are still 171 and 201)
    return (nChance > 110) ? 110 : nChance;
}

// dk: 11-Dec-2005 Totally reveiwed numbers in all below
int OAI_RangedCalcKillChance(object oDamager, object oCreature, object oWeapon)
{
    int nChance;
    int nWeapon = GetBaseItemType(oWeapon);
    int nAC = GetAC(oCreature);

    //IF IMMUNE TO CRITICALS, THEN IMMUNE TO THIS
    if(GetIsImmune(oCreature,IMMUNITY_TYPE_CRITICAL_HIT) == TRUE){return 0;}

    int PlayerRace = GetRacialType(oDamager);
    int EnemySize = GetCreatureSize(oCreature);
    int EnemyRace = GetRacialType(oCreature);

    //IMMUNTIES/RESISTANCES TO INSTANT KILLS
    if(EnemyRace == RACIAL_TYPE_DRAGON)   {return 0;} //You can't blow away Dragons
    if(EnemyRace == RACIAL_TYPE_UNDEAD)   {return 0;} //nor Undead (they're already dead)
    if(EnemyRace == RACIAL_TYPE_OUTSIDER) {return 0;} //nor Outsiders
    if(EnemyRace == RACIAL_TYPE_CONSTRUCT){return 0;} //nor Constructs
    if(EnemyRace == RACIAL_TYPE_ELEMENTAL){return 0;} //nor Elementals

    //BASE SETTINGS
    switch (nWeapon)
    {
        case BASE_ITEM_LONGBOW: nChance = 30; break;
        case BASE_ITEM_SHORTBOW: nChance = 25; break;
        case BASE_ITEM_LIGHTCROSSBOW: nChance = 25; break;
        case BASE_ITEM_HEAVYCROSSBOW: nChance = 35; break;
        case BASE_ITEM_SLING: nChance = 15; break;
        case BASE_ITEM_THROWINGAXE: nChance = 20; break;
        case BASE_ITEM_DART: nChance = 15; break;
        case BASE_ITEM_SHURIKEN: nChance = 20; break;
    }

    //SETTINGS DUE TO ARMOR
    if(nAC > 35)     {nChance += -40;}
    else if(nAC > 25){nChance += -25;}
    else if(nAC > 20){nChance += -15;}
    else if(nAC > 15){nChance += -10;}
    else if(nAC > 10){nChance +=   0;}
    else if(nAC >  0){nChance +=  15;}
    else if(nAC == 0){nChance +=  25;}

    //SETTINGS DUE TO WEAPON FOCUS/SPECIALIZATION
    //A modest %15 boost for focused weapon
    if(nWeapon == BASE_ITEM_LONGBOW && GetHasFeat(FEAT_WEAPON_FOCUS_LONGBOW, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_SHORTBOW && GetHasFeat(FEAT_WEAPON_FOCUS_SHORTBOW, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_LIGHTCROSSBOW && GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_HEAVYCROSSBOW && GetHasFeat(FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_SLING && GetHasFeat(FEAT_WEAPON_FOCUS_SLING, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_THROWINGAXE && GetHasFeat(FEAT_WEAPON_FOCUS_THROWING_AXE, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_DART && GetHasFeat(FEAT_WEAPON_FOCUS_DART, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_SHURIKEN && GetHasFeat(FEAT_WEAPON_FOCUS_SHURIKEN, oDamager) == TRUE){nChance += 15;}

    //An addition %15 for specialization
    if(nWeapon == BASE_ITEM_LONGBOW && GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LONGBOW, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_SHORTBOW && GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORTBOW, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_LIGHTCROSSBOW && GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_CROSSBOW, oDamager) == TRUE){nChance+= 15;}
    if(nWeapon == BASE_ITEM_HEAVYCROSSBOW && GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HEAVY_CROSSBOW, oDamager) == TRUE){nChance+= 15;}
    if(nWeapon == BASE_ITEM_SLING && GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SLING, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_THROWINGAXE && GetHasFeat(FEAT_WEAPON_SPECIALIZATION_THROWING_AXE, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_DART && GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DART, oDamager) == TRUE){nChance += 15;}
    if(nWeapon == BASE_ITEM_SHURIKEN && GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHURIKEN, oDamager) == TRUE){nChance += 15;}

    //An addition %20 for Improved Critical
    if(nWeapon == BASE_ITEM_LONGBOW && GetHasFeat(FEAT_IMPROVED_CRITICAL_LONGBOW, oDamager) == TRUE){nChance += 20;}
    if(nWeapon == BASE_ITEM_SHORTBOW && GetHasFeat(FEAT_IMPROVED_CRITICAL_SHORTBOW, oDamager) == TRUE){nChance += 20;}
    if(nWeapon == BASE_ITEM_LIGHTCROSSBOW && GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_CROSSBOW, oDamager) == TRUE){nChance+= 20;}
    if(nWeapon == BASE_ITEM_HEAVYCROSSBOW && GetHasFeat(FEAT_IMPROVED_CRITICAL_HEAVY_CROSSBOW, oDamager) == TRUE){nChance+= 20;}
    if(nWeapon == BASE_ITEM_SLING && GetHasFeat(FEAT_IMPROVED_CRITICAL_SLING, oDamager) == TRUE){nChance += 20;}
    if(nWeapon == BASE_ITEM_THROWINGAXE && GetHasFeat(FEAT_IMPROVED_CRITICAL_THROWING_AXE, oDamager) == TRUE){nChance += 20;}
    if(nWeapon == BASE_ITEM_DART && GetHasFeat(FEAT_IMPROVED_CRITICAL_DART, oDamager) == TRUE){nChance += 20;}
    if(nWeapon == BASE_ITEM_SHURIKEN && GetHasFeat(FEAT_IMPROVED_CRITICAL_SHURIKEN, oDamager) == TRUE){nChance += 20;}

    //SETTINGS DUE TO PLAYER RACE
    if(PlayerRace == RACIAL_TYPE_ELF && nWeapon == BASE_ITEM_LONGBOW){nChance += 20;}
    if(PlayerRace == RACIAL_TYPE_HALFELF && nWeapon == BASE_ITEM_LONGBOW){nChance += 10;}
    if(PlayerRace == RACIAL_TYPE_HALFLING && nWeapon == BASE_ITEM_SLING){nChance += 20;}

    //SETTINGS DUE TO ENEMY SIZE
    if(EnemySize == CREATURE_SIZE_HUGE)  {nChance +=  10;}
    if(EnemySize == CREATURE_SIZE_LARGE) {nChance +=   5;}
    if(EnemySize == CREATURE_SIZE_MEDIUM){nChance +=   0;}
    if(EnemySize == CREATURE_SIZE_SMALL) {nChance += -15;}
    if(EnemySize == CREATURE_SIZE_TINY)  {nChance += -25;}

    //FORTITUDE/REFLEX SAVING THROW
    //if(FortitudeSave(oCreature,nChance/5 + 20)){return 0;}
    //if(ReflexSave(oCreature,nChance/5 + 20)){return 0;}

    // Here a zero is a real modifier, change to 1 to allow critical roll
    if (nChance == 0) nChance = 1;
    return nChance;
}

int OAI_IsRidingHorse(object oCreature)
{
  if(GetPhenoType(oCreature) == 3) return TRUE;
  if(GetPhenoType(oCreature) == 5) return TRUE;
  if(GetPhenoType(oCreature) == 6) return TRUE;
  if(GetPhenoType(oCreature) == 8) return TRUE;

  return FALSE;
}

void OAI_MountUp(object oCreature)
{
  object oCityProper = GetNearestObjectByTag("CityProper",OBJECT_SELF);
  if(GetIsObjectValid(oCityProper)) return;

  int nType = 0;

  if(GetBattleCondition(OAI_ROLE_HORSEMAN_SADDLE))
  {
    int nPheno = GetPhenoType(OBJECT_SELF);
    int nPChange = -1;
    if(nPheno == PHENOTYPE_NORMAL)
    {
      nPChange = OAI_NORMAL_M;
    }
    if(nPheno == PHENOTYPE_BIG)
    {
      nPChange = OAI_LARGE_M;
    }

    if(nPChange != -1)
    {
      SetPhenoType(nPChange);

      //Now Set the Horse
      int nRH = d4(1);
      switch (nRH)
      {
        case 1 : SetCreatureTailType(OAI_TAILTYPE_BRN_SADDLE,OBJECT_SELF);break;
        case 2 : SetCreatureTailType(OAI_TAILTYPE_DPL_SADDLE,OBJECT_SELF);break;
        case 3 : SetCreatureTailType(OAI_TAILTYPE_SPT_SADDLE,OBJECT_SELF);break;
        case 4 : SetCreatureTailType(OAI_TAILTYPE_BLK_SADDLE,OBJECT_SELF);break;
      }

      //Set Horse Speed
      effect eSpeed = SupernaturalEffect(EffectMovementSpeedIncrease(50));
      ApplyEffectToObject(DURATION_TYPE_PERMANENT , eSpeed, OBJECT_SELF);
    }

    return;
  }

  if(GetBattleCondition(OAI_ROLE_HORSEMAN_RCLOTH))
  {
    int nPheno = GetPhenoType(OBJECT_SELF);
    int nPChange = -1;
    if(nPheno == PHENOTYPE_NORMAL)
    {
      nPChange = OAI_NORMAL_M;
    }
    if(nPheno == PHENOTYPE_BIG)
    {
      nPChange = OAI_LARGE_M;
    }

    if(nPChange != -1)
    {
      SetPhenoType(nPChange);

      //Now Set the Horse
      int nRH = d4(1);
      switch (nRH)
      {
        case 1 : SetCreatureTailType(OAI_TAILTYPE_BRN_RCLOTH,OBJECT_SELF);break;
        case 2 : SetCreatureTailType(OAI_TAILTYPE_DPL_RCLOTH,OBJECT_SELF);break;
        case 3 : SetCreatureTailType(OAI_TAILTYPE_SPT_RCLOTH,OBJECT_SELF);break;
        case 4 : SetCreatureTailType(OAI_TAILTYPE_BLK_RCLOTH,OBJECT_SELF);break;
      }

      //Set Horse Speed
      effect eSpeed = SupernaturalEffect(EffectMovementSpeedIncrease(46));
      ApplyEffectToObject(DURATION_TYPE_PERMANENT , eSpeed, OBJECT_SELF);
    }

    return;
  }

  if(GetBattleCondition(OAI_ROLE_HORSEMAN_PCLOTH))
  {
    int nPheno = GetPhenoType(OBJECT_SELF);
    int nPChange = -1;
    if(nPheno == PHENOTYPE_NORMAL)
    {
      nPChange = OAI_NORMAL_M;
    }
    if(nPheno == PHENOTYPE_BIG)
    {
      nPChange = OAI_LARGE_M;
    }

    if(nPChange != -1)
    {
      SetPhenoType(nPChange);

      //Now Set the Horse
      int nRH = d4(1);
      switch (nRH)
      {
        case 1 : SetCreatureTailType(OAI_TAILTYPE_BRN_PCLOTH,OBJECT_SELF);break;
        case 2 : SetCreatureTailType(OAI_TAILTYPE_DPL_PCLOTH,OBJECT_SELF);break;
        case 3 : SetCreatureTailType(OAI_TAILTYPE_SPT_PCLOTH,OBJECT_SELF);break;
        case 4 : SetCreatureTailType(OAI_TAILTYPE_BLK_PCLOTH,OBJECT_SELF);break;
      }

      //Set Horse Speed
      effect eSpeed = SupernaturalEffect(EffectMovementSpeedIncrease(46));
      ApplyEffectToObject(DURATION_TYPE_PERMANENT , eSpeed, OBJECT_SELF);
    }

    return;
  }

  if(GetBattleCondition(OAI_ROLE_HORSEMAN_LEATHER))
  {
    int nPheno = GetPhenoType(OBJECT_SELF);
    int nPChange = -1;
    if(nPheno == PHENOTYPE_NORMAL)
    {
      nPChange = OAI_NORMAL_M;
    }
    if(nPheno == PHENOTYPE_BIG)
    {
      nPChange = OAI_LARGE_M;
    }

    if(nPChange != -1)
    {
      SetPhenoType(nPChange);

      //Now Set the Horse
      int nRH = d4(1);
      switch (nRH)
      {
        case 1 : SetCreatureTailType(OAI_TAILTYPE_BRN_LEATHER,OBJECT_SELF);break;
        case 2 : SetCreatureTailType(OAI_TAILTYPE_DPL_LEATHER,OBJECT_SELF);break;
        case 3 : SetCreatureTailType(OAI_TAILTYPE_SPT_LEATHER,OBJECT_SELF);break;
        case 4 : SetCreatureTailType(OAI_TAILTYPE_BLK_LEATHER,OBJECT_SELF);break;
      }

      //Set Horse Speed
      effect eSpeed = SupernaturalEffect(EffectMovementSpeedIncrease(46));
      ApplyEffectToObject(DURATION_TYPE_PERMANENT , eSpeed, OBJECT_SELF);
    }

    return;
  }

  if(GetBattleCondition(OAI_ROLE_HORSEMAN_CHAIN))
  {
    int nPheno = GetPhenoType(OBJECT_SELF);
    int nPChange = -1;
    if(nPheno == PHENOTYPE_NORMAL)
    {
      nPChange = OAI_NORMAL_M;
    }
    if(nPheno == PHENOTYPE_BIG)
    {
      nPChange = OAI_LARGE_M;
    }

    if(nPChange != -1)
    {
      SetPhenoType(nPChange);

      //Now Set the Horse
      int nRH = d4(1);
      switch (nRH)
      {
        case 1 : SetCreatureTailType(OAI_TAILTYPE_BRN_CHAIN,OBJECT_SELF);break;
        case 2 : SetCreatureTailType(OAI_TAILTYPE_DPL_CHAIN,OBJECT_SELF);break;
        case 3 : SetCreatureTailType(OAI_TAILTYPE_SPT_CHAIN,OBJECT_SELF);break;
        case 4 : SetCreatureTailType(OAI_TAILTYPE_BLK_CHAIN,OBJECT_SELF);break;
      }

      //Set Horse Speed
      effect eSpeed = SupernaturalEffect(EffectMovementSpeedIncrease(44));
      ApplyEffectToObject(DURATION_TYPE_PERMANENT , eSpeed, OBJECT_SELF);
    }

    return;
  }

  if(GetBattleCondition(OAI_ROLE_HORSEMAN_SCAIL))
  {
    int nPheno = GetPhenoType(OBJECT_SELF);
    int nPChange = -1;
    if(nPheno == PHENOTYPE_NORMAL)
    {
      nPChange = OAI_NORMAL_M;
    }
    if(nPheno == PHENOTYPE_BIG)
    {
      nPChange = OAI_LARGE_M;
    }

    if(nPChange != -1)
    {
      SetPhenoType(nPChange);

      //Now Set the Horse
      int nRH = d4(1);
      switch (nRH)
      {
        case 1 : SetCreatureTailType(OAI_TAILTYPE_BRN_SCAIL,OBJECT_SELF);break;
        case 2 : SetCreatureTailType(OAI_TAILTYPE_DPL_SCAIL,OBJECT_SELF);break;
        case 3 : SetCreatureTailType(OAI_TAILTYPE_SPT_SCAIL,OBJECT_SELF);break;
        case 4 : SetCreatureTailType(OAI_TAILTYPE_BLK_SCAIL,OBJECT_SELF);break;
      }

      //Set Horse Speed
      effect eSpeed = SupernaturalEffect(EffectMovementSpeedIncrease(42));
      ApplyEffectToObject(DURATION_TYPE_PERMANENT , eSpeed, OBJECT_SELF);
    }

    return;
  }
}

void OAI_TrampleCharge(object oCreature)
{


}

int OAI_TrampleCalcKillChance(object oDamager, object oCreature)
{
    int nChance;
    int nAC = GetAC(oCreature);

    //IF IMMUNE TO CRITICALS, THEN IMMUNE TO THIS
    if(GetIsImmune(oCreature,IMMUNITY_TYPE_CRITICAL_HIT) == TRUE){return 0;}

    int PlayerRace = GetRacialType(oDamager);
    int EnemySize = GetCreatureSize(oCreature);
    int EnemyRace = GetRacialType(oCreature);

    //IMMUNTIES/RESISTANCES TO INSTANT KILLS
    if(EnemyRace == RACIAL_TYPE_DRAGON)   {return 0;} //You can't blow away Dragons
    if(EnemyRace == RACIAL_TYPE_UNDEAD)   {return 0;} //nor Undead (they're already dead)
    if(EnemyRace == RACIAL_TYPE_OUTSIDER) {return 0;} //nor Outsiders
    if(EnemyRace == RACIAL_TYPE_CONSTRUCT){return 0;} //nor Constructs
    if(EnemyRace == RACIAL_TYPE_ELEMENTAL){return 0;} //nor Elementals

    //HORSE BASE CHANCE
    nChance = 30;

    //SETTINGS DUE TO ARMOR
    if(nAC > 35)     {nChance += -20;}
    else if(nAC > 25){nChance += -15;}
    else if(nAC > 20){nChance += -10;}
    else if(nAC > 15){nChance +=  -5;}
    else if(nAC > 10){nChance +=   0;}
    else if(nAC >  0){nChance +=   5;}
    else if(nAC == 0){nChance +=  10;}

    //ADD DISCIPLINE TO TRAMPLE CHANCE
    int nDisc = GetSkillRank(SKILL_DISCIPLINE,oDamager);

    //SETTINGS DUE TO ENEMY SIZE
    if(EnemySize == CREATURE_SIZE_HUGE)  {nChance += -10;}
    if(EnemySize == CREATURE_SIZE_LARGE) {nChance +=  -5;}
    if(EnemySize == CREATURE_SIZE_MEDIUM){nChance +=   0;}
    if(EnemySize == CREATURE_SIZE_SMALL) {nChance +=  10;}
    if(EnemySize == CREATURE_SIZE_TINY)  {nChance +=  20;}

    // Here a zero is a real modifier, change to 1 to allow critical roll
    if (nChance == 0) nChance = 1;
    return nChance;
}

void OAI_TrampleFallChance(object oDamager, object oCreature)
{
    int nFall = d100(1);

    int nChance;
    int EnemySize = GetCreatureSize(oCreature);

    //SETTINGS DUE TO ARMOR
    int nAC = GetAC(oCreature);
    if(nAC > 35)     {nChance += 10;}
    else if(nAC > 25){nChance +=  7;}
    else if(nAC > 20){nChance +=  4;}
    else if(nAC > 15){nChance +=  2;}
    else if(nAC > 10){nChance +=  1;}

    //ADD DISCIPLINE TO FALL OFF ROLL
    int nDisc = GetSkillRank(SKILL_DISCIPLINE,oDamager);
    nFall = nFall + nDisc;

    //SETTINGS DUE TO ENEMY SIZE
    if(EnemySize == CREATURE_SIZE_HUGE)  {nChance +=  40;}
    if(EnemySize == CREATURE_SIZE_LARGE) {nChance +=  30;}
    if(EnemySize == CREATURE_SIZE_MEDIUM){nChance +=  20;}
    if(EnemySize == CREATURE_SIZE_SMALL) {nChance +=  10;}
    if(EnemySize == CREATURE_SIZE_TINY)  {nChance +=   0;}

    //Fall Off Horse if Fall Chance
    if(nChance > nFall)
    {
      //TODO :: Switch Back to Normal

    }
}

void OAI_Trample(object oDamager,object oCreature=OBJECT_SELF)
{
  int nRoll = uroll();
  if (nRoll < 81) return;

  // These two numbers need to be tweaked to suite your tastes
  /*
   * NOTE: If we limit chance to 110 then 90-95 will be glancing critical for highly
   *       skilled characters and 96+ will almost alway be a kill giving us 5% chance
   *       of each. Has a nice feel to it. Remember these criticals are in addition to
   *       the standard critical hits so we don't want them occuring all the time. Which
   *       is why 201 is a good heavy threshold. Its still in reach of a novice and never
   *       guaranteed (over a glancing critical that is, keep reading).
   *
   * Also: The lower critical for kill shots is okay as player level is not counted,
   *       only weapon base and some feats are counted allowing the chance add for a
   *       kill shot to max out at around 90-100 with a min of 15 which again gives a
   *       max kill chance of about 5%. These numbers have worked well so far.
   */
  int nCritThreshold = 171;         // # needed to score a critical hit
  int nCritKillThreshold = 201;     // # needed to score a killing critical hit
  int nKC;

  //Need Body Location
  /*
    1 - 2   => Head
    3       => Neck
    4 - 5   => Chest
    6 - 7   => Waist
    8       => Groin
    9 - 11  => Right Arm
    12 - 14 => Left Arm
    15 - 17 => Right Leg
    18 - 20 => Left Leg
  */
  int nBodyPart = d20(1);

  // Color Variables
  string RED = "<có  >";
  string GRAY = "<c°°°>";

  //VFX Blood
  effect eSBlood = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
  effect eMBlood = EffectVisualEffect(VFX_COM_CHUNK_RED_MEDIUM);

  //Vermin for Green Blood
  int nCRace = GetRacialType(oCreature);
  if(nCRace == RACIAL_TYPE_VERMIN)
  {
    eSBlood = EffectVisualEffect(VFX_COM_CHUNK_GREEN_SMALL);
    eMBlood = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);
  }

  //Calculate Critical Chance
  nKC = OAI_TrampleCalcKillChance(oDamager, oCreature);
  if(nKC == 0) return;        // No chance allowed
  if (GetIsPC(oDamager))
        SendMessageToPC(oDamager, "nRoll = " + IntToString(nRoll) + " nSkill = " + IntToString(nKC));
  nRoll += nKC;

  // No critical threshold then finish here
  if(nRoll < nCritThreshold) return;

  //Heavy or Glancing
  int nHit = 1;
  if (nRoll >= nCritKillThreshold) nHit = 2;

/******************************************************************************/
//:: HEAD

  if(nBodyPart >= 1 && nBodyPart <= 2)
  {
    //Helmets
    if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature)) == BASE_ITEM_HELMET)
    {
      if(nHit == 2) DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature));
      nHit = 1;
    }

    //Heavy Hit
    if(nHit == 2)
    {
      //Apply Voice Chat
      PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

      AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

      int nD3 = d3(1);
      switch(nD3)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HHEAD_HEAVY1)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HHEAD_HEAVY2)); break;
        case 3: AssignCommand(oCreature,SpeakString(GRAY+HHEAD_HEAVY3)); break;
      }

      //Apply Visual
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

      //Apply Death Effects
      OAI_CritKills(oCreature, oDamager);
    }
    else
    {
      AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

      int nD2 = d2(1);
      switch(nD2)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
      }

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oCreature, HoursToSeconds(4));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
    }

    return;
  }

/******************************************************************************/
//:: NECK

  if(nBodyPart == 3)
  {
    //Heavy Hit
    if(nHit == 2)
    {
      //Apply Voice Chat
      PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

      AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

      int nD3 = d3(1);
      switch(nD3)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HNECK_HEAVY1)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HNECK_HEAVY2)); break;
        case 3: AssignCommand(oCreature,SpeakString(GRAY+HNECK_HEAVY3)); break;
      }

      //Apply Visual
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

      //Apply Death Effects
      OAI_CritKills(oCreature, oDamager);
    }
    else
    {
      AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

      int nD2 = d2(1);
      switch(nD2)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
      }

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, 3.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
    }

    return;
  }


/******************************************************************************/
//:: CHEST

  if(nBodyPart >= 4 && nBodyPart <= 5)
  {
    //Heavy Hit
    if(nHit == 2)
    {
      //Apply Voice Chat
      PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

      AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

      int nD3 = d3(1);
      switch(nD3)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HCHEST_HEAVY1)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HCHEST_HEAVY2)); break;
        case 3: AssignCommand(oCreature,SpeakString(GRAY+HCHEST_HEAVY3)); break;
      }

      //Apply Visual
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

      //Apply Death Effects
      OAI_CritKills(oCreature, oDamager);
    }
    else
    {
      AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

      int nD2 = d2(1);
      switch(nD2)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
      }

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, 3.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
    }

    return;
  }

/******************************************************************************/
//:: WAIST

  if(nBodyPart >= 6 && nBodyPart <= 7)
  {
    //Heavy Hit
    if(nHit == 2)
    {
      //Apply Voice Chat
      PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

      AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

      int nD3 = d3(1);
      switch(nD3)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HWAIST_HEAVY1)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HWAIST_HEAVY2)); break;
        case 3: AssignCommand(oCreature,SpeakString(GRAY+HWAIST_HEAVY3)); break;
      }

      //Apply Visual
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eMBlood, oCreature);

      //Apply Death Effects
      OAI_CritKills(oCreature, oDamager);
    }
    else
    {
      AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

      int nD2 = d2(1);
      switch(nD2)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
      }

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
    }

    return;
  }

/******************************************************************************/
//:: RIGHT ARM

  if(nBodyPart >= 9 && nBodyPart <= 11)
  {
    //Heavy Hit
    if(nHit == 2)
    {
      //Weapon
      object oCWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature);
      if(GetIsObjectValid(oCWeapon) == TRUE)
      {
        //Drops Weapon
        CreateObject(OBJECT_TYPE_ITEM, GetResRef(oCWeapon), GetLocation(oCreature));
        DestroyObject(oCWeapon, 0.5);
      }

      //Apply Voice Chat
      PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

      AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

      int nD3 = d3(1);
      switch(nD3)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HARM_HEAVY1)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HARM_HEAVY2)); break;
        case 3: AssignCommand(oCreature,SpeakString(GRAY+HARM_HEAVY3)); break;
      }

      //Apply Visual
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
    }
    else
    {
      AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

      int nD2 = d2(1);
      switch(nD2)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
      }

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
    }

    return;
  }

/******************************************************************************/
//:: LEFT ARM

  if(nBodyPart >= 12 && nBodyPart <= 14)
  {
    //Shield
    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature)) == TRUE)
    {
      if(nHit == 2)
      {
        object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature);
        int nShield = GetBaseItemType(oShield);
        if(nShield == BASE_ITEM_LARGESHIELD
          || nShield == BASE_ITEM_SMALLSHIELD
          || nShield == BASE_ITEM_TOWERSHIELD)
        {
          //Destroy Shield
          DestroyObject(oShield, 0.5);
          nHit = 1;
        }
      }
    }

    //Heavy Hit
    if(nHit == 2)
    {
      //Apply Voice Chat
      PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

      AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

      int nD3 = d3(1);
      switch(nD3)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HARM_HEAVY1)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HARM_HEAVY2)); break;
        case 3: AssignCommand(oCreature,SpeakString(GRAY+HARM_HEAVY3)); break;
      }

      //Apply Visual
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
    }
    else
    {
      AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

      int nD2 = d2(1);
      switch(nD2)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
      }

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oCreature, RoundsToSeconds(1));
    }

    return;
  }

/******************************************************************************/
//:: LEGS

  if(nBodyPart >= 15 && nBodyPart <= 20)
  {
    //Heavy Hit
    if(nHit == 2)
    {
      //Apply Voice Chat
      PlayVoiceChat(VOICE_CHAT_DEATH,oCreature);

      AssignCommand(oCreature,SpeakString(RED+"Heavy Critical: "));

      int nD3 = d3(1);
      switch(nD3)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HLEG_HEAVY1)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HLEG_HEAVY2)); break;
        case 3: AssignCommand(oCreature,SpeakString(GRAY+HLEG_HEAVY3)); break;
      }

      //Apply Visual
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eSBlood, oCreature);

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(20, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, RoundsToSeconds(1));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
    }
    else
    {
      AssignCommand(oCreature,SpeakString(RED+"Glancing Critical: "));

      int nD2 = d2(1);
      switch(nD2)
      {
        case 1: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
        case 2: AssignCommand(oCreature,SpeakString(GRAY+HORSE_GLANCE)); break;
      }

      //Apply Additional Damage
      AssignCommand(oDamager, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_BLUDGEONING), oCreature));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCreature, RoundsToSeconds(1));
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oCreature, RoundsToSeconds(2));
    }

    return;
  }
}

int OAI_TryToWhirl(object oCreature)
{
  int nSTR = GetAbilityScore(oCreature,ABILITY_STRENGTH);
  int nINT = GetAbilityScore(oCreature,ABILITY_INTELLIGENCE);
  int nWhirl = nSTR + nINT;

  if(GetHasFeat(FEAT_WHIRLWIND_ATTACK) || GetHasFeat(FEAT_IMPROVED_WHIRLWIND))
  {
    int nNumberofAttackers = WhirlwindGetNumberOfMeleeAttackers(WHIRL_DISTANCE);
    if(nNumberofAttackers)
    {
      if(Random(100) + 1 <= nWhirl)
      {
        ActionUseFeat(FEAT_WHIRLWIND_ATTACK, oCreature);
        return TRUE;
      }
      else return FALSE;
    }
    else return FALSE;
  }
  return FALSE;
}

//General Melee Combat
void OAI_MeleeGeneral(object oTarget,object oCreature = OBJECT_SELF)
{
  int nAC = GetAC(oTarget);
  int nAttack = GetHitDice(OBJECT_SELF);
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH);
  int nDiff = (nAttack + nSTR) - nAC;

  //Try to Enhance Weapon
  int nWeapon = FALSE;
  if(TrySpell(SPELL_KEEN_EDGE, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_BLADE_THIRST, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_BLACKSTAFF, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_GREATER_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_FLAME_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;

  //Try Taunt
  int nTaunt = GetLocalInt(oCreature,"OAI_TAUNTTRY");
  if(GetSkillRank(SKILL_TAUNT) > GetSkillRank(SKILL_CONCENTRATION) && nTaunt == 0 && d2() == 1)
  {
    SetLocalInt(oCreature,"OAI_TAUNTTRY",1);
    PlayVoiceChat(VOICE_CHAT_TAUNT);
    ActionUseSkill(SKILL_TAUNT, oTarget);
    DetermineCombatRound(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_BARBARIAN_RAGE) && !GetHasSpellEffect(307) && GetLevelByClass(CLASS_TYPE_BARBARIAN) > 0)
  {
    ActionUseFeat(FEAT_BARBARIAN_RAGE, OBJECT_SELF);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_BARBARIAN_RAGE);
    DetermineCombatRound(oTarget);
  }

  if(GetHasFeat(FEAT_IMPROVED_POWER_ATTACK) && nDiff > 9)
  {
    ActionUseFeat(FEAT_IMPROVED_POWER_ATTACK, oTarget);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_POWER_ATTACK) && nDiff > 4)
  {
    ActionUseFeat(FEAT_POWER_ATTACK, oTarget);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_SHADOW_DAZE) && !GetHasFeatEffect(FEAT_SHADOW_DAZE, oTarget))
  {
    ActionUseFeat(FEAT_SHADOW_DAZE, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SHADOW_DAZE);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  int nFeat = -1;
  int nRand = Random(4);
  if (nRand == 0)
  {
    int nMySize = GetCreatureSize(OBJECT_SELF);
    if(GetHasFeat(FEAT_IMPROVED_KNOCKDOWN))
    {
      nFeat = FEAT_IMPROVED_KNOCKDOWN;
      nMySize++;
    }
    else if (GetHasFeat(FEAT_KNOCKDOWN))
    {
      nFeat = FEAT_KNOCKDOWN;
    }
    if(GetIsImmune(oTarget, IMMUNITY_TYPE_KNOCKDOWN) || GetCreatureSize(oTarget) > nMySize+1) nFeat = -1;
  }

  if(nFeat != -1)
  {
    ActionUseFeat(nFeat, oTarget);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  nFeat = -1;
  nRand = Random(4);
  if(nRand == 0 && GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget)))
  {
    int nMySize = GetCreatureSize(OBJECT_SELF);
    if(GetHasFeat(FEAT_IMPROVED_DISARM) && nDiff > 3)
    {
      nFeat = FEAT_IMPROVED_DISARM;
      nMySize++;
    }
    else if (GetHasFeat(FEAT_DISARM) && nDiff > 5)
    {
      nFeat = FEAT_DISARM;
    }
  }

  if(nFeat != -1)
  {
    ActionUseFeat(nFeat, oTarget);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_INFLICT_CRITICAL_WOUNDS))
  {
    ActionUseFeat(FEAT_INFLICT_CRITICAL_WOUNDS, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_INFLICT_CRITICAL_WOUNDS);
    OAI_WrapperActionAttack(oTarget);
    return;
  }
  if(GetHasFeat(FEAT_INFLICT_SERIOUS_WOUNDS))
  {
    ActionUseFeat(FEAT_INFLICT_SERIOUS_WOUNDS, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_INFLICT_SERIOUS_WOUNDS);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_CONTAGION))
  {
    ActionUseFeat(FEAT_CONTAGION, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_CONTAGION);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  talent tUse = GetCreatureTalent(TALENT_CATEGORY_HARMFUL_MELEE,20);
  if(GetIsTalentValid(tUse) && VerifyCombatMeleeTalent(tUse, oTarget))
  {
    bkTalentFilter(tUse, oTarget);
    return;
  }

  // dk: 5-Jun-2006 Probably need a default hit the enemy here
  OAI_WrapperActionAttack(oTarget);
}

//General Melee Combat
void OAI_MeleeDexterity(object oTarget,object oCreature = OBJECT_SELF)
{
  int nAC = GetAC(oTarget);
  int nAttack = GetHitDice(OBJECT_SELF);
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH);
  int nDiff = (nAttack + nSTR) - nAC;

  //Try to Enhance Weapon
  int nWeapon = FALSE;
  if(TrySpell(SPELL_BLADE_THIRST, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_KEEN_EDGE, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;

  if(GetHasFeat(FEAT_SHADOW_DAZE) && !GetHasFeatEffect(FEAT_SHADOW_DAZE, oTarget))
  {
    ActionUseFeat(FEAT_SHADOW_DAZE, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SHADOW_DAZE);
  }

  //Try to Flank and Parry
  location lLoc;
  location lLFlank = GetFlankingLeftLocation(oTarget);
  location lRFlank = GetFlankingRightLocation(oTarget);
  location lFLFlank = GetForwardFlankingLeftLocation(oTarget);
  location lFRFlank = GetForwardFlankingRightLocation(oTarget);

  if(d2() == 1)
  {
    switch(d4())
    {
      case 1: lLoc = lLFlank; break;
      case 2: lLoc = lRFlank; break;
      case 3: lLoc = lFLFlank; break;
      case 4: lLoc = lFRFlank; break;
    }

    ClearAllActions();
    ActionMoveToLocation(lLoc, TRUE);
  }

  if(SpecialTacticsDefensive(oTarget)) return;

  OAI_WrapperActionAttack(oTarget);
}

//Ranged Combat
void OAI_RangedCombat(object oTarget,object oCreature = OBJECT_SELF)
{
  int nArQty = GetLocalInt(oTarget,"ARROW");
  int nBoQty = GetLocalInt(oTarget,"BOLT");
  int nBuQty = GetLocalInt(oTarget,"BULLET");

  //Switch to Melee
  if(GetDistanceToObject(oTarget) < 5.0 && !GetHasFeat(FEAT_POINT_BLANK_SHOT))
  {
    DetermineCombatRound(oTarget);
    return;
  }

  //Force the Ranged Equip
  if(!GetIsWieldingRanged(OBJECT_SELF))
  {
    ClearAllActions();
    OAI_EquipRanged();
  }

  //Arcane Archer
  if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER) > 0)
  {
    if(GetHasFeat(FEAT_PRESTIGE_ARROW_OF_DEATH))
    {
      ActionUseFeat(FEAT_PRESTIGE_ARROW_OF_DEATH, oTarget);
      DecrementRemainingFeatUses(OBJECT_SELF,FEAT_PRESTIGE_ARROW_OF_DEATH);
      ActionAttack(oTarget);
      return;
    }

    if(GetHasFeat(FEAT_PRESTIGE_HAIL_OF_ARROWS))
    {
      ActionUseFeat(FEAT_PRESTIGE_HAIL_OF_ARROWS, OBJECT_SELF);
      DecrementRemainingFeatUses(OBJECT_SELF,FEAT_PRESTIGE_HAIL_OF_ARROWS);
      ActionAttack(oTarget);
      return;
    }

    if(GetHasFeat(FEAT_PRESTIGE_IMBUE_ARROW))
    {
      ActionUseFeat(FEAT_PRESTIGE_IMBUE_ARROW, oTarget);
      DecrementRemainingFeatUses(OBJECT_SELF,FEAT_PRESTIGE_IMBUE_ARROW);
      ActionAttack(oTarget);
      return;
    }

    if(GetHasFeat(FEAT_PRESTIGE_SEEKER_ARROW_2))
    {
      ActionUseFeat(FEAT_PRESTIGE_SEEKER_ARROW_2, oTarget);
      DecrementRemainingFeatUses(OBJECT_SELF,FEAT_PRESTIGE_SEEKER_ARROW_2);
      ActionAttack(oTarget);
      return;
    }

    if(GetHasFeat(FEAT_PRESTIGE_SEEKER_ARROW_1))
    {
      ActionUseFeat(FEAT_PRESTIGE_SEEKER_ARROW_1, oTarget);
      DecrementRemainingFeatUses(OBJECT_SELF,FEAT_PRESTIGE_SEEKER_ARROW_1);
      ActionAttack(oTarget);
      return;
    }
  }

  //Occasionally use active feats
  int nRand = Random(5);
  int nFeat = -1;
  object oRanged = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
  if(nRand == 0 && GetHasFeat(FEAT_CALLED_SHOT))
  {
    nFeat = FEAT_CALLED_SHOT;
  }
  else if(nRand == 1 && GetHasFeat(FEAT_RAPID_SHOT))
  {
    if(IsBow(oRanged) && nArQty > 0) nFeat = FEAT_RAPID_SHOT;
    if(IsSling(oRanged) && nBuQty > 0) nFeat = FEAT_RAPID_SHOT;
  }
  else if(nRand == 2 && GetHasFeat(FEAT_RAPID_RELOAD))
  {
    if(IsCrossbow(oRanged) && nBoQty > 0) nFeat = FEAT_RAPID_RELOAD;
  }

  if(nFeat != -1)
  {
    ClearAllActions();
    ActionUseFeat(nFeat, oTarget);
  }

  if(SpecialTacticsRanged(oTarget)) return;

  OAI_WrapperActionAttack(oTarget);
}

//Religious Melee Combat
void OAI_MeleeDivine(object oTarget,object oCreature = OBJECT_SELF)
{
  //First Try Divine Spells
  int nWeapon = FALSE;
  if(TrySpell(SPELL_DIVINE_POWER, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_DIVINE_FAVOR, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;

  //Now Try to Enhance Weapon
  if(TrySpell(SPELL_HOLY_SWORD, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_GREATER_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_DARKFIRE, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_BLESS_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_DEAFENING_CLANG, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;

  //Now Try Feats
  if(GetHasFeat(FEAT_DIVINE_MIGHT) && !GetHasSpellEffect(473))
  {
    ActionUseFeat(FEAT_DIVINE_MIGHT, OBJECT_SELF);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_DIVINE_MIGHT);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_DIVINE_SHIELD) && !GetHasSpellEffect(474))
  {
    ActionUseFeat(FEAT_DIVINE_SHIELD, OBJECT_SELF);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_DIVINE_SHIELD);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_DIVINE_WRATH) && !GetHasSpellEffect(474))
  {
    ActionUseFeat(FEAT_DIVINE_WRATH, OBJECT_SELF);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_DIVINE_WRATH);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetLevelByClass(CLASS_TYPE_SHADOWDANCER) && d4() == 1 && GetHasFeat(FEAT_SHADOW_DAZE))
  {
    ActionUseFeat(FEAT_SHADOW_DAZE,oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SHADOW_DAZE);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  //Fall Through
  DetermineCombatRound(oTarget);
}

//Smite Melee Combat
void OAI_MeleeSmite(object oTarget,object oCreature = OBJECT_SELF)
{
  //Now Try to Enhance Weapon
  int nWeapon = FALSE;
  if(TrySpell(SPELL_HOLY_SWORD, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_GREATER_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_DARKFIRE, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_BLESS_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_DEAFENING_CLANG, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;

  if(GetHasFeat(FEAT_SMITE_EVIL) && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL)
  {
    ActionUseFeat(FEAT_SMITE_EVIL, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SMITE_EVIL);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_SMITE_GOOD) && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_GOOD)
  {
    ActionUseFeat(FEAT_SMITE_GOOD, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SMITE_GOOD);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  //Turn Off Smite Melee and Fight Normal IF No More Smites
  if(!GetHasFeat(FEAT_SMITE_EVIL) && !GetHasFeat(FEAT_SMITE_GOOD))
  {
    SetStatusCondition(OAI_I_CAN_SMITE_MELEE,FALSE);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  //Fall Through
  DetermineCombatRound(oTarget);
}

//Sneak Melee Combat
void OAI_MeleeSneak(object oTarget,object oCreature = OBJECT_SELF)
{
  //Why Am I Here?
  if(!GetHasFeat(FEAT_SNEAK_ATTACK))
  {
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_SHADOW_EVADE) && !GetHasSpellEffect(SPELL_SHADOW_EVADE))
  {
    ActionUseFeat(FEAT_SHADOW_EVADE, OBJECT_SELF);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SHADOW_EVADE);
    OAI_WrapperActionAttack(oTarget);
    return;
  }
  else if(GetHasFeat(FEAT_PRESTIGE_INVISIBILITY_1) && !GetHasSpellEffect(SPELL_SHADOW_EVADE))
  {
    ActionUseFeat(FEAT_PRESTIGE_INVISIBILITY_1, OBJECT_SELF);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_PRESTIGE_INVISIBILITY_1);
    OAI_WrapperActionAttack(oTarget);
    return;
  }
  else if(GetHasFeat(FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE) && !GetHasSpellEffect(SPELL_SHADOW_EVADE))
  {
    ActionUseFeat(FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE, OBJECT_SELF);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE);
    OAI_WrapperActionAttack(oTarget);
    return;
  }
  if(GetHasFeat(FEAT_SHADOW_DAZE) && !GetHasFeatEffect(FEAT_SHADOW_DAZE, oTarget))
  {
    ActionUseFeat(FEAT_SHADOW_DAZE, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SHADOW_DAZE);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  if(SpecialTacticsAmbusher(oTarget)) return;

  //Fall Through
  DetermineCombatRound(oTarget);
}

//Weapon Master Melee Combat
void OAI_MeleeWeaponMaster(object oTarget,object oCreature = OBJECT_SELF)
{
  //Weapon Master Ki Damage
  if(TryKiDamage(oTarget) && d2() == 1) return;

  //Try a Whirlwind Attack
  if(OAI_TryToWhirl(OBJECT_SELF)) return;

  //Fall Through
  DetermineCombatRound(oTarget);
}

//Palemaster Melee Combat
void OAI_MeleePalemaster(object oTarget,object oCreature = OBJECT_SELF)
{
  //Try to Enhance Weapon
  int nWeapon = FALSE;
  if(TrySpell(SPELL_BLACKSTAFF, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_GREATER_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_FLAME_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_KEEN_EDGE, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;

  if(GetHasFeat(FEAT_DEATHLESS_MASTER_TOUCH))
  {
    ActionUseFeat(FEAT_DEATHLESS_MASTER_TOUCH, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_DEATHLESS_MASTER_TOUCH);
    ActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_UNDEAD_GRAFT_2))
  {
    ActionUseFeat(FEAT_UNDEAD_GRAFT_2, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_UNDEAD_GRAFT_2);
    ActionAttack(oTarget);
    return;
  }

  if(GetHasFeat(FEAT_UNDEAD_GRAFT_1))
  {
    ActionUseFeat(FEAT_UNDEAD_GRAFT_1, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF,FEAT_UNDEAD_GRAFT_1);
    ActionAttack(oTarget);
    return;
  }

  //Done with Melee....Lets go back to Being Just a Caster
  SetStatusCondition(OAI_I_CAN_PM_MELEE,FALSE);
  DetermineCombatRound(oTarget);
}

//Dragon Disciple Melee Combat
void OAI_MeleeRDD(object oTarget,object oCreature = OBJECT_SELF)
{
  //Try to Enhance Weapon
  int nWeapon = FALSE;
  if(TrySpell(SPELL_BLACKSTAFF, OBJECT_SELF) && nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_GREATER_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_MAGIC_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_FLAME_WEAPON, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;
  if(TrySpell(SPELL_KEEN_EDGE, OBJECT_SELF)&& nWeapon == FALSE) nWeapon = TRUE;

  if(GetHasFeat(FEAT_DRAGON_DIS_BREATH) && d2() == 1)
  {
    ActionCastSpellAtObject(690, GetNearestEnemy(), METAMAGIC_ANY, TRUE);
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_DRAGON_DIS_BREATH);
    OAI_WrapperActionAttack(oTarget);
    return;
  }

  //Fall Through
  DetermineCombatRound(oTarget);
}

//Shifter Melee Combat
void OAI_MeleeShifter(object oTarget,object oCreature = OBJECT_SELF)
{
  //The Shifter Chooses Which Wildshape They Wish
  if(GetHasFeat(FEAT_WILD_SHAPE)
    && !GetHasEffect(EFFECT_TYPE_POLYMORPH, OBJECT_SELF)
    && GetDistanceToObject(oTarget) < 10.0)
  {
    // Dragon Shape
    if(TrySpell(725, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      SetBattleCondition(OAI_ROLE_DRAGON);
      DetermineCombatRound(oTarget);
      return;
    }

    // Construct Shape
    if(TrySpell(737, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Undead Shape
    if(TrySpell(685, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Outsider Shape - Black Slaad
    if(TrySpell(735, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_CAST_SPELLS);
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Outsider Shape - Azer Chieftain
    if(TrySpell(733, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Outsider Shape - Rakshasa
    if(TrySpell(734, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_CAST_SPELLS);
      SetBattleCondition(OAI_ROLE_AOE_SPECIALIST);
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Human Shape - Drow
    if(TrySpell(682, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Human Shape - Lizardman
    if(TrySpell(683, OBJECT_SELF))
    {
      SetBattleCondition(OAI_COMBAT_FLAG_RANGED);
      SetCombatCondition(X0_COMBAT_FLAG_RANGED);
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Human Shape - Kobold Commando
    if(TrySpell(684, OBJECT_SELF))
    {
      SetBattleCondition(OAI_COMBAT_FLAG_AMBUSHER);
      SetCombatCondition(X0_COMBAT_FLAG_AMBUSHER);
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Large Dire Tiger
    if(TrySpell(694, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Medusa
    if(TrySpell(679, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // MindFlayer
    if(TrySpell(691, OBJECT_SELF))
    {
      SetBattleCondition(OAI_ROLE_MINDFLAYER);
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Greater Wildshape III
    if(TrySpell(676, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Greater Wildshape II
    if(TrySpell(675, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    // Greater Wildshape I
    if(TrySpell(646, OBJECT_SELF))
    {
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    if(GetHasFeat(FEAT_WILD_SHAPE) && !GetHasSpellEffect(320))
    {
      ActionUseFeat(FEAT_WILD_SHAPE, OBJECT_SELF);
      SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
      DetermineCombatRound(oTarget);
      return;
    }

    return;
  }

  SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);

  DetermineCombatRound(oTarget);
}

//Monk Melee Combat
void OAI_MeleeMonk(object oTarget,object oCreature = OBJECT_SELF)
{
  object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
  int nHaveWeapon = GetIsObjectValid(oMyWeapon);
  int nAC = GetAC(oTarget);
  float fAttack;
  int nAttack = GetHitDice(OBJECT_SELF);

  int nWIS = GetAbilityModifier(ABILITY_WISDOM);
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH);
  int nFS = GetFortitudeSavingThrow(oTarget);
  int nDiff = nAC - nAttack;

  if(GetHasFeat(FEAT_QUIVERING_PALM))
  {
    if((!nHaveWeapon || GetBaseItemType(oMyWeapon) == BASE_ITEM_KAMA)
      && GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT
      && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
      //Can insta-kill. Roll is DC10 + 0.5 * monks level + wis modifier vs Fort
      int nRoll = d10() + (nAttack/2) + nWIS;
      if(nRoll > nFS)
      {
        ActionUseFeat(FEAT_QUIVERING_PALM, oTarget);
        DecrementRemainingFeatUses(OBJECT_SELF,FEAT_QUIVERING_PALM);
        ActionAttack(oTarget);
        return;
      }
    }
  }

  if(!GetHasFeatEffect(FEAT_SAP, oTarget)
    && !GetHasFeatEffect(FEAT_STUNNING_FIST, oTarget)
    && !nHaveWeapon)
  {
    if(GetHasFeat(FEAT_STUNNING_FIST) && nDiff > 0)
    {
      ActionUseFeat(FEAT_STUNNING_FIST, oTarget);
      DecrementRemainingFeatUses(OBJECT_SELF,FEAT_STUNNING_FIST);
      ActionAttack(oTarget);
      return;
    }

    if(GetHasFeat(FEAT_SAP) && nDiff > 0)
    {
      ActionUseFeat(FEAT_SAP, oTarget);
      DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SAP);
      ActionAttack(oTarget);
      return;
    }
  }

  if(GetHasFeat(FEAT_FLURRY_OF_BLOWS)
    && (nDiff - 1) > 0
    && (!nHaveWeapon || GetBaseItemType(oMyWeapon) == BASE_ITEM_KAMA))
  {
    ActionUseFeat(FEAT_FLURRY_OF_BLOWS, oTarget);
    ActionAttack(oTarget);
    return;
  }

  //50% Use Defensive Tactics
  if(d2() == 1)
  {
    OAI_MeleeDexterity(oTarget);
    return;
  }

  //Fall Through
  DetermineCombatRound(oTarget);
}

void OAI_BlinkMove()
{
    vector vWho = GetPosition(OBJECT_SELF);
    float fWho;
    location lWho;
    location lOld = GetLocation(OBJECT_SELF);
    effect eBlink=EffectVisualEffect(GetLocalInt(OBJECT_SELF, "OAI_BLINK_FX"));
    int iX, iY;
    while(iX==0 && iY==0)
    {
      iX = (Random(7) - 3) * 2;
      iY = (Random(7) - 3) * 2;
    }
    vWho.x += IntToFloat(iX);
    vWho.y += IntToFloat(iY);
    iX=Random(3601);
    fWho=IntToFloat(iX) / 10.0;
    lWho=Location(GetArea(OBJECT_SELF), vWho, fWho);
    ClearAllActions();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlink, lOld);
    DelayCommand(0.5, JumpToLocation(lWho));
    DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlink, lWho));
    ActionDoCommand(SetFacing(fWho));
    if(GetIsPC(OBJECT_SELF)) SetCameraFacing(fWho);
}

void OAI_BlinkMelee(object oTarget)
{
    vector vWho = GetPosition(oTarget);
    float fWho = GetFacing(oTarget);
    location lWho;
    location lOld = GetLocation(OBJECT_SELF);
    effect eBlink=EffectVisualEffect(GetLocalInt(OBJECT_SELF, "OAI_BLINK_FX"));
    int iX, iY;
    while(iX==0 && iY==0)
    {
      iX = (Random(5) - 2);
      iY = (Random(5) - 2);
    }
    vWho.x += IntToFloat(iX);
    vWho.y += IntToFloat(iY);
    lWho=Location(oArea, vWho, fWho);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlink, lOld);
    DelayCommand(0.5, JumpToLocation(lWho));
    DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlink, lWho));
}

void OAI_SetUpBarbarian(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);

  //Good/Evil
  int nAlign = GetAlignmentGoodEvil(oCreature);
  int nMoral = GetAlignmentLawChaos(oCreature);

  //Dex or Strength Based Barbarian
  if(nDEX > nSTR)
  {
    SetStatusCondition(OAI_I_CAN_DEX_MELEE);
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }
  else SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);

  if(nAlign == ALIGNMENT_GOOD)
  {
    if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION))
    {
      SetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE);
    }
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpBard(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);

  //Good/Evil
  int nAlign = GetAlignmentGoodEvil(oCreature);
  int nMoral = GetAlignmentLawChaos(oCreature);

  SetStatusCondition(OAI_I_CAN_CAST_SPELLS);

  if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER))
  {
    SetBattleCondition(OAI_COMBAT_FLAG_RANGED);
  }

  if(nAlign == ALIGNMENT_GOOD)
  {
    if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION))
    {
      SetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE);
    }
  }

  if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_PALEMASTER))
  {
    SetStatusCondition(OAI_I_CAN_PM_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE))
  {
    SetStatusCondition(OAI_I_CAN_RDD_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpCleric(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);

  //Good/Evil
  int nAlign = GetAlignmentGoodEvil(oCreature);
  int nMoral = GetAlignmentLawChaos(oCreature);

  SetStatusCondition(OAI_I_CAN_CAST_SPELLS);
  SetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE);

  //Zen Archery
  if(GetHasFeat(FEAT_ZEN_ARCHERY))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }

  if(nAlign == ALIGNMENT_GOOD)
  {
    if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION))
    {
      SetStatusCondition(OAI_I_CAN_SMITE_MELEE);
    }
  }

  if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpDruid(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);

  SetStatusCondition(OAI_I_CAN_CAST_SPELLS);

  //Zen Archery
  if(GetHasFeat(FEAT_ZEN_ARCHERY))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }

  if(GetLevelByClass(CLASS_TYPE_SHIFTER))
  {
    SetStatusCondition(OAI_I_CAN_SHIFTER_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpFighter(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);

  //Good/Evil
  int nAlign = GetAlignmentGoodEvil(oCreature);
  int nMoral = GetAlignmentLawChaos(oCreature);

  //Dex or Strength Based Fighter
  if(nDEX > nSTR)
  {
    SetStatusCondition(OAI_I_CAN_DEX_MELEE);
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }
  else SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);

  if(nAlign == ALIGNMENT_GOOD)
  {
    if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION))
    {
      SetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE);
    }
  }

  if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER))
  {
    SetBattleCondition(OAI_COMBAT_FLAG_RANGED);
  }

  if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpMonk(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);
  int nWIS = GetAbilityModifier(ABILITY_WISDOM,oCreature);

  //Good/Evil
  int nAlign = GetAlignmentGoodEvil(oCreature);
  int nMoral = GetAlignmentLawChaos(oCreature);

  //Dex or Strength Based Monk
  if(nDEX > nSTR || nWIS >= 0)
  {
    SetStatusCondition(OAI_I_CAN_MONK_MELEE);
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }
  else SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);

  if(nAlign == ALIGNMENT_GOOD)
  {
    if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION))
    {
      SetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE);
    }
  }

  if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpPaladin(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);

  //Good/Evil
  int nAlign = GetAlignmentGoodEvil(oCreature);
  int nMoral = GetAlignmentLawChaos(oCreature);

  //Dex or Strength Based Paladin
  if(nDEX > nSTR)
  {
    SetStatusCondition(OAI_I_CAN_DEX_MELEE);
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }
  else SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);

  //Zen Archery
  if(GetHasFeat(FEAT_ZEN_ARCHERY))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }

  //Paladin Smite
  SetStatusCondition(OAI_I_CAN_SMITE_MELEE);

  if(nAlign == ALIGNMENT_GOOD)
  {
    if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION))
    {
      SetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE);
    }
  }

  if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpRanger(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);

  //Good/Evil
  int nAlign = GetAlignmentGoodEvil(oCreature);
  int nMoral = GetAlignmentLawChaos(oCreature);

  //Ranger Melee
  if(nDEX > nSTR)
  {
    SetStatusCondition(OAI_I_CAN_DEX_MELEE);
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }
  else SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);

  //Zen Archery
  if(GetHasFeat(FEAT_ZEN_ARCHERY))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }

  if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER))
  {
    SetBattleCondition(OAI_COMBAT_FLAG_RANGED);
  }

  if(nAlign == ALIGNMENT_GOOD)
  {
    if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION))
    {
      SetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE);
    }

    if(GetLevelByClass(CLASS_TYPE_HARPER))
    {
      SetBattleCondition(OAI_ROLE_BUFFER);
    }
  }

  if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER))
  {
    SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpRogue(object oCreature)
{
  //Personal Modifiers
  int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oCreature);
  int nDEX = GetAbilityModifier(ABILITY_DEXTERITY,oCreature);

  //Rogue Melee
  if(nDEX > nSTR)
  {
    SetStatusCondition(OAI_I_CAN_DEX_MELEE);
    SetStatusCondition(OAI_I_CAN_FIGHT_RANGED);
  }
  else SetStatusCondition(OAI_I_CAN_FIGHT_MELEE);

  if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER))
  {
    SetBattleCondition(OAI_COMBAT_FLAG_RANGED);
  }

  if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER))
  {
    SetStatusCondition(OAI_I_CAN_WM_MELEE);
  }
}

void OAI_SetUpSorcerer(object oCreature)
{
  SetStatusCondition(OAI_I_CAN_CAST_SPELLS);

  if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER))
  {
    SetBattleCondition(OAI_COMBAT_FLAG_RANGED);
  }

  if(GetLevelByClass(CLASS_TYPE_PALEMASTER))
  {
    SetStatusCondition(OAI_I_CAN_PM_MELEE);
  }

  if(GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE))
  {
    SetStatusCondition(OAI_I_CAN_RDD_MELEE);
  }
}

void OAI_SetUpWizard(object oCreature)
{
  SetStatusCondition(OAI_I_CAN_CAST_SPELLS);

  if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER))
  {
    SetBattleCondition(OAI_COMBAT_FLAG_RANGED);
  }

  if(GetLevelByClass(CLASS_TYPE_PALEMASTER))
  {
    SetStatusCondition(OAI_I_CAN_PM_MELEE);
  }
}

int OAI_MindFlayerCombat(object oTarget)
{
  SetBattleCondition(OAI_BLINK_SELF);

  int nChoice = 1;

  //Go Melee Against Petrified Targets
  if(GetHasEffect(EFFECT_TYPE_PETRIFY, oTarget) == TRUE) nChoice = 1;
  else if(GetIsPlayableRacialType(oTarget)
    && OAI_MFGetTargetConditionSucks(oTarget)
    || GetSubRace(oTarget)== "Tiefling")
  {
    nChoice = 2;
  }
  //If the target is down below 10 hp and AC is below 23, we go into melee as well
  else if(GetCurrentHitPoints(oTarget) < 10 && GetAC(oTarget) < 23) nChoice = 1;

  if(nChoice == 2)
  {
    if(GetDistanceBetween(OBJECT_SELF, oTarget) < 1.5f)
    {
      ActionMoveAwayFromObject(oTarget, FALSE, 1.5f);
    }

    ActionMoveToObject(oTarget, FALSE, 1.5f);
    ActionDoCommand(SetFacingPoint(GetPositionFromLocation(GetLocation(oTarget))));
    ActionWait(0.5f);

    if(OAI_MFGetTargetConditionSucks(oTarget))
    {
      ActionCastSpellAtObject(716, oTarget,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT);
      return TRUE;
    }

    //70% Chance Of Special Mind blast
    else if(d100() <= 70)
    {
      ActionCastSpellAtObject(551, oTarget,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT);
      return TRUE;
    }

    //Spells
    else
    {
      int nN = caiGetAvailableCombatSpell(OBJECT_SELF, oTarget);
      if(nN > 0)
      {
        ActionCastSpellAtObject(nN,oTarget);
        return TRUE;
      }
      else
      {
        if(WhatToDoAfterCasting(OBJECT_SELF)){}
        else ActionAttack(oTarget);
      }
    }
  }

  return FALSE;
}

int OAI_MFGetTargetConditionSucks(object oTarget)
{
  if(GetHasEffect(EFFECT_TYPE_POLYMORPH, oTarget) == TRUE) return FALSE;

  if(GetHasEffect(EFFECT_TYPE_STUNNED, oTarget)
    || GetHasEffect(EFFECT_TYPE_PARALYZE, oTarget)
    || GetHasEffect(VFX_DUR_PARALYZE_HOLD, oTarget)
    || GetHasEffect(VFX_DUR_PARALYZE_HOLD, oTarget) )
  {
    return TRUE;
  }
  else
  {
    // if dazed, try to brainsuck only 30% of the time)
    if(GetHasEffect(EFFECT_TYPE_DAZED, oTarget) && (Random(100) < 30) )
    {
      return TRUE;
    }
    return FALSE;
  }
}

int OAI_SpiderTactics(object oTarget)
{
  //Find the Weakest Enemy
  object oWeakest = GetFactionMostDamagedMember(oTarget);

  location lLoc = GetLocation(OBJECT_SELF);
  location lWeakest = GetLocation(oWeakest);

  if(GetDistanceToObject(oWeakest) > 4.0)
  {
    ClearAllActions();
    effect eVis = EffectDisappearAppear(lWeakest);
    effect eWeb = EffectVisualEffect(VFX_DUR_WEB);
    DelayCommand(0.3,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, 2.0));
    DelayCommand(2.3,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, lLoc, 2.0));
    DelayCommand(5.0,ActionAttack(oWeakest));
    return TRUE;
  }
  return FALSE;
}

//: AI FUNCTIONS
/******************************************************************************/

//void main(){}
