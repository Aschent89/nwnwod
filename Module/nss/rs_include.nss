//rs_include
//ReSpawn Creatures include
//This is the include file for all ReSpawn System scripts.
//All functions will be defined here.

//added for walkwaypoint function
#include "x0_i0_walkway"

/********************************Constants*************************************/
/******************************************************************************/

/******************************Configurables***********************************/

//This number multiplied by the Respawn Time is how often the spawnpoints will spawn
const float RS_DELAY_CYCLE = 10.0;   //how often the spawn script is ran in seconds.

//Set this to TRUE to use the AREA_WAYPOINT variables for all creatures in that area
const int RS_USE_AREA_VARIABLES = FALSE;

//Set this to true if you wish the spawns to be destroyed when no PC's found in area.
//If you have another system in place to take care of spawns, then set this to FALSE
const int RS_DESTROY_ON_EXIT = TRUE;

//settings for specific spawns. If RS_DESTROY_ON_EXIT is FALSE, these won't matter.
const int RS_CLEAN_SPAWNED_CREATURES = TRUE;
const int RS_CLEAN_SPAWNED_PLACEABLES = TRUE;
const int RS_CLEAN_SPAWNED_TRAPS = TRUE;
const int RS_CLEAN_SPAWNED_ITEMS = TRUE;

//Set this to true to clean up items found by the cleanup as well as spawns.
//If you have another system in place for taking care of dropped items,
//then set this to FALSE
const int RS_CLEAN_ITEMS = TRUE;

//Set this to TRUE if you want traps to spawn at any time. (appearing while PC is in area)
//Set to FALSE (default) if you want them to spawn only when a PC enters.
const int RS_TRAP_SPAWN_WITH_PC_IN_AREA = FALSE;

//Set this to TRUE if you want items to spawn at any time. (appearing while PC is in area)
//Set to FALSE (default) if you want them to spawn only when a PC enters.
const int RS_ITEM_SPAWN_WITH_PC_IN_AREA = TRUE;

/*These two constants ares used to adjust the level of the creatures based on */
/*the PC level. the SOFT side will still use the area or spawnpoint levels set, */
/*but will adjust the creatures levels closer to the PC's. I.e. the area level*/
/*is set to 4-8 range. A level 3 PC will spawn level 4 creatures, a level 12 PC*/
/*will spawn level 8 creatures, a level 6 PC will spawn level 5-7 creatures, etc.*/
/*The HARD setting will set the creature to the level of the PC. In the above */
/*example, area level 4-8, PC level 3 will spawn level 3 creatures, PC level 12*/
/*will spawn level 12 creatures, etc...                                       */
/*Keep in mind if you use the HARD setting, it will override any area levels and*/
/*the SOFT setting                                                            */

//Set this to true to adjust the level of creatures based on PC level,
//but keeping within the range of the area.
const int RS_PC_LEVEL_CREATURE_LEVEL_SOFT = TRUE;

//Set this to TRUE to base creature level on PC entering level
//gives levels of PC level +- 1, i.e. if PC level = 10, creatures will be 9-11.
//Note: overides SOFT setting, area levels and spawnpoint levels.
const int RS_PC_LEVEL_CREATURE_LEVEL_HARD = FALSE;

//Despawn switches. set to FALSE to disable the despawning when time of day spawns are used
const int RS_DESPAWN_CREATURES = TRUE;
const int RS_DESPAWN_PLACEABLES = TRUE;
const int RS_DESPAWN_TRAPS = TRUE;
const int RS_DESPAWN_ITEMS = TRUE;

/********************************Creatures*************************************/
const string RS_CREATURE_WAYPOINT = "RS_CREATURE";
const string RS_AREA_CREATURE = "Area Creature";
const string RS_LEVEL_MAX = "Level Max";
const string RS_LEVEL_MIN = "Level Min";
const string RS_CREATURE_NAME = "New Name of Creature";
const string RS_CREATURE_TAG = "New Tag of Creature";
const string RS_NUM_CREATURES_MAX = "Number of Creatures Max";
const string RS_NUM_CREATURES_MIN = "Number of Creatures Min";
const string RS_ACTION = "Action";
const string RS_BOSS = "Boss";
const string RS_PERCENT_CHANCE_TO_SPAWN = "Percent Chance To Spawn";

/*******************************Placeables*************************************/
const string RS_PLACEABLE_WAYPOINT = "RS_PLACEABLE";
const string RS_AREA_PLACEABLE = "Area Placeable";
const string RS_PLACEABLE_NAME = "New Name of Placeable";
const string RS_PLACEABLE_TAG = "New Tag of Placeable";
const string RS_LOCKED = "Locked";
const string RS_LOCK_DC = "Lock DC";
const string RS_LOCK_KEY = "Lock Key";
const string RS_PLOT = "Plot";
const string RS_STATIC = "Static";
const string RS_FORT_SAVE_VARIABLE = "Fort Save";
const string RS_REFLEX_SAVE_VARIABLE = "Reflex Save";
const string RS_WILL_SAVE_VARIABLE = "Will Save";
const string RS_HARDNESS = "Hardness";
const string RS_NUM_PLACEABLES_MAX = "Number of Placeables Max";
const string RS_NUM_PLACEABLES_MIN = "Number of Placeables Min";
const string RS_TRAPPED = "Trapped";

/*********************************Traps****************************************/
const string RS_TRAP_WAYPOINT = "RS_TRAP";
const string RS_TRAP_RANDOM_OBJECT = "Trap Random Object";
const string RS_AREA_TRAP = "Area Trap";
const string RS_TRAP_OBJECT_TAG = "Trap Object Tag";
const string RS_TRAP_DISARM_SCRIPT = "OnTrapDisarm Script";
const string RS_TRAP_TRIGGERED_SCRIPT = "OnTrapTriggered Script";
const string RS_NUM_TRAPS_MIN = "Number of Traps Min";
const string RS_NUM_TRAPS_MAX = "Number of Traps Max";
const string RS_TRAP_RECOVERABLE = "Recoverable";
const string RS_TRAP_KEY_TAG = "KeyTag";
const string RS_TRAP_DETECT_DC = "Detect DC";
const string RS_TRAP_DETECTABLE = "Detecable";
const string RS_TRAP_DISARM_DC = "Disarm DC";
const string RS_TRAP_DISARMABLE = "Disarmable";
const string RS_TRAP_ONE_SHOT = "OneShot";
const string RS_TRAP_SIZE_MIN = "Size of Trap Min";
const string RS_TRAP_SIZE_MAX = "Size of Trap Max";
const string RS_TRAP_TAG = "New Tag of Trap";
const string RS_TRAP_STRENGTH = "Trap Strength";
const string RS_TRAP_ELEMENT = "Trap Element";

/*********************************Items****************************************/
const string RS_ITEM_WAYPOINT = "RS_ITEM";
const string RS_ITEM_NAME = "New Name of Item";
const string RS_ITEM_TAG = "New Tag of Item";
const string RS_NUM_ITEMS_MIN = "Number of Items Min";
const string RS_NUM_ITEMS_MAX = "Number of Items Max";
const string RS_AREA_ITEM = "Area Item";
const string RS_ITEM_CONTAINER_TAG = "Container Tag";
const string RS_ITEM_RANDOM_OBJECT = "Item on Random Object";
const string RS_ITEM_VAULT = "Object Tag To Get Items From";
const string RS_PERCENT_ON_CREATURE = "Percent Chance on Creature";
const string RS_PERCENT_ON_PLACEABLE = "Percent Chance on Placeable";
const string RS_PERCENT_CHANCE_TO_SPAWN_ITEM = "Percent Chance to Spawn Item";

/********************************Shared****************************************/
const string RS_HP_ADJUST_MIN = "HP Adjust Min";
const string RS_HP_ADJUST_MAX = "HP Adjust Max";
const string RS_RESPAWN_TIME_MAX = "Respawn Time Max";
const string RS_RESPAWN_TIME_MIN = "Respawn Time Min";
const string RS_DISTANCE_MIN = "Distance Min";
const string RS_DISTANCE_MAX = "Distance Max";
const string RS_TIME_OF_DAY_SPAWN = "Time of Day";
const string RS_MAX_SPAWN = "Max Number of Spawns";
const string RS_SCRIPT_TO_RUN_ON_SPAWN = "Script To Run On Spawn";

/*********************************others***************************************/
const string RS_AREA_WAYPOINT = "RS_AREA";
const int RS_FORT_SAVE = 1;
const int RS_REFLEX_SAVE = 2;
const int RS_WILL_SAVE = 3;
const int RS_TYPE_CREATURE = 1;
const int RS_TYPE_PLACEABLE = 2;
const int RS_TYPE_TRAP = 3;
const int RS_TYPE_ITEM = 4;

/*****************Functions to retrieve variables from oWP*********************/
/********************Pass the spawnpoint object to these***********************/

//Returns spawn from Area tagged sTag
object RS_GetSpawnFromArea(object oWP, int iType, string sTag);

//Returns spawn from container (items only)
object RS_GetSpawnFromContainer(object oWP, string sTag);

//Returns Resref of creature or placeable to spawn from oWP name
string RS_GetResrefFromWaypoint(object oWP);

//Returns HP adjustment of creatures to spawn
int RS_GetHPAdjust(object oWP);

//Returns New Name of Creature
string RS_GetNewName(object oWP);

//Returns New Tag of Creature
string RS_GetNewTag(object oWP);

//Returns minimum Number of Creatures/Placeables to spawn
int RS_GetNumToSpawnMin(object oWP);

//Returns maximum Number of Creatures/Placeables to spawn
int RS_GetNumToSpawnMax(object oWP);

//Returns respawn time max
int RS_GetSpawnTimeMax(object oWP);

//Returns respawn time min
int RS_GetSpawnTimeMin(object oWP);

//Returns number of Items to create on creature
int RS_GetNumItems(object oWP);

//Returns number of stats to change on creature
int RS_GetNumStats(object oWP);

//Returns the spawnpoint ID for oWP
int RS_GetWPID(object oWP);

//Returns the level to adjust the creatures to
//Done at creation, so differeing levels will be returned.
int RS_GetLevel(object oWP);

//Sets the level of oCreature to iLevel
void RS_LevelCreature(object oCreature, int iLevel);

//Returns the abillity change for iStat
//Done at creation for differeing stat changes.
int RS_GetStatChange(object oWP, int iStat);

//Returns Locked variable; 1, or 0 on error
int RS_GetLocked(object oWP);

//Returns the Lock DC Variable
int RS_GetLockDC(object oWP);

//Returns the Lock Key variable, used to spawn key.
//Tag is set to Tag of locked item + key resref
string RS_GetLockKey(object oWP);

//Returns Hardness variable
int RS_GetHardness(object oWP);

//Returns Plot variable; 1, or 0 on error
int RS_GetPlot(object oWP);

//Returns Static variable; 1, or 0 on error
int RS_GetStatic(object oWP);

//Returns Trapped variable; 1, or 0 on error
int RS_GetTrapped(object oWP);

//Get trap type from trap strength and element
int RS_GetTrapType(object oWP);

//Returns Trap Detect DC variable
int RS_GetTrapDetectDC(object oWP);

//Returns Trap Disarm DC variable
int RS_GetTrapDisarmDC(object oWP);

//Returns iSave Save variable.
int RS_GetSave(object oWP, int iSaveThrow);

//Returns the average PC Level of the PC's in area of oWP
int RS_PCLevel(object oWP);

//Returns the X size of oArea.
float RS_AreaGetSizeX(object oArea);

//Returns the Y size of oArea.
float RS_AreaGetSizeY(object oArea);

//Returns whether the creature/placeable is spawnable or not based on time of day
int RS_GetSpawnable(object oWP);

//Adds variables from oWP to oObject
void RS_AddVariables(object oWP, object oObject);

//Removes all spawned creatures and placeables in oArea
//Static placeables are not removed.
void RS_Clear_Spawns(object oArea);

//Removes time of day spawns that are no longer allowed to be spawned
void RS_Despawn(object oWP);

//Returns a Non Trapped Object from oArea; OBJECT_INVALID if none found
object RS_GetRandomNonTrappedObject(object oArea);

//Returns a Container Object from area oWP is in.
//iContType = container type (OBJECT_TYPE_CREATURE or OBJECT_TYPE_PLACEABLE)
object RS_GetRandomContainer(object oWP, int iContType);

//Returns a random location within the area oArea.
//Pass oWP if spawn is distance from WP. (if OBJECT_INVALID is passed, returns random loc)
//iType is type of spawn, Creatures do not need to be verified.
//fDistance = min distance from edge of area
location RS_GetRandomLocation(object oArea = OBJECT_SELF, object oWP = OBJECT_INVALID, int iType = RS_TYPE_CREATURE, float fDistance = 1.0f);

/*********************Functions of changing stats and Items********************/

//Adjusts stats by their coresponding variables on oCreature.
void RS_AdjustStat(object oCreature, object oWP);

//Assigns oCreature to equip oItem, if it can.
void RS_EquipItem(object oCreature, object oItem);

//Creates Items on oCreature
void RS_CreateItem(object oCreature, object oWP);

//Assigns action to do on oCreature based on oWP settings
//Last action assignment, sets commanadbility to FALSE, until all actions are done
void RS_Action(object oCreature, object oWP);

/*************************Functions for spawntimes*****************************/

//Returns the time left to spawn creatures from spawnpoint oWP
int RS_GetNextSpawnTimeLeft(object oWP);

//Resets the time left to spawn creatures on spawnpoint oWP
void RS_SetNextSpawnTimeLeft(object oWP);

//Decreases spawn time on oWP by 1
void RS_DecrementSpawnTime(object oWP);

/****************************Lets get spawning*********************************/

//Returns the number of creatures spawned from this spawnpoint
int RS_GetNumCreaturesSpawned(object oWP);

//Returns the number of placeables spawned from this spawnpoint
int RS_GetPlaceablesSpawned(object oWP);

//Returns the number of Traps spawned from this spawnpoint
int RS_GetTrapsSpawned(object oWP);

//Returns the number of Items spawned from this spawnpoint
int RS_GetItemsSpawned(object oWP);

//Spawns creatures on spawnpoint oWP
void RS_SpawnCreatures(object oWP);

//Spawns Placeables on spawnpoint
void RS_SpawnPlaceables(object oWP);

//Spawns Traps on spawnpoint
void RS_SpawnTraps(object oWP);

//Spawns Items on spawnpoint
void RS_SpawnItems(object oWP);

/****************************Special Functions*********************************/
//Created by OwChallie
// Used to create a number of objects around a given location
// nObjectType - the type of object to be created, OBJECT_TYPE_*
// sObjectTag  - the resref of the objects to be created
// nNoOfSides  - the number of sides the shape has
// lMidPoint   - the mid point of the shape
// fSize       - the size of the shape
// sNewTag     - the new tag of the object created being sNewTag1 to sNewTagn,
//               n being the number specified by nNoOfSides
// fObjectLife - the number of seconds the object exists (0.0 for infinite)
void CreateObjectsInShape(int nObjectType, string sObjectTag, int nNoOfSides, location lMidPoint, float fSize, string sNewTag="", float fObjectLife=0.0);

//custom for this only
void CreateBeams(string sTag, int iInt=0);

//Resets the counters for spawns in areas
void RS_ResetCounters(object oArea);

//Sets the name of the object to a random name
void RS_RandomName(object oObject);

// Duplicates the placeable specified by oSource.
// If a new tag is specified, it will be assigned to the new object.
/*Note: Variables, script events, and conversation are not copied.
//      Script events and Conversation will be set by the resref of the item.
        Keys can not be set to be removed if resref item does not do so. */
object CopyPlaceable(object oSource, location locLocation, string sNewTag = "");

/***************************Function Definitions*******************************/

object RS_GetSpawnFromArea(object oWP, int iType, string sTag)
{
    if(!GetIsObjectValid(oWP)) return OBJECT_INVALID;

    object oArea = GetObjectByTag(sTag);
    object oObject;
    object oReturn;
    int iOType;
    int iNumCreatures = GetLocalInt(oArea, "RS Number of Creatures");
    int iNumPlaceables = GetLocalInt(oArea, "RS Number of Placeables");
    int iNumTraps = GetLocalInt(oArea, "RS Number of Traps");
    int iNumItems = GetLocalInt(oArea, "RS Number of Items");
    int iCount;
    int iRand = 1;

    if(iType == RS_TYPE_CREATURE && iNumCreatures == -1) return oReturn;
    if(iType == RS_TYPE_PLACEABLE && iNumPlaceables == -1) return oReturn;
    if(iType == RS_TYPE_TRAP && iNumTraps == -1) return oReturn;
    if(iType == RS_TYPE_ITEM && iNumItems == -1) return oReturn;

    oObject = GetFirstObjectInArea(oArea);

    if(iNumCreatures == 0)        //if 0 then we have not counted yet
    {
        while(GetIsObjectValid(oObject))
        {
            iOType = GetObjectType(oObject);
            if (iOType == OBJECT_TYPE_CREATURE) iNumCreatures++;
            if (iOType == OBJECT_TYPE_PLACEABLE) iNumPlaceables++;
            if (iOType == OBJECT_TYPE_TRIGGER && GetIsTrapped(oObject)) iNumTraps++;
            if (iOType == OBJECT_TYPE_ITEM) iNumItems++;
            oObject = GetNextObjectInArea(oArea);
        }
        if(iNumCreatures == 0) iNumCreatures = -1; //no creatures in here
        if(iNumPlaceables == 0) iNumPlaceables = -1; //no placeables in here
        if(iNumTraps == 0) iNumTraps = -1; //no traps in here
        if(iNumItems == 0) iNumItems = -1; //no items in here
        SetLocalInt(oArea, "RS Number of Creatures", iNumCreatures);
        SetLocalInt(oArea, "RS Number of Placeables", iNumPlaceables);
        SetLocalInt(oArea, "RS Number of Traps", iNumTraps);
        SetLocalInt(oArea, "RS Number of Items", iNumItems);
        oObject = GetFirstObjectInArea(oArea);
    }

    switch (iType)
    {
        case RS_TYPE_CREATURE:              //Creatures
        {
            iRand = Random(iNumCreatures)+1;
            iCount = 1;
            while(iCount <= iRand && GetIsObjectValid(oObject))
            {
                iOType = GetObjectType(oObject);
                if (iOType == OBJECT_TYPE_CREATURE)
                {
                    oReturn = oObject;
                    iCount++;
                }
                oObject = GetNextObjectInArea(oArea);
            }
        }break;

        case RS_TYPE_PLACEABLE:             //Placeables
        {
            iRand = Random(iNumPlaceables)+1;
            iCount = 1;
            while(iCount <= iRand && oObject != OBJECT_INVALID)
            {
                iOType = GetObjectType(oObject);
                if (iOType == OBJECT_TYPE_PLACEABLE)
                {
                    oReturn = oObject;
                    iCount++;
                }
                oObject = GetNextObjectInArea(oArea);
            }
        }break;

        case RS_TYPE_TRAP:                  //Traps
        {
            iRand = Random(iNumTraps)+1;
            iCount = 1;
            while(iCount <= iRand && oObject != OBJECT_INVALID)
            {
                iOType = GetObjectType(oObject);
                if (iOType == OBJECT_TYPE_TRIGGER && GetIsTrapped(oObject))
                {
                    oReturn = oObject;
                    iCount++;
                }
                oObject = GetNextObjectInArea(oArea);
            }
        }break;

        case RS_TYPE_ITEM:                  //Items
        {
            iRand = Random(iNumItems)+1;
            iCount = 1;
            while(iCount <= iRand && oObject != OBJECT_INVALID)
            {
                iOType = GetObjectType(oObject);
                if (iOType == OBJECT_TYPE_ITEM)
                {
                    oReturn = oObject;
                    iCount++;
                }
                oObject = GetNextObjectInArea(oArea);
            }
        }break;
    }

    //Reset the counters so DM's can change things
    if(GetLocalInt(oArea, "RS_Reset")==0)
    {
        SetLocalInt(oArea, "RS_Reset", 1);
        DelayCommand(30.0, RS_ResetCounters(oArea));
    }
    return oReturn;
}

void RS_ResetCounters(object oArea)
{
    DeleteLocalInt(oArea, "RS Number of Creatures");
    DeleteLocalInt(oArea, "RS Number of Placeables");
    DeleteLocalInt(oArea, "RS Number of Traps");
    DeleteLocalInt(oArea, "RS Number of Items");
    DeleteLocalInt(oArea, "RS_Reset");
}

object RS_GetSpawnFromContainer(object oWP, string sTag)
{
    if(!GetIsObjectValid(oWP)) return OBJECT_INVALID;
    object oVault = GetObjectByTag(sTag);
    int iNumItems;
    int x;
    object oItem = GetFirstItemInInventory(oVault);
    while(GetIsObjectValid(oItem))
    {
        iNumItems++;
        oItem = GetNextItemInInventory(oVault);
    }
    if(iNumItems == 0) return OBJECT_INVALID;
    int iRand = Random(iNumItems) + 1;
    oItem = GetFirstItemInInventory(oVault);
    for(x=1;x<iRand;x++)
    {
        oItem = GetNextItemInInventory(oVault);
    }
    return oItem;
}

string RS_GetResrefFromWaypoint(object oWP)
{
    if(!GetIsObjectValid(oWP)) return "";
    string sResref = "";
    sResref = GetName(oWP);
    if(sResref == "RS_CREATURE_RESREF"
        || sResref == "RS_PLACEABLE_RESREF"
        //traps are not spawned from resrefs
        || sResref == "RS_ITEM_RESREF"
        )
    {
        //check for DM in game created, as SetName does not work on waypoints.
        sResref = GetLocalString(oWP, "DM NAMED");
        if(sResref == "") //if still no name, then inform the DM's and delete the WP
        {
            string sMessage = "Spawnpoint in area " + GetName(GetArea(oWP)) + " has no resref associated with it.";
            SendMessageToAllDMs(sMessage);
            sMessage = "Spawnpoint will be deleted for now so you do not get this message again.";
            SendMessageToAllDMs(sMessage);
            sMessage = "Make a note in case it is a builder mistake.";
            SendMessageToAllDMs(sMessage);
            DestroyObject(oWP);
        }
    }
    //check to see if an area or container matches the name,
    //if so, then group spawn: set group spawn variable.
    object oArea = GetObjectByTag(sResref);
    if(GetIsObjectValid(oArea))
    {
        //test for containers versus areas
        if (GetHasInventory(oArea)) SetLocalInt(oWP, "RS_ContainerSpawn", 1); //container spawn
        else SetLocalInt(oWP, "RS_GroupSpawn", 1);  //area spawn
    }

    return sResref;
}

int RS_GetHPAdjust(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iHPMin = 0;
    int iHPMax = 0;
    int iHPDiff = 0;
    int iHP = 0;

    iHPMin = GetLocalInt(oWP, RS_HP_ADJUST_MIN);
    iHPMax = GetLocalInt(oWP, RS_HP_ADJUST_MAX);

    if(iHPMax == -1) iHPMax = d100(3) + 60;//63-360
    if(iHPMin > iHPMax)             //min should always be less than max
    {
        iHPDiff = iHPMin;
        iHPMin = iHPMax;
        iHPMax = iHPDiff;
        iHPDiff = 0;
    }

    if(iHPMin < 0)                  //if min < 0
    {                               //set up for Random to work
        iHPDiff = abs(iHPMin);      //absolute value of Min
        iHPMax += abs(iHPMin);      //added to max
        iHPMin = 0;                 //then min set to 0. Same range
    }

    iHP = Random(iHPMax - iHPMin) + iHPMin; //get random number with range
    iHP -= iHPDiff;                         //set back to between original values.
    return iHP;
}

string RS_GetNewName(object oWP)
{
    if(!GetIsObjectValid(oWP)) return "";
    string sName = "";
    string sTag = GetTag(oWP);
    if(sTag == RS_CREATURE_WAYPOINT) sName = GetLocalString(oWP, RS_CREATURE_NAME);
    if(sTag == RS_PLACEABLE_WAYPOINT) sName = GetLocalString(oWP, RS_PLACEABLE_NAME);
    //Traps don't get names
    if(sTag == RS_ITEM_WAYPOINT) sName = GetLocalString(oWP, RS_ITEM_NAME);
    return sName;
}

string RS_GetNewTag(object oWP)
{
    if(!GetIsObjectValid(oWP)) return "";
    string sTag = "";
    string sWPTag = GetTag(oWP);
    if(sWPTag == RS_CREATURE_WAYPOINT) sTag = GetLocalString(oWP, RS_CREATURE_TAG);
    if(sWPTag == RS_PLACEABLE_WAYPOINT) sTag = GetLocalString(oWP, RS_PLACEABLE_TAG);
    if(sWPTag == RS_TRAP_WAYPOINT) sTag = GetLocalString(oWP, RS_TRAP_TAG);
    if(sWPTag == RS_ITEM_WAYPOINT) sTag = GetLocalString(oWP, RS_ITEM_TAG);
    return sTag;
}

int RS_GetNumToSpawnMin(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iNum = 0;
    string sTag = GetTag(oWP);
    if(sTag == RS_CREATURE_WAYPOINT) iNum = GetLocalInt(oWP, RS_NUM_CREATURES_MIN);
    if(sTag == RS_PLACEABLE_WAYPOINT) iNum = GetLocalInt(oWP, RS_NUM_PLACEABLES_MIN);
    if(sTag == RS_TRAP_WAYPOINT) iNum = GetLocalInt(oWP, RS_NUM_TRAPS_MIN);
    if(sTag == RS_ITEM_WAYPOINT) iNum = GetLocalInt(oWP, RS_NUM_ITEMS_MIN);
    if(iNum < 0) iNum = 0;
    return iNum;
}

int RS_GetNumToSpawnMax(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iNum = 0;
    string sTag = GetTag(oWP);
    if(sTag == RS_CREATURE_WAYPOINT) iNum = GetLocalInt(oWP, RS_NUM_CREATURES_MAX);
    if(sTag == RS_PLACEABLE_WAYPOINT) iNum = GetLocalInt(oWP, RS_NUM_PLACEABLES_MAX);
    if(sTag == RS_TRAP_WAYPOINT) iNum = GetLocalInt(oWP, RS_NUM_TRAPS_MAX);
    if(sTag == RS_ITEM_WAYPOINT) iNum = GetLocalInt(oWP, RS_NUM_ITEMS_MAX);
    if(iNum == -1)iNum = d20();
    if(iNum < 1) iNum = 1;
    return iNum;
}

int RS_GetSpawnTimeMax(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iSpawnTime = 0;
    iSpawnTime = GetLocalInt(oWP, RS_RESPAWN_TIME_MAX);
    return iSpawnTime;
}

int RS_GetSpawnTimeMin(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iSpawnTime = 0;
    iSpawnTime = GetLocalInt(oWP, RS_RESPAWN_TIME_MIN);
    return iSpawnTime;
}

int RS_GetNumItems(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iNumItems = 0;
    string sItem = "";
    sItem = GetLocalString(oWP, "Item1");
    int x = 1;
    while(sItem != "")
    {
        iNumItems++;
        x++;
        sItem = GetLocalString(oWP, "Item" + IntToString(x));
    }
    return iNumItems;
}

int RS_GetNumStats(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iNumStats = 0;
    int iStat = 0;
    iStat = GetLocalInt(oWP, "StatChange1");
    int x = 1;
    while(iStat != 0)
    {
        iNumStats++;
        x++;
        iStat = GetLocalInt(oWP, "StatChange" + IntToString(x));
    }
    return iNumStats;
}

int RS_GetStatChange(object oWP, int iStat)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iStatChangeMin = 0;
    int iStatChangeMax = 0;
    int iStatChange = 0;
    int iStatDiff = 0;

    iStatChangeMin = GetLocalInt(oWP, "StatChangeVar" + IntToString(iStat) + "Min");
    iStatChangeMax = GetLocalInt(oWP, "StatChangeVar" + IntToString(iStat) + "Max");

    if(iStatChangeMin > iStatChangeMax)     //min should always be < max
    {
        iStatDiff = iStatChangeMin;
        iStatChangeMin = iStatChangeMax;
        iStatChangeMax = iStatDiff;
        iStatDiff = 0;
    }

    if(iStatChangeMin < 0)
    {
        iStatDiff = abs(iStatChangeMin);
        iStatChangeMax += abs(iStatChangeMin);
        iStatChangeMin = 0;
    }
    iStatChange = Random(iStatChangeMax - iStatChangeMin) + iStatChangeMin;
    iStatChange -= iStatDiff;
    return iStatChange;
}

void RS_AdjustStat(object oCreature, object oWP)
{
    if(!GetIsObjectValid(oWP) && !GetIsObjectValid(oCreature)) return;
    int iNumStats = RS_GetNumStats(oWP);
    int x;
    effect eAbility;
    int iStatChange;
    int iAbility;

    for(x=1; x<=iNumStats;x++)
    {
        iAbility = GetLocalInt(oWP, "StatChange" + IntToString(x));
        if(iAbility == -1) iAbility = d6();
        iStatChange = RS_GetStatChange(oWP, x);
        if(iStatChange > 0)
        {
            switch (iAbility)
            {
                case 1: eAbility = EffectAbilityIncrease(ABILITY_STRENGTH, iStatChange);break;
                case 2: eAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, iStatChange);break;
                case 3: eAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, iStatChange);break;
                case 4: eAbility = EffectAbilityIncrease(ABILITY_INTELLIGENCE, iStatChange);break;
                case 5: eAbility = EffectAbilityIncrease(ABILITY_WISDOM, iStatChange);break;
                case 6: eAbility = EffectAbilityIncrease(ABILITY_CHARISMA, iStatChange);break;
            }
        }
        else if(iStatChange < 0)
        {
            iStatChange = abs(iStatChange);
            switch (iAbility)
            {
                case 1: eAbility = EffectAbilityDecrease(ABILITY_STRENGTH, iStatChange);break;
                case 2: eAbility = EffectAbilityDecrease(ABILITY_DEXTERITY, iStatChange);break;
                case 3: eAbility = EffectAbilityDecrease(ABILITY_CONSTITUTION, iStatChange);break;
                case 4: eAbility = EffectAbilityDecrease(ABILITY_INTELLIGENCE, iStatChange);break;
                case 5: eAbility = EffectAbilityDecrease(ABILITY_WISDOM, iStatChange);break;
                case 6: eAbility = EffectAbilityDecrease(ABILITY_CHARISMA, iStatChange);break;
            }
        }
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAbility, oCreature);
    }
}

void RS_EquipItem(object oCreature, object oItem)
{
    if(!GetIsObjectValid(oItem) && !GetIsObjectValid(oCreature)) return;
    AssignCommand(oCreature, ActionEquipMostEffectiveArmor());  //equips most effective armor in inventory

    int iBase = GetBaseItemType(oItem);
    switch (iBase)                       //check if weapon and if so, equip it
    {
        case BASE_ITEM_BASTARDSWORD:
        case BASE_ITEM_BATTLEAXE:
        case BASE_ITEM_CLUB:
        case BASE_ITEM_DAGGER:
        case BASE_ITEM_DART:
        case BASE_ITEM_DIREMACE:
        case BASE_ITEM_DOUBLEAXE:
        case BASE_ITEM_DWARVENWARAXE:
        case BASE_ITEM_ENCHANTED_WAND:
        case BASE_ITEM_GREATAXE:
        case BASE_ITEM_GREATSWORD:
        case BASE_ITEM_GRENADE:
        case BASE_ITEM_HALBERD:
        case BASE_ITEM_HANDAXE:
        case BASE_ITEM_HEAVYCROSSBOW:
        case BASE_ITEM_HEAVYFLAIL:
        case BASE_ITEM_KAMA:
        case BASE_ITEM_KATANA:
        case BASE_ITEM_KUKRI:
        case BASE_ITEM_LIGHTCROSSBOW:
        case BASE_ITEM_LIGHTFLAIL:
        case BASE_ITEM_LIGHTHAMMER:
        case BASE_ITEM_LIGHTMACE:
        case BASE_ITEM_LONGBOW:
        case BASE_ITEM_LONGSWORD:
        case BASE_ITEM_MAGICROD:
        case BASE_ITEM_MAGICSTAFF:
        case BASE_ITEM_MAGICWAND:
        case BASE_ITEM_MORNINGSTAR:
        case BASE_ITEM_QUARTERSTAFF:
        case BASE_ITEM_RAPIER:
        case BASE_ITEM_SCIMITAR:
        case BASE_ITEM_SCYTHE:
        case BASE_ITEM_SHORTBOW:
        case BASE_ITEM_SHORTSPEAR:
        case BASE_ITEM_SHORTSWORD:
        case BASE_ITEM_SHURIKEN:
        case BASE_ITEM_SICKLE:
        case BASE_ITEM_SLING:
        case BASE_ITEM_THROWINGAXE:
        case BASE_ITEM_TRIDENT:
        case BASE_ITEM_TWOBLADEDSWORD:
        case BASE_ITEM_WARHAMMER:
        case BASE_ITEM_WHIP:                    //it is a weapon, put it in right hand
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
        }break;

        case BASE_ITEM_CPIERCWEAPON:
        case BASE_ITEM_CSLASHWEAPON:      //creature weapon
        case BASE_ITEM_CSLSHPRCWEAP:
        case BASE_ITEM_CBLUDGWEAPON:
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_CWEAPON_R));
        }break;

        case BASE_ITEM_ARROW:   //arrows
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_ARROWS));
        }break;

        case BASE_ITEM_BULLET: //bullets
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_BULLETS));
        }break;

        case BASE_ITEM_BOOTS: //Boots
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_BOOTS));
        }break;

        case BASE_ITEM_BELT: //Belt
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_BELT));
        }break;

        case BASE_ITEM_HELMET: //Helmet
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_HEAD));
        }break;

        case BASE_ITEM_AMULET: //Neck
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_NECK));
        }break;

        case BASE_ITEM_BRACER: //Arms
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_ARMS));
        }break;

        case BASE_ITEM_RING: //Ring  only can equip one, sorry
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTRING));
        }break;

        case BASE_ITEM_CLOAK: //Cloak
        {
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_CLOAK));
        }break;

        default: //not equipable, leave it alone
    }

}

void RS_CreateItem(object oObject, object oWP)
{
    if(!GetIsObjectValid(oWP) && !GetIsObjectValid(oObject)) return;
    int iNumItems = RS_GetNumItems(oWP);
    int iType = GetObjectType(oObject);
    int iItemDrop;
    int iRand;
    int x;
    string sItem;
    object oItem;
    for(x=1;x<=iNumItems;x++)
    {
        sItem = GetLocalString(oWP, "Item" + IntToString(x));

        iItemDrop = GetLocalInt(oWP, "Item" + IntToString(x) + " Drop");
        if(iItemDrop == -1) iItemDrop = d100();
        if(iItemDrop >100) iItemDrop = 100;
        iRand = Random(101);  //0-100
        if(iRand <= iItemDrop) iItemDrop = 1;
        else iItemDrop = 0;

        oItem = CreateItemOnObject(sItem, oObject);
        if(oItem != OBJECT_INVALID)
        {
            if(iItemDrop == 0) SetDroppableFlag(oItem, FALSE);
            if(iItemDrop == 1) SetDroppableFlag(oItem, TRUE);
            if(iType == OBJECT_TYPE_CREATURE) RS_EquipItem(oObject, oItem);
        }
    }
}

int RS_GetNextSpawnTimeLeft(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iTime = 0;
    iTime = GetLocalInt(oWP, "SpawnTime");
    return iTime;
}

void RS_SetNextSpawnTimeLeft(object oWP)
{
    if(!GetIsObjectValid(oWP)) return;
    int iTime = 0;
    int iMax = RS_GetSpawnTimeMax(oWP);
    int iMin = RS_GetSpawnTimeMin(oWP);
    if (iMin < 0) iMin = 0;
    if (iMax == -1) iMax = d100();
    iTime = Random(iMax - iMin) + iMin;
    SetLocalInt(oWP, "SpawnTime", iTime);
}

void RS_DecrementSpawnTime(object oWP)
{
    if(!GetIsObjectValid(oWP)) return;
    int iTime = 0;
    iTime = RS_GetNextSpawnTimeLeft(oWP);
    iTime = iTime - FloatToInt(RS_DELAY_CYCLE);
    SetLocalInt(oWP, "SpawnTime", iTime);
}

int RS_GetWPID(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iWPID = 0;
    iWPID = GetLocalInt(oWP, "WPID");
    return iWPID;
}

int RS_GetNumCreaturesSpawned(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iNum = 0;
    int iWPID = RS_GetWPID(oWP);
    int iCWPID = 0;
    object oArea = GetArea(oWP);
    object oCreature = GetFirstObjectInArea(oArea);
    while(oCreature != OBJECT_INVALID)
    {
        if(GetObjectType(oCreature) == OBJECT_TYPE_CREATURE)
        {
            iCWPID = GetLocalInt(oCreature, "WPID");
            if(iCWPID == iWPID) iNum++;
        }
        oCreature = GetNextObjectInArea(oArea);
    }
    return iNum;
}

int RS_GetPlaceablesSpawned(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iSpawn = 0;
    int iWPID = RS_GetWPID(oWP);
    int iPWPID = 0;
    object oArea = GetArea(oWP);
    object oPlaceable = GetFirstObjectInArea(oArea);
    while(oPlaceable != OBJECT_INVALID)
    {
        if(GetObjectType(oPlaceable) == OBJECT_TYPE_PLACEABLE)
        {
            iPWPID = GetLocalInt(oPlaceable, "WPID");
            if(iPWPID == iWPID) iSpawn++;
        }
        oPlaceable = GetNextObjectInArea(oArea);
    }
    return iSpawn;
}

int RS_GetSpawnable(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iSpawn = 0;
    int iSettings = GetLocalInt(oWP, RS_TIME_OF_DAY_SPAWN);
    switch(iSettings)
    {
        case 0000:  iSpawn = 1;break;//Dawn, Day, Dusk, and Night     //backwards compatability
        case 0001:  if(GetIsNight()) iSpawn = 1;break;//night
        case 0010:  if(GetIsDusk()) iSpawn = 1;break;//Dusk
        case 0011:  if(GetIsDusk() || GetIsNight()) iSpawn = 1;break;//Dusk and Night
        case 0100:  if(GetIsDay()) iSpawn = 1;break;//Day
        case 0101:  if(GetIsDay() || GetIsNight()) iSpawn = 1;break;//Day and Night
        case 0110:  if(GetIsDay() || GetIsDusk()) iSpawn = 1;break;//Day and Dusk
        case 0111:  if(GetIsDay() || GetIsDusk() || GetIsNight()) iSpawn = 1;break;//Day, Dusk, and Night
        case 1000:  if(GetIsDawn()) iSpawn = 1;break;//Dawn
        case 1001:  if(GetIsDawn() || GetIsNight()) iSpawn = 1;break;//Dawn and Night
        case 1010:  if(GetIsDawn() || GetIsDusk()) iSpawn = 1;break;//Dawn and Dusk
        case 1011:  if(GetIsDawn() || GetIsDusk() || GetIsNight()) iSpawn = 1;break;//Dawn, Dusk, and Night
        case 1100:  if(GetIsDawn() || GetIsDay()) iSpawn = 1;break;//Dawn and Day
        case 1101:  if(GetIsDawn() || GetIsDay() || GetIsNight()) iSpawn = 1;break;//Dawn, Day, and Night
        case 1110:  if(GetIsDawn() || GetIsDay() || GetIsDusk()) iSpawn = 1;break;//Dawn, Day, and Dusk
        case 1111:  iSpawn = 1;break;//Dawn, Day, Dusk, and Night
    }
    return iSpawn;
}

int RS_PCLevel(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    object oArea = GetArea(oWP);
    object oPC = GetFirstPC();
    int iPCPosLvl1 = 0;
    int iPCPosLvl2 = 0;
    int iPCPosLvl3 = 0;
    int iPCLevel = 0;
    int x = 0;

    while(GetIsObjectValid(oPC))
    {
        if(GetArea(oPC)==oArea)
        {
            iPCPosLvl1 = GetLevelByPosition(1, oPC);
            iPCPosLvl2 = GetLevelByPosition(2, oPC);
            iPCPosLvl3 = GetLevelByPosition(3, oPC);
            iPCLevel += iPCPosLvl1 + iPCPosLvl2 + iPCPosLvl3;
            x++;
        }
        oPC = GetNextPC();
    }
    iPCLevel = iPCLevel / x;
    return iPCLevel;
}

int RS_GetLevel(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iLvlMin = 1;
    int iLvlMax = 1;
    int iBoss = GetLocalInt(oWP, RS_BOSS);
    int iLevel = 0;
    if(!RS_PC_LEVEL_CREATURE_LEVEL_HARD)
    {
        if(RS_USE_AREA_VARIABLES && iBoss == 0)
        {
            int x = 0;
            object oAWP = GetObjectByTag(RS_AREA_WAYPOINT,x);
            x++;
            while (GetArea(oAWP) != OBJECT_SELF)
            {
                oAWP = GetObjectByTag(RS_AREA_WAYPOINT,x);
                x++;
            }
            iLvlMax = GetLocalInt(oAWP, RS_LEVEL_MAX);
            iLvlMin = GetLocalInt(oAWP, RS_LEVEL_MIN);
        }
        else
        {
            iLvlMax = GetLocalInt(oWP, RS_LEVEL_MAX);
            iLvlMin = GetLocalInt(oWP, RS_LEVEL_MIN);
        }

        if(iLvlMax == -1) iLvlMax = d4() * d10();//if max = -1 random levels chosen
        if(iLvlMin > iLvlMax)           //builder screwed up, fix it
        {                               //min should always be < max
            int iLvlSwap = iLvlMin;
            iLvlMin = iLvlMax;
            iLvlMax = iLvlSwap;
        }

        if(RS_PC_LEVEL_CREATURE_LEVEL_SOFT)
        {
            int iPCLevel = RS_PCLevel(oWP);
            int iTempMin = iLvlMin;
            int iTempMax = iLvlMax;
            if(iPCLevel + 1 <= iLvlMax) iLvlMax = iPCLevel + 1;
            if(iPCLevel - 1 >= iLvlMin) iLvlMin = iPCLevel - 1;
            if(iPCLevel - 1 >= iLvlMax) iLvlMin = iLvlMax;
            if(iPCLevel + 1 <= iLvlMin) iLvlMax = iLvlMin;
            if(iLvlMin >= iTempMax) iLvlMin = iTempMax;
            if(iLvlMax <= iTempMin) iLvlMax = iTempMin;
        }
        if(iBoss == 1)
        {
            iLvlMax = GetLocalInt(oWP, RS_LEVEL_MAX);
            iLvlMin = GetLocalInt(oWP, RS_LEVEL_MIN);
        }
        if(iLvlMax < 0) iLvlMax = 0;
        if(iLvlMin < 0) iLvlMin = 0;    //if negative, then no change to creature.

        iLevel = Random(iLvlMax - iLvlMin) + iLvlMin;
    }
    else
    {
        iLevel = RS_PCLevel(oWP);
        iLevel = Random(3) + (iLevel-1);
    }
    return iLevel;
}

void RS_LevelCreature(object oCreature, int iLevel)
{
    if(!GetIsObjectValid(oCreature)) return;
    int iClassDefault = GetClassByPosition(1, oCreature);
    int iPackageDefault = GetCreatureStartingPackage(oCreature);
    effect eNegLevel;
    int iCurLevel;
    int y;

    //set the new level
    iCurLevel = GetHitDice(oCreature);  //get current level of critter
    if(iLevel != 0) iLevel -= iCurLevel;    //adjust level to variables
    if(iLevel > 0)
    {
        for(y=1;y<=iLevel;y++)
        {
            LevelUpHenchman(oCreature, iClassDefault, TRUE, iPackageDefault);
        }
    }
    else if (iLevel < 0)
    {
        eNegLevel = SupernaturalEffect(EffectNegativeLevel(abs(iLevel)));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNegLevel, oCreature);
    }
}

void RS_Action(object oCreature, object oWP)
{
    int iAction = GetLocalInt(oWP, RS_ACTION);
    if(iAction < -1 || iAction > 4) iAction = 1;
    if(iAction == -1) iAction = d4();
    SetLocalInt(oCreature, "X2_L_SPAWN_USE_AMBIENT", 1);
    switch(iAction)
    {
        default:
        case 0:
        case 1: AssignCommand(oCreature, ActionRandomWalk());break;
        case 2: AssignCommand(oCreature, WalkWayPoints());break;
        case 3: AssignCommand(oCreature, ActionAttack(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oCreature)));
        case 4: DeleteLocalInt(oCreature, "X2_L_SPAWN_USE_AMBIENT");break;//Do Nothing
    }
}

void RS_RandomName(object oObject)
{
    string sName = GetName(oObject, TRUE);
    switch(GetObjectType(oObject))
    {

        case OBJECT_TYPE_CREATURE:
        {
            int iGender = GetGender(oObject);
            int iRace = GetRacialType(oObject);
            int iRaceGender = 0;
            switch (iGender)
            {
                case GENDER_FEMALE:
                {
                    switch(iRace)
                    {
                        case RACIAL_TYPE_DWARF: iRaceGender = NAME_FIRST_DWARF_FEMALE;break;
                        case RACIAL_TYPE_ELF: iRaceGender = NAME_FIRST_ELF_FEMALE;break;
                        case RACIAL_TYPE_GNOME: iRaceGender = NAME_FIRST_GNOME_FEMALE;break;
                        case RACIAL_TYPE_HALFELF: iRaceGender = NAME_FIRST_HALFELF_FEMALE;break;
                        case RACIAL_TYPE_HALFLING: iRaceGender = NAME_FIRST_HALFLING_FEMALE;break;
                        case RACIAL_TYPE_HALFORC: iRaceGender = NAME_FIRST_HALFORC_FEMALE;break;
                        case RACIAL_TYPE_HUMAN: iRaceGender = NAME_FIRST_HUMAN_FEMALE;break;
                        default: iRaceGender = NAME_FAMILIAR;
                    }
                }break;
                case GENDER_BOTH:
                case GENDER_MALE:
                case GENDER_NONE:
                case GENDER_OTHER:
                {
                    switch(iRace)
                    {
                        case RACIAL_TYPE_DWARF: iRaceGender = NAME_FIRST_DWARF_MALE;break;
                        case RACIAL_TYPE_ELF: iRaceGender = NAME_FIRST_ELF_MALE;break;
                        case RACIAL_TYPE_GNOME: iRaceGender = NAME_FIRST_GNOME_MALE;break;
                        case RACIAL_TYPE_HALFELF: iRaceGender = NAME_FIRST_HALFELF_MALE;break;
                        case RACIAL_TYPE_HALFLING: iRaceGender = NAME_FIRST_HALFLING_MALE;break;
                        case RACIAL_TYPE_HALFORC: iRaceGender = NAME_FIRST_HALFORC_MALE;break;
                        case RACIAL_TYPE_HUMAN: iRaceGender = NAME_FIRST_HUMAN_MALE;break;
                        default: iRaceGender = NAME_FIRST_GENERIC_MALE;
                    }
                }break;
            }
            sName = RandomName(iRaceGender);
        }break;

        //if you want random names for these types, you will have to add code for that.
        case OBJECT_TYPE_PLACEABLE:
        case OBJECT_TYPE_TRIGGER:
        case OBJECT_TYPE_ITEM:
        default:break;
    }
    SetName(oObject, sName);
}

void RS_SpawnCreatures(object oWP)
{
    if(!GetIsObjectValid(oWP)) return;
    int bSpawnable = RS_GetSpawnable(oWP);
    //if not the right time to spawn, increment counter, but don't spawn. //added despawn
    if(!bSpawnable)
    {
        RS_SetNextSpawnTimeLeft(oWP);
        if(RS_DESPAWN_CREATURES) RS_Despawn(oWP);
        return;
    }
    int iWPID = RS_GetWPID(oWP);
    string sResref = RS_GetResrefFromWaypoint(oWP);
    object oArea = GetArea(oWP);
    location lLoc  = GetLocation(oWP);
    int iAreaSpawn = GetLocalInt(oWP, RS_AREA_CREATURE);
    string sTag = RS_GetNewTag(oWP);
    string sName;
    int iHPAdjust;
    int iLevel;
    object oCreature;
    effect eEffect;
//    float fDelay = IntToFloat(d100())/100; // 0.01 - 1.0

    if(iAreaSpawn) lLoc = RS_GetRandomLocation(oArea, oWP);  //get random location out of player sight
    if(GetLocalInt(oWP, RS_LEVEL_MAX)!=-2) iLevel = RS_GetLevel(oWP); //get random level based on variables
    else iLevel = 0;//overide feature
    if(GetLocalInt(oWP, "RS_GroupSpawn") == 1) oCreature = CopyObject(RS_GetSpawnFromArea(oWP, RS_TYPE_CREATURE, sResref),lLoc,OBJECT_INVALID,sTag);
    else oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResref, lLoc, FALSE, sTag);

    if(oCreature != OBJECT_INVALID)
    {
        sName = RS_GetNewName(oWP);
        if(GetStringLowerCase(sName) == "random") RS_RandomName(oCreature);
        else SetName(oCreature, sName);

        DelayCommand(0.05, RS_LevelCreature(oCreature, iLevel));
        DelayCommand(0.1, RS_AdjustStat(oCreature, oWP));//adjust the stats based on variables
        DelayCommand(0.15, RS_CreateItem(oCreature, oWP));//add the Items based on variables
        SetLocalInt(oCreature, "WPID", iWPID);//set the creatures spawn origin ID

        //adjust the hit points
        iHPAdjust = RS_GetHPAdjust(oWP);
        if(iHPAdjust != 0)
        {
            if(iHPAdjust < 0)
            {
                //let's not kill the creature at spawn
                if(abs(iHPAdjust) >= GetMaxHitPoints(oCreature)) iHPAdjust = GetMaxHitPoints(oCreature) - 1;
                eEffect = EffectDamage(abs(iHPAdjust));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oCreature);
            }
            else
            {
                if(iHPAdjust > 0)
                {
                    eEffect = EffectTemporaryHitpoints(iHPAdjust);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                }
            }
        }
        DelayCommand(0.20, RS_Action(oCreature, oWP));
        DelayCommand(0.25, RS_AddVariables(oWP, oCreature));
    }
    DelayCommand(0.30, ExecuteScript(GetLocalString(oWP, RS_SCRIPT_TO_RUN_ON_SPAWN), oCreature));
}

int RS_GetLocked(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iLocked = 0;
    iLocked = GetLocalInt(oWP, RS_LOCKED);
    if (iLocked != 1 && iLocked != 0) iLocked = 0;
    return iLocked;
}

int RS_GetLockDC(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iLockDC = 0;
    iLockDC = GetLocalInt(oWP, RS_LOCK_DC);
    if(iLockDC <0) iLockDC = 0;
    return iLockDC;
}

string RS_GetLockKey(object oWP)
{
    if(!GetIsObjectValid(oWP)) return "";
    string sLockKey = "";
    sLockKey = GetLocalString(oWP, RS_LOCK_KEY);
    return sLockKey;
}

int RS_GetHardness(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iHardness = 0;
    iHardness = GetLocalInt(oWP, RS_HARDNESS);
    if(iHardness <0) iHardness = 0;
    return iHardness;
}

int RS_GetPlot(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iPlot = 0;
    iPlot = GetLocalInt(oWP, RS_PLOT);
    if (iPlot != 1 && iPlot != 0) iPlot = 0;
    return iPlot;
}

int RS_GetStatic(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iStatic = 0;
    iStatic = GetLocalInt(oWP, RS_STATIC);
    if (iStatic != 0 && iStatic != 1) iStatic = 0;
    return iStatic;
}

int RS_GetTrapped(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iTrapped = 0;
    iTrapped = GetLocalInt(oWP, RS_TRAPPED);
    if (iTrapped != 1 && iTrapped != 0) iTrapped = 0;
    return iTrapped;
}

int RS_GetTrapDisarmDC(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iTrapDC = 0;
    iTrapDC = GetLocalInt(oWP, RS_TRAP_DISARM_DC);
    if(iTrapDC <0) iTrapDC = 0;
    return iTrapDC;
}

int RS_GetTrapDetectDC(object oWP)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iTrapDC = 0;
    iTrapDC = GetLocalInt(oWP, RS_TRAP_DETECT_DC);
    if(iTrapDC <0) iTrapDC = 0;
    return iTrapDC;
}

int RS_GetSave(object oWP, int iSaveThrow)
{
    if(!GetIsObjectValid(oWP)) return 0;
    int iSave = 0;
    switch (iSaveThrow)
    {
        case RS_FORT_SAVE: iSave = GetLocalInt(oWP, RS_FORT_SAVE_VARIABLE);break;
        case RS_REFLEX_SAVE: iSave = GetLocalInt(oWP, RS_REFLEX_SAVE_VARIABLE);break;
        case RS_WILL_SAVE: iSave = GetLocalInt(oWP, RS_WILL_SAVE_VARIABLE);break;
    }
    if(iSave == -1)iSave = d20();
    if(iSave < 0) iSave = 0;
    return iSave;
}

int RS_GetTrapType(object oWP)
{
    int iTrapType = 0; //minor Spike
    int iTrapStrength = GetLocalInt(oWP, RS_TRAP_STRENGTH);
    int iTrapElement = GetLocalInt(oWP, RS_TRAP_ELEMENT);
    if(iTrapStrength == -1) iTrapStrength = Random(4);//0-3
    if(iTrapElement == -1) iTrapElement = Random(11);//0-10
    iTrapType = (iTrapElement * 4) + iTrapStrength;
    return iTrapType;
}

void RS_AddVariables(object oWP, object oObject)
{
    if(!GetIsObjectValid(oWP) || !GetIsObjectValid(oObject)) return;
    string sVar = GetLocalString(oWP, "Int1");
    int iVar = GetLocalInt(oWP, "IntVal1");
    string sVar2 = GetLocalString(oWP, "StringVal1");
    float fVar = GetLocalFloat(oWP, "FloatVal1");
    int x = 1;
    //Integers
    while(sVar != "")
    {
        SetLocalInt(oObject, sVar, iVar);
        x++;
        sVar = GetLocalString(oWP, "Int" + IntToString(x));
        iVar = GetLocalInt(oWP, "IntVal" + IntToString(x));
    }
    //Strings
    sVar = GetLocalString(oWP, "String1");
    x=1;
    while(sVar != "")
    {
        SetLocalString(oObject, sVar, sVar2);
        x++;
        sVar = GetLocalString(oWP, "String" + IntToString(x));
        sVar2 = GetLocalString(oWP, "StringVal" + IntToString(x));
    }
    //Floats
    sVar = GetLocalString(oWP, "Float1");
    x=1;
    while(sVar != "")
    {
        SetLocalFloat(oObject, sVar, fVar);
        x++;
        sVar = GetLocalString(oWP, "Float" + IntToString(x));
        fVar = GetLocalFloat(oWP, "FloatVal" + IntToString(x));
    }
}

void RS_SpawnPlaceables(object oWP)
{
    if(!GetIsObjectValid(oWP)) return;
    int bSpawnable = RS_GetSpawnable(oWP);
    //if not the right time to spawn, increment counter, but don't spawn.
    if(!bSpawnable)
    {
        RS_SetNextSpawnTimeLeft(oWP);
        if(RS_DESPAWN_PLACEABLES) RS_Despawn(oWP);
        return;
    }
    int iWPID = RS_GetWPID(oWP);
    string sResref = RS_GetResrefFromWaypoint(oWP);
    object oArea = GetArea(oWP);
    location lLoc;
    int iAreaSpawn = GetLocalInt(oWP, RS_AREA_PLACEABLE);
    if(!iAreaSpawn) lLoc = GetLocation(oWP);
    string sTag = RS_GetNewTag(oWP);
    string sName = RS_GetNewName(oWP);
    int iHPAdjust;
    effect eEffect;
    object oPlaceable;
    int iLocked = RS_GetLocked(oWP);
    int iLockDC = RS_GetLockDC(oWP);
    string sLockKey = RS_GetLockKey(oWP);
    int iHardness = RS_GetHardness(oWP);
    int iPlot = RS_GetPlot(oWP);
    int iStatic = RS_GetStatic(oWP);
    int iTrapped = RS_GetTrapped(oWP);
    int iTrapDetectDC = RS_GetTrapDetectDC(oWP);
    int iTrapDisarmDC = RS_GetTrapDisarmDC(oWP);
    int iFortSave= RS_GetSave(oWP, RS_FORT_SAVE);
    int iReflexSave= RS_GetSave(oWP, RS_REFLEX_SAVE);
    int iWillSave= RS_GetSave(oWP, RS_WILL_SAVE);
    float fDelay = IntToFloat(d100())/100; // 0.01 - 1.0

    if(iAreaSpawn) lLoc = RS_GetRandomLocation(oArea, oWP, RS_TYPE_PLACEABLE);  //get random location out of player sight

    if(GetLocalInt(oWP, "RS_GroupSpawn") == 1) oPlaceable = CopyPlaceable(RS_GetSpawnFromArea(oWP, RS_TYPE_PLACEABLE, sResref),lLoc,sTag);
    else oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sResref, lLoc, FALSE, sTag);

    if(oPlaceable != OBJECT_INVALID)
    {
        if(GetStringLowerCase(sName) == "random") RS_RandomName(oPlaceable);
        else SetName(oPlaceable, sName); //name

        SetPlotFlag(oPlaceable, iPlot);    //plot?
        if(iHardness != 0)SetHardness(iHardness, oPlaceable);  //hardness change?
        SetUseableFlag(oPlaceable, !iStatic);//if static, then it is not useable
        //since static can not be set in game, set plot on to disallow breakage
        if(iStatic == 1) SetPlotFlag(oPlaceable, 1);

        //traps
        if(iTrapped)
        {
            if(!GetIsTrapped(oPlaceable))
            {
                CreateTrapOnObject(RS_GetTrapType(oWP), oPlaceable);
                DelayCommand(fDelay, SetTrapDetectable(oPlaceable, TRUE));
                DelayCommand(fDelay*1.1, SetTrapOneShot(oPlaceable, TRUE));
                DelayCommand(fDelay*1.2, SetTrapRecoverable(oPlaceable, TRUE));
                DelayCommand(fDelay*1.3, SetTrapDisarmable(oPlaceable, TRUE));
            }
            DelayCommand(fDelay*1.4, SetTrapActive(oPlaceable, TRUE));
            DelayCommand(fDelay*1.5, SetTrapDisarmDC(oPlaceable, iTrapDisarmDC));
            DelayCommand(fDelay*1.6, SetTrapDetectDC(oPlaceable, iTrapDetectDC));
        }
        //saves
        if(iFortSave !=0) DelayCommand(fDelay*1.7, SetFortitudeSavingThrow(oPlaceable, iFortSave));
        if(iReflexSave !=0) DelayCommand(fDelay*1.8, SetFortitudeSavingThrow(oPlaceable, iReflexSave));
        if(iWillSave !=0) DelayCommand(fDelay*1.9, SetFortitudeSavingThrow(oPlaceable, iWillSave));

        DelayCommand(fDelay*2.0, RS_CreateItem(oPlaceable, oWP));//add the Items based on variables
        SetLocalInt(oPlaceable, "WPID", iWPID);//set the placeable's spawn origin ID

        //adjust the hit points (not sure if this works on placeables)
        iHPAdjust = RS_GetHPAdjust(oWP);
        if(iHPAdjust != 0)
        {
            if(iHPAdjust < 0)
            {
                eEffect = EffectDamage(abs(iHPAdjust));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPlaceable);
            }
            else
            {
                if(iHPAdjust > 0)
                {
                    eEffect = EffectTemporaryHitpoints(iHPAdjust);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPlaceable);
                }
            }
        }
    }
    DelayCommand(fDelay*2.1, RS_AddVariables(oWP, oPlaceable));
    string sScript = GetLocalString(oWP, RS_SCRIPT_TO_RUN_ON_SPAWN);
    DelayCommand(fDelay*2.3, ExecuteScript(sScript, oPlaceable));
    DelayCommand(0.30, ExecuteScript(GetLocalString(oWP, RS_SCRIPT_TO_RUN_ON_SPAWN), oPlaceable));
}

location RS_GetRandomLocation(object oArea = OBJECT_SELF, object oWP = OBJECT_INVALID, int iType = RS_TYPE_CREATURE, float fDistance = 1.0f)
{
    object oObject = OBJECT_INVALID;
    location lLocation1;
    location lLocation2;
    location lLocation3;
    float fDistance1;
    float fDistance2;
    float fMaxDistance;
    float fMinDistance;
    if(GetIsObjectValid(oWP))
    {
        fMaxDistance = GetLocalFloat(oWP, RS_DISTANCE_MAX);
        fMinDistance = GetLocalFloat(oWP, RS_DISTANCE_MIN);
        lLocation3 = GetLocation(oWP);
    }
    int nSizeX = (GetAreaSize(AREA_WIDTH,oArea)*10)-1;
    int nSizeY = (GetAreaSize(AREA_HEIGHT,oArea)*10)-1;
    int nNth;

    if(fMaxDistance < 0.0) fMaxDistance = 0.0;
    if(fMinDistance < 0.0) fMinDistance = 0.0;

    if(fMaxDistance != 0.0 || fMinDistance != 0.0)  //ranged location
    {
        //min distance is set, but no max distance, set max distance to edge.
        if(fMaxDistance == 0.0 && fMinDistance != 0.0)
        {
            if(nSizeX >= nSizeY) fMaxDistance = IntToFloat(nSizeX);
            else fMaxDistance = IntToFloat(nSizeY);
        }

        //swap if set backwards
        if(fMinDistance > fMaxDistance)
        {
            float fSwap = fMinDistance;
            fMinDistance = fMaxDistance;
            fMaxDistance = fSwap;
        }
        float fDirection = (IntToFloat(Random(36001)) / 100.0f);
        float fDistance3 = (IntToFloat(Random((100 * FloatToInt(fMaxDistance)) + 1)) / 100.0f) + fMinDistance;
        float fFacing = fDirection + 180.0f;
        while(fFacing > 360.0f) fFacing -= 360.0f;
        vector vVec = GetPosition(oWP) + (fDistance3 * AngleToVector(fDirection));
        lLocation2 = Location(oArea, vVec, fFacing);
    }
    else
    {
        //try to find location out of player sight
        for (; nNth < 5; nNth++)
        {
            lLocation1 = Location(oArea, Vector(IntToFloat(Random(nSizeX) + 1), IntToFloat(Random(nSizeY) + 1)), 0.0);
            oObject = GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, lLocation1, 1);

            if (GetIsObjectValid(oObject))
            {
                fDistance1 = GetDistanceBetweenLocations(lLocation1, GetLocation(oObject));

                if (fDistance1 > fDistance2)
                {
                    lLocation2 = lLocation1;
                    fDistance2 = fDistance1;
                }

                if (fDistance1 >= 25.0) break;
            }
            else
            {
                lLocation2 = lLocation1;
                break;
            }
        }
    }

    //verify location, creatures will already be spawned to valid locations
    if(iType != RS_TYPE_CREATURE)//this was set up to save cpu for creature spawns
    {
        object oVerify;
        oVerify = CreateObject(OBJECT_TYPE_CREATURE, "rs_verify", lLocation2);
        lLocation2 = GetLocation(oVerify);
        DestroyObject(oVerify);
    }

    //location fDistance from edge
    vector vCurPos = GetPositionFromLocation(lLocation2);
    float fNewX = vCurPos.x;
    float fNewY = vCurPos.y;
    if((fNewX + fDistance) > IntToFloat(nSizeX)) fNewX = nSizeX - fDistance;
    if((fNewY + fDistance) > IntToFloat(nSizeY)) fNewY = nSizeY - fDistance;
    if((fNewX - fDistance) < 1.0) fNewX = fDistance + 1;
    if((fNewY - fDistance) < 1.0) fNewY = fDistance + 1;
    vector vNewPos = Vector(fNewX, fNewY, vCurPos.z);
    lLocation2 = Location(oArea, vNewPos, 0.0);

    return lLocation2;
}

void CreateObjectsInShape(int nObjectType, string sObjectTag, int nNoOfSides, location lMidPoint, float fSize, string sNewTag, float fObjectLife)
{
    object oObject, oArea = GetAreaFromLocation(lMidPoint);
    float fFacing = GetFacingFromLocation(lMidPoint);
    float fAngle, fNewX, fNewY;
    int nLooper;
    vector vPos = GetPositionFromLocation(lMidPoint);
    vector vNewPos;
    location lNewLoc;
    string sTag;
    for (nLooper = 0; nLooper < nNoOfSides; nLooper++)
    {
        if (sNewTag != "") sTag = sNewTag + IntToString(nLooper + 1);
        fAngle = IntToFloat(360 / nNoOfSides) * IntToFloat(nLooper);
        vNewPos = vPos + (fSize * AngleToVector(fFacing + fAngle));
        lNewLoc = Location(oArea, vNewPos, fFacing + fAngle);
        oObject = CreateObject(nObjectType, sObjectTag, lNewLoc, TRUE, sTag);
        if (fObjectLife != 0.0) DestroyObject(oObject, fObjectLife);
    }
}

void CreateBeams(string sTag, int iInt=0)
{
    object oItem1;
    object oItem2;
    effect eEffect;
    int x;
    if(iInt == 0)
    {
        for(x=1; x<9; x++)
        {
            oItem1 = GetObjectByTag(sTag + IntToString(x));
            if(x<8) oItem2 = GetObjectByTag(sTag + IntToString(x+1));
            else oItem2 = GetObjectByTag(sTag + IntToString(1));

            eEffect = EffectBeam(VFX_BEAM_SILENT_LIGHTNING, oItem1, BODY_NODE_CHEST);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oItem2);
        }
    }
    else
    {
        for(x=1; x<9; x++)
        {
            oItem1 = GetObjectByTag(sTag + IntToString(1) + IntToString(x));
            if(x<8) oItem2 = GetObjectByTag(sTag + IntToString(1) + IntToString(x+1));
            else oItem2 = GetObjectByTag(sTag + IntToString(1) + IntToString(1));
            eEffect = EffectBeam(VFX_BEAM_SILENT_MIND, oItem1, BODY_NODE_CHEST);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oItem2);
        }
    }
}

void RS_Clear_Spawns(object oArea)
{
    if(!GetIsObjectValid(oArea)) return;
    object oTrash = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oTrash))
    {
        if(GetIsPC(oTrash)) return;//stop if you find a PC
        int iType = GetObjectType(oTrash);

        switch(iType)
        {
            case OBJECT_TYPE_CREATURE:      //creatures
            {
                int iWPID = GetLocalInt(oTrash, "WPID");
                if(iWPID != 0 && RS_CLEAN_SPAWNED_CREATURES) DestroyObject(oTrash);
            }break;

            case OBJECT_TYPE_PLACEABLE:     //placeables and bodybags
            {
                int iWPID = GetLocalInt(oTrash, "WPID");
                if(RS_CLEAN_SPAWNED_PLACEABLES && iWPID != 0)
                {
                    if(GetHasInventory(oTrash))
                    {
                        object oItem = GetFirstItemInInventory(oTrash);
                        while(GetIsObjectValid(oItem))
                        {
                            DestroyObject(oItem);
                            oItem = GetNextItemInInventory(oTrash);
                        }
                    }
                    DelayCommand(1.0, DestroyObject(oTrash));
                }

                //bodybags
                if(GetTag(oTrash)=="BodyBag" && RS_CLEAN_ITEMS)
                {
                    object oItem = GetFirstItemInInventory(oTrash);
                    while(GetIsObjectValid(oItem))
                    {
                        DestroyObject(oItem);
                        oItem = GetNextItemInInventory(oTrash);
                    }
                    DelayCommand(1.0, DestroyObject(oTrash));
                }

            }break;

            case OBJECT_TYPE_ITEM:          //Items
            {
                int iWPID = GetLocalInt(oTrash, "WPID");
                if((iWPID != 0 && RS_CLEAN_SPAWNED_ITEMS) || (iWPID == 0 && RS_CLEAN_ITEMS))
                {
                    if(GetHasInventory(oTrash))
                    {
                        object oInv = GetFirstItemInInventory(oTrash);
                        while(oInv != OBJECT_INVALID)
                        {
                            DestroyObject(oInv);
                            oInv = GetNextItemInInventory(oTrash);
                        }
                    }
                    DelayCommand(1.0, DestroyObject(oTrash));
                }

            }break;

            case OBJECT_TYPE_AREA_OF_EFFECT:        //left over area of effect spells
            {
                DestroyObject(oTrash);
            }break;

            case OBJECT_TYPE_TRIGGER:
            {

            }break;

            case OBJECT_TYPE_WAYPOINT:
            case OBJECT_TYPE_STORE:
            case OBJECT_TYPE_ENCOUNTER:
            break;
        }
        oTrash = GetNextObjectInArea(oArea);
    }

    //Run three times to make sure we get everything
    //Destroyed creatures will drop items
    //If a PC is found, the script will stop anyway
    if(GetLocalInt(oArea, "RS_CLEAN") == 0)
    {
        DelayCommand(5.0, RS_Clear_Spawns(oArea));
        SetLocalInt(oArea, "RS_CLEAN", 1);
    }
    else if(GetLocalInt(oArea, "RS_CLEAN") == 1)
    {
        DelayCommand(5.0, RS_Clear_Spawns(oArea));
        SetLocalInt(oArea, "RS_CLEAN", 2);
    }
    else DeleteLocalInt(oArea, "RS_CLEAN");
}

object RS_GetRandomNonTrappedObject(object oArea)
{
    if(!GetIsObjectValid(oArea)) return OBJECT_INVALID;
    int iNumObjects = 0;
    int iType;
    int x = 1;
    object oReturn = OBJECT_INVALID;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
        iType = GetObjectType(oObject);
        if((iType == OBJECT_TYPE_PLACEABLE || iType == OBJECT_TYPE_DOOR) && !GetIsTrapped(oObject))
        {
            if(GetTag(oObject) != "rs_spawner")iNumObjects++;//spawner should not get trapped
        }
        oObject = GetNextObjectInArea(oArea);
    }

    if(iNumObjects == 0) return OBJECT_INVALID;

    int iRand = Random(iNumObjects)+1;

    oObject = GetFirstObjectInArea(oArea);
    iType = GetObjectType(oObject);
    for(x=1; x<=iRand; x++)
    {
        if((iType == OBJECT_TYPE_PLACEABLE || iType == OBJECT_TYPE_DOOR) && !GetIsTrapped(oObject))
        {
            if(GetTag(oObject) == "rs_spawner")iRand++;//spawners should not get trapped
            oReturn = oObject;
        }
        else iRand++;
        oObject = GetNextObjectInArea(oArea);
        iType = GetObjectType(oObject);
    }
    return oReturn;
}

int RS_GetTrapsSpawned(object oWP)
{
    int iNumTraps = 0;
    object oArea = GetArea(oWP);
    object oObject = GetFirstObjectInArea(oArea);
    int iWPID = RS_GetWPID(oWP);

    while(GetIsObjectValid(oObject))
    {
        if(GetIsTrapped(oObject))
        {
            if(GetLocalInt(oObject, "RS_TRAPPED") == iWPID) iNumTraps++;
        }
        oObject = GetNextObjectInArea(oArea);
    }
    return iNumTraps;
}

int RS_GetItemsSpawned(object oWP)
{
    int iNumItems = 0;
    object oArea = GetArea(oWP);
    object oObject = GetFirstObjectInArea(oArea);
    object oItem;
    int iWPID = RS_GetWPID(oWP);

    while(GetIsObjectValid(oObject))
    {
        if(GetHasInventory(oObject))
        {
            oItem = GetFirstItemInInventory(oObject);
            while(GetIsObjectValid(oItem))
            {
                if(GetLocalInt(oItem, "RS_ITEM")== iWPID)iNumItems++;
                oItem = GetNextItemInInventory(oObject);
            }
        }
        else if(GetLocalInt(oItem, "RS_ITEM")== iWPID)iNumItems++;
        oObject = GetNextObjectInArea(oArea);
    }
    return iNumItems;
}

void RS_SpawnTraps(object oWP)
{
    if(!GetIsObjectValid(oWP)) return;
    int iSpawnable = RS_GetSpawnable(oWP);
    //if not the right time to spawn, increment counter, but don't spawn.
    if(!iSpawnable)
    {
        RS_SetNextSpawnTimeLeft(oWP);
        if(RS_DESPAWN_TRAPS) RS_Despawn(oWP);
        return;
    }
    int iWPID = RS_GetWPID(oWP);
    object oTarget = GetObjectByTag(GetLocalString(oWP, RS_TRAP_OBJECT_TAG));
    location lTarget = GetLocation(oWP);
    int iTrapRandomObject = GetLocalInt(oWP, RS_TRAP_RANDOM_OBJECT);
    float fSizeMax = GetLocalFloat(oWP, RS_TRAP_SIZE_MAX) * 1000;
    float fSizeMin = GetLocalFloat(oWP, RS_TRAP_SIZE_MIN) * 1000;
    float fSize = (Random(FloatToInt(fSizeMax - fSizeMin)) + fSizeMin)/1000;
    string sTag = RS_GetNewTag(oWP);
    if(GetLocalInt(oWP, RS_AREA_TRAP)) lTarget = RS_GetRandomLocation(GetArea(oWP), oWP, RS_TYPE_TRAP, fSize);
    int iDetectDC = RS_GetTrapDetectDC(oWP);
    int iDetectable = GetLocalInt(oWP, RS_TRAP_DETECTABLE);
    int iDisarmDC = RS_GetTrapDisarmDC(oWP);
    int iDisarmable = GetLocalInt(oWP, RS_TRAP_DISARMABLE);
    int iOneShot = GetLocalInt(oWP, RS_TRAP_ONE_SHOT);
    int iRecover = GetLocalInt(oWP, RS_TRAP_RECOVERABLE);
    string sKeyTag = GetLocalString(oWP, RS_TRAP_KEY_TAG);
    string sOnDisarmScript = GetLocalString(oWP, RS_TRAP_DISARM_SCRIPT);
    string sOnTrapTriggeredScript = GetLocalString(oWP, RS_TRAP_TRIGGERED_SCRIPT);
    int iTrapType = RS_GetTrapType(oWP);
    string sResref = RS_GetResrefFromWaypoint(oWP);

    if(GetLocalInt(oWP, "RS_GroupSpawn") == 1)iTrapType = GetTrapBaseType(RS_GetSpawnFromArea(oWP, RS_TYPE_TRAP, sResref));

    if(iTrapRandomObject) oTarget = RS_GetRandomNonTrappedObject(GetArea(oWP));

    if(GetIsObjectValid(oTarget)) CreateTrapOnObject(iTrapType, oTarget, STANDARD_FACTION_HOSTILE, sOnDisarmScript, sOnTrapTriggeredScript);
    else oTarget = CreateTrapAtLocation(iTrapType, lTarget, fSize, sTag, STANDARD_FACTION_HOSTILE, sOnDisarmScript, sOnTrapTriggeredScript);

    if(GetIsObjectValid(oTarget))
    {
        SetTrapActive(oTarget, TRUE);
        SetTrapDetectable(oTarget, iDetectable);
        SetTrapDetectDC(oTarget, iDetectDC);
        SetTrapDisarmable(oTarget, iDisarmable);
        SetTrapDisarmDC(oTarget, iDisarmDC);
        if(sKeyTag != "") SetTrapKeyTag(oTarget, sKeyTag);
        SetTrapOneShot(oTarget, iOneShot);
        SetTrapRecoverable(oTarget, iRecover);
        SetLocalInt(oTarget, "RS_TRAPPED", iWPID);
    }
    ExecuteScript(GetLocalString(oWP, RS_SCRIPT_TO_RUN_ON_SPAWN), oTarget);
}

object RS_GetRandomContainer(object oWP, int iContType)
{
    if(!GetIsObjectValid(oWP)) return OBJECT_INVALID;
    object oArea = GetArea(oWP);
    int iNumObjects = 0;
    int iType;
    int x = 1;
    object oReturn = OBJECT_INVALID;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
        iType = GetObjectType(oObject);
        if(iType == iContType && !GetIsPC(oObject))
        {
            if(GetTag(oObject) != "rs_spawner")iNumObjects++;//spawner should not get items
        }
        oObject = GetNextObjectInArea(oArea);
    }

    if(iNumObjects == 0) return OBJECT_INVALID;

    int iRand = Random(iNumObjects)+1;

    oObject = GetFirstObjectInArea(oArea);
    iType = GetObjectType(oObject);
    for(x=1; x<=iRand; x++)
    {
        if((iType == OBJECT_TYPE_PLACEABLE && GetHasInventory(oObject)) || (iType == OBJECT_TYPE_CREATURE && !GetIsPC(oObject)))
        {
            if(GetTag(oObject) == "rs_spawner")iRand++;//spawners should not get items
            oReturn = oObject;
        }
        else iRand++;
        oObject = GetNextObjectInArea(oArea);
        iType = GetObjectType(oObject);
    }
    return oReturn;
}

void RS_SpawnItems(object oWP)
{
    if(!GetIsObjectValid(oWP)) return;
    int iSpawnable = RS_GetSpawnable(oWP);
    //if not the right time to spawn, increment counter, but don't spawn.
    if(!iSpawnable)
    {
        RS_SetNextSpawnTimeLeft(oWP);
        if(RS_DESPAWN_ITEMS) RS_Despawn(oWP);
        return;
    }

    int iPercent = GetLocalInt(oWP, RS_PERCENT_CHANCE_TO_SPAWN_ITEM);
    if(d100() > iPercent) return;

    int iWPID = RS_GetWPID(oWP);
    object oObject, oItem;
    string sTag = GetLocalString(oWP, RS_ITEM_TAG);
    string sResref = RS_GetResrefFromWaypoint(oWP);
    location lLoc;
    int iAreaSpawn = GetLocalInt(oWP, RS_AREA_ITEM);

    if(iAreaSpawn)
    {
        int iRandomObject = GetLocalInt(oWP, RS_ITEM_RANDOM_OBJECT);
        int iPercCreature = GetLocalInt(oWP, RS_PERCENT_ON_CREATURE);
        int iPercPlaceable = GetLocalInt(oWP, RS_PERCENT_ON_PLACEABLE);

        if(iRandomObject)
        {
            if((iPercCreature + iPercPlaceable)<=100)//up to 100 percent total
            {
                int iDie = d100();
                if(iDie <iPercCreature) oObject = RS_GetRandomContainer(oWP, OBJECT_TYPE_CREATURE);
                else if(iDie < (iPercCreature+iPercPlaceable)) oObject = RS_GetRandomContainer(oWP, OBJECT_TYPE_PLACEABLE);
                else oObject = GetObjectByTag(GetLocalString(oWP, RS_ITEM_CONTAINER_TAG));
            }
            else   //seperate percentile for each
            {
                if(d100() < iPercCreature) oObject = RS_GetRandomContainer(oWP, OBJECT_TYPE_CREATURE);
                else if(d100() < iPercPlaceable) if(iRandomObject) oObject = RS_GetRandomContainer(oWP, OBJECT_TYPE_PLACEABLE);
                else oObject = GetObjectByTag(GetLocalString(oWP, RS_ITEM_CONTAINER_TAG));
            }
        }
        else oObject = GetObjectByTag(GetLocalString(oWP, RS_ITEM_CONTAINER_TAG));
    }
    else oObject = GetObjectByTag(GetLocalString(oWP, RS_ITEM_CONTAINER_TAG));

    if(GetIsObjectValid(oObject))
    {
        lLoc = GetLocation(oObject);
        if(GetLocalInt(oWP, "RS_GroupSpawn") == 1) oItem = CopyObject(RS_GetSpawnFromArea(oWP, RS_TYPE_ITEM, sResref), lLoc, oObject, sTag);
        else if(GetLocalInt(oWP, "RS_ContainerSpawn") == 1) oItem = CopyObject(RS_GetSpawnFromContainer(oWP, sResref), lLoc, oObject, sTag);
        else oItem = CreateItemOnObject(sResref, oObject, 1, sTag);
        SetLocalInt(oItem, "RS_ITEM", iWPID);
    }
    else
    {
        if(iAreaSpawn)lLoc = RS_GetRandomLocation(GetArea(oWP), oWP, RS_TYPE_ITEM, 1.0);
        else lLoc = GetLocation(oWP);
        if(GetLocalInt(oWP, "RS_GroupSpawn") == 1) oItem = CopyObject(RS_GetSpawnFromArea(oWP, RS_TYPE_ITEM, sResref), lLoc, OBJECT_INVALID, sTag);
        else if(GetLocalInt(oWP, "RS_ContainerSpawn") == 1) oItem = CopyObject(RS_GetSpawnFromContainer(oWP, sResref), lLoc, OBJECT_INVALID, sTag);
        else oItem = CreateObject(OBJECT_TYPE_ITEM, sResref, lLoc, FALSE, sTag);
        SetLocalInt(oItem, "RS_ITEM", iWPID);
    }

    string sName = GetLocalString(oWP, RS_ITEM_NAME);
    if(sName != "")
    {
        if(GetStringLowerCase(sName) == "random") RS_RandomName(oItem);
        else SetName(oItem, sName);
    }
}

void RS_Despawn(object oWP)
{
    if(!GetIsObjectValid(oWP)) return;
    object oTrash = GetFirstObjectInArea(GetArea(oWP));
    int iWP_WPID = RS_GetWPID(oWP);
    while(GetIsObjectValid(oTrash))
    {
        int iType = GetObjectType(oTrash);
        if(iType != OBJECT_TYPE_WAYPOINT)
        {
            int iWPID = GetLocalInt(oTrash, "WPID");
            if(iWPID == iWP_WPID)
            {
                if(GetHasInventory(oTrash))
                {
                    object oInv = GetFirstItemInInventory(oTrash);
                    while(oInv != OBJECT_INVALID)
                    {
                        DestroyObject(oInv);
                        oInv = GetNextItemInInventory(oTrash);
                    }
                }
                DestroyObject(oTrash);
            }
        }
        oTrash = GetNextObjectInArea(GetArea(oWP));
    }
}

object CopyPlaceable(object oSource, location locLocation, string sNewTag = "")
{
    //get info from source placeable
    string sName = GetName(oSource);
    string sTag = ( sNewTag == "" ? GetTag(oSource) : sNewTag);
    //int iAppearance = GetItemAppearance(oSource, ITEM_APPR_TYPE_SIMPLE_MODEL, 0); //As of 1.68, can not set placeable appearance
    int iPlot = GetPlotFlag(oSource);
    int iUseable = GetUseableFlag(oSource);
    int iHasInventory = GetHasInventory(oSource);
    //int iStatic =
    int iHardness = GetHardness(oSource);
    int iHitPoints = GetMaxHitPoints(oSource);
    int iFortitude = GetFortitudeSavingThrow(oSource);
    int iReflex = GetReflexSavingThrow(oSource);
    int iWill = GetWillSavingThrow(oSource);

    int iLocked = GetLocked(oSource);
    int iRelock = GetLockLockable(oSource);
    //int iRemoveKey =
    int iKeyRequired = GetLockKeyRequired(oSource);
    int iOpenDC = GetLockUnlockDC(oSource);
    int iCloseDC = GetLockLockDC(oSource);
    string sKeyTag = GetLockKeyTag(oSource);

    int iTrapped = GetIsTrapped(oSource);
    int iTrapType = GetTrapBaseType(oSource);
    int iDetectDC = GetTrapDetectDC(oSource);
    int iDisarmDC = GetTrapDisarmDC(oSource);
    int iOneShot = GetTrapOneShot(oSource);
    int iDetectable = GetTrapDetectable(oSource);
    int iDisarmable = GetTrapDisarmable(oSource);
    int iRecoverable = GetTrapRecoverable(oSource);
    string sTrapKey = GetTrapKeyTag(oSource);
    int iActive = GetTrapActive(oSource);
    //string sOnDisarmScript =
    //string sOnTrapTriggeredScript =
    //int iSetDC =
    //int iDetectDCModWhenSetByRogue =
    //int iDisarmDCModWhenSetByRogue =

/*
    string sOnClick =
    string sOnClose =
    string sOnDamaged =
    string sOnDeath =
    string sOnHeartbeat =
    string sOnHeartbeat =
    string sOnDisturbed =
    string sOnLock =
    string sOnPhysicallyAttacked =
    string sOnOpen =
    string sOnSpellCastAt =
    string sOnUnlock =
    string sOnUsed =
    string sOnUserDefined =
*/
    string sResref = GetResRef(oSource);
    //string sFaction =
    //string sConversation =
    //int iNoInterrupt =
    int iPortrait = GetPortraitId(oSource);
    string sPortrait = GetPortraitResRef(oSource);
    int iInitialState = GetIsOpen(oSource);
    //int iTreasureModel =

    //Variables =

    //string sDescription =
    //string sComments =


    //Create new placeable

    object oNew = CreateObject(OBJECT_TYPE_PLACEABLE, sResref, locLocation, FALSE, sTag);
    SetName(oNew, sName);
    SetPlotFlag(oNew, iPlot);
    SetUseableFlag(oNew, iUseable);
    SetHardness(iHardness, oNew);

    //hp
    int iNewHP = GetCurrentHitPoints(oNew);
    effect eTHP = EffectTemporaryHitpoints(iHitPoints - iNewHP);
    effect eDam = EffectDamage(iNewHP - iHitPoints);

    effect eHP = (iNewHP < iHitPoints ? eTHP : eDam);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHP, oNew);
    //hp

    SetFortitudeSavingThrow(oNew, iFortitude);
    SetReflexSavingThrow(oNew, iReflex);
    SetWillSavingThrow(oNew, iWill);

    //inventory
    object oItem = GetFirstItemInInventory(oSource);
    object oBagItem, oNewItem;

    //First, find the bags and set any items in them to copied, as the items will be copied with the bags.
    //remember, bags within bags is a bad thing.

    while (GetIsObjectValid(oItem))
    {
        if (GetHasInventory(oItem))
        {
            oBagItem = GetFirstItemInInventory(oItem);
            while(GetIsObjectValid(oBagItem))
            {
                if(!GetHasInventory(oBagItem))
                {
                    // item in the bag got copied with the bag
                    SetLocalInt(oBagItem, "copied", 1);//set to copied
                }

                // Next item
                oBagItem = GetNextItemInInventory(oItem);
            }
            //copy the bag itself (items inside come with)
            CopyObject(oItem, GetLocation(oNew), oNew);
        }
        oItem = GetNextItemInInventory(oSource);
    }

    oItem = GetFirstItemInInventory(oSource);
    //Copy the rest if the items into the new placeable
    int iCopy;
    while (GetIsObjectValid(oItem))
    {
        // Copy the item into the new placeable if not already copied
        // containers and their inventories have already been copied,
        // so ignore them
        if(!GetHasInventory(oItem))
        {
            iCopy = GetLocalInt(oItem, "copied");
            if(iCopy != 1)
            {
                oNewItem = CopyItem(oItem, oNew, TRUE);
            }
        }
        DeleteLocalInt(oNewItem, "copied");  //don't need these anymore

        // Next item
        oItem = GetNextItemInInventory(oSource);
    }
    //inventory

    SetLocked(oNew, iLocked);
    SetLockLockable(oNew, iRelock);

    SetLockKeyRequired(oNew, iKeyRequired);
    SetLockUnlockDC(oNew, iOpenDC);
    SetLockLockDC(oNew, iCloseDC);
    SetLockKeyTag(oNew, sKeyTag);

    //trap
    if(iTrapped)
    {
        CreateTrapOnObject(iTrapType, oNew/*,STANDARD_FACTION_HOSTILE, sOnDisarmScript, sOnTrapTriggeredScript*/);
        SetTrapDetectDC(oNew, iDetectDC);
        SetTrapDisarmDC(oNew, iDisarmDC);
        SetTrapOneShot(oNew, iOneShot);
        SetTrapDetectable(oNew, iDetectable);
        SetTrapDisarmable(oNew, iDisarmable);
        SetTrapRecoverable(oNew, iRecoverable);
        SetTrapKeyTag(oNew, sTrapKey);
        SetTrapActive(oNew, iActive);
    }
    //trap

    //faction
    ChangeFaction(oNew, oSource);
    //faction

    if(sPortrait == "") SetPortraitId(oNew, iPortrait);
    else SetPortraitResRef(oNew, sPortrait);

    if(iInitialState && GetObjectType(oNew) == OBJECT_TYPE_DOOR) AssignCommand(oNew, ActionOpenDoor(oNew));

    //variables
    //variables

    //description
    //description

    //comments
    //comments
    return oNew;
}

//for compilation testing
/*
void main(){}
*/
