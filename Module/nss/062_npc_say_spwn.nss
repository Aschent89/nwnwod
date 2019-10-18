//::///////////////////////////////////////////////
//::
//:: FileName: 062_npc_say_spwn
//::
//:://////////////////////////////////////////////
/*
This is a derivation of the "more fully commented"
OnSpawn script from bioware. I left in all the comments
for people to read, but you really only need the
lines that are uncommented.

If you want your NPC to walk around a bit, use the
SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS) rather
than the immobile one. However, this significantly
reduces the effect of the npc_say script.
*/
//:://////////////////////////////////////////////
//:: Created By:    Ranoulf
//:: Created On:    Aug 22 02
//:://////////////////////////////////////////////
#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"
void main()
{
// OPTIONAL BEHAVIORS (Comment In or Out to Activate ) ****************************************************************************
     SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
                // This causes the NPC to speak a single line from their dialogue file
                // upon perceiving a player. Make sure that the line being spoken is at the
                // very top of the NPC's other dialogue starting nodes and that you have
                // placed the script "nw_d2_gen_check" in that line's 'Text Appears When' area.
                // Do not use this flag for hostile creatures.
     //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
                // This flag is similar to the above... except that it allows a hostile NPC
                // to display a single line of dialogue before attacking. Put the line into the
                // NPC's dialogue file as above, but place "nw_d2_gen_combat" into 'Text Appears When'
     //SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
                // This sets up the NPC so that any NPC of a faction who is friendly to it
                // who is attacked or attacks an enemy (and is using the generic AI) will issue a shout
                // that this NPC will now listen and respond to.
     //SetSpawnInCondition(NW_FLAG_STEALTH);
                // If the NPC has Hide skill they will automatically be in Stealth Mode
                // but only when the WalkWayPoints command is called (below)
     //SetSpawnInCondition(NW_FLAG_SEARCH);
                // If the NPC has the Search skill they are automatically in Search Mode
                // but only when the WalkWayPoints command is called (below)
     //SetSpawnInCondition(NW_FLAG_SET_WARNINGS);
                // This will set the NPC to give a warning to non-enemies before attacking
     //SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);
                // This seperates the NPC's waypoints into night and day. Normally a waypoint prefix "WP"
                // or "POST" would be used always. If this flag is set, those prefixes are used in the day
                // and "WN" or "NIGHT" prefixes are used at night.
     //SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);
                // when the creature spawns in, it uses EffectAppear() instead of fading in
                // but only if SetListeningPatterns is called (below)
     SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
                // this causes the NPC to use common animations it possesses, and will appear more
                // social if placed near a friendly NPC (they will turn to each other and use social animations)
     //SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
                //This is similar to the above, except that the creature will also move around randomly
                //NOTE that these animations will play automatically for Encounter Creatures.
    // NOTE: ONLY ONE OF THE FOLOOWING ESCAPE COMMANDS SHOULD EVER BE ACTIVATED AT ANY ONE TIME.
    //SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);    // OPTIONAL BEHAVIOR (Flee to a way point and return a short time later.)
    //SetSpawnInCondition(NW_FLAG_ESCAPE_LEAVE);     // OPTIONAL BEHAVIOR (Flee to a way point and do not return.)
    //SetSpawnInCondition(NW_FLAG_TELEPORT_LEAVE);   // OPTIONAL BEHAVIOR (Teleport to safety and do not return.)
    //SetSpawnInCondition(NW_FLAG_TELEPORT_RETURN);  // OPTIONAL BEHAVIOR (Teleport to safety and return a short time later.)
                // to use 'escape', you need a waypoint the NPC will flee to with the tag "EXIT_" + the NPC's tag
                // these commands can be activated in a script by calling ActivateFleeToExit(), "NW_IO_GENERIC" must be included
                // for the escape commands that have 'return', the NPC will be re-spawned at it's starting location
// CUSTOM USER DEFINED EVENTS
/*
    The following settings will allow the user to fire one of the blank user defined events in the NW_D2_DefaultD.  Like the
    On Spawn In script this script is meant to be customized by the end user to allow for unique behaviors.  The user defined
    events user 1000 - 1010
*/
    //SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1001
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007
// DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) *****************************************************************************************
    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.
    WalkWayPoints();           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                               // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                               // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                               //    combat.
                               // To get the NPC to continue walking waypoints after conversation, you must go
                               // into its dialogue file and, under 'Other Files', call this command again in the
                               // 'End' and 'Aborted' script sections
    GenerateNPCTreasure();     //* Use this to create a small amount of treasure on the creature
}

