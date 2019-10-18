#include "rp_struct"
#include "_inc_color_text_"
///////////////////////////////////////////////////////////////////////////////
/////////////////////Mad Rabbit's Roleplaying World////////////////////////////
//////////////////////////////Controls/////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/* This package of scripts is designed to create an as realistic and immersive
roleplaying world as possible. The following is a list of global variables for
enabling and disabling the features of the program                           */
///////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Created By : MadRabbit
//Email : mad_rabbit_land@hotmail.com
//NOTE : Only email me with bugs and suggestions for improvement of the overall
//program for release on the vault. I do not do special requests or specific
//modifications for an individual server.
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////DEBUG////////////////////////////////////////
//Set to 1 to turn on debug mode. Set to 0 to turn off.
//Default : 0
const int RP_DEBUG_ON = 0;
///////////////////////////////PERSISTANT TIME//////////////////////////////////
//Set to 1 if you want the modules time to be recorded on rest and reset each
//time the module to load. Set to 0 disable this feature.
//WARNING: Disabling this feature can cause conflict with other systems in this
//package
//Default : 1
const int RP_PERSISTANT_TIME_ON = 1;

//////////////////////////////CLIENT ON ENTER///////////////////////////////////
//Set to 1 if you want characters to be stripped of their gold and items when
//they log in for the first time. They are given a no drop item that flags
//them as already having been stripped. Set to 0 to disable this
//Default : 0
const int RP_STRIP_PLAYER_FIRST_LOGIN_ON = 0;

//////////////////////////////////RESTING///////////////////////////////////////
//Set to 1 if you want players to be restricted to resting in resting area. Set
//to 0 if you want to allow players to rest anywhere.
//Default : 1
const int RP_RESTING_AREA_ON = 1;

//Set to 1 if you want the resting player to be struck with blindness and the
//sleeping visual effect. Set to 0 to disable
//Default : 1
const int RP_RESTING_EFFECTS_ON = 1;

/////////////////////////////////CAMPFIRES//////////////////////////////////////
//Duration of lit campfires in hours
//Default : 2
const int RP_CAMPFIRES_DURATION = 2;

/////////////////////HUNGER THIRST AND FATIGUE SYSTEM//////////////////////////
//Set to 0 to disable the fatigue system. Set to 1 to enable.
//Default : 1
const int RP_HTF_FATIGUE_ON = 0;

//Set to 0 to disable the Hunger and Thirst system. Set to 1 to enable.
//Default : 1
const int RP_HTF_HT_ON = 0;

//This is the number of hours a player can go without resting before fatigue
//begins. Forumula is RP_HTF_FATIGUE_START + CON Bonus
//Default : 12
const int RP_HTF_FATIGUE_START = 12;

//Set to 1 to reapply any effects on respawn the player had prior to death from hunger,
//thirst or fatigue. Set to 0 to clear the effects on death. The effects will
//be reapplied upon the next module-wide check.
//Default : 1
const int RP_HTF_EFFECTS_ON_RESPAWN = 0;

//This is the number of hours before the berry bushes produce more berries after
//being picked
//Default : 1
const int RP_HTF_BERRY_BUSHES_RESPAWN = 1;

/*The following is a list of the effects that are applied when the player
becomes tired, hungry, or thirsty. There is two different levels of effects,
Level 2 being applied 6 hours after the Level 1 effects are applied. The effects
do not stack. You may customize these effects by changing the effect function
within each effect variable. *IMPORTANT* You must not change the variable name
or the scripts will not compile! There is 3 different effects that may be applied
for each level of hunger, thirst, and fatigue. Unfortanely, you may not add
anymore effects, but you can use less than 3.

Example One:
Let's say you wish to change the 20% spell failure on Level 1 Fatigue to -10 penalty
to the skill Tumble.
Orginal Code: Fatigue.eLvl1Effect1 = EffectSpellFailure(20);
Modified Code: Fatigue.eLvl1Effect1 = EffectSkillDecrease(SKILL_TUMBLE, 10);

Example Two:
Let's say you wish to use the 20% spell failure and -10 to attack with Level 1
Fatigue, but don't want to use the third effect of 20% movement speed decrease.
You would modify the third effect to the following
Original Code: Fatigue.eLvl1Effect3 = EffectMovementSpeedDecrease(30);
Modified Code: Fatigue.eLvl1Effect3;
*/

//Fatigue Effects
struct HTF FatigueEffects()
{
    //DO NOT CHANGE THIS
    struct HTF Fatigue;

    //Level 1 Fatigue Effects
    //Default: Spell Failure 20%
    Fatigue.Lvl1Effect1 = EffectSpellFailure(40);
    //Default: -10 Attack Penalty
    Fatigue.Lvl1Effect2 = EffectAttackDecrease(10);
    //Default: 20% Movement Speed Decrease
    Fatigue.Lvl1Effect3 = EffectMovementSpeedDecrease(20);

    //Level 2 Fatigue Effects
    //Default: Spell Failure 40%
    Fatigue.Lvl2Effect1 = EffectSpellFailure(60);
    //Default: -20 Attack Penalty
    Fatigue.Lvl2Effect2 = EffectAttackDecrease(20);
    //Default: 30% Movement Speed Decrease
    Fatigue.Lvl2Effect3 = EffectMovementSpeedDecrease(40);

    //DO NOT CHANGE THIS
    return Fatigue;
}

//Hunger Effects
struct HTF HungerEffects()
{
    //DO NOT CHANGE THIS
    struct HTF Hunger;

    //Level 1 Hunger Effects
    //Default: -4 Strength Penalty
    Hunger.Lvl1Effect1 = EffectAbilityDecrease(ABILITY_STRENGTH, 4);
    //Default: -4 Dexterity Penalty
    Hunger.Lvl1Effect2 = EffectAbilityDecrease(ABILITY_DEXTERITY, 4);
    //Default: -4 Constitution Penalty
    Hunger.Lvl1Effect3 = EffectAbilityDecrease(ABILITY_CONSTITUTION, 4);

    //Level 2 Hunger Effects
    //Default: -8 Strength Penalty
    Hunger.Lvl2Effect1 = EffectAbilityDecrease(ABILITY_STRENGTH, 8);
    //Default: -8 Dexterity Penalty
    Hunger.Lvl2Effect2 = EffectAbilityDecrease(ABILITY_DEXTERITY, 8);
    //Default: -8 Constitution Penalty
    Hunger.Lvl2Effect3 = EffectAbilityDecrease(ABILITY_CONSTITUTION, 8);

    //DO NOT CHANGE THIS
    return Hunger;
}

//Thirst Effects
struct HTF ThirstEffects()
{
    //DO NOT CHANGE THIS
    struct HTF Thirst;

    //Level 1 Thirst Effects
    //Default: -4 Intillegence Penalty
    Thirst.Lvl1Effect1 = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 4);
    //Default: -4 Wisdom Penalty
    Thirst.Lvl1Effect2 = EffectAbilityDecrease(ABILITY_WISDOM, 4);
    //Default: -4 Charisma Penalty
    Thirst.Lvl1Effect3 = EffectAbilityDecrease(ABILITY_CHARISMA, 4);

    //Level 2 Thirst Effects
    //Default: -8 Intillegence Penalty
    Thirst.Lvl2Effect1 = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 8);
    //Default: -8 Wisdom Penalty
    Thirst.Lvl2Effect2 = EffectAbilityDecrease(ABILITY_WISDOM, 8);
    //Default: -8 Charisma Penalty
    Thirst.Lvl2Effect3 = EffectAbilityDecrease(ABILITY_CHARISMA, 8);

    //DO NOT CHANGE THIS
    return Thirst;
}

////////////////////////////PLAYER DEATH////////////////////////////////////////
//This is the delay before the GUI Panel pops up after the player dies
//Default = 2.5
const float RP_DEATH_GUI_PANEL_DELAY = 2.5;

//Set to 1 if you want the screen to go black while player waits for GUI panel.
//Default = 0
const int RP_DEATH_BLACK_SCREEN_ON = 0;

//Set to 0 to disable the respawn button on GUI Panel. Set to 1 to enable
//Default = 1
const int RP_DEATH_RESPAWN_BUTTON_ON = 1;

//Set to 0 to disable the wait for help button on GUI Panel. Set to 1 to enable
//Default = 1
const int RP_DEATH_WAIT_FOR_HELP_BUTTON_ON = 1;

//Change this string to replace the help message on GUI Panel with your own.
//Set to "" to use the Bioware default help message
const string RP_DEATH_HELP_MESSAGE = "You have died! Respawning will apply a death penalty, or you may choose to wait for help.";

//////////////////////////////SPELL COMPONENTS//////////////////////////////////
//Set to 1 to enable the spell component system. Set to 0 to disable. To add
//spell components to spells, open the script rp_spl_cmpnt_lst and follow the
//instructions
//Default = 0;
const int RP_SPELL_COMPONENTS_ON = 0;

/////////////////////////////ARMOR ENCUMBRANCE//////////////////////////////////
//Set to 1 to enable the armor encumbrance system. Set to 0 to disable
//Default : 1
const int RP_ARMOR_ON = 1;

//The following is a list of the movement speed penalties associated with each
//armor and racial type.

//Medium Armor
struct Armor MedArmor()
{
    //DO NOT CHANGE THIS
    struct Armor Medium;

    //Default = 0
    Medium.Dwarf = 10;
    //Default = 10
    Medium.Elf = 5;
    //Default = 5
    Medium.Gnome = 25;
    //Default = 10
    Medium.Human = 5;
    //Default = 10
    Medium.HalfElf = 5;
    //Default = 5
    Medium.Halfling = 25;
    //Default = 10
    Medium.HalfOrc = 5;

    return Medium;
}

//Heavy Armor
struct Armor HvyArmor()
{
    //DO NOT CHANGE THIS
    struct Armor Heavy;

    //Default = 0
    Heavy.Dwarf = 25;
    //Default = 25;
    Heavy.Elf = 10;
    //Default = 20
    Heavy.Gnome = 50;
    //Default = 25
    Heavy.Human = 10;
    //Default = 25;
    Heavy.HalfElf = 10;
    //Default = 20
    Heavy.Halfling = 50;
    //Default = 25;
    Heavy.HalfOrc = 10;

    return Heavy;
}

/////////////////////////////GLOBAL WEATHER/////////////////////////////////////
//Set to 1 to enable the global weather system. Set to 0 to disable.
//Default : 1
const int RP_WEATHER_ON = 1;

//The weather will change after a random time between the min and max duration
const int RP_WEATHER_DURATION_MIN = 10; //Minutes
const int RP_WEATHER_DURATION_MAX = 60; //Minutes

//The following is a list of the chances of switching between weather. Each section
//is a percent figure so all three variables must add up to 100. It is divided by season
//so you can configure, for example, winter months to have a higher chance of snow then
//summer months

//Spring (Months 1-3)
//Default Settings : It rains more than it snows or is clear during the spring;
struct Season SpringWeather()
{
    //DO NOT CHANGE THIS
    struct Season Spring;

    //Change these to alter the chances to change when it's clear...
    Spring.ClearToClear = 50;
    Spring.ClearToRain = 40;
    Spring.ClearToSnow = 10;

    //Change these to alter the chances to change when it's raining...
    Spring.RainToClear = 40;
    Spring.RainToRain = 50;
    Spring.RainToSnow = 10;

    //Change these to alter the chances to change when it's snowing...
    Spring.SnowToClear = 30;
    Spring.SnowToRain = 60;
    Spring.SnowToSnow = 10;

    //DO NOT CHANGE THIS
    return Spring;
}

//Summer (Months 4-6)
//Default Settings : More or less, equal chance for rain or clear weather during
//summer. No chance of snow
struct Season SummerWeather()
{
    //DO NOT CHANGE THIS
    struct Season Summer;

    //Change these to alter the chances to change when it's clear...
    Summer.ClearToClear = 70;
    Summer.ClearToRain = 25;
    Summer.ClearToSnow = 05;

    //Change these to alter the chances to change when it's raining...
    Summer.RainToClear = 35;
    Summer.RainToRain = 60;
    Summer.RainToSnow = 05;

    //Change these to alter the chances to change when it's snowing...
    Summer.SnowToClear = 40;
    Summer.SnowToRain = 50;
    Summer.SnowToSnow = 10;

    //DO NOT CHANGE THIS
    return Summer;
}

//Fall (Months 7-9)
//Default Settings : It snows more than it rains in the fall.
struct Season FallWeather()
{
    //DO NOT CHANGE THIS
    struct Season Fall;

    //Change these to alter the chances to change when it's clear...
    Fall.ClearToClear = 20;
    Fall.ClearToRain = 40;
    Fall.ClearToSnow = 40;

    //Change these to alter the chances to change when it's raining...
    Fall.RainToClear = 40;
    Fall.RainToRain = 40;
    Fall.RainToSnow = 20;

    //Change these to alter the chances to change when it's snowing...
    Fall.SnowToClear = 20;
    Fall.SnowToRain = 40;
    Fall.SnowToSnow = 40;

    //DO NOT CHANGE THIS
    return Fall;
}

//Winter (Months 10-12)
//Default Settings : More or less, equal chance of snow or clear weather in winter.
//No chance of rain.
struct Season WinterWeather()
{
    //DO NOT CHANGE THIS
    struct Season Winter;

    //Change these to alter the chances to change when it's clear...
    Winter.ClearToClear = 10;
    Winter.ClearToRain = 30;
    Winter.ClearToSnow = 40;

    //Change these to alter the chances to change when it's raining...
    Winter.RainToClear = 10;
    Winter.RainToRain = 45;
    Winter.RainToSnow = 45;

    //Change these to alter the chances to change when it's snowing...
    Winter.SnowToClear = 10;
    Winter.SnowToRain = 45;
    Winter.SnowToSnow = 45;

    //DO NOT CHANGE THIS
    return Winter;
}
//The following is where you may enter exceptions to the weather system. Areas
//that always have the same weather. This is done via the SetWeather command
//off the Functions Menu
void RpWeatherExceptions()
{
    // examples:
    //SetWeather(GetObjectByTag("AreaDesert"),   WEATHER_CLEAR);
    //SetWeather(GetObjectByTag("AreaBeach"),    WEATHER_RAIN);
    //SetWeather(GetObjectByTag("AreaMountain"), WEATHER_SNOW);
}

//////////////////////////////PLAYER RESPAWN///////////////////////////////////

//The respawn system has three different modes it operates in. Enter a 1, 2, or 3
//to switch between modes
//Default : 1
const int RP_RESPAWN_MODE = 2;

//Mode One
//In this mode, the player will be ressurected with full life, suffer an xp and
//gold penalty and be teleported to the waypoint Player Respawn Point

//The following is the percentage of gold and xp that gets taken from the player
//Default: 0.05 (5 Percent)
const float RP_RESPAWN_GOLD_PENALTY = 0.05;
//Default: 50 (Per Level)
const int RP_RESPAWN_XP_PENALTY = 50;

//The following is the cap on the amount of gold and xp a player can lose from
//respawning
//Default: 100000
const int RP_RESPAWN_GOLD_CAP = 100000;
//Default: 25000
const int RP_RESPAWN_XP_CAP = 25000;

//Mode Two
//In this mode, the player is ressurected where they died, healed a certain number
//of hit points per level, and suffers penalties for a duration.

//The following is a list of the variables associated with mode two.

struct Respawn ModeTwo()
{
    //DO NOT CHANGE THIS
    struct Respawn Variables;

    //The following is the penalties applied upon respawning. You may change them
    //how you want. They must not be instant effects. There may be up to five effects.
    //They are altered in the same way you altered the Fatigue, Hunger, and Thirst
    //effects.

    //Default: Daze
    Variables.Penalty1 = EffectDazed();
    //Default : 50% Movement Speed Decrease
    Variables.Penalty2 = EffectMovementSpeedDecrease(50);
    //Default : Slow
    Variables.Penalty3 = EffectSlow();
    //Default : Spell Failure 50%
    Variables.Penalty4 = EffectSpellFailure(50);
    //Default : -20 Attack
    Variables.Penalty5 = EffectAttackDecrease(20);

    //This is the number of hitpoints the player is healed for every level they
    //have
    //Default : 3
    Variables.HitPointsPerLevel = 1;

    //This is the duration of the penalties
    //Default: 120.0
    Variables.Duration = 45.0;

    return Variables;
}

///////////////////////////PLAYER CHAT COMMANDS////////////////////////////////

//Set to 1 to enable the player chat commands. Set to 0 to disable
//Default = 1;
const int RP_PLAYER_CHAT_COMMANDS_ON = 1;

//You may disable different parts of the player chat commands system by deleting
//the following scripts
//COMMANDS: Emotes                   SCRIPT: com_s_emo
//COMMANDS: Hugging and Kissing      SCRIPT: com_s_hug
//COMMANDS: Walking                  SCRIPT: com_s_wlk
//COMMANDS: Touching                 SCRIPT: com_s_tch
//COMMANDS: Lap Sitting              SCRIPT: com_s_lap
//COMMANDS: Description Modification SCRIPT: com_s_dsc
//COMMANDS: Item Modification        SCRIPT: com_s_itm
//COMMANDS: Player Journal           SCRIPT: com_s_jrl
//COMMANDS: Associate Speak          SCRIPT: com_s_spk
//COMMANDS: Glowing Eyes             SCRIPT: com_s_eye
//COMMANDS: Sexual Positions         SCRIPT: com_s_sex
//COMMANDS: Misc                     SCRIPT: com_s_sve, com_s_stp, com_s_mad
//COMMANDS: Voice Chat               SCRIPT: com_s_voc

////////////////////////////PLAYER CHAT CONTROLS///////////////////////////////

//Set to 1 to disable use of the shout channel. Set to 0 to enable.
//Default: 0
const int RP_PLAYER_CHAT_SHOUT_CHANNEL_OFF = 1;

//Set to 1 to disable use of the party channel. Set to 0 to enable.
//Default: 0
const int RP_PLAYER_CHAT_PARTY_CHANNEL_OFF = 0;

///////////////////////////AREA RESPAWN AND DESPAWN////////////////////////////

//This is the number of minutes before an object in an area is respawned
//Default: 10
const int RP_AREA_RESPAWN_TIME = 30;

//This is the number of minutes before an object in an area is despawned
//Default: 10
const int RP_AREA_DESPAWN_TIME = 10;

//If set to 1, the cleaner scripts will destroy any items on the ground, regardless
//of whether or not it was created by the spawn system. Set to 0 to disable
//Default: 1
const int RP_AREA_CLEAN_ITEMS_ON = 1;

////////////////////////////////ITEM TORCHES////////////////////////////////////

//Duration of Torches in hours
//Default: 2
const int RP_TORCH_DURATION = 1;

//////////////////////////////PLACEABLE TORCHES/////////////////////////////////

//Duration of Torches in hours
//Default: 4
const int RP_PLC_TORCH_DURATION = 4;

////////////////////////////////////FISHING/////////////////////////////////////

//The following is the list of resrefs for the items created by the fishing
//scripts. There may be up to 3 fish items, 3 treasure items, and 3 junk items

struct Fishing Items()
{
    //DO NOT CHANGE THIS
    struct Fishing ResRef;

    //ResRef of Fish Items
    //NOTE : Fish must have tags of rp_fish to be baked in the oven
    //Default: Fish
    ResRef.sFish1 = "rp_fish";
    ResRef.sFish2 = "rp_fish";
    ResRef.sFish3 = "rp_fish";

    //ResRef of Treasure Items
    //Default: Gold Ring
    ResRef.sTreasure1 = "nw_it_mring023";
    //Default: Silver Necklace
    ResRef.sTreasure2 = "nw_it_mneck021";
    //Default: Thieves Tools +3
    ResRef.sTreasure3 = "nw_it_picks002";

    //ResRef of Junk Items
    //Default: Rusty Dagger
    ResRef.sJunk1 = "rp_junk_1";
    //Default: Wet Book
    ResRef.sJunk2 = "rp_junk_2";
    //Default: Soggy Rags
    ResRef.sJunk3 = "rp_junk_3";

    //DO NOT CHANGE THIS
    return ResRef;
}

///////////////////////////MESSAGES TO PLAYERS/////////////////////////////////
//The following is a list of the messages sent to players via the scripts. You
//may change them at will

//Sent to player when he uses rest option on rest conversation and is not in
//resting area
const string RP_STRING_NOT_IN_RESTING_AREA = "You are not in a resting area and may not rest.";

//Sent to player when they enter a resting zone
const string RP_STRING_REST_ZONE_ENTER = "You have entered a resting area.";

//Sent to player when they leave a resting zone
const string RP_STRING_REST_ZONE_EXIT = "You have left a resting area.";

//Sent to player when they use an unlit campfire
const string RP_STRING_UNLIT_CAMPFIRE = "You may light this campfire with a Flint and Tinder...";

//Sent to player when they use the Flint and Tinder on an object other than an
//Unlit Campfire
const string RP_STRING_FLINT_WRONG_TARGET = "You may only use this item on Unlit Campfires.";

//Sent to players if they are too far from a campfire to lite it
const string RP_STRING_FLINT_TOO_FAR = "You must be within 5 feet to light a campfire.";

//String spoken by Lit Campfires when created
const string RP_STRING_CAMPFIRE_CREATED = "The campfire comes to life, flames crackling and hissing.";

//String spoken by Lit Campfires when destroyed.
const string RP_STRING_CAMPFIRE_DESTROYED = "The campfire burns out, a wisp of smoldering smoke in it's abscense.";

//Message for Fatigue Phase 2
const string RP_STRING_FATIGUE_PHASE_2 = "You are exhausted...";

//Message for Fatigue Phase 1
const string RP_STRING_FATIGUE_PHASE_1 = "You grow tired...";

//Message for when fatigue is removed on rest
const string RP_STRING_FATIGUE_REST = "You feel refreshed from resting, your fatigue fading...";

//Message for Hunger Phase 2
const string RP_STRING_HUNGER_PHASE_2 = "You are starving...";

//Message for Hunger Phase 1
const string RP_STRING_HUNGER_PHASE_1 = "You are hungry...";

//Message for Hunger No Food
const string RP_STRING_HUNGER_NO_FOOD = "You have no food and begin to grow hungry...";

//Message for Consuming Food
const string RP_STRING_HUNGER_FOOD = "You eat, satisfying your hunger for the time being...";

//Message for Thirst Phase 2
const string RP_STRING_THIRST_PHASE_2 = "You are dehydrated...";

//Message for Thirst Phase 1
const string RP_STRING_THIRST_PHASE_1 = "You are thirsty...";

//Message for Thirst No Food
const string RP_STRING_THIRST_NO_DRINK = "You have no drink and begin to grow thirsty...";

//Message for Consuming Drink
const string RP_STRING_THIRST_DRINK = "You drink, quenching your thirst for the time being...";

//Message when Player is not in an Oasis for filling empty bottles
const string RP_STRING_NOT_NEAR_WATER = "You must be near a stream or pond with fresh water before you can fill the empty bottle...";

//Message when Player fills an empty bottle
const string RP_STRING_FILL_BOTTLE = "You fill the empty bottle with fresh water...";

//Message when Player enters an Oasis
const string RP_STRING_OASIS_ENTER = "You are near fresh water. Perhaps you should fill your empty bottles...";

//Message when Player exits an Oasis
const string RP_STRING_OASIS_EXIT = "You have left fresh water and can no longer fill your empty bottles.";

//Message when Player picks berries from a berry bush
const string RP_STRING_PICK_BERRIES = "You pick some berries from the bush...";

//Message when there is no berries on a berry bush
const string RP_STRING_NO_BERRIES = "There is no berries on the bush...";

//Message when torches burn out
const string RP_STRING_TORCHES_BURN_OUT = "The torch burns out...";

//Message when placeable torch is already lit
const string RP_STRING_PLC_TORCH_ON = "The torch is already lit...";

//Message when the player does not have oil to light a placeable torch
const string RP_STRING_PLC_NO_OIL = "You need Torch Oil to light the torch!";

//Message when the player uses oil to light a placeable torch
const string RP_STRING_PLC_USE_OIL = "You use Torch Oil to light the torch";

//Message when a chair breaks when the player sits in it
const string RP_STRING_CHAIR_BREAKS_ON_SIT = "The chair breaks when you sit in it!";

//Message when player attempts to fish, but is not near a fishing hole
const string RP_STRING_FISH_NOT_NEAR_HOLE = "You must be near a fishing hole to fish!";

//Message when player moves and stops fishing
const string RP_STRING_FISH_PLAYER_HAS_MOVED = "You have moved and stopped fishing!";

//Message when player casting a fishing line
const string RP_STRING_FISH_CAST_LINE = "You cast your line...";

//Random message 1 while player is fishing
const string RP_STRING_FISH_RANDOM_1 = "You are still fishing...";

//Random message 2 while player is fishing
const string RP_STRING_FISH_RANDOM_2 = "You spill your drink while fishing...";

//Random message 3 while player is fishing
const string RP_STRING_FISH_RANDOM_3 = "You yawn while fishing...";

//Message when player fishing catchs nothing
const string RP_STRING_FISH_CATCH_NOTHING = "You reel in your line and have caught nothing!";

//Message when fishing player disturbs a water elemental
const string RP_STRING_FISH_DISTURB_ELEM = "You have disturbed a water elemental!";

//Message when fishing player breaks their pole
const string RP_STRING_FISH_POLE_BREAK = "You have broken your pole!";

//Message when fishing player catchs a peice of treasure
const string RP_STRING_FISH_CATCH_TREASURE = "You reel in your line and have caught something valuable!";

//Message when fishing player catchs a peice of junk
const string RP_STRING_FISH_CATCH_JUNK = "You reel in your line and have caught a peice of junk!";

//Message when fishing player catchs a fresh fish
const string RP_STRING_FISH_CATCH_FISH = "You reel in your line and have caught a fresh fish!";

///////////////////////////////////////////////////////////////////////////////
////////////////////DO NOT CHANGE ANYTHING BELOW THIS LINE/////////////////////
///////////////////////////////////////////////////////////////////////////////

/////////////////////////////CONSTANTS//////////////////////////////////////////

//Tag and Resref for Marker for PC Stripping when they first login
const string RP_TAG_MARKED_AS_STRIPPED_ITEM = "sca_ww_marker";

////////////////////////////DECLARATIONS///////////////////////////////////////

//Send Debug Message to all players
void RpDebugMessage(string sString);

//Create a Time Stamp by converting the calendar and time into total seconds
int RpTimeStamp();

//////////////////////////////DEFINITIONS//////////////////////////////////////

void RpDebugMessage(string sString)
{
    if (!RP_DEBUG_ON) return;

    sString = RGBColorText(TEXT_COLOR_BLUE, sString);
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC)) {
        SendMessageToPC(oPC, sString);
        oPC = GetNextPC(); }

    SendMessageToAllDMs(sString);
    PrintString(sString);
}

int RpTimeStamp()
{
    int nSeconds = GetTimeSecond();
    int nMinutes = GetTimeMinute() * 60;
    int nHours = GetTimeHour() * 60 * 60;
    int nDays = GetCalendarDay() * 24 * 60 * 60;
    int nMonths = GetCalendarMonth() * 28 * 24 * 60 * 60;
    int nYears = GetCalendarYear() * 12 * 28 *24 *60 *60;

    int nTimeStamp = nSeconds + nMinutes + nHours + nDays + nMonths + nYears;

    return nTimeStamp;
}







