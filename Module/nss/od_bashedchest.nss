//od_bashedchest - Same as X0_I0_TREASURE except higher chance of gold
// and less chance for multiple items


//:://////////////////////////////////////////////////
//:: X0_I0_TREASURE

/*
Include library for XP1 treasure generation system.

--------------------------------------------------

MAIN CONCEPT:

The module builder creates some base containers and fills them
with instances of the treasure items that s/he wants to appear
randomly. The actual treasure containers then randomly pick from
the contents of these base containers to generate their own
contents.

--------------------------------------------------

SETUP:

Create four module-wide base containers (for low, medium, high,
and unique treasure items) and place them anywhere in your
module. Make sure that they are in locations inaccessible to the
players, though!

Give these module-wide base containers these tags (or just use the
blueprints):

    X0_MOD_TREASURE_LOW       - low-level treasure
    X0_MOD_TREASURE_MED       - medium-level treasure
    X0_MOD_TREASURE_HIGH      - high-level treasure
    X0_MOD_TREASURE_UNIQ      - unique treasure items

Fill the instances of these base containers with appropriate treasure
for your module.

For any areas where you want finer control over the treasure,
simply create additional base containers (you don't need all four
-- any one that you skip will fall back to the module-wide version)
and place them in the area. Give them these tags (same just without
the "MOD"):

    X0_TREASURE_LOW       - low-level treasure
    X0_TREASURE_MED       - medium-level treasure
    X0_TREASURE_HIGH      - high-level treasure
    X0_TREASURE_UNIQ      - unique treasure items

For any treasure container, use one of the following scripts
as BOTH the OnOpen/OnDeath handler:

Any Treasure: x0_o2_any{low,med,high,uniq}
Books (book, scroll): x0_o2_book{low,med,high,uniq}
Potions: x0_o2_potn{low,med,high,uniq}
Armor (armor, shield, helm, boots, etc): x0_o2_arm{low,med,high,uniq}
Weapon: x0_o2_weap{low,med,high,uniq}
Gold: x0_o2_gold{low,med,high,uniq}

Others may also be added.

MONSTER/NPC TREASURE
--------------------
If you would like to have special monster treasure (monster treasure
defaults to low treasure otherwise), you can also add any of these
base chests:

X0_TREASURE_MONSTER_<monster tag> - treasure found on monsters with
                                    the given tag. This will strip off
                                    any trailing digits, so for instance,
                                    NW_KOBOLD1, NW_KOBOLD2, NW_KOBOLD005
                                    would all end up checking the chest
                                    X0_TREASURE_MONSTER_NW_KOBOLD.

X0_TREASURE_MONSTER_<racialtype> - treasure found on monsters of the given
                                   racialtype. Ex:
                                   X0_TREASURE_MONSTER_ELF
                                   X0_TREASURE_MONSTER_UNDEAD
                                   The spelling matches that used in the
                                   RACIALTYPE_* constants.

X0_TREASURE_MONSTER       - generic treasure found on all monsters/NPCs
                            in the module.

To use monster treasure, use the default OnSpawn script nw_c2_default9
or modify the OnSpawn script as follows:

- Replace #include "nw_o2_coninclude" with #include "x0_i0_treasure"
- Replace GenerateNPCTreasure(); with CTG_GenerateNPCTreasure();
- If you prefer to generate monster treasure from the general chests,
  you can also add a parameter to CTG_GenerateNPCTreasure(); to
  specify whether the treasure generated should be low/medium/high/uniq.
  See the comments to that function for details.

--------------------------------------------------

DETAILS:

Each treasure container has a script that looks for the
nearest object with the tag matching the type of
treasure.

When the treasure-generating scripts look for a container,
they will take the nearest container in the local area, then
fall back to the module-wide container. If no container can
be found, they will fall back on the standard random treasure
generation system.

The treasure generation system will randomly select from
1-3 items from whatever items are in the nearest container.
Each item has a 50/50 chance of being replaced by a random
amount of coin based on the standard treasure generation
system.

IMPORTANT NOTE ON PROBABILITY:
Each item in the chest has an equal probability of being
selected. To control the probability of any given item
appearing, simply place multiple copies of it in the container.

Because of the stacking rules, there is a slight modification
to this. Ammunition/throwing weapons will have a probability
equal to the number of stacks in the chest, since the max stack
size is the default stack size. Potions, scrolls, and gems, however,
will be counted individually to determine the probability even if
they are stacked, since their default stack size is 1.

To control the size of the stack that actually gets created, you
should create a blueprint that has the appropriate stack size.
You can adjust the stack size of the instance you stuff into the
base container to whatever you want afterwards; the blueprint's
stack size will control what

There are scripts that will cause only specific types of items
to be selected from the container of the specified level --
eg, only books/scrolls, or only weapons or armor, etc -- useful
for bookcases or for weapon racks, & so on.

The unique treasure chest will only place each item in the
chest once, will never place more than one item, and will
never replace the item with coin.

Advantages of this system:
- Complete control over which items can appear in a
  module or in an area.

- Thematically-appropriate treasure can be placed in each
  area.

- Easy for module builders to set up.

- Trivial to add new items to the treasure distribution.

- Trivial to adjust probabilities of items appearing.

- Easy to have unique treasure items showing up randomly.

Disadvantages of this system:
- No level-specific treasure generation. This system is thus
  NOT appropriate for an area that is intended to scale to
  radically-different levels. Rather, it is appropriate for
  use where the levels of the characters are roughly known
  to the module designer and the treasure can be designed to
  match.

- No class-specific treasure generation planned for now.
  (However, I may add something to increase probability of
  certain items popping up, optionally. TBD.)

For XP1, we feel this is a good tradeoff, but this should
be kept in mind when deciding whether to use this system or
the original treasure generation system in user-made modules.

-- NN



*******************************************************
THE FOLLOWING ARE THE ENHANCEMENTS / CHANGES by DrDread
*******************************************************

The original code handles random loot in a horrible way.
It also uses the old method of for generating Gold when the need
arises which is quite bad. In my opinion this code was never completed by Bioware
yet the fundamental system is a very good one! I have made the following
fixes changes to the code. Have fun and beware of Dragons!

-   Items are 100% random now, a count of each item type is kept track of
    and then used as the basis for the random instance of that type of
    to be pulled when scaning the chest. Putting duplicates of an item in a chest
    will of course increase the chances of it being pulled as normal

-   The Gold creating function has been overhauled. The "average" amount of Gold
    generated can now be set for the 3 levels of treasure (Low, Medium, High) as well
    as the percentage of randomness the actual amount can stray from the average.
    Gold for Monster type chests can be set as an average amount PER HITDICE of the monster slain
    and uses the same random percentage as the others. The constants for all these can be
    found below the others, they are called:

        TREASURE_TYPE_GOLD_LOW
        TREASURE_TYPE_GOLD_MED
        TREASURE_TYPE_GOLD_HIGH
        TREASURE_TYPE_GOLD_MONSTER
        TREASURE_TYPE_GOLD_RANGE


-   If an item is dupped and converted to gold when rolling a chest, its GP value is used as originaly
    intended instead of a call to the old gold system. The Multiplyer variable in
    the code now acts as it should (X0_GOLD_MODIFIER). This only really applies to the "ANY" type of
    chests and Monster loot however. Specific Item type chests like Armor or Potion
    will ONLY convert items to gold if a dup item is generated, the probability chance is ignored
    for those chests (who finds gold in a weapon rack anyway?).
    You can always set these values to 0.0 and place gold in the chest as loot to control
    The amount to be dropped, making different size stacks in the palletre as described above

-   A Respawn timer variable has been added. Respawning destroyed chests was never
    implemented from Bioware, so I did. This will set the time before the chest
    will spawn more loot or recreate itself after being destroyed, it's called

        TREASURE_RESPAWN_TIMER

    If you don't want your treasure to respawn, set it to 0.0

-   Certain stackable loot (Potions, Scrolls, Gems, Kits) have been set to spawn
    a certain stack when they are chosen as opposed to just one.
    The Maximum amount found at once is controlled by a constant named MAX_STACK_SIZE
    What is stacked this way is controlled by the fGetIsStackable function

TECHNICAL:

-   Modified CTG_GetSpecificBaseTypeTreasureItem() function to scan from the beggining
    of the "array" but looking for the Random(Count) instance of that type of item
    The count, if non-existant, is initilized by scanning the whole array for that type
    and setting it as a variable on the chest, done only once per type.

-   Moved the long "BaseItemType" if/then block into its own function called
    fCheckForBaseType since it is now used to check for appropiate items as
    well as for generating a "count" of a particular item type when needed.

-   Added a few functions to handle the destruction and respawn of the chests
    without interfering with the original flow of the Bioware code
    When loot scripts are fired a call is made to fRespawnCheck.
    It uses the standard Invisible Object as a placeholder until the respawn
    timer is up and recreates the placeable in the same location using the
    resref and its original TAG if it was different. Works for any placeable
    by the way.

-   Added several Constants to handle features. Names have been stated above


 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/16/2002
//:://////////////////////////////////////////////////

// For legacy treasure generation
#include "nw_o2_coninclude"

/**********************************************************************
 * CONSTANTS
 **********************************************************************/

// * this is the percent chance that no treasure will be spawned by a creature dying
const int BK_CHANCE_OF_N0_MONSTERTREASURE = 75;

// Tag for sub-treasure container prefix and placeholder item suffix
string sSubTreasure     =     "X0_SUBTREASURE_";
string sSubTreasureItem =     "_ITEM";

// Tags for the module-wide containers
string sModContLow  =     "X0_MOD_TREASURE_LOW";
string sModContMed  =     "X0_MOD_TREASURE_MED";
string sModContHigh =     "X0_MOD_TREASURE_HIGH";
string sModContUniq =     "X0_MOD_TREASURE_UNIQ";

// Tags for the area-specific containers
string sContLow  =     "X0_TREASURE_LOW";
string sContMed  =     "X0_TREASURE_MED";
string sContHigh =     "X0_TREASURE_HIGH";
string sContUniq =     "X0_TREASURE_UNIQ";

// Tag for the monster-specific containers
string sContMonster =     "X0_TREASURE_MONSTER";

// Gold item ResRef
string sGoldResRef = "NW_IT_GOLD001";

// Varname holding the number of treasure items
string sNumTreasureItemsVarname = "X0_NUM_TREASURE_ITEMS";

// Varname holding the base type of each treasure item
string sBaseTypeVarname = "X0_BASE_TYPE_TREASURE";

// Varname holding a reference to each treasure item
string sTreasureItemVarname = "X0_TREASURE_ITEM";

// Varname indicating that the treasure container has been filled
string sTreasureGeneratedVarname = "X0_TREASURE_HAS_BEEN_GENERATED";


// Major treasure categories

int TREASURE_TYPE_LOW    = 1;
int TREASURE_TYPE_MED    = 2;
int TREASURE_TYPE_HIGH   = 3;
int TREASURE_TYPE_UNIQUE = 4;
int TREASURE_TYPE_MONSTER = 5;


// Special generalized base types.
// Giving these large values to make sure they never
// conflict with the actual base type values -- that
// would cause those base types to be non-specifiable.
int TREASURE_BASE_TYPE_WEAPON = 13000;
int TREASURE_BASE_TYPE_WEAPON_NOAMMO = 13001;
int TREASURE_BASE_TYPE_WEAPON_RANGED = 13002;
int TREASURE_BASE_TYPE_WEAPON_MELEE = 13003;
int TREASURE_BASE_TYPE_ARMOR = 13004;
int TREASURE_BASE_TYPE_CLOTHING = 13005;

// Probability of a single item being generated,
// in percentage
int TREASURE_PROBABILITY_1 = 95;

// Probability of two items being generated,
// in percentage
int TREASURE_PROBABILITY_2 = 10;

// Probability of an item being converted to gold
int TREASURE_GOLD_PROBABILITY = 50;

// Probability of an item being converted to gold For monsters
// Otherwise only gold on dup items
int TREASURE_MONSTER_GOLD_PROBABILITY = 50;

// Average amount of gold per type
// TREASURE_TYPE_GOLD_RANGE is random percentage of the average in either direction (+/-)
// that will actually be dispensed
// Example: if average is 100 gold at RANGE 50 the possibility is 50-150gp
// TREASURE_TYPE_GOLD_MONSTER is average amount PER HD of the monster killed
int TREASURE_TYPE_GOLD_LOW     = 100;
int TREASURE_TYPE_GOLD_MED     = 1000;
int TREASURE_TYPE_GOLD_HIGH    = 10000;
int TREASURE_TYPE_GOLD_MONSTER = 10;    // Per HitDice
int TREASURE_TYPE_GOLD_RANGE   = 50;    // Percentage Random (1-100 only)

// Multiplier to use on the value of an item to convert it to gold
float X0_GOLD_MODIFIER = 0.50;

// Respawn Timer for Chest
float TREASURE_RESPAWN_TIMER = 900.0;

// Max Stack size for certain type of loot (potions, Gems, Kits, Scrolls)
// Determined from fGetIsStackable function
int MAX_STACK_SIZE = 1;


/**********************************************************************
 * FUNCTION PROTOTYPES
 *
 * All functions prefixed with CTG for "container treasure generation".
 **********************************************************************/

// Get the number of items to generate
// Returns an integer from 1-3, probabilities
// determined by the values of the constants
// TREASURE_PROBABILITY_1 & _2.
int CTG_GetNumItems();

// Get the number of items in a base container.
int CTG_GetNumItemsInBaseContainer(object oBaseCont);

// Determine whether an item should actually just be gold.
// Returns TRUE or FALSE.
// Probability controlled by constant TREASURE_GOLD_PROBABILITY
int CTG_IsItemGold(int iType=0);

// Find and return the right monster container, if
// available.
object CTG_GetMonsterBaseContainer(object oSource=OBJECT_SELF);

// Locate the base container of the appropriate type closest to
// oSource.
// Possible values for nTreasureType:
//     TREASURE_TYPE_LOW
//     TREASURE_TYPE_MED
//     TREASURE_TYPE_HIGH
//     TREASURE_TYPE_UNIQUE
object CTG_GetNearestBaseContainer(int nTreasureType, object oSource=OBJECT_SELF);

// Get the module-wide base container of the appropriate type.
// Possible values for nTreasureType:
//     TREASURE_TYPE_LOW
//     TREASURE_TYPE_MED
//     TREASURE_TYPE_HIGH
//     TREASURE_TYPE_UNIQUE
object CTG_GetModuleBaseContainer(int nTreasureType);

// Get the specified item out of the given base container's inventory
object CTG_GetTreasureItem(object oBaseCont, int nItemNum);

// Return random item from specified subtreasure container
object CTG_GetSubTreasureItem(object oItem, int count=1);

// Test if treasure has been generated in the given object
int CTG_GetIsTreasureGenerated(object oCont);

// Set whether treasure has been generated
void CTG_SetIsTreasureGenerated(object oCont, int bGenerated=TRUE);

// Create random treasure items of the appropriate type
// in the specified container. Will typically be called
// by a script on a treasure container.
//
// Possible values for nTreasureType:
//     TREASURE_TYPE_LOW
//     TREASURE_TYPE_MED
//     TREASURE_TYPE_HIGH
//     TREASURE_TYPE_UNIQUE
void CTG_CreateTreasure(int nTreasureType, object oAdventurer, object oCont=OBJECT_SELF);

// Starting from the specified item position, return the first
// item that matches one of the three base types.
//
// nBaseType1 may also be passed in as a special custom type,
// which will OVERRIDE any other specified base types:
//
//  TREASURE_BASE_TYPE_WEAPON (for any weapon type)
//  TREASURE_BASE_TYPE_WEAPON_NOAMMO (for any weapon but ammunition)
//  TREASURE_BASE_TYPE_WEAPON_RANGED (for any ranged weapon)
//  TREASURE_BASE_TYPE_WEAPON_MELEE (for any melee weapon)
//  TREASURE_BASE_TYPE_ARMOR (for armor, shields)
//  TREASURE_BASE_TYPE_CLOTHING (for belts, boots, bracers,
//                              cloaks, helms, gloves)
object CTG_GetSpecificBaseTypeTreasureItem(object oBaseCont, int nItemNum, int nBaseType1=BASE_ITEM_INVALID, int nBaseType2=BASE_ITEM_INVALID, int nBaseType3=BASE_ITEM_INVALID);


// Create treasure of the appropriate treasure level and matching one
// of up to three different base types in the specified container.
//
// Possible values for nTreasureType:
//     TREASURE_TYPE_LOW
//     TREASURE_TYPE_MED
//     TREASURE_TYPE_HIGH
//     TREASURE_TYPE_UNIQUE
//
// Possible values for nBaseType1/2/3: any BASE_ITEM_* constant.
//
// If nBaseType1 is passed in as invalid, NO TYPE CHECKING WILL BE DONE.
//
// nBaseType1 may also be passed in as a special custom type,
// which will OVERRIDE any other specified base types:
//
//  TREASURE_BASE_TYPE_WEAPON (for any weapon type)
//  TREASURE_BASE_TYPE_WEAPON_NOAMMO (for any weapon but ammunition)
//  TREASURE_BASE_TYPE_WEAPON_RANGED (for any ranged weapon)
//  TREASURE_BASE_TYPE_WEAPON_MELEE (for any melee weapon)
//  TREASURE_BASE_TYPE_ARMOR (for armor, shields)
//  TREASURE_BASE_TYPE_CLOTHING (for belts, boots, bracers,
//                              cloaks, helms, gloves)
//
void CTG_CreateSpecificBaseTypeTreasure(int nTreasureType, object oAdventurer, object oCont, int nBaseType1=BASE_ITEM_INVALID, int nBaseType2=BASE_ITEM_INVALID, int nBaseType3=BASE_ITEM_INVALID);

// Create gold treasure in the specified container.
void CTG_CreateGoldTreasure(int nTreasureType, object oAdventurer, object oCont=OBJECT_SELF, object oItem=OBJECT_INVALID);

// Create treasure on an NPC.
// This function will typically be called from within the
// NPC's OnSpawn handler.
// Note that this defaults to TREASURE_TYPE_MONSTER, which uses
// the monster-specific treasure chests and falls back to low-
// level treasure if none exist.
void CTG_GenerateNPCTreasure(int nTreasureType=5, object oNPC=OBJECT_SELF);

// Check if the item's base type is of the given base type
int CTG_GetIsBaseType(int nItemBaseType, int nBaseType1=BASE_ITEM_INVALID, int nBaseType2=BASE_ITEM_INVALID, int nBaseType3=BASE_ITEM_INVALID);

// Check if the item's base type is a weapon
int CTG_GetIsWeapon(int nItemBaseType);

// Check if the item's base type is a weapon but not ammunition
int CTG_GetIsWeaponNoammo(int nItemBaseType);

// Check if the item's base type is a ranged weapon
int CTG_GetIsRangedWeapon(int nItemBaseType);

// Check if the item's base type is a melee weapon
int CTG_GetIsMeleeWeapon(int nItemBaseType);

// Check if the item's base type is armor
int CTG_GetIsArmor(int nItemBaseType);

// Check if the item's base type is clothing
int CTG_GetIsClothing(int nItemBaseType);

// Tack on the appropriate racialtype suffix
string CTG_GetRacialtypeChestTag(string sBaseTag, object oSource);

/**********************************************************************
 * PRIVATE FUNCTION DEFINITIONS
 * These functions are deliberately not prototyped and not intended
 * for use outside this library.
 **********************************************************************/


// DrDread Function block

int fGetIsStackable(object oNewItem)
    {
    int iType = GetBaseItemType(oNewItem);
    if (iType==BASE_ITEM_GEM || iType==BASE_ITEM_SPELLSCROLL || iType==BASE_ITEM_POTIONS ||
        iType==BASE_ITEM_HEALERSKIT || iType==BASE_ITEM_SCROLL)
        {
        return TRUE;
        }
    return FALSE;
    }


void fCreatePlaceable(string sResRef, string sTag, location lLocation, int iCreate=0)
    {
    if (iCreate==1)
        {
        CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLocation, TRUE, sTag);
        DelayCommand(0.5, SetPlotFlag(OBJECT_SELF, FALSE));
        DelayCommand(1.0, DestroyObject(OBJECT_SELF));
        }
    else
        {
        DelayCommand(TREASURE_RESPAWN_TIMER, fCreatePlaceable(sResRef, sTag, lLocation, 1));
        }

    }


void fReSpawnPlaceable(string sResRef, string sTag, location lLocation)
    {
    object oHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation);
    SetPlotFlag(oHolder, TRUE);
    AssignCommand(oHolder, fCreatePlaceable(sResRef, sTag, lLocation));

    }

void fRespawnCheck(object oCont)
    {

    // Respawn Timer
    if (TREASURE_RESPAWN_TIMER!=0.0)
        {
        if (GetObjectType(oCont)==OBJECT_TYPE_PLACEABLE && GetCurrentHitPoints(oCont)<=0 && GetLocalInt(oCont, "RESPAWN_ONCE")==0)
            {
            SetLocalInt(oCont, "RESPAWN_ONCE",1);
            AssignCommand(GetModule(), fReSpawnPlaceable(GetResRef(oCont), GetTag(oCont), GetLocation(oCont)));
            }
        else
            {
            DelayCommand(TREASURE_RESPAWN_TIMER, CTG_SetIsTreasureGenerated(oCont, FALSE));
            }
        }
    }


// This function deliberately not prototyped. Should not be used
// outside this library.
// Test whether a treasure container has been initialized for
// specific base treasure type use.
int CTG_GetIsContainerInitialized(object oBaseCont)
{
    return GetLocalInt(oBaseCont, "X0_CONTAINER_INITIALIZED");
}

// This function deliberately not prototyped. Should not be used
// outside this library.
// Set whether a treasure container has been initialized for
// specific base treasure type use.
void CTG_SetIsContainerInitialized(object oBaseCont, int bInit=TRUE)
{
    SetLocalInt(oBaseCont, "X0_CONTAINER_INITIALIZED", bInit);
}

// This function deliberately not prototyped. Should not be used
// outside this library.
// Initialize a treasure container to store the items contained
// inside as local variables on the container.
void CTG_InitContainer(object oBaseCont)
{
    // don't do this twice
    if (CTG_GetIsContainerInitialized(oBaseCont)) return;

    // initialize
    int nItems = CTG_GetNumItemsInBaseContainer(oBaseCont);

    int i;
    object oTmp = OBJECT_INVALID;
    oTmp = GetFirstItemInInventory(oBaseCont);
    for (i=0; i < nItems && GetIsObjectValid(oTmp); i++) {
        // Store the item and its base type as local vars on
        // the container object itself.
        string sIndex = IntToString(i);
        string sVar = sBaseTypeVarname + sIndex;

        SetLocalInt(oBaseCont, sVar, GetBaseItemType(oTmp));
        sVar = sTreasureItemVarname + sIndex;
        SetLocalObject(oBaseCont, sVar, oTmp);

        oTmp = GetNextItemInInventory(oBaseCont);
    }

    // mark as initialized
    CTG_SetIsContainerInitialized(oBaseCont);
}


/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

// Get the number of items to generate
// Returns an integer from 1-3, probabilities
// determined by the values of the constants
// TREASURE_PROBABILITY_1 & _2.
int CTG_GetNumItems()
{
    int nRoll = d100();

    if (nRoll < TREASURE_PROBABILITY_1) {
        return 1;
    } else if (nRoll < (TREASURE_PROBABILITY_1 + TREASURE_PROBABILITY_2)) {
        return 2;
    }
    return 3;
}


// Get the number of items in a base container
int CTG_GetNumItemsInBaseContainer(object oBaseCont)
{
    int nItems = GetLocalInt(oBaseCont, sNumTreasureItemsVarname);
    if (nItems != 0) {
        return nItems;
    }

    // Haven't initialized the number of items yet
    object oTmp = GetFirstItemInInventory(oBaseCont);
    while (GetIsObjectValid(oTmp)) {
        nItems++;
        oTmp = GetNextItemInInventory(oBaseCont);
    }
    SetLocalInt(oBaseCont, sNumTreasureItemsVarname, nItems);
    return nItems;
}


// Determine whether an item should actually just be gold.
// Returns TRUE or FALSE.
// Probability controlled by constant TREASURE_GOLD_PROBABILITY
int CTG_IsItemGold(int iType = 0)
{
    int nRoll = d100();
    int iRandom;

    if (iType==1)
        {
        if (nRoll < TREASURE_MONSTER_GOLD_PROBABILITY)
            return TRUE;
        }
    else
        {
        if (nRoll < TREASURE_GOLD_PROBABILITY)
            return TRUE;
        }
    return FALSE;
}

int GetIsInteger(string sChar)
{
    return (sChar == "0"
            || sChar == "1"
            || sChar == "2"
            || sChar == "3"
            || sChar == "4"
            || sChar == "5"
            || sChar == "6"
            || sChar == "7"
            || sChar == "8"
            || sChar == "9");
}

// Find and return the right monster container, if
// available.
object CTG_GetMonsterBaseContainer(object oSource=OBJECT_SELF)
{
    object oCont = OBJECT_INVALID;
    string sContTag = "";

    // For monster treasure, we first check for
    // a chest with a tag matching the specific
    // monster.
    // We strip numbers off the end of the tag first
    string sCreatureTag = GetTag(oSource);
    while ( GetIsInteger(GetStringRight(sCreatureTag, 1)) ) {
        sCreatureTag = GetStringLeft(sCreatureTag,
                                     GetStringLength(sCreatureTag)-1);
    }

    sContTag = sContMonster + "_" + sCreatureTag;
    oCont = GetObjectByTag(sContTag);
    if (GetIsObjectValid(oCont)) {
        return oCont;
    }

    // Didn't find that -- check for a chest for the
    // appropriate racialtype.
    sContTag = CTG_GetRacialtypeChestTag(sContMonster, oSource);
    oCont = GetObjectByTag(sContTag);
    if (GetIsObjectValid(oCont)) {
        return oCont;
    }

    // Didn't find that -- check for a module-wide
    // monster chest
    oCont = GetObjectByTag(sContMonster);
    return oCont;
}


// Locate the nearest base container of the appropriate type.
// Possible values for nTreasureType:
//     TREASURE_TYPE_MONSTER
//     TREASURE_TYPE_LOW
//     TREASURE_TYPE_MED
//     TREASURE_TYPE_HIGH
//     TREASURE_TYPE_UNIQUE
object CTG_GetNearestBaseContainer(int nTreasureType,
                                   object oSource=OBJECT_SELF)
{
    object oCont = OBJECT_INVALID;
    int nType = nTreasureType;
    string sContTag = "";

    if (nType == TREASURE_TYPE_MONSTER) {
        oCont = CTG_GetMonsterBaseContainer(oSource);
        if (GetIsObjectValid(oCont))
            return oCont;

        // no monster-specific treasure set up
        nType = TREASURE_TYPE_LOW;
    }

    if (nType == TREASURE_TYPE_LOW) {
        sContTag = sContLow;
    } else if (nType == TREASURE_TYPE_MED) {
        sContTag = sContMed;
    } else if (nType == TREASURE_TYPE_HIGH) {
        sContTag = sContHigh;
    } else if (nType == TREASURE_TYPE_UNIQUE) {
        sContTag = sContUniq;
    } else {
        // Invalid treasure type
        return oCont;
    }

    oCont = GetNearestObjectByTag(sContTag);
    if (!GetIsObjectValid(oCont)) {
        // No area chest -- return the module-wide one
        return CTG_GetModuleBaseContainer(nType);
    }
    return oCont;
}

// Get the module-wide base container of the appropriate type.
// Possible values for nTreasureType:
//     TREASURE_TYPE_LOW
//     TREASURE_TYPE_MED
//     TREASURE_TYPE_HIGH
//     TREASURE_TYPE_UNIQUE
object CTG_GetModuleBaseContainer(int nTreasureType)
{
    object oCont = OBJECT_INVALID;
    string sContTag = "";

    if (nTreasureType == TREASURE_TYPE_LOW) {
        sContTag = sModContLow;
    } else if (nTreasureType == TREASURE_TYPE_MED) {
        sContTag = sModContMed;
    } else if (nTreasureType == TREASURE_TYPE_HIGH) {
        sContTag = sModContHigh;
    } else if (nTreasureType == TREASURE_TYPE_UNIQUE) {
        sContTag = sModContUniq;
    } else {
        // Invalid treasure type
        return oCont;
    }

    oCont = GetObjectByTag(sContTag);
    return oCont;
}


// Generate treasure using default method.
// Not prototyped -- this function should not be used outside
// this library.
void CTG_CreateDefaultTreasure(int nTreasureType, object oAdventurer, object oCont)
{
    // generate treasure using default method from nw_o2_coninclude
    if (nTreasureType == TREASURE_TYPE_LOW) {
        GenerateLowTreasure(oAdventurer, oCont);
    } else if (nTreasureType == TREASURE_TYPE_MED) {
        GenerateMediumTreasure(oAdventurer, oCont);
    } else if (nTreasureType == TREASURE_TYPE_HIGH) {
        GenerateHighTreasure(oAdventurer, oCont);
    } else if (nTreasureType == TREASURE_TYPE_UNIQUE) {
        GenerateBossTreasure(oAdventurer, oCont);
    }
}

// Get the specified item out of the given base container's inventory
object CTG_GetTreasureItem(object oBaseCont, int nItemNum)
{
    if (!GetIsObjectValid(oBaseCont)) {return OBJECT_INVALID;}

    // initialize the container -- this will automatically
    // only happen once.
    CTG_InitContainer(oBaseCont);

    // Refs to the items are stored on the container itself
    string sVar = sTreasureItemVarname + IntToString(nItemNum);
    return GetLocalObject(oBaseCont, sVar);
}

int fCheckForBaseType(int nBaseType1, int nBaseType2, int nBaseType3, int nItemBaseType)
{
  if (
    // Check for a weapon
    (nBaseType1 == TREASURE_BASE_TYPE_WEAPON
     &&
     CTG_GetIsWeapon(nItemBaseType))
    ||
    // non-ammo weapon
    (nBaseType1 == TREASURE_BASE_TYPE_WEAPON_NOAMMO
     &&
     CTG_GetIsWeaponNoammo(nItemBaseType))
    ||
    // ranged weapon
    (nBaseType1 == TREASURE_BASE_TYPE_WEAPON_RANGED
     &&
     CTG_GetIsRangedWeapon(nItemBaseType))
    ||
    // melee weapon
    (nBaseType1 == TREASURE_BASE_TYPE_WEAPON_MELEE
     &&
     CTG_GetIsMeleeWeapon(nItemBaseType))
    ||
    // armor
    (nBaseType1 == TREASURE_BASE_TYPE_ARMOR
     &&
     CTG_GetIsArmor(nItemBaseType))
    ||
    // clothing
    (nBaseType1 == TREASURE_BASE_TYPE_CLOTHING
     &&
     CTG_GetIsClothing(nItemBaseType))
    ||
    // other specific item type
    ( CTG_GetIsBaseType(nItemBaseType,
                        nBaseType1,
                        nBaseType2,
                        nBaseType3))
    ) // end of if statement
        {
        return TRUE;
        }

    return FALSE;
}

// Starting from the specified item position, return the first
// item that matches one of the three base types.
// If nBaseType1 is passed in as invalid, NO TYPE CHECKING WILL BE DONE.
// nBaseType1 may also be passed in as a special custom type:
// TREASURE_BASE_TYPE_WEAPON (for any weapon type)
// TREASURE_BASE_TYPE_WEAPON_NOAMMO (for any weapon but ammunition)
// TREASURE_BASE_TYPE_WEAPON_RANGED (for any ranged weapon)
// TREASURE_BASE_TYPE_WEAPON_MELEE (for any melee weapon)
// TREASURE_BASE_TYPE_ARMOR (for armor, shields)
// TREASURE_BASE_TYPE_CLOTHING (for belts, boots, bracers,
//                              cloaks, helms, gloves)
object CTG_GetSpecificBaseTypeTreasureItem(object oBaseCont,
                                           int nItemNum,
                                           int nBaseType1=BASE_ITEM_INVALID,
                                           int nBaseType2=BASE_ITEM_INVALID,
                                           int nBaseType3=BASE_ITEM_INVALID)
{
    if (!GetIsObjectValid(oBaseCont)) {return OBJECT_INVALID;}

    // initialize the container -- this will automatically
    // only happen once.
    CTG_InitContainer(oBaseCont);

    int nRollOverNum = CTG_GetNumItemsInBaseContainer(oBaseCont);

    // If there are no items in the container, no chance of finding a matching one!
    if (nRollOverNum == 0) return OBJECT_INVALID;

    int i;
    string sVar;
    int nItemBaseType;
    int nLooped = 0;

    // DrDread add-in, prob should of made it a function but eh...
    // Scans the item "array" and sets a count for that item type
    // if needed

    int iTypeCount = GetLocalInt(oBaseCont, "BASE_ITEM_COUNT_" + IntToString(nBaseType1));

    if (iTypeCount==0)
        {
        for (i=0; i<=(nRollOverNum-1); i++)
            {
            sVar = sBaseTypeVarname + IntToString(i);
            nItemBaseType = GetLocalInt(oBaseCont, sVar);

            if (fCheckForBaseType(nBaseType1, nBaseType2, nBaseType3, nItemBaseType))
                {
                iTypeCount++;
                }
            }

        SetLocalInt(oBaseCont, "BASE_ITEM_COUNT_" + IntToString(nBaseType1), iTypeCount);

        }

    int iRandom = Random(iTypeCount);

    //for (i=nItemNum; i != nItemNum || !nLooped ; i++) {
    for (i=0; i<=nRollOverNum-1 ; i++) {

        // The base type of each item is stored on the container itself
        sVar = sBaseTypeVarname + IntToString(i);
        nItemBaseType = GetLocalInt(oBaseCont, sVar);

        if (fCheckForBaseType(nBaseType1, nBaseType2, nBaseType3, nItemBaseType))
            {
                // we found a matching item -- return it
                if (iRandom==0)
                    {
                    return CTG_GetTreasureItem(oBaseCont, i);
                    }
                else
                    {
                    iRandom--;
                    }

            }

        // Handle the wrap-around case
        /*
        if ( (i+1) == nRollOverNum ) {
            // set i back to 0
            i = -1;
            nLooped = 1;

        }
        */
    }

    // No matching item was found -- return null
    return OBJECT_INVALID;
}

// Return random item from specified subtreasure container
object CTG_GetSubTreasureItem(object oItem, int count=1)
{
    // first get tag of subtreasure container
    string sSubCont = GetStringLeft(GetTag(oItem),
        GetStringLength(GetTag(oItem)) - GetStringLength(sSubTreasureItem));
    // get nearest subtreasure container (or globally if not in this area)
    object oSubCont = GetNearestObjectByTag(sSubCont);
    if (!GetIsObjectValid(oSubCont)) oSubCont = GetObjectByTag(sSubCont);
    if (!GetIsObjectValid(oSubCont)) return OBJECT_INVALID;

    int nItemsInSubCont = CTG_GetNumItemsInBaseContainer(oSubCont);
    int nRandom = Random(nItemsInSubCont);
    oItem = CTG_GetTreasureItem(oSubCont, nRandom);

    // recursively check for subtreasure item?
    if (TestStringAgainstPattern(sSubTreasure+"**"+sSubTreasureItem, GetTag(oItem))) {
        if (count < 3) oItem = CTG_GetSubTreasureItem(oItem, count+1);
        else oItem = OBJECT_INVALID;
    }

    return oItem;
}

// Test if treasure has been generated in the given object
int CTG_GetIsTreasureGenerated(object oCont)
{
    return GetLocalInt(oCont, sTreasureGeneratedVarname);
}

// Set whether treasure has been generated
void CTG_SetIsTreasureGenerated(object oCont, int bGenerated=TRUE)
{
    SetLocalInt(oCont, sTreasureGeneratedVarname, bGenerated);
}

// Create random treasure items of the appropriate type
// in the specified container. Should be called
// by a script on a treasure container.
//
// Possible values for nTreasureType:
//     TREASURE_TYPE_LOW
//     TREASURE_TYPE_MED
//     TREASURE_TYPE_HIGH
//     TREASURE_TYPE_UNIQUE
void CTG_CreateTreasure(int nTreasureType,
                        object oAdventurer,
                        object oCont=OBJECT_SELF)
{
    // To avoid code duplication, this actually just uses the specific
    // version and passes an invalid item type
    CTG_CreateSpecificBaseTypeTreasure(nTreasureType, oAdventurer, oCont);
}



// Create treasure of the appropriate treasure level and matching one
// of up to three different base types in the specified container.
//
// Possible values for nTreasureType:
//     TREASURE_TYPE_LOW
//     TREASURE_TYPE_MED
//     TREASURE_TYPE_HIGH
//     TREASURE_TYPE_UNIQUE
//
// Possible values for nBaseType1/2/3: any BASE_ITEM_* constant.
// Can also use these special values:
//  TREASURE_BASE_TYPE_WEAPON (for any weapon type)
//  TREASURE_BASE_TYPE_WEAPON_NOAMMO (for any weapon but ammunition)
//  TREASURE_BASE_TYPE_WEAPON_RANGED (for any ranged weapon)
//  TREASURE_BASE_TYPE_WEAPON_MELEE (for any melee weapon)
//  TREASURE_BASE_TYPE_ARMOR (for armor, shields)
//  TREASURE_BASE_TYPE_CLOTHING (for belts, boots, bracers,
//                              cloaks, helms, gloves)
//
void CTG_CreateSpecificBaseTypeTreasure(int nTreasureType,
                                        object oAdventurer,
                                        object oCont,
                                        int nBaseType1=BASE_ITEM_INVALID,
                                        int nBaseType2=BASE_ITEM_INVALID,
                                        int nBaseType3=BASE_ITEM_INVALID)
{
    // Prevent duplicate treasure generation
    if (CTG_GetIsTreasureGenerated(oCont)) {return;}
    CTG_SetIsTreasureGenerated(oCont);

    fRespawnCheck(oCont);

    // Locate the base container
    object oBaseCont = CTG_GetNearestBaseContainer(nTreasureType,
                                                   oCont);

    // Make sure we have a valid base container
    if (!GetIsObjectValid(oBaseCont)) {
        // if not, generate treasure using default method
        if (nBaseType1 == BASE_ITEM_BOOK
            || nBaseType1 == BASE_ITEM_SPELLSCROLL)
        {
            // Make book treasure
            GenerateBookTreasure(oAdventurer, oCont);
        } else {
            // Generate default treasure
            CTG_CreateDefaultTreasure(nTreasureType, oAdventurer, oCont);
        }
        return;
    }

    // Get the number of available items
    int nItemsInBaseCont = CTG_GetNumItemsInBaseContainer(oBaseCont);

    // Special case: unique treasure items
    if (nTreasureType == TREASURE_TYPE_UNIQUE) {
        // only give one item and only give it once
        int nRandom = Random(nItemsInBaseCont);

        object oItem;
        if (nBaseType1 == BASE_ITEM_INVALID) {
            // we're not checking base types
            oItem = CTG_GetTreasureItem(oBaseCont, nRandom);
        } else {
            oItem = CTG_GetSpecificBaseTypeTreasureItem(oBaseCont,
                                                        nRandom,
                                                        nBaseType1,
                                                        nBaseType2,
                                                        nBaseType3);
        }

        // Trigger sub-treasure item lookup?
        if (TestStringAgainstPattern(sSubTreasure+"**"+sSubTreasureItem, GetTag(oItem)))
            oItem = CTG_GetSubTreasureItem(oItem);

        if (!GetIsObjectValid(oItem)) {
            CTG_CreateDefaultTreasure(nTreasureType, oAdventurer, oCont);
        } else {
            // Copy the item
//            CreateItemOnObject(GetResRef(oItem), oCont);
            // * do an actual copy BK Feb 2003. Less chance of resref errors
            CopyObject(oItem, GetLocation(oItem), oCont);

            // Destroy the original
            DestroyObject(oItem);
        }

        return;
    }

    // Otherwise, we generate 1-3 items, possibly convert some
    // to gold.
    int nItems = CTG_GetNumItems();
    int nItemsCreated = 0;
    object oItem = OBJECT_INVALID;

    // Keep track of items handed out to avoid dupes
    object oItem1 = OBJECT_INVALID;
    object oItem2 = OBJECT_INVALID;
    object oNewItem;

    // Random number -- position of item to hand out
    int nRandom = 0;

    while (nItemsCreated < nItems) {
        nItemsCreated++;

//Next line is commented in x0_i0_treasure, uncommented here to allow gold to
//be generated on bashed

//       if (nBaseType1 == BASE_ITEM_INVALID &&  CTG_IsItemGold() )

         if (CTG_IsItemGold())
        {
            CTG_CreateGoldTreasure(nTreasureType, oAdventurer, oCont);
        }
        else
        {
            nRandom = Random(nItemsInBaseCont);

            if (nBaseType1 == BASE_ITEM_INVALID)
            {
                // we're not checking base types
                oItem = CTG_GetTreasureItem(oBaseCont, nRandom);
            }
            else
            {
                if (GetObjectType(oCont)==OBJECT_TYPE_CREATURE && CTG_IsItemGold(1))
                    {
                    CTG_CreateGoldTreasure(nTreasureType, oAdventurer, oCont);
                    }
                else
                    {

                    oItem = CTG_GetSpecificBaseTypeTreasureItem(oBaseCont,
                                                                nRandom,
                                                                nBaseType1,
                                                                nBaseType2,
                                                                nBaseType3);
                    }

            }

            // Trigger sub-treasure item lookup?
            if (TestStringAgainstPattern(sSubTreasure+"**"+sSubTreasureItem, GetTag(oItem)))
                oItem = CTG_GetSubTreasureItem(oItem);

            if (!GetIsObjectValid(oItem))
            {
                // Ugh, no matching item found!
                // Bad module designer, no cookie.
                CTG_CreateDefaultTreasure(nTreasureType, oAdventurer, oCont);
            }
            else if ( nItemsCreated > 1 &&
                        (GetTag(oItem) == GetTag(oItem1) || GetTag(oItem) == GetTag(oItem2)) )
            {
                // Ugh, duplicate item. Make gold instead.
                CTG_CreateGoldTreasure(nTreasureType, oAdventurer, oCont, oItem);
            }
            else
            {
                // Make the item
                oNewItem = CopyItem(oItem, oCont);
                if (fGetIsStackable(oNewItem))
                    {
                    SetItemStackSize(oNewItem, Random(MAX_STACK_SIZE)+1);
                    }


                if (nItemsCreated == 1) {
                    oItem1 = oItem;
                } else {
                    // if this is the third item, it doesn't matter
                    // anyway, so we might as well save the conditional.
                    oItem2 = oItem;
                }
            }
        }
    }
}

int fGetTreasureGoldAmount(int iType, object oCont = OBJECT_INVALID)
    {
    int iAverage;

    if (iType==TREASURE_TYPE_LOW){iAverage = TREASURE_TYPE_GOLD_LOW;}
    if (iType==TREASURE_TYPE_MED){iAverage = TREASURE_TYPE_GOLD_MED;}
    if (iType==TREASURE_TYPE_HIGH){iAverage = TREASURE_TYPE_GOLD_HIGH;}
    if (iType==TREASURE_TYPE_MONSTER)
        {
        if (GetObjectType(oCont)==OBJECT_TYPE_CREATURE)
            {
            iAverage = TREASURE_TYPE_GOLD_MONSTER*GetHitDice(oCont);
            }
        else
            {
            iAverage = TREASURE_TYPE_GOLD_LOW;
            }
        }

    int iMod = (iAverage*TREASURE_TYPE_GOLD_RANGE)/100;
    int iAmount = iAverage-iMod + (Random(iMod*2)+1);

    if (iAmount<=0){return 0;}
    return iAmount;
    }


// Create gold treasure in the specified container.
void CTG_CreateGoldTreasure(int nTreasureType,
                            object oAdventurer,
                            object oCont=OBJECT_SELF, object oItem=OBJECT_INVALID)
{

    fRespawnCheck(oCont);

    int iAmount;
    if (oItem!=OBJECT_INVALID)
        {
        iAmount = FloatToInt(GetGoldPieceValue(oItem)*X0_GOLD_MODIFIER);
        }
    else if (GetObjectType(oCont)==OBJECT_TYPE_CREATURE)
        {
        iAmount = fGetTreasureGoldAmount(TREASURE_TYPE_MONSTER, oCont);
        }
    else
        {
        iAmount = fGetTreasureGoldAmount(nTreasureType, oCont);
        }

    CreateItemOnObject(sGoldResRef, oCont, iAmount);

    // Just use the default generation scripts
    //CreateGold(oCont, oAdventurer, nTreasureType);

}


// Create treasure on an NPC.
// This function will typically be called from within the
// NPC's OnSpawn handler.
// Note that this defaults to TREASURE_TYPE_MONSTER, which uses
// the monster-specific treasure chests and falls back to low-
// level treasure if none exist.
void CTG_GenerateNPCTreasure(int nTreasureType=5, object oNPC=OBJECT_SELF)
{

    // Locate the base container
    object oBaseCont = CTG_GetNearestBaseContainer(nTreasureType,
                                                   oNPC);

    // Make sure we have a valid base container
    if (!GetIsObjectValid(oBaseCont)) {
        // if not, generate treasure using default method from
        // nw_o2_coninclude.
        if (nTreasureType == TREASURE_TYPE_MONSTER)
            GenerateNPCTreasure(TREASURE_TYPE_LOW, oNPC);
        else
            GenerateNPCTreasure(nTreasureType, oNPC);
        return;
    }

    // Now we determine whether we put treasure on the NPC
    int nRacialType = GetRacialType(oNPC);
    switch (nRacialType) {
    case RACIAL_TYPE_ANIMAL:
    case RACIAL_TYPE_BEAST:
    case RACIAL_TYPE_MAGICAL_BEAST:
    case RACIAL_TYPE_VERMIN:
        // No treasure, sorry.
        return;
    }

    if (nTreasureType == TREASURE_TYPE_MONSTER) {

        if (d100() < BK_CHANCE_OF_N0_MONSTERTREASURE) {
            return;
        }
    }

    // Otherwise, generate as usual
    CTG_CreateTreasure(nTreasureType, oNPC, oNPC);
}



/**********************************************************************
 * Boring type-checking functions.
 **********************************************************************/


// Check if the item's base type is of the given base type
int CTG_GetIsBaseType(int nItemBaseType,
                            int nBaseType1=BASE_ITEM_INVALID,
                            int nBaseType2=BASE_ITEM_INVALID,
                            int nBaseType3=BASE_ITEM_INVALID)
{
    return ( (nItemBaseType != BASE_ITEM_INVALID)
             && (
                 nItemBaseType == nBaseType1
                 || nItemBaseType == nBaseType2
                 || nItemBaseType == nBaseType3) );
}

// Check if the item's base type is a weapon
int CTG_GetIsWeapon(int nItemBaseType)
{
    return (
            nItemBaseType == BASE_ITEM_ARROW
            || nItemBaseType == BASE_ITEM_BASTARDSWORD
            || nItemBaseType == BASE_ITEM_BATTLEAXE
            || nItemBaseType == BASE_ITEM_BOLT
            || nItemBaseType == BASE_ITEM_BULLET
            || nItemBaseType == BASE_ITEM_CBLUDGWEAPON
            || nItemBaseType == BASE_ITEM_CLUB
            || nItemBaseType == BASE_ITEM_CPIERCWEAPON
            || nItemBaseType == BASE_ITEM_CSLASHWEAPON
            || nItemBaseType == BASE_ITEM_CSLSHPRCWEAP
            || nItemBaseType == BASE_ITEM_DAGGER
            || nItemBaseType == BASE_ITEM_DART
            || nItemBaseType == BASE_ITEM_DIREMACE
            || nItemBaseType == BASE_ITEM_DOUBLEAXE
            || nItemBaseType == BASE_ITEM_GREATAXE
            || nItemBaseType == BASE_ITEM_GREATSWORD
            || nItemBaseType == BASE_ITEM_GRENADE
            || nItemBaseType == BASE_ITEM_HALBERD
            || nItemBaseType == BASE_ITEM_HANDAXE
            || nItemBaseType == BASE_ITEM_HEAVYCROSSBOW
            || nItemBaseType == BASE_ITEM_HEAVYFLAIL
            || nItemBaseType == BASE_ITEM_KAMA
            || nItemBaseType == BASE_ITEM_KATANA
            || nItemBaseType == BASE_ITEM_KUKRI
            || nItemBaseType == BASE_ITEM_LIGHTCROSSBOW
            || nItemBaseType == BASE_ITEM_LIGHTFLAIL
            || nItemBaseType == BASE_ITEM_LIGHTHAMMER
            || nItemBaseType == BASE_ITEM_LIGHTMACE
            || nItemBaseType == BASE_ITEM_LONGBOW
            || nItemBaseType == BASE_ITEM_LONGSWORD
            || nItemBaseType == BASE_ITEM_MORNINGSTAR
            || nItemBaseType == BASE_ITEM_QUARTERSTAFF
            || nItemBaseType == BASE_ITEM_RAPIER
            || nItemBaseType == BASE_ITEM_SCIMITAR
            || nItemBaseType == BASE_ITEM_SCYTHE
            || nItemBaseType == BASE_ITEM_SHORTBOW
            || nItemBaseType == BASE_ITEM_SHORTSPEAR
            || nItemBaseType == BASE_ITEM_SHORTSWORD
            || nItemBaseType == BASE_ITEM_SHURIKEN
            || nItemBaseType == BASE_ITEM_SICKLE
            || nItemBaseType == BASE_ITEM_SLING
            || nItemBaseType == BASE_ITEM_THROWINGAXE
            || nItemBaseType == BASE_ITEM_TWOBLADEDSWORD
            || nItemBaseType == BASE_ITEM_WARHAMMER);
}

// Check if the item's base type is a weapon but not ammunition
int CTG_GetIsWeaponNoammo(int nItemBaseType)
{
    return ( CTG_GetIsWeapon(nItemBaseType)
             && (nItemBaseType != BASE_ITEM_ARROW
                 || nItemBaseType != BASE_ITEM_BOLT
                 || nItemBaseType != BASE_ITEM_BULLET)
             );
}

// Check if the item's base type is a ranged weapon
int CTG_GetIsRangedWeapon(int nItemBaseType)
{
    return (nItemBaseType == BASE_ITEM_DART
            || nItemBaseType == BASE_ITEM_GRENADE
            || nItemBaseType == BASE_ITEM_HEAVYCROSSBOW
            || nItemBaseType == BASE_ITEM_LIGHTCROSSBOW
            || nItemBaseType == BASE_ITEM_LONGBOW
            || nItemBaseType == BASE_ITEM_SHORTBOW
            || nItemBaseType == BASE_ITEM_SHURIKEN
            || nItemBaseType == BASE_ITEM_SLING
            || nItemBaseType == BASE_ITEM_THROWINGAXE);
}

// Check if the item's base type is a melee weapon
int CTG_GetIsMeleeWeapon(int nItemBaseType)
{
    return (
            nItemBaseType == BASE_ITEM_BASTARDSWORD
            || nItemBaseType == BASE_ITEM_BATTLEAXE
            || nItemBaseType == BASE_ITEM_CLUB
            || nItemBaseType == BASE_ITEM_DAGGER
            || nItemBaseType == BASE_ITEM_DIREMACE
            || nItemBaseType == BASE_ITEM_DOUBLEAXE
            || nItemBaseType == BASE_ITEM_GREATAXE
            || nItemBaseType == BASE_ITEM_GREATSWORD
            || nItemBaseType == BASE_ITEM_HALBERD
            || nItemBaseType == BASE_ITEM_HANDAXE
            || nItemBaseType == BASE_ITEM_HEAVYFLAIL
            || nItemBaseType == BASE_ITEM_KAMA
            || nItemBaseType == BASE_ITEM_KATANA
            || nItemBaseType == BASE_ITEM_KUKRI
            || nItemBaseType == BASE_ITEM_LIGHTFLAIL
            || nItemBaseType == BASE_ITEM_LIGHTHAMMER
            || nItemBaseType == BASE_ITEM_LIGHTMACE
            || nItemBaseType == BASE_ITEM_LONGSWORD
            || nItemBaseType == BASE_ITEM_MORNINGSTAR
            || nItemBaseType == BASE_ITEM_QUARTERSTAFF
            || nItemBaseType == BASE_ITEM_RAPIER
            || nItemBaseType == BASE_ITEM_SCIMITAR
            || nItemBaseType == BASE_ITEM_SCYTHE
            || nItemBaseType == BASE_ITEM_SHORTSPEAR
            || nItemBaseType == BASE_ITEM_SHORTSWORD
            || nItemBaseType == BASE_ITEM_SICKLE
            || nItemBaseType == BASE_ITEM_TWOBLADEDSWORD
            || nItemBaseType == BASE_ITEM_WARHAMMER);
}

// Check if the item's base type is armor
int CTG_GetIsArmor(int nItemBaseType)
{
    return (nItemBaseType == BASE_ITEM_ARMOR
            || nItemBaseType == BASE_ITEM_LARGESHIELD
            || nItemBaseType == BASE_ITEM_SMALLSHIELD
            || nItemBaseType == BASE_ITEM_TOWERSHIELD);
}

// Check if the item's base type is clothing
int CTG_GetIsClothing(int nItemBaseType)
{
        return (nItemBaseType == BASE_ITEM_BELT
            || nItemBaseType == BASE_ITEM_BOOTS
            || nItemBaseType == BASE_ITEM_BRACER
            || nItemBaseType == BASE_ITEM_CLOAK
            || nItemBaseType == BASE_ITEM_GLOVES);
}

// Tack on the appropriate racialtype suffix
string CTG_GetRacialtypeChestTag(string sBaseTag, object oSource)
{
    string sCont = sBaseTag + "_";
    switch (GetRacialType(oSource)) {
    case RACIAL_TYPE_INVALID: return "";
    case RACIAL_TYPE_ABERRATION: sCont = sCont + "ABERRATION"; break;
    case RACIAL_TYPE_ANIMAL: sCont = sCont + "ANIMAL"; break;
    case RACIAL_TYPE_BEAST: sCont = sCont + "BEAST"; break;
    case RACIAL_TYPE_CONSTRUCT: sCont = sCont + "CONSTRUCT"; break;
    case RACIAL_TYPE_DRAGON: sCont = sCont + "DRAGON"; break;
    case RACIAL_TYPE_DWARF: sCont = sCont + "DWARF"; break;
    case RACIAL_TYPE_ELEMENTAL: sCont = sCont + "ELEMENTAL"; break;
    case RACIAL_TYPE_ELF: sCont = sCont + "ELF"; break;
    case RACIAL_TYPE_FEY: sCont = sCont + "FEY"; break;
    case RACIAL_TYPE_GIANT: sCont = sCont + "GIANT"; break;
    case RACIAL_TYPE_GNOME: sCont = sCont + "GNOME"; break;
    case RACIAL_TYPE_HALFELF: sCont = sCont + "HALFELF"; break;
    case RACIAL_TYPE_HALFLING: sCont = sCont + "HALFLING"; break;
    case RACIAL_TYPE_HALFORC: sCont = sCont + "HALFORC"; break;
    case RACIAL_TYPE_HUMAN: sCont = sCont + "HUMAN"; break;
    case RACIAL_TYPE_HUMANOID_GOBLINOID: sCont = sCont + "GOBLINOID"; break;
    case RACIAL_TYPE_HUMANOID_MONSTROUS: sCont = sCont + "MONSTROUS"; break;
    case RACIAL_TYPE_HUMANOID_ORC: sCont = sCont + "ORC"; break;
    case RACIAL_TYPE_HUMANOID_REPTILIAN: sCont = sCont + "REPTILIAN"; break;
    case RACIAL_TYPE_MAGICAL_BEAST: sCont = sCont + "MAGICAL_BEAST"; break;
    case RACIAL_TYPE_OUTSIDER: sCont = sCont + "OUTSIDER"; break;
    case RACIAL_TYPE_SHAPECHANGER: sCont = sCont + "SHAPECHANGER"; break;
    case RACIAL_TYPE_UNDEAD: sCont = sCont + "UNDEAD"; break;
    case RACIAL_TYPE_VERMIN: sCont = sCont + "VERMIN"; break;
    }

    return sCont;
}


//void main() {}
