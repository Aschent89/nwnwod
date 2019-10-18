////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_spawn
//  by Don Anderson
//  dandersonru@msn.com
//
//  Main AI Spawn Script
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_base"
#include "oai_inc_eqweapon"
#include "x0_i0_spawncond"
#include "x0_i0_combat"

//OAI Placed Respawn....Setting Parameters
void OAI_SetRespawn(object oCreature);

//OAI Placed Respawn
void OAI_Respawn(object oCreature);

//OAI Create Respawning Creature
void OAI_CreateSpawn(int nType, string sResRef, location lLoc);

//Sets up Random Abilities
void SetRandomAbilitiesOnCreatureSpawn();

//OAI Random Loot Drops
void OAI_LootRandom(object oCreature,int nDice);

void WhoAmI()
{
  object oCreature = OBJECT_SELF;

  //Class 1 or 2 are the Setup Classes
  int nClass1 = GetClassByPosition(1,oCreature);
  int nClass2 = GetClassByPosition(2,oCreature);

//:: COMBAT ALLIANCES
  int nSet = 0;
  object oSpecial = GetObjectByTag("FACTION_1000");
  object oCommoner = GetObjectByTag("FACTION_1001");
  object oMerchant = GetObjectByTag("FACTION_1002");
  object oDefender = GetObjectByTag("FACTION_1003");
  object oHostile = GetObjectByTag("FACTION_1004");
  object oPackAnimal = GetObjectByTag("FACTION_1005");
  object oHorse = GetObjectByTag("FACTION_1006");
  object oPet = GetObjectByTag("FACTION_1007");

  if(GetFactionEqual(oCreature,oSpecial)) SetLocalString(oCreature,OAI_FACTION,NEUTRAL);
  if(GetFactionEqual(oCreature,oCommoner)) SetLocalString(oCreature,OAI_FACTION,NEUTRAL);
  if(GetFactionEqual(oCreature,oMerchant)) SetLocalString(oCreature,OAI_FACTION,NEUTRAL);
  if(GetFactionEqual(oCreature,oDefender)) SetLocalString(oCreature,OAI_FACTION,ALLY);
  if(GetFactionEqual(oCreature,oHostile)) SetLocalString(oCreature,OAI_FACTION,HOSTILE);
  if(GetFactionEqual(oCreature,oPackAnimal)) SetLocalString(oCreature,OAI_FACTION,INDEPENDENT);
  if(GetFactionEqual(oCreature,oHorse)) SetLocalString(oCreature,OAI_FACTION,INDEPENDENT);
  if(GetFactionEqual(oCreature,oPet)) SetLocalString(oCreature,OAI_FACTION,INDEPENDENT);
  string sCheck = GetLocalString(oCreature,OAI_FACTION);
  if(sCheck != "") nSet = 1;

  int nRth = 1;
  string sFaction = "FACTION_";
  string sName,sAllege,sNumber,sRep;
  object oRep = GetObjectByTag("FACTION_001");
  while(GetIsObjectValid(oRep) && nSet != 1)
  {
    if(GetFactionEqual(oCreature,oRep))
    {
      sName = GetName(oRep);
      sAllege = GetLocalString(oRep,"ALLIANCE");
      if(sAllege == "ALLY") SetLocalString(oCreature,OAI_FACTION,ALLY);
      else if(sAllege == "AXIS") SetLocalString(oCreature,OAI_FACTION,AXIS);
      else if(sAllege == "INDEPENDENT") SetLocalString(oCreature,OAI_FACTION,INDEPENDENT);
      else SetLocalString(oCreature,OAI_FACTION,NEUTRAL);

      sCheck = GetLocalString(oCreature,OAI_FACTION);
      if(sCheck != "") nSet = 1;

      break;
    }

    nRth++;
    if(nRth > 0 && nRth < 10) sNumber = "00" + IntToString(nRth);
    if(nRth >= 10 && nRth < 100) sNumber = "0" + IntToString(nRth);
    if(nRth >= 100 && nRth < 1000) sNumber = IntToString(nRth);
    sRep = sFaction + sNumber;
    oRep = GetObjectByTag(sRep);
  }

  if(GetHasSpell(SPELL_POLYMORPH_SELF)
    || GetHasSpell(SPELL_SHAPECHANGE)
    || GetHasSpell(SPELL_TENSERS_TRANSFORMATION))
  {
    SetStatusCondition(OAI_I_CAN_POLYMORPH);
  }

  //Summoning
  talent tSummon = GetCreatureTalent(TALENT_CATEGORY_BENEFICIAL_OBTAIN_ALLIES, 20);
  if(GetIsTalentValid(tSummon)) { SetStatusCondition(OAI_I_CAN_SUMMON); }

  //Timestop NPC Banning
  int nOAITSB = GetLocalInt(GetModule(),"OAITSB");
  if(nOAITSB == 1)
  {
    int nTSLoop = 1;
    while(GetHasSpell(SPELL_TIME_STOP,oCreature) && nTSLoop < 100)
    {
      DecrementRemainingSpellUses(oCreature, SPELL_TIME_STOP);
      nTSLoop++;
    }
  }

  //Turn Off Ambient Animations in Special Places
  object oAmbient = GetNearestObjectByTag("OAI_NoAmbient");
  if(GetIsObjectValid(oAmbient))
  {
    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS,FALSE);
    SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS,FALSE);
  }

  //Fear Cheating =)
  int nOAIFEAR = GetLocalInt(GetModule(),"OAIFEAR");
  effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nOAIFEAR, SAVING_THROW_TYPE_FEAR);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eSave, oCreature);

//:: CLASS SPECIFIC CONDITIONS

  if(nClass1 == CLASS_TYPE_BARBARIAN || nClass2 == CLASS_TYPE_BARBARIAN)
  {
    OAI_SetUpBarbarian(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_BARD || nClass2 == CLASS_TYPE_BARD)
  {
    OAI_SetUpBard(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_CLERIC || nClass2 == CLASS_TYPE_CLERIC)
  {
    OAI_SetUpCleric(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_DRUID || nClass2 == CLASS_TYPE_DRUID)
  {
    OAI_SetUpDruid(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_FIGHTER || nClass2 == CLASS_TYPE_FIGHTER)
  {
    OAI_SetUpFighter(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_MONK || nClass2 == CLASS_TYPE_MONK)
  {
    OAI_SetUpMonk(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_PALADIN || nClass2 == CLASS_TYPE_PALADIN)
  {
    OAI_SetUpPaladin(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_RANGER || nClass2 == CLASS_TYPE_RANGER)
  {
    OAI_SetUpRanger(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_ROGUE || nClass2 == CLASS_TYPE_ROGUE)
  {
    OAI_SetUpRogue(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_SORCERER || nClass2 == CLASS_TYPE_SORCERER)
  {
    OAI_SetUpSorcerer(oCreature);
  }

  else if(nClass1 == CLASS_TYPE_WIZARD || nClass2 == CLASS_TYPE_WIZARD)
  {
    OAI_SetUpWizard(oCreature);
  }

/******************************************************************************/
//:: OAI & NWN Default Spawn Setups

  string sResRef = GetResRef(OBJECT_SELF);
  string sTag = GetTag(OBJECT_SELF);

  //Encounter Spawned Creatures Get a Despawn Time of 240 Seconds
  //This is Checked in the Heartbeat of the Creature.
  if(GetIsEncounterCreature(OBJECT_SELF))
  {
    int nTime = OAI_GetCurrentRealSeconds();
    SetLocalInt(OBJECT_SELF,"OAI_DESPAWN",nTime);
  }

  //Set Up Default NWN Animals
  if(GetRacialType(OBJECT_SELF) == RACIAL_TYPE_ANIMAL)
  {
    ExecuteScript("oai_animals",OBJECT_SELF);
  }

  //Barmaid
  if(sTag == "Barmaid")
  {
    SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING,FALSE);
    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS,FALSE);
    SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS,FALSE);
    SetAnimationCondition(NW_ANIM_FLAG_CHATTER,FALSE);

    //Barmaid Speed =)
    effect eRate = SupernaturalEffect(EffectMovementSpeedDecrease(15));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRate, oCreature);

    SetLocalInt(OBJECT_SELF, "OAI_BARMAID", 1);
  }

  //Inn Cook
  if(sTag == "InnCook")
  {
    SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING,FALSE);
    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS,FALSE);
    SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS,FALSE);
    SetAnimationCondition(NW_ANIM_FLAG_CHATTER,FALSE);

    //Cook Speed =)
    effect eRate = SupernaturalEffect(EffectMovementSpeedDecrease(15));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRate, oCreature);

    SetLocalInt(OBJECT_SELF, "OAI_COOK", 1);
  }

  //Guards
  int nGuard = GetLocalInt(OBJECT_SELF,"OAI_GUARD");
  if(nGuard == 1)
  {
    SetBattleCondition(OAI_ROLE_GUARD);
  }

  //Stripper
  int nStripper = GetLocalInt(OBJECT_SELF,"OAI_STRIPPER");
  if(nStripper == 1)
  {
    SetBattleCondition(OAI_ROLE_STRIPPER);

    //Stripper Speed =)
    effect eRate = SupernaturalEffect(EffectMovementSpeedDecrease(25));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRate, oCreature);
  }

  //Manual Shapechanger
  if(GetLocalInt(OBJECT_SELF, "OAI_SHAPECHANGE") > 0) SetStatusCondition(OAI_I_CAN_POLYMORPH);

  //Set Up For Lycans
  if(OAI_GetIsLycan(OBJECT_SELF)) SetStatusCondition(OAI_I_CAN_POLYMORPH);

  //Natural Blinkers and Teleporters
  if(OAI_GetIsBlinker(OBJECT_SELF))
  {
    SetBattleCondition(OAI_BLINK_SELF);
    SetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE", 5);
  }

  //Gelatanous Cube
  if(OAI_GetIsGelCube(OBJECT_SELF))
  {
    SetBattleCondition(OAI_ROLE_GELATINOUSCUBE);
    SetSpawnInCondition(NW_FLAG_STEALTH);
    SetSpawnInCondition(NW_FLAG_SEARCH);

    effect eGhost = EffectCutsceneGhost();
    eGhost = SupernaturalEffect(eGhost);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eGhost,OBJECT_SELF);

    //75% Concealment
    effect eConceal = EffectConcealment(75, MISS_CHANCE_TYPE_NORMAL);
    eConceal = ExtraordinaryEffect(eConceal);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);

    //50% Immunity to Piercing
    effect ePiercing = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 50);
    ePiercing = ExtraordinaryEffect(ePiercing);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePiercing, OBJECT_SELF);

    //50% Immunity to Slashing
    effect eSlashing = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 50);
    eSlashing = ExtraordinaryEffect(eSlashing);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlashing, OBJECT_SELF);

    //100% Immunity to Negative
    effect eNegative = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    eNegative = ExtraordinaryEffect(eNegative);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNegative, OBJECT_SELF);

    //100% Immunity to Positive
    effect ePositive = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 100);
    ePositive = ExtraordinaryEffect(ePositive);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePositive, OBJECT_SELF);

    //100% Immunity to Electricity
    effect eElectrical = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 100);
    eElectrical = ExtraordinaryEffect(eElectrical);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eElectrical, OBJECT_SELF);
  }

  //Oozes, Puddings, Slimes
  if(OAI_GetIsOoze(OBJECT_SELF))
  {
    SetBattleCondition(OAI_ROLE_OOZE);
    SetSpawnInCondition(NW_FLAG_STEALTH);
    SetSpawnInCondition(NW_FLAG_SEARCH);

    //75% Concealment
    effect eConceal = EffectConcealment(75, MISS_CHANCE_TYPE_NORMAL);
    eConceal = ExtraordinaryEffect(eConceal);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);

    if(OAI_GetIsOozePudding(OBJECT_SELF))
    {
      SetBattleCondition(OAI_ROLE_PUDDING);

      //99% Immunity to Piercing
      effect ePiercing = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 99);
      ePiercing = ExtraordinaryEffect(ePiercing);
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePiercing, OBJECT_SELF);

      //99% Immunity to Slashing
      effect eSlashing = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 99);
      eSlashing = ExtraordinaryEffect(eSlashing);
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlashing, OBJECT_SELF);
    }

    if(OAI_GetIsOozeJelly(OBJECT_SELF))
    {
      SetBattleCondition(OAI_ROLE_JELLY);

      //75% Immunity to Piercing
      effect ePiercing = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 75);
      ePiercing = ExtraordinaryEffect(ePiercing);
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePiercing, OBJECT_SELF);

      //75% Immunity to Slashing
      effect eSlashing = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 75);
      eSlashing = ExtraordinaryEffect(eSlashing);
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlashing, OBJECT_SELF);
    }

    if(OAI_GetIsOozeSlime(OBJECT_SELF))
    {
      SetBattleCondition(OAI_ROLE_SLIME);

      //50% Immunity to Piercing
      effect ePiercing = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 50);
      ePiercing = ExtraordinaryEffect(ePiercing);
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePiercing, OBJECT_SELF);

      //50% Immunity to Slashing
      effect eSlashing = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 50);
      eSlashing = ExtraordinaryEffect(eSlashing);
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlashing, OBJECT_SELF);
    }

    //100% Immunity to Negative
    effect eNegative = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    eNegative = ExtraordinaryEffect(eNegative);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNegative, OBJECT_SELF);

    //100% Immunity to Positive
    effect ePositive = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 100);
    ePositive = ExtraordinaryEffect(ePositive);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePositive, OBJECT_SELF);

    //100% Immunity to Electricity
    effect eElectrical = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 100);
    eElectrical = ExtraordinaryEffect(eElectrical);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eElectrical, OBJECT_SELF);

    //100% Immunity to Acid
    effect eAcid = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, 100);
    eAcid = ExtraordinaryEffect(eAcid);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAcid, OBJECT_SELF);
  }

  //Mycons and Spores Generators
  if(OAI_GetIsMycon(OBJECT_SELF))
  {
    SetBattleCondition(OAI_ROLE_MYCON);

    //100% Immunity to Negative
    effect eNegative = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    eNegative = ExtraordinaryEffect(eNegative);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNegative, OBJECT_SELF);

    //100% Immunity to Positive
    effect ePositive = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 100);
    ePositive = ExtraordinaryEffect(ePositive);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePositive, OBJECT_SELF);

    //100% Immunity to Bludgeoning
    effect eBludgeoning = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 100);
    eBludgeoning = ExtraordinaryEffect(eBludgeoning);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBludgeoning, OBJECT_SELF);

    //100% Immunity to Electricity
    effect eElectrical = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 100);
    eElectrical = ExtraordinaryEffect(eElectrical);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eElectrical, OBJECT_SELF);

    //100% Immunity to Acid
    effect eAcid = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, 100);
    eAcid = ExtraordinaryEffect(eAcid);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAcid, OBJECT_SELF);

    if(OAI_GetIsMyconSpawner(OBJECT_SELF)) SetBattleCondition(OAI_ROLE_MYCONSPAWNER);
  }

  //Spiders
  if(OAI_GetIsSpider(OBJECT_SELF))
  {
    //Standard Spiders
    SetBattleCondition(OAI_RETURN_TO_SPAWNPOINT);
    SetLocalInt(OBJECT_SELF,"FIGHT_OR_FLIGHT",0);
    SetSpawnInCondition(NW_FLAG_SEARCH);
    SetBattleCondition(OAI_ROLE_SPIDER);
    SetBattleCondition(OAI_ROLE_NUMBEROFATTACKS);
    SetLocalInt(OBJECT_SELF,"OAI_ROLE_NUMBEROFATTACKS",3);
    SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);

    //Set Spider Senses
    effect eSight = EffectTrueSeeing();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSight, OBJECT_SELF);

    int nPhase = FALSE;
    int nApp = GetAppearanceType(oCreature);
    switch(nApp)
    {
      case 160: nPhase = TRUE; break;
      case 1315: nPhase = TRUE; break;
      case 1906: nPhase = TRUE; break;
      case 1907: nPhase = TRUE; break;
      case 1908: nPhase = TRUE; break;
      case 1909: nPhase = TRUE; break;
      case 1910: nPhase = TRUE; break;
    }

    if(nPhase == TRUE)
    {
      SetBattleCondition(OAI_BLINK_SELF);
      SetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE", 3);
    }

    int nWraith = FALSE;
    nApp = GetAppearanceType(OBJECT_SELF);
    switch(nApp)
    {
      case 162: nWraith = TRUE; break;
      case 1256: nWraith = TRUE; break;
      case 1918: nWraith = TRUE; break;
      case 1919: nWraith = TRUE; break;
      case 1920: nWraith = TRUE; break;
      case 1921: nWraith = TRUE; break;
      case 1922: nWraith = TRUE; break;
    }

    if(nWraith == TRUE)
    {
      SetBattleCondition(OAI_ROLE_GHOST);
    }
  }

  //Beetles and Other Burrowing Creatures
  if(OAI_GetIsBurrower(OBJECT_SELF))
  {
    SetBattleCondition(OAI_ROLE_BURROWER);

    //Large or Small Burrower?
    if(OAI_GetIsLargeBurrower(OBJECT_SELF)) SetBattleCondition(OAI_ROLE_LBURROWER);
    if(OAI_GetIsSmallBurrower(OBJECT_SELF)) SetBattleCondition(OAI_ROLE_SBURROWER);
  }

  //Automatic Ghosts
  if(OAI_GetIsGhost(OBJECT_SELF)) SetBattleCondition(OAI_ROLE_GHOST);

  //Manually Set Ghosts and Add Effects
  if(GetBattleCondition(OAI_ROLE_GHOST))
  {
    effect vfx = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, vfx, OBJECT_SELF);
    ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);

    effect eConceal = EffectConcealment(50, MISS_CHANCE_TYPE_NORMAL);
    eConceal = ExtraordinaryEffect(eConceal);
    effect eGhost = EffectCutsceneGhost();
    eGhost = ExtraordinaryEffect(eGhost);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
  }

  //Trolls
  if(OAI_GetIsTroll(OBJECT_SELF))
  {
    SetSpawnInCondition(NW_FLAG_SEARCH);
    SetBattleCondition(OAI_ROLE_TROLL);
    SetBattleCondition(OAI_ROLE_SPEEDY);
  }

  //MindFlayer
  if(OAI_GetIsMindFlayer(OBJECT_SELF))
  {
    SetBattleCondition(OAI_FAST_BUFF_ADVANCED);
    SetBattleCondition(OAI_BLINK_SELF);
    SetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE", 10);
    SetBattleCondition(OAI_ROLE_MINDFLAYER);
  }

  //Beholder
  if(OAI_GetIsBeholder(OBJECT_SELF))
  {
    SetBattleCondition(OAI_FAST_BUFF_ADVANCED);
    SetBattleCondition(OAI_CAST_AURAS_NOW);
    SetBattleCondition(OAI_BLINK_SELF);
    SetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE", 20);
    SetBattleCondition(OAI_ROLE_BEHOLDER);
    SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);
  }

  //Dragon
  if(OAI_GetIsDragon(OBJECT_SELF))
  {
    SetBattleCondition(OAI_ROLE_DRAGON);
    SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);
  }

  //Vampires
  if(OAI_GetIsVampire(OBJECT_SELF))
  {
    SetBattleCondition(OAI_ROLE_VAMPIRE);
  }

  //Winged Creatures
  if(OAI_GetIsWinged(OBJECT_SELF))
  {
    SetBattleCondition(OAI_ROLE_WINGED);
  }

  //Set As Able To Raise Dead
  if(GetHasSpell(SPELL_RESURRECTION) || GetHasSpell(SPELL_RAISE_DEAD))
  {
    SetStatusCondition(OAI_I_CAN_RAISE_DEAD);
  }

  //Suicide Bombers =O
  int nSuicide = GetLocalInt(OBJECT_SELF, "OAI_SUICIDE");
  if(nSuicide == 1) SetBattleCondition(OAI_ROLE_SUICIDE);

  //Transforming Creatures....Creature to Tree/Stone....whatever
  int nXForm = GetLocalInt(OBJECT_SELF, "OAI_TRANSFORM");
  if(nXForm == 1) SetBattleCondition(OAI_ROLE_TRANSFORMER);

//:: OAI & NWN Default Spawn Setups
/******************************************************************************/

  if(GetBattleCondition(OAI_ROLE_GROUP_LEADER)) SetLocalInt(OBJECT_SELF,"OAI_I_AM_A_LEADER",1);

  int nIllusionary = GetLocalInt(OBJECT_SELF, "OAI_ILLUSION_DC");
  int nAT = GetLocalInt(OBJECT_SELF, "OAI_REAL_SELF");
  if(nIllusionary > 0)
  {
    if(nAT > 0)
    {
      SetLocalInt(OBJECT_SELF,"OAI_HAS_ILLUSION",TRUE);
      SetCreatureAppearanceType(OBJECT_SELF ,nAT);
    }
  }

  if(GetBattleCondition(OAI_ROLE_SPEEDY))
  {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectHaste(),OBJECT_SELF);
  }

  if(GetBattleCondition(OAI_ROLE_NUMBEROFATTACKS))
  {
    int nNOA = GetLocalInt(OBJECT_SELF,"OAI_ROLE_NUMBEROFATTACKS");

    //Set Range
    if(nNOA < 1) nNOA = 5;
    if(nNOA > 5) nNOA = 5;

    effect eNOA = EffectModifyAttacks(nNOA);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eNOA), OBJECT_SELF);
  }

  if(GetBattleCondition(OAI_ROLE_HORSEMAN))
  {
    OAI_MountUp(OBJECT_SELF);
  }

  //Special NWN Combat AI's
  if(GetBattleCondition(OAI_COMBAT_FLAG_RANGED))
  {
    SetCombatCondition(X0_COMBAT_FLAG_RANGED);
  }
  if(GetBattleCondition(OAI_COMBAT_FLAG_DEFENSIVE))
  {
    SetCombatCondition(X0_COMBAT_FLAG_DEFENSIVE);
  }
  if(GetBattleCondition(OAI_COMBAT_FLAG_AMBUSHER))
  {
    SetCombatCondition(X0_COMBAT_FLAG_AMBUSHER);
  }
  if(GetBattleCondition(OAI_COMBAT_FLAG_COWARDLY))
  {
    SetCombatCondition(X0_COMBAT_FLAG_COWARDLY);
  }

  //If Evil Do Not Buff Others
  if(GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL)
  {
    SetBattleCondition(OAI_ROLE_BUFFER, FALSE);
  }

  //Do we need to remember where we spawned?
  if(GetBattleCondition(OAI_RETURN_TO_SPAWNPOINT)) SetLocalLocation(OBJECT_SELF, "OAI_SPAWN_LOCATION", GetLocation(OBJECT_SELF));

  //OAI Respawn is Enabled?
  if(GetLocalInt(GetModule(),"OAIRESPAWN"))
  {
    //If Module is Already Running for DM Spawns Don't Set Respawn
    int nMR = GetLocalInt(GetModule(),"MODULE_RUNNING");
    if(nMR <= 0)
    {
      SetLocalLocation(OBJECT_SELF, "OAI_SPAWN_LOCATION", GetLocation(OBJECT_SELF));
      OAI_SetRespawn(OBJECT_SELF);
    }
  }

  //Dynamically created Torches
  int nOAITORCH = GetLocalInt(GetModule(),"OAITORCH");
  if(nOAITORCH == 1)
  {
    //Check for an Existing Torch
    object oLight = GetModItemWithProperty(OBJECT_SELF, PROP_LIGHT, PROPV_TORCH);

    //No Torch...lets try a Random to give one
    if(!GetIsObjectValid(oLight))
    {
      switch(GetRacialType(OBJECT_SELF))
      {
        case RACIAL_TYPE_HUMANOID_ORC:
        case RACIAL_TYPE_HUMANOID_GOBLINOID:
        case RACIAL_TYPE_HUMANOID_REPTILIAN:
        case RACIAL_TYPE_HUMANOID_MONSTROUS:
          // Smaller chance for humanoids to have torches
          if (d8() == 1) CreateItemOnObject("torch");
          break;
        case RACIAL_TYPE_HUMAN:
        case RACIAL_TYPE_HALFORC:
        case RACIAL_TYPE_DWARF:
        case RACIAL_TYPE_ELF:
        case RACIAL_TYPE_GNOME:
        case RACIAL_TYPE_HALFELF:
        case RACIAL_TYPE_HALFLING:
          switch (d10())
          {
            case 1:
            case 2:
            case 3:
              CreateItemOnObject("torch");
              break;
            case 4:
              CreateItemOnObject("lantern");
              break;
          }
      }
    }
  }

  //Upgrade Armor
  object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
  if(GetIsObjectValid(oArmor))
  {
    SetIdentified(oArmor,TRUE);
    OAI_UpgradeArmor(oArmor);
  }

  //Set Up Our Weapons
  object oRH = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
  if(GetIsObjectValid(oRH)) SetIdentified(oRH,TRUE);
  object oLH = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
  if(GetIsObjectValid(oLH)) SetIdentified(oLH,TRUE);

  DelayCommand(4.0, OAI_ChooseWeapons());

  //Racial Movement Rate for Small Creatures (Configured in oai_mod_onload)
  int nRacial = GetLocalInt(GetModule(),"RACIALMOVE");
  if(nRacial == 1) SetRacialMovementRate(OBJECT_SELF);

  //Use Search and Stealth for Flag
  if(GetSpawnInCondition(NW_FLAG_SEARCH)) ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
  if(GetSpawnInCondition(NW_FLAG_STEALTH)) ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
}

void OAI_SetRespawn(object oCreature)
{
  object oMod = GetModule();

  //Module is Already Running for DM Spawns
  int nMR = GetLocalInt(oMod,"MODULE_RUNNING");
  if(nMR > 0) return;

  //Creature Initialized Already
  int nRInitial = GetLocalInt(oCreature,"OAI_RESPAWN_INITIALIZE");
  if(nRInitial > 0) return;

  //Creature is Handled by NESS (Neshke's Extended Spawn System)
  string sNESS = GetLocalString(oCreature, "f_Template");
  if(sNESS != "")
  {
    SetLocalInt(oCreature,"OAI_RESPAWN_ENABLE",0);
    SetLocalInt(oCreature,"OAI_RESPAWN_INITIALIZE",1);
    return;
  }

  //Creature Respawning Enabled
  int nEnable = GetLocalInt(oMod,"OAI_RESPAWN_ENABLE");
  if(nEnable <= 0 && nRInitial == 1) return;

  //Initialize Respawn
  int nWP = FALSE;
  object oWP = GetNearestObjectByTag("OAI_RESPAWN");
  float fWP = GetDistanceBetween(oCreature,oWP);
  if(fWP < 11.0)nWP = TRUE;
  if(nWP == TRUE)
  {
    int nRE = GetLocalInt(oWP,"OAI_RESPAWN_ENABLE");
    int nRD = GetLocalInt(oWP,"OAI_RESPAWN_DELAY");
    int nRR = GetLocalInt(oWP,"OAI_RESPAWN_RANDOM");

    SetLocalInt(oCreature,"OAI_RESPAWN_ENABLE",nRE);
    SetLocalInt(oCreature,"OAI_RESPAWN_DELAY",nRD);
    SetLocalInt(oCreature,"OAI_RESPAWN_RANDOM",nRR);
  }
  else
  {
    SetLocalInt(oCreature,"OAI_RESPAWN_ENABLE",1);
    SetLocalInt(oCreature,"OAI_RESPAWN_DELAY",10);
    SetLocalInt(oCreature,"OAI_RESPAWN_RANDOM",5);
  }

  SetLocalInt(oCreature,"OAI_SPAWN",1);
  SetLocalInt(oCreature,"OAI_RESPAWN_INITIALIZE",1);
}

void OAI_Respawn(object oCreature)
{
  //Not a Placed Spawn
  if(GetLocalInt(oCreature,"OAI_SPAWN")) return;

  object oMod = GetModule();

  int nType      = GetObjectType(oCreature);
  string sResRef = GetResRef(oCreature);
  location lLoc  = GetLocalLocation(oCreature, "OAI_SPAWN_LOCATION");
  float fFacing  = GetFacing(oCreature);

  //Encounter Creatures Will Just Despawn
  if(GetIsEncounterCreature(oCreature)) return;

  //Creature Respawning Not Enabled
  int nEnable = GetLocalInt(oCreature,"OAI_RESPAWN_ENABLE");
  if(nEnable <= 0) return;

  //Respawn Delay
  int nRD = GetLocalInt(oCreature,"OAI_RESPAWN_DELAY");

  //Respawn Random
  int nRR = GetLocalInt(oCreature,"OAI_RESPAWN_RANDOM");
  int nD2 = d2(1);//1 is Add, 2 is Subtract

  //New Respawn Time
  int nNRT = nRD + nRR;
  if(nD2 == 2) nNRT = nRD - nRR;
  if(nNRT <= 0) nNRT = 1;
  float fNRT = IntToFloat(nNRT) * 60.0;

  //Process Respawn
  AssignCommand(oMod, DelayCommand(fNRT, OAI_CreateSpawn(nType, sResRef, lLoc)));
}

void OAI_CreateSpawn(int nType, string sResRef, location lLoc)
{
  object oNew = CreateObject(nType, sResRef, lLoc);
  SetLocalInt(oNew, "OAI_SPAWN", 1);
}

void SetRandomAbilitiesOnCreatureSpawn()
{

  int nRandomize = GetLocalInt(GetModule(),"OAI_RANDOM_ABILITIES");
  if(nRandomize == 0) return;

  object oSpawnedCreature = OBJECT_SELF;

  int nSpawnCreatureAssociateType = GetAssociateType(oSpawnedCreature);
  int nSpawnSummonCreatureLevel;

  string sResRefCreature = GetResRef(oSpawnedCreature);

  //BonusMalus Effects
  effect eSpawnStrengthBonus;
  effect eSpawnStrengthMalus;
  effect eSpawnDexterityBonus;
  effect eSpawnDexterityMalus;
  effect eSpawnConstitutionBonus;
  effect eSpawnConstitutionMalus;
  effect eSpawnWisdomBonus;
  effect eSpawnWisdomMalus;
  effect eSpawnIntelligenceBonus;
  effect eSpawnIntelligenceMalus;
  effect eSpawnCharismaBonus;
  effect eSpawnCharismaMalus;
  effect eSpawnAttackBonus;
  effect eSpawnAttackMalus;
  effect eSpawnArmorClassBonus;
  effect eSpawnArmorClassMalus;
  effect eSpawnSavingThrowFortBonus;
  effect eSpawnSavingThrowFortMalus;
  effect eSpawnSavingThrowDexBonus;
  effect eSpawnSavingThrowDexMalus;
  effect eSpawnSavingThrowWillBonus;
  effect eSpawnSavingThrowWillMalus;
  effect eSpawnSkillDisciplineBonus;
  effect eSpawnSkillDisciplineMalus;
  effect eSpawnSkillSpotBonus;
  effect eSpawnSkillSpotMalus;
  effect eSpawnSkillListenBonus;
  effect eSpawnSkillListenMalus;
  effect eSpawnSkillConcentrationBonus;
  effect eSpawnSkillConcentrationMalus;
  effect eSpawnExtraAttackBonus;

  //For undead, elementals, planars, constructs, vermin racial types only
  effect eSpawnTurningResistenceBonus;
  effect eSpawnTurningResistenceMalus;

  //Final BonusMalus linked effects
  effect eBonusMalusLink;

  //Visual effects
  effect eGhostSmoke1 = EffectVisualEffect(VFX_DUR_GHOST_SMOKE);
  effect eGhostSmoke2 = EffectVisualEffect(VFX_DUR_GHOST_SMOKE_2);
  effect eGhostTransparent = EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT);
  effect eGhostlyVisagePulse = EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE);
  effect eGhostlyVisage = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
  effect eEtherealVisage = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);

  effect eGhost = EffectCutsceneGhost();

  //Illusionary creatures
  int nIllusionary = GetLocalInt(OBJECT_SELF, "OAI_ILLUSION_DC");
  int nAT = GetLocalInt(OBJECT_SELF, "OAI_REAL_SELF");

  switch (nSpawnCreatureAssociateType)
  {
    /*
    Animal companions, familiars and henchmen are not subjected
    to randomizer functions as to maintain their specific profile
    as characters.
    Dominated creatures were already spawned before falling under
    player control, hence were likely already applied a randomizer effect
    */
    case ASSOCIATE_TYPE_ANIMALCOMPANION:
    case ASSOCIATE_TYPE_DOMINATED:
    case ASSOCIATE_TYPE_FAMILIAR:
    case ASSOCIATE_TYPE_HENCHMAN:
      break;

    /*
    Summoned creatures, as they are random creatures conjured by the caster,
    are determined by the spell cast for what concerns the type of creature
    and its basic power level (picking them from the module blueprint list for
    creatures), and then their stats and talents are randomized upon spawning.
    */
    case ASSOCIATE_TYPE_SUMMONED:

    /*
    Gets the power of the summoned creature
    and sets the number of attacks depending
    on creature power level.
    It overrides the toolset settings, for easier customization.
    */
    nSpawnSummonCreatureLevel = StringToInt(GetStringRight(sResRefCreature, 1));
    switch (nSpawnSummonCreatureLevel)
    {
      case 1:
      case 2:
      case 3:
        SetBaseAttackBonus(1, oSpawnedCreature);
        break;
      case 4:
      case 5:
      case 6:
        SetBaseAttackBonus(2, oSpawnedCreature);
        break;
      case 7:
      case 8:
      case 9:
        SetBaseAttackBonus(3, oSpawnedCreature);
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnStrengthBonus = EffectAbilityIncrease(ABILITY_STRENGTH, d4());
        break;
      case 2:
        eSpawnStrengthMalus = EffectAbilityDecrease(ABILITY_STRENGTH, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnDexterityBonus = EffectAbilityIncrease(ABILITY_DEXTERITY, d4());
        break;
      case 2:
        eSpawnDexterityMalus = EffectAbilityDecrease(ABILITY_DEXTERITY, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnConstitutionBonus = EffectAbilityIncrease(ABILITY_CONSTITUTION, d4());
        break;
      case 2:
        eSpawnConstitutionMalus = EffectAbilityDecrease(ABILITY_CONSTITUTION, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnWisdomBonus = EffectAbilityIncrease(ABILITY_WISDOM, d4());
        break;
      case 2:
        eSpawnWisdomMalus = EffectAbilityDecrease(ABILITY_WISDOM, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnAttackBonus = EffectAttackIncrease(ATTACK_BONUS_MISC, d4());
        break;
      case 2:
        eSpawnAttackMalus = EffectAttackDecrease(d4(), ATTACK_BONUS_MISC);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnArmorClassBonus = EffectACIncrease(d4(), AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
        break;
      case 2:
        eSpawnArmorClassMalus = EffectACDecrease(d4(), AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSavingThrowFortBonus = EffectSavingThrowIncrease(SAVING_THROW_FORT, d8(), SAVING_THROW_ALL);
        break;
      case 2:
        eSpawnSavingThrowFortMalus = EffectSavingThrowDecrease(SAVING_THROW_FORT, d4(), SAVING_THROW_ALL);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSavingThrowDexBonus = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, d8(), SAVING_THROW_ALL);
        break;
      case 2:
        eSpawnSavingThrowDexMalus = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, d4(), SAVING_THROW_ALL);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSavingThrowWillBonus = EffectSavingThrowIncrease(SAVING_THROW_WILL, d8(), SAVING_THROW_ALL);
        break;
      case 2:
        eSpawnSavingThrowWillMalus = EffectSavingThrowDecrease(SAVING_THROW_WILL, d4(), SAVING_THROW_ALL);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSkillDisciplineBonus = EffectSkillIncrease(SKILL_DISCIPLINE, d8());
        break;
      case 2:
        eSpawnSkillDisciplineMalus = EffectSkillDecrease(SKILL_DISCIPLINE, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSkillSpotBonus = EffectSkillIncrease(SKILL_SPOT, d8());
        break;
      case 2:
        eSpawnSkillSpotMalus = EffectSkillDecrease(SKILL_SPOT, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSkillListenBonus = EffectSkillIncrease(SKILL_LISTEN, d8());
        break;
      case 2:
        eSpawnSkillListenMalus = EffectSkillDecrease(SKILL_LISTEN, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSkillConcentrationBonus = EffectSkillIncrease(SKILL_CONCENTRATION, d8());
        break;
      case 2:
        eSpawnSkillConcentrationMalus = EffectSkillDecrease(SKILL_CONCENTRATION, d4());
        break;
      case 3:
        break;
    }

    //Creature has a slight chance to get an extra attack per round */
    switch (d10())
    {
      case 10:
        eSpawnExtraAttackBonus = EffectModifyAttacks(1);
        break;
      default:
        break;
    }

    if(nIllusionary > 0)
    {
      switch (d3())
      {
        case 1:
          eSpawnCharismaBonus = EffectAbilityIncrease(ABILITY_CHARISMA, d4());
          break;
        case 2:
          eSpawnCharismaMalus = EffectAbilityDecrease(ABILITY_CHARISMA, d4());
          break;
        case 3:
          break;
      }
    }

    /*
    Racial types that are subjected to turn undead ability type
    receive a random bonus or malus to their ability to resist it
    */
    if ((GetRacialType(oSpawnedCreature) == RACIAL_TYPE_CONSTRUCT)
      || (GetRacialType(oSpawnedCreature) == RACIAL_TYPE_ELEMENTAL)
      || (GetRacialType(oSpawnedCreature) == RACIAL_TYPE_OUTSIDER)
      || (GetRacialType(oSpawnedCreature) == RACIAL_TYPE_UNDEAD)
      || (GetRacialType(oSpawnedCreature) == RACIAL_TYPE_VERMIN))
    {
      switch (d3())
      {
        case 1:
          eSpawnTurningResistenceBonus = EffectTurnResistanceIncrease(d4());
          break;
        case 2:
          eSpawnTurningResistenceMalus = EffectTurnResistanceDecrease(d4());
          break;
        case 3:
          break;
      }
    }

    break;

    /*
    All spawned creature that are not associates of the player characters,
    i.e. are normal creatures spawned by other means (encounter, DM spawn, whatever),
    get the randomizer effect applied to them, again to provide a wider and
    less predictable range of NPC/monster encounters
    */
    case ASSOCIATE_TYPE_NONE:

    /*
    Rolls a dice for each ability and depending on the result,
    sets a bonus, a malus or simply does nothing
    */
    switch (d3())
    {
      case 1:
        eSpawnStrengthBonus = EffectAbilityIncrease(ABILITY_STRENGTH, d6());
        break;
      case 2:
        eSpawnStrengthMalus = EffectAbilityDecrease(ABILITY_STRENGTH, d6());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnDexterityBonus = EffectAbilityIncrease(ABILITY_DEXTERITY, d6());
        break;
      case 2:
        eSpawnDexterityMalus = EffectAbilityDecrease(ABILITY_DEXTERITY, d6());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnConstitutionBonus = EffectAbilityIncrease(ABILITY_CONSTITUTION, d6());
        break;
      case 2:
        eSpawnConstitutionMalus = EffectAbilityDecrease(ABILITY_CONSTITUTION, d6());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnWisdomBonus = EffectAbilityIncrease(ABILITY_WISDOM, d6());
        break;
      case 2:
        eSpawnWisdomMalus = EffectAbilityDecrease(ABILITY_WISDOM, d6());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnIntelligenceBonus = EffectAbilityIncrease(ABILITY_INTELLIGENCE, d6());
        break;
      case 2:
        eSpawnIntelligenceMalus = EffectAbilityDecrease(ABILITY_INTELLIGENCE, d6());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnCharismaBonus = EffectAbilityIncrease(ABILITY_CHARISMA, d6());
        break;
      case 2:
        eSpawnCharismaMalus = EffectAbilityDecrease(ABILITY_CHARISMA, d6());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnAttackBonus = EffectAttackIncrease(ATTACK_BONUS_MISC, d4());
        break;
      case 2:
        eSpawnAttackMalus = EffectAttackDecrease(d4(), ATTACK_BONUS_MISC);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnArmorClassBonus = EffectACIncrease(d4(), AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
        break;
      case 2:
        eSpawnArmorClassMalus = EffectACDecrease(d4(), AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSavingThrowFortBonus = EffectSavingThrowIncrease(SAVING_THROW_FORT, d8(), SAVING_THROW_ALL);
        break;
      case 2:
        eSpawnSavingThrowFortMalus = EffectSavingThrowDecrease(SAVING_THROW_FORT, d4(), SAVING_THROW_ALL);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSavingThrowDexBonus = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, d8(), SAVING_THROW_ALL);
        break;
      case 2:
        eSpawnSavingThrowDexMalus = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, d4(), SAVING_THROW_ALL);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSavingThrowWillBonus = EffectSavingThrowIncrease(SAVING_THROW_WILL, d8(), SAVING_THROW_ALL);
        break;
      case 2:
        eSpawnSavingThrowWillMalus = EffectSavingThrowDecrease(SAVING_THROW_WILL, d4(), SAVING_THROW_ALL);
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSkillDisciplineBonus = EffectSkillIncrease(SKILL_DISCIPLINE, d8());
        break;
      case 2:
        eSpawnSkillDisciplineMalus = EffectSkillDecrease(SKILL_DISCIPLINE, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSkillSpotBonus = EffectSkillIncrease(SKILL_SPOT, d8());
        break;
      case 2:
        eSpawnSkillSpotMalus = EffectSkillDecrease(SKILL_SPOT, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSkillListenBonus = EffectSkillIncrease(SKILL_LISTEN, d8());
        break;
      case 2:
        eSpawnSkillListenMalus = EffectSkillDecrease(SKILL_LISTEN, d4());
        break;
      case 3:
        break;
    }

    switch (d3())
    {
      case 1:
        eSpawnSkillConcentrationBonus = EffectSkillIncrease(SKILL_CONCENTRATION, d8());
        break;
      case 2:
        eSpawnSkillConcentrationMalus = EffectSkillDecrease(SKILL_CONCENTRATION, d4());
        break;
      case 3:
        break;
    }

    //Creature has a slight chance to get an extra attack per round
    switch (d10())
    {
      case 10:
        eSpawnExtraAttackBonus = EffectModifyAttacks(1);
        break;
        default:
        break;
    }

    /*
    Racial types that are subjected to turn undead ability type
    receive a random bonus or malus to their ability to resist it
    */
    if ((GetRacialType(oSpawnedCreature) == RACIAL_TYPE_CONSTRUCT)
      || (GetRacialType(oSpawnedCreature) == RACIAL_TYPE_ELEMENTAL)
      || (GetRacialType(oSpawnedCreature) == RACIAL_TYPE_OUTSIDER)
      || (GetRacialType(oSpawnedCreature) == RACIAL_TYPE_UNDEAD)
      || (GetRacialType(oSpawnedCreature) == RACIAL_TYPE_VERMIN))
    {
      switch (d3())
      {
        case 1:
          eSpawnTurningResistenceBonus = EffectTurnResistanceIncrease(d4());
          break;
        case 2:
          eSpawnTurningResistenceMalus = EffectTurnResistanceDecrease(d4());
          break;
        case 3:
          break;
      }
    }

    break;
  }

  //Link Effects
  eBonusMalusLink = EffectLinkEffects(eSpawnStrengthBonus, eSpawnStrengthMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnDexterityBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnDexterityMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnConstitutionBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnConstitutionMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnWisdomBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnWisdomMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnIntelligenceBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnIntelligenceMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnCharismaBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnCharismaMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnAttackBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnAttackMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnArmorClassBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnArmorClassMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSavingThrowFortBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSavingThrowFortMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSavingThrowDexBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSavingThrowDexMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSavingThrowWillBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSavingThrowWillMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSkillDisciplineBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSkillDisciplineMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSkillSpotBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSkillSpotMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSkillListenBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSkillListenMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSkillConcentrationBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnSkillConcentrationMalus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnTurningResistenceBonus);
  eBonusMalusLink = EffectLinkEffects(eBonusMalusLink, eSpawnTurningResistenceMalus);

  //Makes effects non dispellable
  eBonusMalusLink = SupernaturalEffect(eBonusMalusLink);

  //Apply Effects on Creature
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBonusMalusLink, oSpawnedCreature);

}

void OAI_LootRandom(object oCreature,int nDice)
{
  //All Loot Drops
  if(nDice <= 0) return;

  //If this is an Animal Return
  int nAnimal = GetLocalInt(oCreature,"OAI_ANIMAL");
  if(nAnimal > 0) return;

  //Dice Roll
  int nRoll = Random(nDice)+1;
  if(nRoll == 1) return;

  //Remove All the Droppable Items
  object oItem = GetFirstItemInInventory(oCreature);
  while(GetIsObjectValid(oItem))
  {
    if(GetDroppableFlag(oItem))
    {
      DestroyObject(oItem, 0.1);
    }

    oItem = GetNextItemInInventory(oCreature);
  }
}

void OAI_RemoveTorches(object oCreature)
{
  object oLight; string sTorch;
  object oItem = GetFirstItemInInventory(oCreature);
  while(GetIsObjectValid(oItem))
  {
    sTorch = GetTag(oItem);
    if(sTorch == "Torch") DestroyObject(oItem);
    if(sTorch == "OpenLantern") DestroyObject(oItem);
    if(sTorch == "Lantern") DestroyObject(oItem);
    if(sTorch == "NW_IT_TORCH001") DestroyObject(oItem);

    oItem = GetNextItemInInventory(oCreature);
  }
}

//void main() {}
