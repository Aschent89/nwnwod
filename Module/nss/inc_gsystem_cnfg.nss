//::///////////////////////////////////////////////
//:: Name: inc_gsystem_cnfg
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Configuration script which allows module
    builders to adjust PGS-related settings to their
    own personal tastes.
*/
//:://////////////////////////////////////////////
//:: Created By: Samius Maximus
//:: Created On:
//:://////////////////////////////////////////////

//------------------------------------------------
//Database file names.  These can be changed to
//allow for multiple modules containing their
//own guilds, etc...
//
//Note: If only using one module, there is no need
//to edit these.
//------------------------------------------------
const string PGS_MODULE_DB = "PGS_Module_Info";
const string PGS_PLAYER_DB = "PGS_Player_Info";
const string PGS_TIME_DB = "PGS_Module_Time";
const string PGS_TERRITORY_DB = "PGS_Territory_Info";

//------------------------------------------------
//This variable allows for module builders to
//specify which type of DB access they wish to
//use to retain persistency among guilds.
//
//TRUE = Use BioWare DB access.
//FALSE = Use APS/NWNx2 access.
//
//Credit to Galantir Galadros for the conversion.
//------------------------------------------------
const int PGS_USE_BIOWARE_DB = TRUE;

//------------------------------------------------
//Filter amount for the guild list (either faction-
//based, or all).  List filtering is customizeable
//on a per-player-basis.  When enabled, only guilds
//with a membership count greater than or equal
//to the amount specified will be displayed.
//------------------------------------------------
const int PGS_GUILD_LIST_FILTERING_AMOUNT = 1;

//------------------------------------------------
//Guild creation requirement(s).  The following
//variables offer control on what type of players
//can create guilds (pending DM granting rights
//are disabled -- see config option below).  Setting
//any of these to 0 will disable the condition.
//Otherwise, the player must meet or exceed the
//value to be allowed to create a guild.
//------------------------------------------------
const int PGS_GUILD_CREATION_CHARISMA_REQUIREMENT = 0;
const int PGS_GUILD_CREATION_LEVEL_REQUIREMENT = 30;
const int PGS_GUILD_CREATION_GOLD_REQUIREMENT = 1000000;
const int PGS_GUILD_JOINING_LEVEL_REQUIREMENT = 5;

//If enabled, guilds can only be created by players who have been
//approved by a DM (i.e. DM targets the PC with the Guild Journal
//and grants them access).  Targeted PC *MUST* also meet any/all
//other guild creation restrictions (listed above) as well.
const int PGS_RESTRICT_GUILD_CREATION = FALSE;

//------------------------------------------------
//Guild war hostility delay.  This value specifies
//the delay before applying the hostile faction to
//opposing guild members.
//
//Note: Value must be in seconds.
//------------------------------------------------
const float PGS_FLOAT_HOSTILITY_DELAY = 60.0f;

//------------------------------------------------
//Module persistent time.  These variables deal
//with persistent time, and scheduled events based
//on time.
//
//Note: Persistent time no longer needs to be
//enabled to apply gold (interest) and XP bonuses.
//------------------------------------------------
const int PGS_ENABLE_PERSISTENT_TIME = FALSE;

//This variable specifes the number of days required to pass before
//applying GOLD & XP bonuses for territories and/or interest.
const int PGS_DAY_COUNT_FOR_GUILD_BONUS = 28;

const float PGS_FLOAT_INTEREST_RATE = 1.07f;  /*1.07 = 7.00%.*/

//The following variables allow the module builder to balance rewards
//for both public and private guilds INDIVIDUALLY.
const int PGS_PUBLIC_XP_AWARD_MEMBER = 200;
const int PGS_PUBLIC_GOLD_AWARD_MEMBER = 100;
const int PGS_PRIVATE_XP_AWARD_MEMBER = 200;
const int PGS_PRIVATE_GOLD_AWARD_MEMBER = 100;

const int PGS_XP_AWARD_ROLLOVER = TRUE;

//------------------------------------------------
//Guild account and experience caps.  These
//variables allow for the module builder to specify
//maximums for guild accounts, and XP pools.
//Setting these variables to 0 will disable the cap.
//------------------------------------------------
const int PGS_GUILD_ACCOUNT_CAP = 1000000;
const int PGS_GUILD_XP_POOL_CAP = 1000;

const int PGS_MAX_GUILD_COUNT = 0;  /*Maximum number of guilds allow at any one time (0 = no limit).*/
const int PGS_GUILD_TERRITORY_LIMIT = 0;  /*Maximum number of territories a guild can claim. (0 = no limit)*/
const int PGS_MEMBER_COUNT_FOR_CLAIMING = 3;  /*Minimum member count for claiming territories.*/

//------------------------------------------------
//Guild rank names.  The following variables
//control the default rank names used for newly
//created guilds - to act as a template.  Leaders
//can change the rank names for their own guild
//at any time.
//
//Note: Rank order goes from 6 (HIGHEST) to 1
//(LOWEST).
//------------------------------------------------
const string PGS_STRING_GUILD_RANK6 = "Warlord";
const string PGS_STRING_GUILD_RANK5 = "Champion";
const string PGS_STRING_GUILD_RANK4 = "Knight";
const string PGS_STRING_GUILD_RANK3 = "Squire";
const string PGS_STRING_GUILD_RANK2 = "Footman";
const string PGS_STRING_GUILD_RANK1 = "Soldier";

//------------------------------------------------
//The following variables deal with customizing
//messenger creatures.  Every HB, the distance
//between the player and his/her messenger is
//checked.  If it exceeds either or the values
//listed below (based on if the messenger is
//standing or following), then an integer is
//increased.  The variable below these two
//determines how many HB's the messenger creature
//can be out of bounds.  Once exceeded, the
//messenger will "fly away".
//------------------------------------------------
const float PGS_MAX_MESSENGER_FOLLOW_DISTANCE = 10.0f;
const float PGS_MAX_MESSENGER_STAND_DISTANCE = 20.0f;

const int PGS_MESSENGER_HEARTBEAT_COUNT = 3;

//------------------------------------------------
//Vault gnomes have been updated to now also
//function as stand-alone NPCs (can just be placed
//anywhere in the module).  This variable enables/
//disables guild members from accessing his/her
//guild account information via the "pgs_main"
//conversation.
//
//Note: If set to TRUE, you must manually populate
//your module with vault gnomes, else guild accounts
//will be in-accessable to members.
//------------------------------------------------
const int PGS_DISABLE_VAULT_GNOME_FROM_CONVO = TRUE;

//------------------------------------------------
//This variable is used by guild doors.  They will
//automatically re-close and lock themselves after
//this delay.  If you do not want these guild doors
//to auto-close, then simply set the value to 0.0f.
//------------------------------------------------
const float PGS_GUILD_DOOR_CLOSE_DELAY = 10.0f;

//------------------------------------------------
//The following variables allow certain lists
//to be enabled/disabled for players.
//
//Note: If not using claimable territories, you
//should disable the territory list.
//------------------------------------------------
const int PGS_ENABLE_TERRITORY_LIST = TRUE;
const int PGS_ENABLE_PLAYER_LIST = TRUE;

//------------------------------------------------
//This option enables leaders to specify a color
//for his/her guild.  All members will have light
//color emitting from them.  Guilds can choose to
//not have a color, but this option will disable
//it completely for all guilds.
//------------------------------------------------
const int PGS_ENABLE_GUILD_COLOR_LIGHTING = FALSE;

//------------------------------------------------
//The following variables are associated with
//guild-specific lighting (using light effects).
//As membership for the guild grows, the brightness
//for the guild color does as well.  The variables
//below determine the member count needed to reach
//the next stage for light brightness.
//
//Note: Guild colors will start at the lowest level
//of brightness until the next stage is reached.
const int PGS_COLOR_LIGHTING_SIZE4 = 20;
const int PGS_COLOR_LIGHTING_SIZE3 = 10;
const int PGS_COLOR_LIGHTING_SIZE2 = 5;

//------------------------------------------------
//This variable is used to calculate an XP loss
//for when players teleport to a guild territory.
//XP loss is calculating by multiplying player
//level with this constant.
//------------------------------------------------
const int PGS_XP_TELEPORTING_LOSS = 20;

//void main(){}
