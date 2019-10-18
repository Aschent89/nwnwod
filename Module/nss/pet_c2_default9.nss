////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default9
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnSpawn
//
////////////////////////////////////////////////////////////////////////////////

//NWN Bases
#include "x0_i0_anims"
#include "x2_inc_switches"

#include "oai_inc_ai"
#include "oai_inc_spawn"

void main()
{

  object oNPC = OBJECT_SELF;

/******************************************************************************/
//: PRE SPAWN ADDITONS BELOW HERE

  //Custom Scripts you Need to Execute
  ExecuteScript("oai_cust_spawn", OBJECT_SELF);

  //Randomize Abilities
  SetRandomAbilitiesOnCreatureSpawn();

//: PRE SPAWN ADDITONS ABOVE HERE
/******************************************************************************/

/******************************************************************************/
// :: COMMON AI SWITCHES

// * Fast Buff Switches:
  //SetBattleCondition(OAI_FAST_BUFF_COMPLETE);//Everything.....Right Now
  //SetBattleCondition(OAI_FAST_BUFF_ADVANCED);//Lots of the Best Buffs and Enemies within 30 Meters
  //SetBattleCondition(OAI_FAST_BUFF_RANDOM);//Random Buff
  //SetBattleCondition(OAI_FAST_BUFF_SUMMON);//Instant call Summon Creature

// * Return to Spawned Location
  //SetBattleCondition(OAI_RETURN_TO_SPAWNPOINT);

// * Aura switch:
  //SetBattleCondition(OAI_CAST_AURAS_NOW);

// * Morale Switches (Originally By Jeff Petersen)

  /*
  FIGHT_OR_FLIGHT: Added a comment-out feature to set a local
  int on creatures to signal FIGHT_OR_FLIGHT. Disable this
  function by commenting it out. Only affects non-undead,
  non-dominated creatures with int > 5, CR or HD < 5, and
  no fear-specific feats.
  */
  FOF_Set();

  /*
  FIGHT_OR_FLIGHT:: A comment-in feature for leaders, works with
  the morale system. Creatures fleeing will look for a leader in
  range, then rally to him. If no leader and no other rallying
  point, they will run away rather willy-nilly.
  */
  //SetBattleCondition(OAI_ROLE_GROUP_LEADER);

// :: COMMON AI SWITCHES
/******************************************************************************/

/******************************************************************************/
// :: SPECIAL ABILITIES

// * Blinking
  /*
  Blinking is just a short range teleport used in battle to confuse the
  enemy and give casters a extra couple of seconds to cast a spell. There
  are 2 types of blink that you can use, the first is OAI_BLINK_SELF which
  will cause this NPC to teleport to different places around the battle.

  The other type (which can be enabled at the same time) is OAI_BLINK_OTHER
  which will teleport anyone who hits the caster physically. Both blink
  types can have a failure rate set in OAI_BLINK_FAILURE where a 0 means
  they blink every round and a 100 means they never blink.
  */

  //SetBattleCondition(OAI_BLINK_SELF);
  //SetBattleCondition(OAI_BLINK_OTHERS);
  //SetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE", 10); //failure rate of 10%

// * Illusionary Creature
  /*
  An illusionary creature looks like something it is not. There is an
  Illusion Break DC that must be overcome vs. Will Save.
  So make your True Spawn and then Change the Appearance Type Below to
  what the creature should Appear As.
  */
  //SetLocalInt(OBJECT_SELF, "OAI_ILLUSION_DC", 25); //DC of 25
  //SetLocalInt(OBJECT_SELF, "OAI_REAL_SELF", APPEARANCE_TYPE_*);

// * Shapechanger (Not for Shifters!!)
  /*
  A shapechanger just uses a permanent type of polymorph spell and has
  a chance of going off each round depending upon the health of
  the NPC. Just uncomment and supply the value you want and your done.
  */
  //SetLocalInt(OBJECT_SELF, "OAI_SHAPECHANGE", POLYMORPH_TYPE_PIXIE);

// * Summon Hordes (Not Needed with NESS)
  /*
  Every round the creature has a chance of summoning another OAI_SUMMON.
  For example, if you have the pixie king with OAI_SUMMON set to "pixie"
  and OAI_SUMMON_FAILURE set to 0, every round another pixie will join the
  battle using OAI_SUMMON_FX to appear. If the summon fx is 0 or not defined
  it will use no summoning effect.
  */
  //SetLocalString(OBJECT_SELF, "OAI_SUMMON", "pixie"); //replace pixie with the resref of the creature it really is, if needed.
  //SetLocalInt(OBJECT_SELF, "OAI_SUMMON_FAILURE", 25); //25% chance of failure per round
  //SetLocalInt(OBJECT_SELF, "OAI_SUMMON_FX", VFX_FNF_SUMMON_MONSTER_1);

// * Special Conversations
  /*
  Use the file "nw_d2_gen_check" in a converation (first string) and they
  will say it when they see an enemy.
  */
  //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);

  /*
  Similar to above BUT use "nw_d2_gen_combat" in the tree though.
  This causes the creature to say a special greeting in their conversation file
  upon Perceiving the player. Attach the [nw_d2_gen_check.nss] script to the desired
  greeting in order to designate it. As the creature is actually saying this to
  himself, don't attach any player responses to the greeting.
  */
  //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);

// * Auto-stealth
  /*
  The NPC will go into stealth mode when not in combat.
  */
  //SetSpawnInCondition(NW_FLAG_STEALTH);

// * Auto-search
  /*
  The NPC will go into search mode when not in combat
  */
  //SetSpawnInCondition(NW_FLAG_SEARCH);

// * Herbavores and Omnivores
  /*
  This is great for making Animals Behave like natural animals should. Most of the
  standard palette Animals are automatically set for this.
  NOTE: Uncomment ONLY 1 Below. This also DOES NOT work with the Special
        Combat Abilities below.
  */
  //SetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE);
  //SetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE);

// :: SPECIAL ABILITIES
/******************************************************************************/

/******************************************************************************/
// :: SPECIAL COMBAT ABILITIES

    // * These are special flags that can be set on creatures to
    // * make them follow certain specialized combat tactics.
    // * NOTE: ONLY ONE OF THESE CAN BE SET ON A SINGLE CREATURE.
    // *       EXCEPT DENOTED BY  (*)  WHICH CAN BE USED IN ANY
    // *       COMBINATION

    // * Ranged attacker
    // * Will attempt to stay at ranged distance from their
    // * target. This WILL use the Arcane Archer Feats/Skills
    // SetBattleCondition(OAI_COMBAT_FLAG_RANGED);

    // * Defensive attacker
    // * Will use defensive combat feats and parry
    // * Monks will use this Automatically
    // SetBattleCondition(OAI_COMBAT_FLAG_DEFENSIVE);

    // * Ambusher
    // * Will go stealthy/invisible and attack, then
    // * run away and try to go stealthy again before
    // * attacking anew. Any Sneaks? They will use this
    // * automatically.
    // SetBattleCondition(OAI_COMBAT_FLAG_AMBUSHER);

    // * Cowardly
    // * Cowardly creatures will attempt to flee attackers.
    // * Optional: You can place ANY # of Objects with the Tag  OAI_SAFE
    // * and they will attempt to run to that object.
    // SetBattleCondition(OAI_COMBAT_FLAG_COWARDLY);

    // * Beholder
    // * They will use their Eyeball Rays and Special Abilities
    // SetBattleCondition(OAI_ROLE_BEHOLDER);

    // * Gelatinous Cubes
    // * They will try to get close and Engulf their Victims
    // SetBattleCondition(OAI_ROLE_GELATINOUSCUBE);

    // * Trolls
    // * Tough to bring these down...need Fire or Acid to Destroy them
    // SetBattleCondition(OAI_ROLE_TROLL);

    // * Spiders
    // * Spiders Use Their Web Abilities To Swing Around In Battle. They Also
    // * Tend go for the Weakest Creature.
    // SetBattleCondition(OAI_ROLE_SPIDER);

    // * Mindflayers
    // * They will use their Special Brain Suck and Mind Blasts as their
    // * Primary Choices. They will resort to Psionics/Spells or Melee if
    // * Conditions are not right for their Special Abilities
    // SetBattleCondition(OAI_ROLE_MINDFLAYER);

    // * Ghosts (*)
    // * Apply Ghosting Effects to a Creature
    // SetBattleCondition(OAI_ROLE_GHOST);

    // * Quicklings/Speedy Folk (*)
    // * Pretty Simple Really....Applies a Permanent Haste Effect on Creature
    // SetBattleCondition(OAI_ROLE_SPEEDY);

    // * Number of Attacks (*)
    // * Have Creatures with Multiple Arms or Heads or Maybe just want them to be
    // * a Naturally Better with Attacks? Well....do that here.
    // * Uncomment Below and set the Number of Attacks to what you need (Range 1 to 5)
    // * Note: If you leave the Number of Attacks Commented (Green) then 5 is used
    // SetBattleCondition(OAI_ROLE_NUMBEROFATTACKS);
    // SetLocalInt(OBJECT_SELF,"OAI_ROLE_NUMBEROFATTACKS",5); /* <= CHANGE THAT 5 */

    // * Horseman NPCs (Requires NWNv1.69)
    // * This will make Civilized NPCs Ride a Horse.
    // * The SAME NPCs in a Town can Ride Horses when Out of Town.
    // * Horsemen will gain the OAI Trample when Mounted.....Just like the OAI Crits for Horses.
    // * Enable the =>  SetBattleCondition(OAI_ROLE_HORSEMAN);
    // * Then Enable ONE =>  SetBattleCondition(OAI_ROLE_HORSEMAN_*****);
    // * NOTE: If you want a Static Riding NPC....Do that in the Toolset Creature Properties
    // * Horse Riders gain Various Bonus Speed (Not Hasted) Per Type of Horse....Just like Players
    // * The Waypoint "CityProper" will disallow Riding of any kind.
    // * Underground Flagged Areas will disallow Riding of any kind.
    // * Colors of Horses are Random  Brown, Dapple, Black, Spotted
    //SetBattleCondition(OAI_ROLE_HORSEMAN); //Must Be Enabled
    //SetBattleCondition(OAI_ROLE_HORSEMAN_SADDLE); //50% Speed Increase
    //SetBattleCondition(OAI_ROLE_HORSEMAN_RCLOTH); //46% Speed Increase
    //SetBattleCondition(OAI_ROLE_HORSEMAN_PCLOTH); //46% Speed Increase
    //SetBattleCondition(OAI_ROLE_HORSEMAN_LEATHER); //46% Speed Increase
    //SetBattleCondition(OAI_ROLE_HORSEMAN_CHAIN); //44% Speed Increase
    //SetBattleCondition(OAI_ROLE_HORSEMAN_SCAIL); //42% Speed Increase

//: SPECIAL ABILITES
/******************************************************************************/

/******************************************************************************/
//: ANIMATIONS

    // * Separate the NPC's waypoints into day & night.
    // * See comment on WalkWayPoints() for use.
    // *
    SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);

    // * If this is set, the NPC will appear using the "EffectAppear"
    // * animation instead of fading in...Ie....Drop-In Animation
    // *
    // SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);

    // * This will cause an NPC to use common animations it possesses,
    // * and use social ones to any other nearby friendly NPCs.
    // *
    // SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    // * This will cause an NPC to wander randomly around the area.
    // * and use social ones to any other nearby friendly NPCs.
    // *
    SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);

// **** Animation Conditions **** //
    // * These are extra conditions you can put on creatures with ambient
    // * animations.

    // * Civilized creatures interact with placeables in
    // * their area that have the tag "NW_INTERACTIVE"
    // * and "talk" to each other.
    // *
    // * Humanoid races are civilized by default, so only
    // * set this flag for monster races that you want to
    // * behave the same way.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);

    // * If this flag is set, this creature will constantly
    // * be acting. Otherwise, creatures will only start
    // * performing their ambient animations when they
    // * first perceive a player, and they will stop when
    // * the player moves away.
    // SetAnimationCondition(NW_ANIM_FLAG_CONSTANT);

    // * Civilized creatures with this flag set will
    // * randomly use a few voicechats. It's a good
    // * idea to avoid putting this on multiple
    // * creatures using the same voiceset.
    //SetAnimationCondition(NW_ANIM_FLAG_CHATTER);

    // * Creatures with _immobile_ ambient animations
    // * can have this flag set to make them mobile in a
    // * close range. They will never leave their immediate
    // * area, but will move around in it, frequently
    // * returning to their starting point.
    // *
    // * Note that creatures spawned inside interior areas
    // * that contain a waypoint with one of the tags
    // * "NW_HOME", "NW_TAVERN", "NW_SHOP" will automatically
    // * have this condition set.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE);

//: ANIMATIONS
/******************************************************************************/

/******************************************************************************/
//: MANUAL ROLES

/*
  Note: The roles are in the order of priority so if an NPC is marked
        as a healer they will try and heal first, if no one needs a heal
        then they will do any other role below that until they run out
        of roles and attempt a physical attack.
        Casters ARE Automatically Set Up by this AI and depends upon what spells
        have been given to them! Keep this in mind. The Roles Set Below ADD Flavor
        to the Caster and FORCE allow more selections...which could be unintended.

        Note: You can use more than 1 of these but the AI may get a little
              confused if you do. Try to use only 1 or something complimentary
*/

    //* If an npc has healer selected they will heal as a priority, then follow
    //* whatever other roles are switched on.
    //SetBattleCondition(OAI_ROLE_HEALER);

    //* After healing they have 1/4 chance to use monster abilities if they have them,
    //* even if assigned other roles...
    //* A buffer will apply buffs to any group members that request them.
    //SetBattleCondition(OAI_ROLE_BUFFER);

    //* An aoe specialist can be deadly to both sides, but is pretty good at
    //* hitting only enemies. The aoe code uses a bit of math to determine the
    //* best location, so is usually very deadly.
    //SetBattleCondition(OAI_ROLE_AOE_SPECIALIST);

    //* A status caster will attempt to put status ailments on enemies to slow
    //* Things down. They will also try to dispell and keep targets clean for the
    //* Melee attackers.
    //SetBattleCondition(OAI_ROLE_STATUS_CASTER);

    //* An attack caster casts single target or safe aoe attack spells. They will
    //* use dangerous aoe spells if they run out of safe spells
    //SetBattleCondition(OAI_ROLE_ATTACK_CASTER);

//: MANUAL ROLES
/******************************************************************************/

/******************************************************************************/
//: EVENTS (Not used in OAI but left for Custom User Defined Events)

    //SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1001
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007

//: EVENTS
/******************************************************************************/

/******************************************************************************/
//: MAIN SETUP

// * LEAVE THESE ALONE!!

//Sets up the Shouts the NPC Will Listen To
SetListeningPatterns();

//Sets up Personal Characteristics of Each NPC
WhoAmI();

//: MAIN SETUP
/******************************************************************************/

/******************************************************************************/
//: POST SPAWN ADDITONS BELOW HERE



//: POST SPAWN ADDITONS ABOVE HERE
/******************************************************************************/

DelayCommand(2.0, WalkWayPoints());// Delayed walk waypoints, as to not upset instant combat spawning.
                                   // This will also check if to change to day/night posts during the
                                   // walking, no heartbeats.
}
