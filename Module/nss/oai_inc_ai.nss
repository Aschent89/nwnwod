////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_ai
//  by Don Anderson
//  dandersonru@msn.com
//
//  Main AI Script
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_base"

//Combat Round Analyzer
void OAI_DetermineCombatRound(object oIntruder = OBJECT_INVALID);

//From Tony K's Henchman AI
void OAI_DetermineSpecialBehavior(object oTarget = OBJECT_INVALID);

//Round Decounter
int OAI_DecrementCounter(string sCounter);

//Morale Chance to Attack
//Code by Ray Miller 4/21/2003
int DetermineChanceOfAttack(object oPerceived);

//Gets Enemy CR Rating Morale Checks
//(From Jeff Petersen's Fight or Flight v1.4)
float GetEnemyCR(object oEnemy, float fEnemyCR);

//Adds up all the HD or CRs from enemies within fRange.
//(From Jeff Petersen's Fight or Flight v1.4)
float GetTheirCR(object oEnemy, float f_TheirCR, float fRange, object oTheirs);

//Determines CR of caller's party by scanning for all
//friends within fRange. Does NOT include any friends that
//have retreated.
//(From Jeff Petersen's Fight or Flight v1.4)
float GetOurCR(float f_OurCR, float fRange, object oMine);

//Main Setup from Spawn Script
//(From Jeff Petersen's Fight or Flight v1.4)
void FOF_Set(object oCreature = OBJECT_SELF);

//Main Fight or Flight Execute Function
//(From Jeff Petersen's Fight or Flight v1.4)
void FOF_Execute(object oCreature = OBJECT_SELF);

//Leaders Call For Help When Damaged
//(From Jeff Petersen's Fight or Flight v1.4)
void CallForHelp();

//The act of retreating.
//Looks for leaders or rallying points and makes for those,
//when present. Otherwise, they run all over the place.
//(From Jeff Petersen's Fight or Flight v1.4)
void SignalFlee(object oEnemy, float fRange);

//Guard Checking For Weapons if Waypoint "DisallowWeapons" is present.
void OAI_GuardCheck(object oNPC);

//Barmaids
void OAI_Barmaid(object oNPC);

//Bar Chatter
int OAI_BarChatterCheck(object oSelf, object oTavern);
void OAI_BarChatter(object oNPC);

//Inn/Restaurant Cooks (Original By Remi Ennd)
void OAI_Cooks(object oNPC);

//Strippers =) (Original By Aiden and Spectre)
void OAI_Stripper(object oNPC);

/******************************************************************************/
//:: OAI FUNCTIONS

void OAI_DetermineCombatRound(object oIntruder = OBJECT_INVALID)
{
  object oSelf = OBJECT_SELF;

  //Pre-Checks
  if(GetIsDead(oSelf)) return;
  if(!GetCommandable(oSelf)) return;
  if(GetIsObjectValid(GetAttemptedAttackTarget()) || GetIsObjectValid(GetAttemptedSpellTarget())) return;

  object oLastTarget = GetAttackTarget();

  //The Creature in a Switch Target Status
  int nSL = GetLocalInt(OBJECT_SELF,"OAI_SWITCHLOCK");

  //Round Count to Acquire New Target
  int nRC = GetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT");

  //Switching Targets (Target Chosen in nw_c2_default6)
  if(nSL == 1)
  {
      SetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT",2);
  }
  else
  {
    SetLocalInt(OBJECT_SELF,"OAI_SWITCHLOCK",0);

    if(nRC < 1 || !GetIsObjectValid(oLastTarget))
    {
      object oBestTarget = OAI_AcquireTarget();

      //Might be Automatically Switching Targets
      if(oBestTarget != oLastTarget)
      {
        oIntruder = oBestTarget;
      }

      SetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT",2);
    }
    else
    {
      OAI_DecrementCounter("OAI_ROUNDCOUNT");
      oIntruder = oLastTarget;
    }
  }

  //TRUE if Intruder is Valid
  int HaveEnemy = GetIsObjectValid(oIntruder);
  if(HaveEnemy)
  {
    SetLocalObject(oSelf,"OAI_ATTACK_TARGET",oIntruder);
    DeleteLocalInt(OBJECT_SELF, "OAI_SEARCHING");
  }

  if(GetCurrentAction() == ACTION_RANDOMWALK) ClearAllActions();

  //Cast Triggers and Break Illusions On Start Of Combat
  //Cast OnSpawn Triggers or Break Illusions
  if(!GetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST) && HaveEnemy)
  {
    if(OAI_BreakIllusion(oIntruder)) return;
    OAI_CastTriggers();
  }

  //Rezzing is the highest priority of all...
  if(OAI_DetermineAllyToRez()) return;

  //Summon Hordes....Setup in Spawn Script
  if(HaveEnemy)
  {
    OAI_SummonHordes();
  }

  //Heal Self if Less Than Half of Our HP's
  int nStatus = GetCurrentHitPoints(oSelf);
  int nBase = GetMaxHitPoints(oSelf);
  if((nStatus*2) < nBase)
  {
    if(TalentHealingSelf(TRUE) == TRUE) return;
  }

  //Fly Away if Getting to 25% of HP's
  //Primarily for Boss Creatures Not Ready for Slaying =) ...You Know...Story Plots
  int nFA = GetLocalInt(oSelf,"OAI_FLYAWAY");
  if((nStatus*4) < nBase && nFA == 1)
  {
    //Drop Treasure Room Key
    object oTRK = GetItemPossessedBy(oSelf,"Key_TreasureRoom");
    if(GetIsObjectValid(oTRK))
    {
      string sTRK = GetResRef(oTRK);
      CreateObject(OBJECT_TYPE_ITEM,sTRK,GetLocation(oSelf));
    }

    //Dragons Fly Away
    if((GetBattleCondition(OAI_ROLE_DRAGON) || GetRacialType(oSelf) == RACIAL_TYPE_DRAGON))
    {
      effect eDis = EffectDisappear();
      effect ePul = EffectVisualEffect(VFX_IMP_PULSE_WIND);
      DelayCommand(3.0 - 0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, ePul, oSelf));
      DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDis, oSelf));
    }
    else
    {
      effect eDis = EffectDisappear();
      AssignCommand(oSelf,ClearAllActions(TRUE));
      AssignCommand(oSelf,SpeakString("Time to escape!"));
      AssignCommand(oSelf,ActionCastFakeSpellAtObject(SPELL_INVISIBILITY_SPHERE,oSelf));
      DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDis, oSelf));
    }
  }

/******************************************************************************/
//:: SPECIAL COMBAT ROLES

  //Dragons
  if((GetBattleCondition(OAI_ROLE_DRAGON) || GetRacialType(oSelf) == RACIAL_TYPE_DRAGON)
    && HaveEnemy)
  {
    if(OAI_Dragons(oIntruder)) return;
  }

  //Beholders
  if(GetBattleCondition(OAI_ROLE_BEHOLDER) && HaveEnemy)
  {
    OAI_Beholders(oIntruder);
    return;
  }

  //Gelatinous Cubes
  if(GetBattleCondition(OAI_ROLE_GELATINOUSCUBE) && HaveEnemy)
  {
    OAI_GelatinousCube(oIntruder);
    return;
  }

  //Spiders
  if(GetBattleCondition(OAI_ROLE_SPIDER) && HaveEnemy)
  {
    //30% OR Heavily Wounded
    int nInjured = FloatToInt(IntToFloat(GetMaxHitPoints()) * 0.3);
    int nCHP = GetCurrentHitPoints();
    if(Random(100) < 30 || nCHP < nInjured)
    {
      if(OAI_SpiderTactics(oIntruder)) return;
    }
  }

  //Mindflayers
  if(GetBattleCondition(OAI_ROLE_MINDFLAYER) && HaveEnemy)
  {
    if(OAI_MindFlayerCombat(oIntruder)) return;
  }

  //Winged Creatures
  if(GetBattleCondition(OAI_ROLE_WINGED) && HaveEnemy)
  {
    if(OAI_WingedCreature(oIntruder)) return;
  }

  //Creatures can 'Climb' up NWN 3 Meter Cliffs =O
  //Player AI Exploit....time to resolve this one =)
  /*
  float fTDist = GetDistanceToObject(oIntruder);
  if(fTDist < 5.1 && HaveEnemy)
  {
    object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if(IsMeleeWeapon(oRightHand))
    {
      vector vIntruder = GetPosition(oIntruder);
      float fZIntruder = vIntruder.z;
      if(vIntruder.z > 2.0 || vIntruder.z < -2.0)
      {
        if(OAI_JumpCreature(oIntruder)) return;
      }
    }
  }
  */
//:: SPECIAL COMBAT ROLES
/******************************************************************************/

/******************************************************************************/
//:: SPECIAL COMBAT TACTICS (FROM BIOWARE & OLANDER)

  //Special Ranged Tactics (Special Combat AI Run Through Ranged Combat)
  if(GetBattleCondition(OAI_COMBAT_FLAG_RANGED) && HaveEnemy)
  {
    OAI_RangedCombat(oIntruder);
    return;
  }

  //Special Defensive Tactics
  if(GetBattleCondition(OAI_COMBAT_FLAG_DEFENSIVE) && HaveEnemy)
  {
    DetermineCombatRound(oIntruder);
    return;
  }

  //Special Ambusher Tactics
  if(GetBattleCondition(OAI_COMBAT_FLAG_AMBUSHER) && HaveEnemy)
  {
    DetermineCombatRound(oIntruder);
    return;
  }

  //Special Cowardly Tactics
  if(GetBattleCondition(OAI_COMBAT_FLAG_COWARDLY) && HaveEnemy)
  {
    DetermineCombatRound(oIntruder);
    return;
  }

  //Shapechanger With Appearance Set in Spawn Script
  if(GetLocalInt(OBJECT_SELF, "OAI_SHAPECHANGE") > 0)
  {
    if((Random(70) + 30) > ((GetCurrentHitPoints() * 100) / GetMaxHitPoints()))
    {
      // We won't polymorph if already so
      if(!GetHasEffect(EFFECT_TYPE_POLYMORPH, OBJECT_SELF))
      {
        effect eShape = SupernaturalEffect(EffectPolymorph(GetLocalInt(OBJECT_SELF, "OAI_SHAPECHANGE") - 1));
        effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eShape, OBJECT_SELF));
        DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF)));
      }
      DeleteLocalInt(OBJECT_SELF, "OAI_SHAPECHANGE");
      SetStatusCondition(OAI_I_CAN_POLYMORPH,FALSE);
    }
  }

  //Palemasters Always Try to Fight like a Palemaster
  if(GetStatusCondition(OAI_I_CAN_PM_MELEE) && HaveEnemy)
  {
    if(OAI_GetIsTargetInMeleeRange(oIntruder))
    {
      OAI_MeleePalemaster(oIntruder);
      return;
    }
  }

  //Shapechanger With Feats
  if((GetStatusCondition(OAI_I_CAN_POLYMORPH) || GetStatusCondition(OAI_I_CAN_SHIFTER_MELEE)) && HaveEnemy)
  {
    OAI_MeleeShifter(oIntruder);
    return;
  }

  //Summon Help First If Attacker is Close
  if(GetStatusCondition(OAI_I_CAN_SUMMON) && HaveEnemy)
  {
    if(TalentSummonAllies() == TRUE) { SetStatusCondition(OAI_I_CAN_SUMMON, FALSE); }
  }

  //Blinkers
  if(GetBattleCondition(OAI_BLINK_SELF) && HaveEnemy)
  {
    if(Random(100) >= GetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE"))
    {
      int nD6 = d6(1);
      if(nD6 == 3 || nD6 == 5)
      {
        OAI_BlinkMelee(oIntruder);
        DetermineCombatRound(oIntruder);
        return;
      }
      else
      {
        OAI_BlinkMove();
        DetermineCombatRound(oIntruder);
        return;
      }
    }
  }

//:: SPECIAL COMBAT TACTICS (FROM BIOWARE)
/******************************************************************************/

/******************************************************************************/
//:: SPELLCASTER ROLES

  //Role Healer
  if(GetBattleCondition(OAI_ROLE_HEALER) && HaveEnemy)
  {
    //Manage an AOE
    if(OAI_ManageEnemyAOE()) return;

    OAI_BufferCaster(oIntruder,1);
    return;
  }

  //Role Buffer
  if(GetBattleCondition(OAI_ROLE_BUFFER) && HaveEnemy)
  {
    //Manage an AOE
    if(OAI_ManageEnemyAOE()) return;

    //Buffer Start at State 2
    OAI_BufferCaster(oIntruder,2);
    return;
  }

  //Role Status Caster
  if(GetBattleCondition(OAI_ROLE_STATUS_CASTER) && HaveEnemy)
  {
    //Manage an AOE
    if(OAI_ManageEnemyAOE()) return;

    OAI_StatusCaster(oIntruder,1);
    return;
  }

  //Role AOE Specialist
  if(GetBattleCondition(OAI_ROLE_AOE_SPECIALIST) && HaveEnemy)
  {
    //Manage an AOE
    if(OAI_ManageEnemyAOE()) return;

    OAI_AOECaster(oIntruder,1);
    return;
  }

  //Role Attack Caster
  if(GetBattleCondition(OAI_ROLE_ATTACK_CASTER) && HaveEnemy)
  {
    //Manage an AOE
    if(OAI_ManageEnemyAOE()) return;

    OAI_AttackCaster(oIntruder,1);
    return;
  }

  //General Caster Combat
  if(GetStatusCondition(OAI_I_CAN_CAST_SPELLS) && HaveEnemy)
  {
    //Manage an AOE
    if(OAI_ManageEnemyAOE()) return;

    DetermineCombatRound(oIntruder);
    return;
  }

//:: SPELLCASTER ROLES
/******************************************************************************/

/******************************************************************************/
//:: MELEE COMBAT

  if((GetStatusCondition(OAI_I_CAN_DEX_MELEE)
   || GetStatusCondition(OAI_I_CAN_FIGHT_MELEE)
   || GetStatusCondition(OAI_I_CAN_FIGHT_RANGED)
   || GetStatusCondition(OAI_I_CAN_MONK_MELEE)
   || GetStatusCondition(OAI_I_CAN_RELIGIOUS_MELEE)
   || GetStatusCondition(OAI_I_CAN_SHIFTER_MELEE)
   || GetStatusCondition(OAI_I_CAN_SMITE_MELEE)
   || GetStatusCondition(OAI_I_CAN_SNEAK_MELEE)
   || GetStatusCondition(OAI_I_CAN_WM_MELEE))
   && HaveEnemy)
  {
    OAI_Fighting(oIntruder);
    return;
  }

//:: MELEE COMBAT
/******************************************************************************/

/******************************************************************************/
//:: NWN DETERMINE COMBAT ROUND

  //Fall Through for Creatures With No Special Abilities
  if(HaveEnemy)
  {
    // dk: Make sure we wield weapons wielded
    if(!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND))) OAI_EquipAppropriateWeapons(oSelf);
    DetermineCombatRound(oIntruder);
  }

//:: NWN DETERMINE COMBAT ROUND
/******************************************************************************/

/******************************************************************************/
//:: COMBAT IS OVER SO DO SOMETHING SMART

  //if we are in darkness, move out of the effect...
  if(GetHasEffect(EFFECT_TYPE_DARKNESS, oSelf))
  {
    vector vWho = GetPosition(oSelf);
    vWho.x += IntToFloat(Random(3) * 10);
    vWho.y += IntToFloat(Random(3) * 10);
    ActionMoveToLocation(Location(oArea, vWho, 0.0), TRUE);
    return;
  }
  else if(GetHasEffect(EFFECT_TYPE_BLINDNESS, oSelf))
  {
    switch(Random(8))
    {
      case 0: PlayVoiceChat(VOICE_CHAT_HELP); break;
      case 1: PlayVoiceChat(VOICE_CHAT_NO); break;
    }
    ActionRandomWalk();
    return;
  }

  int Ath = 1;
  object oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT);
  while(GetIsObjectValid(oAOE) && GetDistanceToObject(oAOE) < 10.0)
  {
    if(GetAreaOfEffectCreator(oAOE) != oSelf
      || !GetHasEffect(EFFECT_TYPE_AREA_OF_EFFECT, GetAreaOfEffectCreator(oAOE)))
    {
      ActionMoveAwayFromObject(oAOE, TRUE, 11.0);
      return;
    }
    Ath++;
    oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, oSelf, Ath);
  }

  //Are We Shapeshifted
  if(!GetHasEffect(EFFECT_TYPE_POLYMORPH, OBJECT_SELF))
  {
    OAI_RemoveEffects(OBJECT_SELF,OBJECT_SELF,EFFECT_TYPE_POLYMORPH);
  }

  //lastly, if we are not stupid, or certain races run to allies after battle.
  int nRacial = GetRacialType(oSelf);
  if(nRacial != RACIAL_TYPE_ANIMAL
    && nRacial != RACIAL_TYPE_VERMIN
    && nRacial != RACIAL_TYPE_MAGICAL_BEAST
    && nRacial != RACIAL_TYPE_DRAGON
    && nRacial != RACIAL_TYPE_CONSTRUCT
    && nRacial != RACIAL_TYPE_BEAST
    && nRacial != RACIAL_TYPE_ABERRATION
    && GetAbilityScore(oSelf, ABILITY_INTELLIGENCE) > 7)
  {
    object oFriend = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, oSelf, 1, CREATURE_TYPE_IS_ALIVE, TRUE);
    if(GetIsObjectValid(oFriend))
    {
      if(GetDistanceToObject(oFriend) > 12.0) ActionMoveToObject(oFriend, TRUE, 6.0);
      else if(GetDistanceToObject(oFriend) < 4.0) ActionMoveAwayFromObject(oFriend, TRUE, 6.0);
    }

    if(GetSpawnInCondition(NW_FLAG_SEARCH)) ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
    if(GetSpawnInCondition(NW_FLAG_STEALTH)) ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
    if(GetBattleCondition(OAI_RETURN_TO_SPAWNPOINT))
    {
      ActionForceMoveToLocation(GetLocalLocation(OBJECT_SELF, "OAI_SPAWN_LOCATION"));
    }

    WalkWayPoints();
  }

//:: COMBAT IS OVER SO DO SOMETHING SMART
/******************************************************************************/

}

/******************************************************************************/
//:: SPECIAL NPC BEHAVIORS

void OAI_GuardCheck(object oNPC)
{
  object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF);
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);

  //Ok to Wield Weapons
  //(This is a Waypoint that is placed in an Area)
  object oAllow = GetNearestObjectByTag("DisallowWeapons");
  if(!GetIsObjectValid(oAllow)) return;

  //Is the Weapon a Weapon?
  if(IsWeapon(oItem) == FALSE) return;

  //Military Ranked Player
  object oRank = GetItemPossessedBy(oPC,RANKINSIGNIA);
  if(GetIsObjectValid(oRank)) return;

  if(oPC != OBJECT_INVALID
    && (GetDistanceBetween(OBJECT_SELF,oPC) < WARN_DISTANCE)
    && GetObjectSeen(oPC) && !GetIsEnemy(oPC))
  {
    if(oItem != OBJECT_INVALID)
    {
      if(GetLocalObject(OBJECT_SELF,"LastOffender") == oPC)
      {
        if(GetLocalInt(OBJECT_SELF,"OffenseCount") == 2)
        {
          SpeakString(ATTACK_MSG);
          SetIsTemporaryEnemy(oPC,OBJECT_SELF,TRUE,ANGER_DUR);
          ActionAttack(oPC);
        }
        else if(GetLocalInt(OBJECT_SELF,"OffenseCount")==1)
        {
          ActionMoveToObject(oPC,TRUE);
          SetLocalInt(OBJECT_SELF,"OffenseCount",2);
          SpeakString(WARNING3);
        }
        else
        {
          SetLocalInt(OBJECT_SELF,"OffenseCount",1);
          SpeakString(WARNING2);
        }
      }
      else
      {
        SetLocalInt(OBJECT_SELF,"OffenseCount",0);
        SpeakString(WARNING1);
        SetLocalObject(OBJECT_SELF,"LastOffender",oPC);
      }
    }
    else
    {
      if( GetLocalObject(OBJECT_SELF,"LastOffender")!= OBJECT_INVALID) SpeakString(COMPLY_REPLY);
      DeleteLocalObject(OBJECT_SELF,"LastOffender");
      SetLocalInt(OBJECT_SELF,"OffenseCount",0);
    }
  }
}

void OAI_Barmaid(object oNPC)
{
  object oCustomer = GetLocalObject(OBJECT_SELF, "CUSTOMER");

  int nRandom = d8(1); // Set this to the approx number of NPC's in the room
  object oBar = GetWaypointByTag("WP_BAR"); // Place this waypoint where she gets drinks from
  object oRest = GetWaypointByTag("WP_REST"); // Place this waypoint where she returns to rest
  object oCook = GetObjectByTag("COOK"); // Place an NPC Cook in the kitchen with this tag
  object oBartend = GetObjectByTag("BARTENDER");// Place an NPC Bartender at bar with this tag

  string sBarmaid = GetName(OBJECT_SELF);
  string sCook = GetName(oCook);
  string sBartend = GetName(oBartend);

  if(!GetIsObjectValid(oCustomer) && GetLocalInt(OBJECT_SELF, "BARMAID_STATE") < 1)
  {
    oCustomer = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nRandom);
    if(oCustomer != oCook
      && oCustomer != oBartend
      && oCustomer != OBJECT_SELF
      && GetIsObjectValid(oCustomer))
    {
      SetLocalInt (OBJECT_SELF, "BARMAID_STATE", 1);
      SetLocalObject (OBJECT_SELF, "CUSTOMER", oCustomer);
      ActionMoveToObject(oCustomer);

      switch(Random(4))
      {
        case 0:
          ActionSpeakString ("Can I get you something?");
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_YES,oCustomer));
          break;
        case 1:
          ActionSpeakString ("What would you like?");
          break;
        case 2:
          ActionSpeakString ("How are we doing over here?");
          break;
        case 3:
          ActionSpeakString ("Another round?");
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_GOODIDEA,oCustomer));
          break;
      }

      ActionWait(5.0);
      ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 2));
      ActionMoveToObject(oBar);

      switch(Random(4))
      {
        case 0:
          ActionSpeakString ("I need two ales and a bottle of mead.");
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_CANDO,oCook));
          break;
        case 1:
          ActionSpeakString ("Two whiskeys with a water back please.");
          break;
        case 2:
          ActionSpeakString ("They want a pitcher of ale and a loaf of bread");
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_CANTDO,oCook));
          break;
        case 3:
          ActionSpeakString ("A bottle of wine and two glasses then.");
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_TASKCOMPLETE,oCook));
          break;
      }

      ActionWait(8.0);
      ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 3));
      ActionMoveToObject(oCustomer);

      switch(Random(4))
      {
        case 0:
          ActionSpeakString ("Enjoy this friend.");
          break;
        case 1:
          ActionSpeakString ("That'll be 10 gold. I'm just kidding. 3 gold, please.");
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oCustomer));
          break;
        case 2:
          ActionSpeakString ("You look like you could use this.");
          break;
        case 3:
          ActionSpeakString ("Ice brewed in the Frigid North, friend. Enjoy.");
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_THANKS,oCustomer));
          break;
      }

      ActionWait(3.0);
      ActionDoCommand (SetLocalObject(OBJECT_SELF, "CUSTOMER", OBJECT_INVALID));
      ActionMoveToObject(oRest);

      //Enter the direction for her to face while on break or comment line below out!
      DelayCommand(4.0,AssignCommand(OBJECT_SELF,SetFacing(DIRECTION_WEST)));

      ActionWait(5.0);

      switch(Random(4))
      {
        case 0:
          ActionSpeakString ("Slow night tonight, eh "+sBartend);
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_YES,oBartend));
          break;
        case 1:
          ActionSpeakString ("My feet are killing me.");
          break;
        case 2:
          ActionSpeakString ("Well they sure tip well here.");
          break;
        case 3:
          ActionSpeakString ("Look at that tender morsel!");
          ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oBartend));
          break;
      }

      ActionWait(5.0);
      ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 0));
    }
  }
}

int OAI_BarChatterCheck(object oSelf, object oTavern)
{
  //Bar Chatter Conversation Going On?
  object oTavern = GetNearestObjectByTag("NW_TAVERN",oSelf,1);
  int nChat = GetLocalInt(oTavern,"OAI_BARCHAT");
  if(nChat == TRUE) return TRUE;

  SetLocalInt(oTavern,"OAI_BARCHAT",TRUE);
  return FALSE;
}

void OAI_BarChatter(object oNPC)
{
  object oSelf = OBJECT_SELF;
  object oTavern = GetNearestObjectByTag("NW_TAVERN",oSelf,1);
  object oFriend = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_NOT_PC);
  int iSelfState = GetLocalInt(oSelf,"CHAT_STATE");
  int iLastRandom = GetLocalInt(oSelf,"CHAT_LINE");
  int iChat = d10();

  // Return if they are about to use the same lines over
  if (iChat == iLastRandom) return;

  // Don't talk if they are in convo already
  if (IsInConversation(oSelf) || IsInConversation(oFriend))return;

  // This section is the intro area of convo, use openers.
  if (iSelfState == 1)
  {
    switch(iChat)
    {
      case 0:
        SpeakString ("It's always good to see you friend.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("I enjoy getting to see you as well.")));
        break;
      case 1:
        SpeakString ("What's new with you these days?");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Doing what I must and staying busy.")));
        break;
      case 2:
        SpeakString ("I hope your journey here was enjoyable.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("It was quite good thank you.")));
        break;
      case 3:
        SpeakString ("It has been awhile since we got together.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Seems like quite a time aye?")));
        break;
      case 4:
        break;
      case 5:
        break;
    }
  }

  // Now say more direct lines
  if(iSelfState == 3)
  {
    switch(iChat)
    {
      case 0:
        AssignCommand(oFriend,SpeakString("Have you been busy of late?"));
        DelayCommand(3.0f,SpeakString ("Not anymore than usual."));
        break;
      case 1:
        AssignCommand(oFriend,SpeakString ("I purchased a new mount the other day."));
        DelayCommand(3.0f,SpeakString ("Indeed? That is rather exciting."));
        break;
      case 2:
        AssignCommand(oFriend,SpeakString ("Looks loike business is pretty good around here."));
        DelayCommand(3.0f,SpeakString ("Aye...it has been very good."));
        break;
      case 3:
        AssignCommand(oFriend,SpeakString ("Did you ever complete your studies?"));
        DelayCommand(3.0f,SpeakString ("Aye! Thank you for asking, about a month ago."));
        break;
      case 4:
        break;
      case 5:
        AssignCommand(oFriend,SpeakString ("I think we should get something to eat."));
        DelayCommand(3.0f,PlayVoiceChat(VOICE_CHAT_YES));
        break;
    }
  }

  // Third part of conversation
  if(iSelfState == 5)
  {
    switch(iChat)
    {
      case 0:
        SpeakString ("I have been thinking about becoming a wizard.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("You could try but you are no wizard type for sure.")));
        break;
      case 1:
        SpeakString ("Did you notice what the Guilds have done to the town?");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Yes I did. Amazing to say the least.")));
        break;
      case 2:
        SpeakString ("I always enjoy seeing you here.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Aye, my feelings exactly friend.")));
        break;
      case 3:
        SpeakString ("We should do this more often.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Agreed, perhaps again next week aye?")));
        break;
      case 4:
        break;
      case 5:
        SpeakString ("Do you think we should do this again?");
        DelayCommand(3.0f,AssignCommand(oFriend,PlayVoiceChat(VOICE_CHAT_GOODIDEA)));
        break;
    }
  }

  // Fourth part of convo
  if (iSelfState == 7)
  {
    switch(iChat)
    {
      case 0:
        AssignCommand(oFriend,SpeakString ("It seems like we don't get much time to chat."));
        DelayCommand(3.0f,SpeakString ("Aye, we should allow more time to get together, perhaps."));
        break;
      case 1:
        AssignCommand(oFriend,SpeakString ("Look at that sturdy adventurer over there."));
        DelayCommand(3.0f,SpeakString ("I don't know how they do it. Danger and death on their heads everyday."));
        break;
      case 2:
        AssignCommand(oFriend,SpeakString ("I should probably depart before too long."));
        DelayCommand(3.0f,SpeakString ("Understood, time flies when you are having fun."));
        break;
      case 3:
        AssignCommand(oFriend,SpeakString ("Think war is about?"));
        DelayCommand(3.0f,SpeakString ("Could be. Rumors are plenty and Rumors just don't appear from nowhere."));
        break;
      case 4:
        break;
      case 5:
        SpeakString ("Those folks over there think we are quite odd!");
        DelayCommand(3.0f,AssignCommand(oFriend,PlayVoiceChat(VOICE_CHAT_LAUGH)));
        break;
    }
  }

  // Fifth part of convo, this time have fun with PC's by using their names
  if(iSelfState == 9)
  {
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
    string sName = GetName(oPC);
    int iLevels = GetHitDice(oPC);
    switch(iChat)
    {
      case 0:
        SpeakString ("I need to make sure I save some gold to trade with.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Aye, it is easy to spend it all in this city.")));
        break;
      case 1:
        SpeakString ("Did you see the King yesterday?");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Nay, no time for that sort of stuff.")));
        break;
      case 2:
        SpeakString ("I hear things are escalating towards conflict.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Grim news indeed, I hope we will live.")));
        break;
      case 3:
        SpeakString ("I think we should make a point of getting together more often.");
        DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Agreed, it is a good idea, perhaps again soon aye?")));
        break;
      case 4:
        if(iLevels <= 10)
        {
          SpeakString ("I think that is "+sName+", isn't it? Becoming quite strong it appears.");
          DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Aye, I have watched them grow.")));
        }
        break;
      case 5:
        if(iLevels >= 15)
        {
          SpeakString ("I think that adventurer there is "+sName+".");
          DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Aye, that is. Storys are spreading for deeds done too.")));
        }
        break;
      case 6:
        if(iLevels >= 20)
        {
          SpeakString ("Who is that? That is one well traveled adventurer from what I see.");
          DelayCommand(3.0f,AssignCommand(oFriend,SpeakString ("Indeed, that is "+sName+". I heard a guard mention that name the other day.")));
        }
        break;
    }
  }

  // Increment the state, save values and be prepped for next go around
  iSelfState++;
  if(iSelfState > 10)
  {
    SetLocalInt(oTavern,"OAI_BARCHAT",FALSE);
    iSelfState = 0;
  }
  SetLocalInt(oSelf,"CHAT_STATE",iSelfState);
  SetLocalInt(oSelf,"CHAT_LINE",iChat);
}

//Inn/Restaurant Cooks
void OAI_Cooks(object oNPC)
{
  int nCurrentJob = GetLocalInt(OBJECT_SELF,"INN_Cook_Job");
  object oWaypoint;
  object oChair;

  if((GetLocalInt(OBJECT_SELF,"INN_Cook_Busy") > 1) && (GetLocalInt(OBJECT_SELF,"INN_Cook_Job") != 0))
  {
    SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",0);
  }

  if(GetLocalInt(OBJECT_SELF,"INN_Cook_Busy") == 0)
  {
     switch (nCurrentJob)
     {
         case 1: break;
         case 2: break;
         case 3:
             SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",1);
             ClearAllActions();
             ActionSpeakString("One " + GetLocalString(OBJECT_SELF,"INN_Cook_Job_Name") + " coming up.");
             ActionMoveToObject(GetWaypointByTag("INN_KitchenPrepTable"));
             ActionWait(2.0);
             ActionSpeakString("I need some flour....");
             ActionMoveToObject(GetWaypointByTag("INN_KitchenItems3"));
             ActionWait(1.0);
             ActionMoveToObject(GetWaypointByTag("INN_KitchenPrepTable"));
             ActionWait(3.0);
             ActionSpeakString("and some eggs...");
             ActionMoveToObject(GetWaypointByTag("INN_KitchenItems1"));
             ActionWait(1.0);
             ActionMoveToObject(GetWaypointByTag("INN_KitchenPrepTable"));
             ActionWait(2.0);
             ActionSpeakString("can't foget the main item...");
             ActionMoveToObject(GetWaypointByTag("INN_KitchenItems2"));
             ActionWait(1.0);
             ActionMoveToObject(GetWaypointByTag("INN_KitchenPrepTable"));
             ActionWait(5.0);
             ActionSpeakString("now for the oven...");
             ActionMoveToObject(GetWaypointByTag("INN_KitchenOven"));
             ActionWait(1.0);
             ActionMoveToObject(GetWaypointByTag("INN_KitchenPickup"));
             ActionSpeakString(GetLocalString(OBJECT_SELF,"INN_Cook_Job_Name") + " is done");
             ActionDoCommand(SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",0));
             ActionDoCommand(SetLocalInt(OBJECT_SELF,"INN_Cook_Job",0));
             break;
         default:
             switch (d6())
             {
               case 1: SpeakString("I hate to cleaning up this mess."); break;
               case 2: SpeakString("la de da, la de do..."); break;
               case 3: SpeakString("All " + GetName(GetObjectByTag("BARTENDER"))
                       + " ever wants me to do is cook, cook, cook!");
                       break;
               default: break;
             }
             switch (d6())
             {
                 case 1:
                     ClearAllActions();
                     SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",2);
                     if (d4() == 1) { ActionSpeakString("Think I need to sit down for a bit."); }
                     oChair = GetObjectByTag("INN_KitchenChair");
                     ActionSit(oChair);
                     ActionWait(5+IntToFloat(d4()));
                     ActionDoCommand(SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",0));
                     ClearAllActions();
                     break;
                 case 2:
                     ClearAllActions();
                     SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",2);
                     oWaypoint= GetWaypointByTag("INN_KitchenItems1");
                     ActionMoveToObject(oWaypoint);
                     ActionWait(IntToFloat(d4()));
                     ActionDoCommand(SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",0));
                     break;
                 case 3:
                     ClearAllActions();
                     SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",2);
                     oWaypoint= GetWaypointByTag("INN_KitchenItems2");
                     ActionMoveToObject(oWaypoint);
                     ActionWait(IntToFloat(d4()));
                     ActionDoCommand(SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",0));
                     break;
                 case 4:
                     ClearAllActions();
                     SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",2);
                     oWaypoint= GetWaypointByTag("INN_KitchenItems3");
                     ActionMoveToObject(oWaypoint);
                     ActionWait(IntToFloat(d4()));
                     ActionDoCommand(SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",0));
                     break;
                 case 5:
                     ClearAllActions();
                     SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",2);
                     oWaypoint= GetWaypointByTag("INN_KitchenOven");
                     ActionMoveToObject(oWaypoint);
                     ActionWait(IntToFloat(d4()));
                     ActionDoCommand(SetLocalInt(OBJECT_SELF,"INN_Cook_Busy",0));
                     break;
             }
             break;
     }
   }
}

void OAI_Stripper(object oNPC)
{
  int nDance = GetLocalInt(oNPC,"STRIPPING");
  if(nDance == 1) return;

  SetLocalInt(oNPC,"STRIPPING",1);

  //Wearing Now....Set Up in Toolset
  object oStrip05 = GetItemPossessedBy(oNPC,"strip05");

  //Segment Clothing
  object oStrip01 = GetItemPossessedBy(oNPC,"strip01");
  if(GetIsObjectValid(oStrip01) == FALSE) oStrip01 = CreateItemOnObject("strip01",oNPC,1);

  object oStrip02 = GetItemPossessedBy(oNPC,"strip02");
  if(GetIsObjectValid(oStrip02) == FALSE) oStrip02 = CreateItemOnObject("strip02",oNPC,1);

  object oStrip03 = GetItemPossessedBy(oNPC,"strip03");
  if(GetIsObjectValid(oStrip03) == FALSE) oStrip03 = CreateItemOnObject("strip03",oNPC,1);

  object oStrip04 = GetItemPossessedBy(oNPC,"strip04");
  if(GetIsObjectValid(oStrip04) == FALSE) oStrip04 = CreateItemOnObject("strip04",oNPC,1);


  //the tease part
  ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT,1.0);
  ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0);

  //this removes dress and reequips next item to give
  //appearance of taking off only the dress
  ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST));
  ActionEquipItem(oStrip04, INVENTORY_SLOT_CHEST);

  //continue dancing
  ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2,1.0);
  ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0);

  //this removes current clothing and equips
  //next clothing item to give appearance of only taking off
  //one item of clothing
  ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST));
  ActionEquipItem(oStrip03, INVENTORY_SLOT_CHEST);

  //continue dancing
  ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0);
  ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0);

  //remove current clothes and equip next item of clothing
  //gives appearance of removing only one item of clothing
  ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST));
  ActionEquipItem(oStrip02, INVENTORY_SLOT_CHEST);

  //continue dancing
  ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0);
  ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0);

  //remove clothing and equip next clothing item
  ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST));
  ActionEquipItem(oStrip01, INVENTORY_SLOT_CHEST);

  //more dancing
  ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT,1.0);
  ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0);
  ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2,1.0);
  ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0);

  //put clothes back on
  ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST));
  ActionEquipItem(oStrip05, INVENTORY_SLOT_CHEST);
  ActionDoCommand(SetLocalInt(oNPC,"STRIPPING",0));
}

//From Tony K's Henchman AI
void OAI_DetermineSpecialBehavior(object oTarget = OBJECT_INVALID)
{
  if (!GetIsObjectValid(oTarget))
    oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, 1,
                                          CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
  // Neutral targets are of limits
  if (OAI_GetIsNeutral(oTarget)) {
    ClearAllActions(TRUE);
    ClearPersonalReputation(oTarget);
    oTarget = OBJECT_INVALID;
  }

  // Omnivore behavior routine
  if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE))
  {
    // no current attacker and not currently in combat
    if(!GetIsObjectValid(oTarget) && !GetIsInCombat())
    {
      // does not have a current target
      if(!GetIsObjectValid(GetAttemptedAttackTarget())
        && !GetIsObjectValid(GetAttemptedSpellTarget())
        && !GetIsObjectValid(GetAttackTarget()))
      {
        // enemy creature nearby
        if(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 13.0)
        {
          ClearAllActions();
          DetermineCombatRound(oTarget);
          return;
        }

        int nTarget = 1;
        oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, nTarget,
                                     CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL);

        // neutral creature, too close
        while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 7.0)
        {
          if(GetLocalString(oTarget, OAI_FACTION) != NEUTRAL &&
                GetLevelByClass(CLASS_TYPE_DRUID, oTarget) == 0 &&
                GetLevelByClass(CLASS_TYPE_RANGER, oTarget) == 0 &&
                GetAssociateType(oTarget) != ASSOCIATE_TYPE_ANIMALCOMPANION)
          {
            // oTarget has neutral reputation, and is NOT a druid or ranger or an "Animal Companion"
            SetLocalInt(OBJECT_SELF, "lcTempEnemy", 8);
            SetIsTemporaryEnemy(oTarget);
            ClearAllActions();
            DetermineCombatRound(oTarget);
            return;
          }
          oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, ++nTarget,
                                       CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL);
        }

        // non friend creature, too close
        nTarget = 1;
        oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN, OBJECT_SELF, nTarget);

        // heard neutral or enemy creature, too close
        while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 7.0)
        {
          if(!GetIsFriend(oTarget) && GetLocalString(oTarget, OAI_FACTION) != NEUTRAL &&
              GetLevelByClass(CLASS_TYPE_DRUID, oTarget) == 0 &&
              GetLevelByClass(CLASS_TYPE_RANGER, oTarget) == 0 &&
              GetAssociateType(oTarget) != ASSOCIATE_TYPE_ANIMALCOMPANION)
          {
            // oTarget has neutral reputation, and is NOT a druid or ranger or an "Animal Companion"
            SetLocalInt(OBJECT_SELF, "lcTempEnemy", 8);
            SetIsTemporaryEnemy(oTarget);
            ClearAllActions();
            DetermineCombatRound(oTarget);
            return;
          }
          oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN, OBJECT_SELF, ++nTarget);
        }

        if(!IsInConversation(OBJECT_SELF))
        {
          // 25% chance of just standing around instead of constantly
          // randWalking; i thought it looked odd seeing the animal(s)
          // in a constant state of movement, was not realistic,
          // at least according to my Nat'l Geographic videos
          if((d4() != 1) && (GetCurrentAction() == ACTION_RANDOMWALK)) return;
          else if ( (d4() == 1) && (GetCurrentAction() == ACTION_RANDOMWALK) )
          {
            ClearAllActions();
            return;
          }
          else
          {
            ClearAllActions();
            ActionRandomWalk();
            return;
          }
        }
      }
    }
    else if(!IsInConversation(OBJECT_SELF)) // enter combat when attacked
    {
      // after a while (20-25 seconds), omnivore (boar) "gives up"
      // chasing someone who didn't hurt it. but if the person fought back
      // this condition won't run and the boar will fight to death
      if(GetLocalInt(OBJECT_SELF, "lcTempEnemy") != FALSE && (GetLastDamager() == OBJECT_INVALID || GetLastDamager() != oTarget) )
      {
        int nPatience = GetLocalInt(OBJECT_SELF, "lcTempEnemy");
        if (nPatience <= 1)
        {
          ClearAllActions();
          ClearPersonalReputation(oTarget);  // reset reputation
          DeleteLocalInt(OBJECT_SELF, "lcTempEnemy");
          return;
        }
        SetLocalInt(OBJECT_SELF, "lcTempEnemy", --nPatience);
      }
      ClearAllActions();
      DetermineCombatRound(oTarget);
    }
  }

  // Herbivore behavior routine
  else if(GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
  {
    // no current attacker & not currently in combat
    if(!GetIsObjectValid(oTarget) && (GetIsInCombat() == FALSE))
    {
      if(!GetIsObjectValid(GetAttemptedAttackTarget())
        && !GetIsObjectValid(GetAttemptedSpellTarget())
        && !GetIsObjectValid(GetAttackTarget()))
      {
        if(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 13.0) // enemy creature, too close
        {
          ClearAllActions();
          ActionMoveAwayFromObject(oTarget, FALSE, 16.0); // flee from enemy
          return;
        }

        int nTarget = 1;
        oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, nTarget,
                                     CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL);

        while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 7.0) // only consider close creatures
        {
          if(GetLevelByClass(CLASS_TYPE_DRUID, oTarget) == 0 && GetLevelByClass(CLASS_TYPE_RANGER, oTarget) == 0 && GetAssociateType(oTarget) != ASSOCIATE_TYPE_ANIMALCOMPANION)
          {
            // oTarget has neutral reputation, and is NOT a druid or ranger or Animal Companion
            ClearAllActions();
            ActionMoveAwayFromObject(oTarget, FALSE, 16.0); // run away
            return;
          }
          oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, ++nTarget,
                                       CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL);
        }

        nTarget = 1;
        oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN, OBJECT_SELF, nTarget);

        while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 7.0) // only consider close creatures
        {
          if(!GetIsFriend(oTarget) && GetLevelByClass(CLASS_TYPE_DRUID, oTarget) == 0 && GetLevelByClass(CLASS_TYPE_RANGER, oTarget) == 0 && GetAssociateType(oTarget) != ASSOCIATE_TYPE_ANIMALCOMPANION)
          {
            // oTarget has neutral reputation, and is NOT a druid or ranger or Animal Companion
            ClearAllActions();
            ActionMoveAwayFromObject(oTarget, FALSE, 16.0); // run away
            return;
          }
          oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN, OBJECT_SELF, ++nTarget);
        }

        if(!IsInConversation(OBJECT_SELF))
        {
          // 75% chance of randomWalking around, 25% chance of just standing there. more realistic
          if((d4() != 1) && (GetCurrentAction() == ACTION_RANDOMWALK)) return;
          else if ( (d4() == 1) && (GetCurrentAction() == ACTION_RANDOMWALK) )
          {
            ClearAllActions();
            return;
          }
          else
          {
            ClearAllActions();
            ActionRandomWalk();
            return;
          }
        }
      }
    }
    else if(!IsInConversation(OBJECT_SELF)) // NEW BEHAVIOR - run away when attacked
    {
      ClearAllActions();
      ActionMoveAwayFromLocation(GetLocation(OBJECT_SELF), TRUE, 16.0);
    }
  }
}

int DetermineChanceOfAttack(object oPerceived)
{
  float fCR = GetChallengeRating(OBJECT_SELF);
  int iPartyMembers = 1;
  if(fCR < 1.0) fCR = 1.0;
  fCR = fCR + 1.0;
  float fPartyModFactor;
  float fModFactor = sqrt((fCR - (GetHitDice(oPerceived) * 0.5)) / (GetHitDice(oPerceived) * 0.5));
  if(fModFactor > 1.0) fModFactor = 1.0;
  if(fModFactor < 0.0) fModFactor = 0.0;

  object oPartyMember = GetFirstFactionMember(oPerceived, TRUE);
  while(GetIsObjectValid(oPartyMember))
  {
    if(oPartyMember != oPerceived && GetDistanceBetween(oPerceived, oPartyMember) < 15.0)
    {
      fPartyModFactor = sqrt((fCR - (GetHitDice(oPartyMember) * 0.5)) / (GetHitDice(oPartyMember) * 0.5));
      if(fPartyModFactor > 1.0) fPartyModFactor = 1.0;
      if(fPartyModFactor < 0.0) fPartyModFactor = 0.0;
      fModFactor = fModFactor * fPartyModFactor;
      iPartyMembers++;
    }
    oPartyMember = GetNextFactionMember(oPerceived);
  }

  float fChance = 100.0 * fModFactor;
  if(fChance == 0.0) fChance = 5.0 / IntToFloat(iPartyMembers);
  int iChance = FloatToInt(fChance);
  if(iChance == 0) iChance = 1;
  return iChance;
}

float GetEnemyCR (object oEnemy, float fEnemyCR)
{
  if(GetIsPC(oEnemy)) return IntToFloat(GetHitDice(oEnemy));
  else
  {
    float fCR = GetChallengeRating(oEnemy);
    if(fCR < 1.0) fCR = 1.0;
    return fCR;
  }
}

float GetTheirCR(object oEnemy, float f_TheirCR, float fRange, object oTheirs)
{
  oTheirs = GetFirstObjectInShape(SHAPE_SPHERE,fRange,GetLocation(OBJECT_SELF));
  while(GetIsObjectValid(oTheirs))
  {
    if(GetObjectType(oTheirs) == OBJECT_TYPE_CREATURE && GetIsEnemy(oTheirs,OBJECT_SELF))
    {
      if(GetIsPC(oTheirs)) f_TheirCR = f_TheirCR + IntToFloat(GetHitDice(oTheirs));
      else f_TheirCR = f_TheirCR + GetChallengeRating(oTheirs);
    }
    oTheirs = GetNextObjectInShape(SHAPE_SPHERE,fRange,GetLocation(OBJECT_SELF));
  }

  if(f_TheirCR < 1.0) f_TheirCR = 1.0;
  return f_TheirCR;
}

float GetOurCR(float f_OurCR, float fRange, object oMine)
{
  f_OurCR = GetChallengeRating(OBJECT_SELF);
  oMine = GetFirstObjectInShape(SHAPE_SPHERE,fRange,GetLocation(OBJECT_SELF));

  while (GetIsObjectValid(oMine))
  {
    if(GetObjectType(oMine) == OBJECT_TYPE_CREATURE
      && GetIsFriend(oMine,OBJECT_SELF)
      && GetLocalInt(oMine,"RETREATED") != 1
      && GetLocalInt(OBJECT_SELF,"FOF_DEAD") != 1)
    {
      f_OurCR = f_OurCR + GetChallengeRating(oMine);
    }
    oMine = GetNextObjectInShape(SHAPE_SPHERE,fRange,GetLocation(OBJECT_SELF));
  }

  if(f_OurCR < 1.0) f_OurCR = 1.0;
  return f_OurCR;
}

void FOF_Set(object oCreature = OBJECT_SELF)
{
  //basic restrictions: caller is not undead, construct, or HD > 5
  if(GetRacialType(OBJECT_SELF) != RACIAL_TYPE_UNDEAD
    && GetRacialType(OBJECT_SELF) != RACIAL_TYPE_CONSTRUCT
    && (GetHitDice(OBJECT_SELF) < 6
    || GetChallengeRating(OBJECT_SELF) < 6.0)) //fairly arbitrary, but we can work with it
  {
    //Feat-based restrictions: caller has no special fear immunity
    if(!GetHasFeat(FEAT_AURA_OF_COURAGE,OBJECT_SELF)
      && !GetHasFeat(FEAT_FEARLESS,OBJECT_SELF)
      && !GetHasFeat(FEAT_RESIST_NATURES_LURE)
      && !GetIsImmune(OBJECT_SELF,IMMUNITY_TYPE_FEAR)
      && !GetIsImmune(OBJECT_SELF,IMMUNITY_TYPE_MIND_SPELLS))
    {
      //Is it too stupid to know better? Caller has basic intelligence.
      if(GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 8)
      {
        SetLocalInt(OBJECT_SELF,"FIGHT_OR_FLIGHT",1);
        SetListening(OBJECT_SELF,TRUE);
        SetListenPattern(OBJECT_SELF,"RETREAT_CHECK",5000);
        SetListenPattern(OBJECT_SELF,"GUARD_ME",5001);

        //FOF 011203: Set Green/Seasoned/Veteran by HD
        //Veterans = HD 5
        if(GetHitDice(OBJECT_SELF) > 4)
        {
          SetLocalFloat(OBJECT_SELF,"fRaw",5.0);
        }

        //Seasoned = HD 3-4
        if(GetHitDice(OBJECT_SELF) == 3 || GetHitDice(OBJECT_SELF) == 4)
        {
          SetLocalFloat(OBJECT_SELF,"fRaw",4.0);
        }

        //Green = HD 1-2
        if(GetHitDice(OBJECT_SELF) == 1 || GetHitDice(OBJECT_SELF) == 2)
        {
          SetLocalFloat(OBJECT_SELF,"fRaw",3.0);
        }
      }
    }
  }
}

void FOF_Execute(object oCreature = OBJECT_SELF)
{
  object oEnemy;
  object oMaster;
  int nDom;
  float f_SelfCR = GetChallengeRating(OBJECT_SELF);
  if(f_SelfCR < 1.0) f_SelfCR = 1.0;
  float fRange = 20.0;
  float fEnemyCR;
  float fCompare;
  float fHP = IntToFloat(GetCurrentHitPoints(OBJECT_SELF));
  if(fHP < 1.0) fHP = 1.0;
  float fMax = IntToFloat(GetMaxHitPoints(OBJECT_SELF));
  if(fMax < 1.0) fMax = 1.0;
  int nFloor;
  float fRaw = GetLocalFloat(OBJECT_SELF,"fRaw");
  if(fRaw < 1.0) fRaw = 1.0;
  float f_TheirCR;
  float f_OurCR;
  object oTheirs;
  object oMine;
  float fGroupDiff;
  float fEnemyHP;
  float fEnemyMax;
  float fEnemyPercentage;
  float fMyPercentage;
  int nSave;
  float fBase = 20.0;

  //Determine oEnemy
  if(GetLastHostileActor() != OBJECT_INVALID)
  {
    oEnemy = GetLastHostileActor();
  }
  else
  {
    oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);
  }

  //A quick check to see if oEnemy is dominated
  oMaster = GetMaster(oEnemy);
  if(GetIsObjectValid(oMaster))
  {
    if(GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_DOMINATED,oMaster)))
    {
      if(GetAssociate(ASSOCIATE_TYPE_DOMINATED,oMaster) == oEnemy)
      {
        nDom = 1;
      }
      else
      {
        nDom = 0;
      }
    }
  }

  //Gets the individual enemy's CR or HD, as appropriate
  fEnemyCR = GetEnemyCR(oEnemy,fEnemyCR);

  //Compares caller's to enemy's CR. fCompare will impact the
  //key denominator later.
  fCompare = f_SelfCR / (fEnemyCR + 0.01);

  //Get the enemy group's total CR or HD, as appropriate
  f_TheirCR = GetTheirCR(oEnemy,f_TheirCR,fRange,oTheirs);

  //Get the caller's group's total CR or HD, as appropriate.
  f_OurCR = GetOurCR(f_OurCR,fRange,oMine);

  //Compares caller group's to enemy group's CR. fGroupDiff
  //will impact the key denominator later.
  fGroupDiff = f_OurCR / (f_TheirCR + 0.01);

  //HERE IS THE IMPORTANT LINE:
  //At a base level of 4.0 for fRaw, in combats where the
  //opponents and groups are evenly matched, the caller will
  //flee when HP reaches 1/6 of max.
  nFloor = FloatToInt(fMax / (fRaw * (fCompare + fGroupDiff + 0.01)));

  //Use the same factors to modify the base Fear save
  nSave = FloatToInt(fBase / (fCompare + fGroupDiff + 0.01));

  //How bad off is the enemy?
  fEnemyHP = IntToFloat(GetCurrentHitPoints(oEnemy));
  if(fEnemyHP < 1.0) fEnemyHP = 1.0;
  fEnemyMax = IntToFloat(GetMaxHitPoints(oEnemy));
  if(fEnemyMax < 1.0) fEnemyMax = 1.0;
  fEnemyPercentage = fEnemyHP / (fEnemyMax + 0.01);

  //How bad off am I?
  fMyPercentage = fHP / (fMax + 0.01);

  //A bit of a fig leaf here to allow creatures who heard
  //the RETREAT_CHECK shout to run even if they are in
  //better HP shape than oEnemy.
  int nHPCheck;
  if(fMyPercentage < fEnemyPercentage || GetLocalInt(OBJECT_SELF,"HEARD_THE_CALL") == 1)
  {
    nHPCheck = 1;
  }

  //Issues the command to do a Will save vs Fear if caller's
  //HP falls below the floor AND caller is in worse HP shape
  //than its opponent (to give the monsters SOME incentive to
  //slug it out).
  if(GetCurrentHitPoints(OBJECT_SELF) <= nFloor && nHPCheck == 1)
  {
    //A little bit to exclude dominated creatures.
    if (nDom == 0)
    {
      //Performs a will save modified by the factors.
      //Current base of 20 is deceptive; for equal
      //individual/group strengths, the save is 10, or
      //20 / (1 + 1)
      if(WillSave(OBJECT_SELF,nSave,SAVING_THROW_TYPE_FEAR,oEnemy) == 0)
      {
        SignalFlee(oEnemy,fRange);
        DelayCommand(1.0, ActionDoCommand(DetermineCombatRound()));
      }
      else
      {
        //If you've made your will save and you're
        //a leader, you still summon allies to help you.
        if(GetLocalInt(OBJECT_SELF,"OAI_I_AM_A_LEADER") == 1) CallForHelp();
        else DelayCommand(1.0, ActionDoCommand(DetermineCombatRound()));
      }
    }
  }

  //Reset HEARD_THE_CALL to zero in the event this script
  //was called by a RETREAT_CHECK shout.
  SetLocalInt(OBJECT_SELF,"HEARD_THE_CALL",0);
}

void CallForHelp()
{
  SpeakString("GUARD_ME",TALKVOLUME_SILENT_TALK);
  DelayCommand(1.0, ActionDoCommand(DetermineCombatRound()));
}
// dk: make the creature get away
//
// You need to call some things as if we died
void EscapeFromMap()
{
  ExecuteScript("oai_cust_death", OBJECT_SELF);
  DestroyObject(OBJECT_SELF);
}

// dk: 17-Dec-2005 Added KeepFleeing to rally, escape or keep running
void KeepFleeing(float fRange)
{
    // Get closest enemy
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);

    // Remember we were uncommandable when we started fleeing
    SetCommandable(TRUE);

    // Have I recieved inspiration to return to battle
    if ((d20() + GetLocalInt(OBJECT_SELF, "OAI_TRAPPED")) > (GetHasEffect(EFFECT_TYPE_REGENERATE) ? 8 : 18)) {
        PlayVoiceChat(VOICE_CHAT_ATTACK);
        DelayCommand(1.0, ActionDoCommand(DetermineCombatRound()));
        return;
    }

    // Am I far enough away?
    if (GetDistanceBetween(OBJECT_SELF, oEnemy) > fRange) {
        ActionDoCommand(EscapeFromMap());
        return;
    }

    // Dam, either trapped or being followed
    // Remember we were trapped and increase chance of turning and fighting
    SetLocalInt(OBJECT_SELF, "OAI_TRAPPED", GetLocalInt(OBJECT_SELF, "OAI_TRAPPED") + 2);
    SetLocalInt(OBJECT_SELF,"RETREATED",1);
    PlayVoiceChat(VOICE_CHAT_FLEE);
    ActionMoveAwayFromObject(oEnemy,TRUE,fRange + 10.0);
    ActionDoCommand(SetLocalInt(OBJECT_SELF,"RETREATED",0));
    ActionDoCommand(KeepFleeing(fRange));
    SetCommandable(FALSE);
}

void SignalFlee(object oEnemy, float fRange)
{
  object oTest;

  //Is there a leader within fRange + 20.0?
  oTest = GetFirstObjectInShape(SHAPE_SPHERE,fRange + 20.0,GetLocation(OBJECT_SELF),OBJECT_TYPE_CREATURE);
  while(GetIsObjectValid(oTest))
  {
    //Leader...Break Out of Loop
    if(GetLocalInt(oTest,"OAI_I_AM_A_LEADER") == 1) break;
    oTest = GetNextObjectInShape(SHAPE_SPHERE,fRange + 20.0,GetLocation(OBJECT_SELF),OBJECT_TYPE_CREATURE);
  }

  //if we found no leader (the oTest is still a invalid object)
  if(GetIsObjectValid(oTest) == FALSE)
  {
    oTest = GetNearestObjectByTag("OAI_SAFE", OBJECT_SELF);
  }

  //Retreat to leader or rallying point, or scatter.
  if(GetLocalInt(oTest,"OAI_I_AM_A_LEADER") == 1 && GetDistanceToObject(oTest) >= 10.0)
  {
    ClearAllActions();
    //SpeakString("I NEED SOME HELP HERE!");
    PlayVoiceChat(VOICE_CHAT_HELP);
    SetLocalInt(OBJECT_SELF,"RETREATED",1);
    ActionMoveToObject(oTest,TRUE,2.0);
    ActionDoCommand(SetLocalInt(OBJECT_SELF,"RETREATED",0));
    ActionDoCommand(SetCommandable(TRUE,OBJECT_SELF));
    SetCommandable(FALSE,OBJECT_SELF);
  }
  else if(GetIsObjectValid(oTest) == TRUE && GetDistanceToObject(oTest) >= 10.0)
  {
    ClearAllActions();
    //SpeakString("Fall back and regroup!");
    PlayVoiceChat(VOICE_CHAT_GUARDME);
    SetLocalInt(OBJECT_SELF,"RETREATED",1);
    ActionMoveToObject(oTest,TRUE,2.0);
    ActionDoCommand(SetLocalInt(OBJECT_SELF,"RETREATED",0));
    ActionDoCommand(SetCommandable(TRUE,OBJECT_SELF));
    SetCommandable(FALSE,OBJECT_SELF);
  }
  else
  {
    ClearAllActions();
    //SpeakString("RUN! I AM OUT OF HERE!");
    PlayVoiceChat(VOICE_CHAT_FLEE);
    SetLocalInt(OBJECT_SELF,"RETREATED",1);
    ActionMoveAwayFromObject(oEnemy,TRUE,fRange + 10.0);
//    ActionDoCommand(SetLocalInt(OBJECT_SELF,"RETREATED",0));
    ActionDoCommand(KeepFleeing(fRange));
    SetCommandable(FALSE,OBJECT_SELF);
  }

  //Shout a RETREAT_CHECK, but not if you're the one making the
  //check based on an ally's call. Reads an int set in nw_c2_default4.
  if(GetLocalInt(OBJECT_SELF,"HEARD_THE_CALL") == 1)
  {
    SetLocalInt(OBJECT_SELF,"HEARD_THE_CALL",0);
  }
  else
  {
    SpeakString("RETREAT_CHECK",TALKVOLUME_SILENT_TALK);
  }
}

// dk: 1-Jun-2006
int OAI_DecrementCounter(string sCounter)
{
    int nCounter = GetLocalInt(OBJECT_SELF, sCounter) - 1;

    if (nCounter == 0) DeleteLocalInt(OBJECT_SELF, sCounter);
    else if (nCounter > 0) SetLocalInt(OBJECT_SELF, sCounter, nCounter);

    return nCounter;
}

//void main() {}
