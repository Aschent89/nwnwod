////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_eqweapon
//  by Don Anderson
//  dandersonru@msn.com
//
//  Equip Appropriate Weaopns
//  Originally Bioware
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_weapstat"
#include "x0_i0_enemy"

/******************************************************************************/
//:: Structure definitions

struct OAIBest
{
    object oWeapon; // Best Weapon for category
    int nValue;     // GP value of item (may be altered by random stuff)
    int nSize;      // Size of this weapon
};
//:: Structure definitions
/******************************************************************************/

/******************************************************************************/
//:: FUNCTION PROTOTYPES

//Unequips Left and Right Hands
void OAI_UnequipWeapons();

// Equip the appropriate weapons to face the target.
void OAI_EquipAppropriateWeapons(object oTarget, int nClearActions=TRUE);

//Equip Ranged Weapon
int OAI_EquipRanged();

// * returns true if out of ammo of currently equipped weapons
int OAI_IsOutOfAmmo(object oWeapon=OBJECT_INVALID);

//Equips the Stored Right Handed Melee
int OAI_EquipRHMelee(object oItem=OBJECT_INVALID);

//Equips the Left Handed Weapon or Shield
int OAI_EquipLHMelee(object oItem=OBJECT_INVALID);

//Chooses Weapons For Melee/Dual/Shield and Ranged
void OAI_ChooseWeapons();

// * checks to see if oUser has ambidexteriy and two weapon fighting
int OAI_WiseToDualWield(object oUser);

//This is just a wrapper around ActionAttack
//To make sure the creature equips weapons
void OAI_WrapperActionAttack(object oTarget);

// Given two weapons will return the better one
struct OAIBest OAI_SelectBetterWeapon(struct OAIBest Weapon1, struct OAIBest Weapon2);

// True if Weapon1 is better then Weapon2
int OAI_IsBetterWeapon(struct OAIBest Weapon1, struct OAIBest Weapon2);

// True if Weapon1 is much better then Weapon2
int OAI_IsMuchBetterWeapon(struct OAIBest Weapon1, struct OAIBest Weapon2);

// Loot the fallen (corpses and items and containers)
// Will loot any container very nearby (usually corpses and bones)
// If none will look for an item to pick up (closest first).
// returns TRUE if we decide to loot something
int OAI_LootCorpse();

// Cause to rethink our weapon selection next time we need to equip a weapon
void OAI_ResetWeapons();

// Checks to see if caller can use object and has room to carry more
// Currently uses simple category counts for generalised categories
int OAI_DoILikeIt(object oItem);

// Removes Inventory groups counts from caller
void OAI_ForgetInventoryCount();

// Counts up inventory items by group and stores on caller
void OAI_CountMyInventory();

// Gets semi nearest placeable (that has inventory potential) or an item to caller
// Must be with in specified fMaxDist
object OAI_SearchForLootable(int bCorpseOnly=FALSE, float fMaxDist=25.0, int bClosest=FALSE);

/******************************************************************************/
//:: AI Specials needed in lots of places

// dk: 10-Dec-2005 Hacked in AI status checking from Jasperre (Thanks Jasperre =) )
// This reports the AI toggle of oTarget.
// * If the AI is OFF, it is TRUE.
// * Returns Dead + Commandable + AI Off integers
// * Supports automatic timeout of off status
int GetAIOff(object oTarget = OBJECT_SELF);

// Sets the AI to NOT use any hearbeat/perception scripts
// nRounds specifies the number of rounds before automatically switching AI back on
// Defaults to forever (-1)
void SetAIOff(object oTarget = OBJECT_SELF, int nRounds=-1);

// Resets the AI off integer, so the AI scripts run.
void SetAIOn(object oTarget = OBJECT_SELF);
/*::///////////////////////////////////////////////
//:: Name: AI ON, or OFF.
//::///////////////////////////////////////////////
  Scripted version of AI on/off toggle.

  It stops relevent AI scripts from running - using "if(GetAIOff()) return;"

  Simple, but effective!
//::////////////////////////////////////////////*/
// Override for all AI scripts (dk: well perceive and hrtbeat at the moment)
const string AI_TOGGLE  = "AI_TOGGLE";              // INTEGER

int GetAIOff(object oTarget=OBJECT_SELF)
{
  // All AI is off (indefinately) when either of these states exist
  if(GetIsDead(oTarget) || !GetCommandable(oTarget)) return -1;

  // Otherwise return the Off timer
  return GetLocalInt(OBJECT_SELF, AI_TOGGLE);
}

void SetAIOff(object oTarget=OBJECT_SELF, int nRounds=-1)
{
  if (nRounds == 0)
    DeleteLocalInt(oTarget, AI_TOGGLE);
  else
    SetLocalInt(oTarget, AI_TOGGLE, nRounds);
}

void SetAIOn(object oTarget=OBJECT_SELF)
{
  DeleteLocalInt(oTarget, AI_TOGGLE);
}
//:: AI Specials
/******************************************************************************/

//:: FUNCTION PROTOTYPES
/******************************************************************************/

/******************************************************************************/
//:: FUNCTIONS

void OAI_UnequipWeapons()
{
  //Now We Unequip Melee Weapons and Shields
  object oLHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
  if(IsWeapon(oLHand)) ActionUnequipItem(oLHand);

  object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
  if(IsWeapon(oWeapon)) ActionUnequipItem(oWeapon);
}

void OAI_EquipAppropriateWeapons(object oEnemy, int nClearActions=TRUE)
{
  object oSelf = OBJECT_SELF;

  int nEmptyHanded = FALSE;
  int nAlreadyClearedActions = FALSE;

  //Set Up Weapons
  if(!GetLocalInt(oSelf,"OAI_HPW"))
    OAI_ChooseWeapons();

  object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
  object oLeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
  //object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS);
  int bHaveMelee = GetIsObjectValid(GetLocalObject(OBJECT_SELF, "OAI_RH_MELEE"));

  if(!GetIsObjectValid(oRightHand)) nEmptyHanded = TRUE;

  //Determine Enemy Distance
  if(!GetIsObjectValid(oEnemy)) oEnemy = GetNearestPerceivedEnemy();
  float fDist = GetDistanceBetween(OBJECT_SELF, oEnemy);

  //Ranged Attack
  if (!bHaveMelee || fDist > 5.0 || (GetHasFeat(FEAT_POINT_BLANK_SHOT) && d4() > 1))
  {
    // Finished if already weilding a ranged weapon with some ammo
    if (IsRangedWeapon(oRightHand) && !OAI_IsOutOfAmmo(oRightHand))
      return;

    if(nClearActions && !nAlreadyClearedActions)
    {
      ClearAllActions();
      nAlreadyClearedActions = TRUE;
    }

    //Equip a Ranged, if we succeed we are done
    if(OAI_EquipRanged()) return;
  }

  // Falls through if can't or don't want to weild ranged weapon

  //Melee Attack
  // Need a right handed weapon?
  if(!IsMeleeWeapon(oRightHand) && bHaveMelee)
  {
    if(nClearActions && !nAlreadyClearedActions)
    {
      ClearAllActions();
      nAlreadyClearedActions = TRUE;
    }

    // If the weild fails then we should look at our weapons again later
    if (OAI_EquipRHMelee() == FALSE)
      OAI_ResetWeapons();

    //Equips the Left Handed Weapon or Shield
    OAI_EquipLHMelee();
  }

  // Otherwse we are stuck with what we have got
}

int OAI_EquipRanged()
{
  object oItem = GetLocalObject(OBJECT_SELF, "OAI_RANGED");
  if(oItem != OBJECT_INVALID)
  {
    if (OAI_IsOutOfAmmo(oItem))
    {
      // Next round we will check our new weapon statuses
      OAI_ResetWeapons();
    } else
    {
      // dk: 17-Dec-2005 Make sure item is identified for creatue to weild
      SetIdentified(oItem, TRUE);
      ActionDoCommand(ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND));
      return TRUE;
    }
  }
  return FALSE;
}

int OAI_IsOutOfAmmo(object oWeapon=OBJECT_INVALID)
{
  if (oWeapon == OBJECT_INVALID)
    oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);

  if (!GetIsObjectValid(oWeapon))
    return TRUE;

  switch (GetBaseItemType(oWeapon))
  {
    case BASE_ITEM_LONGBOW:
    case BASE_ITEM_SHORTBOW:
      return !GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARROWS));
    case BASE_ITEM_LIGHTCROSSBOW:
    case BASE_ITEM_HEAVYCROSSBOW:
      return !GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOLTS));
    case BASE_ITEM_SLING:
      return !GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BULLETS));
  }

  return FALSE;  // Melee weapons never run out of ammo
}

int OAI_WiseToDualWield(object oUser)
{
  int nWiseness = 0;
  if (GetHasFeat(FEAT_AMBIDEXTERITY, oUser))
    nWiseness++;
  if (GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oUser))
    nWiseness++;
  if (GetHasFeat(FEAT_IMPROVED_TWO_WEAPON_FIGHTING, oUser))
    nWiseness++;

  return nWiseness;
}

int OAI_EquipRHMelee(object oItem=OBJECT_INVALID)
{
  if (oItem == OBJECT_INVALID)
    oItem = GetLocalObject(OBJECT_SELF, "OAI_RH_MELEE");
  if(oItem != OBJECT_INVALID)
  {
    // dk: 17-Dec-2005 Make sure item is identified for creatue to weild
    SetIdentified(oItem, TRUE);
    ActionDoCommand(ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND));
    return TRUE;
  }
  return FALSE;
}

int OAI_EquipLHMelee(object oItem=OBJECT_INVALID)
{
  if (oItem == OBJECT_INVALID)
    oItem = GetLocalObject(OBJECT_SELF, "OAI_LH_MELEE");
  if(oItem != OBJECT_INVALID)
  {
    // dk: 17-Dec-2005 Make sure item is identified for creatue to weild
    SetIdentified(oItem, TRUE);
    ActionDoCommand(ActionEquipItem(oItem,INVENTORY_SLOT_LEFTHAND));
    return TRUE;
  }
  return FALSE;
}

int OAI_WeaponValue(object oItem)
{
    int nCost;

    // All tested weapons get identified
    SetIdentified(oItem, TRUE);
    nCost = GetGoldPieceValue(oItem);

    return nCost;
}

struct OAIBest OAI_InitBest()
{
    struct OAIBest Best;
    Best.oWeapon = OBJECT_INVALID;
    Best.nValue = 0;
    Best.nSize = 0;

    return Best;
}

struct OAIBest OAI_SelectBetterWeapon(struct OAIBest Weapon1, struct OAIBest Weapon2)
{
    // Might improve on this logic later
    if (Weapon1.nValue > Weapon2.nValue)
        return Weapon1;
    else
        return Weapon2;
}

int OAI_IsBetterWeapon(struct OAIBest Weapon1, struct OAIBest Weapon2)
{
    // Might improve on this logic later
    if (Weapon1.nValue > Weapon2.nValue)
        return TRUE;
    else
        return FALSE;
}

int OAI_IsMuchBetterWeapon(struct OAIBest Weapon1, struct OAIBest Weapon2)
{
    // Might improve on this logic later
    if (Weapon1.nValue - Weapon2.nValue > 150)  // worth more then 150gp extra
        return TRUE;
    else
        return FALSE;
}

void OAI_ChooseWeapons()
{
  object oSelf = OBJECT_SELF;

  struct OAIWeapon Current;     // Data on current weapon

  struct OAIBest BestShield = OAI_InitBest();
  struct OAIBest BestSingle = OAI_InitBest();
  struct OAIBest BestDouble = OAI_InitBest();
  struct OAIBest BestOffHand = OAI_InitBest();
  struct OAIBest BestBow = OAI_InitBest();
  struct OAIBest BestXBow = OAI_InitBest();
  struct OAIBest BestSling = OAI_InitBest();
  struct OAIBest BestThrown = OAI_InitBest();

  struct OAIBest This;
  struct OAIBest TmpBest;   // May need to swap some Bests around

  object oItem;

  // Check the slots for ammo
  int bHaveArrows = GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARROWS));
  int bHaveBolts = GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOLTS));
  int bHaveBullets = GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BULLETS));

  // Size of creature. Can weild same size weapon on handed, +1 for two handed
  int nMySize = GetCreatureSize(oSelf);
  int nLoop;            // Main loop control variable
  int nHaveFeats = OAI_GetFeatMask(oSelf);  // Which feat set we have

  nLoop = 4;
  while (nLoop > 0)
  {
    // Main Loop selection of next item
    // Tries to select weilded weapons first, falling through the cycling through invent
    // Switch must always choose an item otherwise the loop is over
    switch (nLoop)
    {
      case 4:  // Right hand
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
        nLoop--;
        if (GetIsObjectValid(oItem))
            break;
      case 3:  // Left hand
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
        nLoop--;
        if (GetIsObjectValid(oItem))
            break;
      case 2:  // First Item in inventory
        oItem = GetFirstItemInInventory();
        nLoop--;    // Now main loop is terminateable (ie. nLoop = 1)
        break;
      case 1:  // Subsequent items in inventory
        oItem = GetNextItemInInventory();
    }
    // Check if Finished
    if (!GetIsObjectValid(oItem))
        break;

    // Need some wepon data
    Current = OAI_GetWeaponStats(oItem);
    This.oWeapon = oItem;
    This.nValue = OAI_WeaponValue(oItem);   // Set Identified on as well (for now)
    This.nSize = Current.nWeaponSize;
    int bCanUse;                            // Need to check abaility ti use some things

    // What type of weapon is it?
    switch (Current.nCategory){
        case 1: // Melee
            //Upgrade Melee Weapon
            OAI_UpgradeMeleeWeapon(oItem);

            // Is the weapon too big for creature to consider
            if (Current.nWeaponSize > nMySize + 1)
                break;

            // Skip if we do not have the feat to weild it
            if ((Current.nReqFeat & nHaveFeats) == 0)
                break;

            // How many hands (size+1 is 2 handed, size is 1 handed, less than size is small weapon (offhand)
            if (nMySize + 1 == Current.nWeaponSize)
            {
                // We will weild it two handed
                BestDouble = OAI_SelectBetterWeapon(BestDouble, This);
            }
            else if (Current.nWeaponSize <= nMySize)
            {
                // If Single weapon is vacant assign it there
                if (!GetIsObjectValid(BestSingle.oWeapon))
                    BestSingle = This;
                else if (Current.nWeaponSize == nMySize)
                {
                    // Can only go in main hand
                    if (BestSingle.nSize == nMySize)
                    {
                        // Out better of two in right hand
                        if (OAI_IsBetterWeapon(This, BestSingle)) {
                            TmpBest = BestSingle;
                            BestSingle = This;
                            This = TmpBest;
                        }

                        // Consider the lesser of the two only if no other left weapon or
                        // left weapon is same size (ie. keep small weapon in off hand)
                        if (!GetIsObjectValid(BestOffHand.oWeapon))
                            BestOffHand = This;
                        else if (BestOffHand.nSize == This.nSize)
                            BestOffHand = OAI_SelectBetterWeapon(BestOffHand, This);
                    }
                    else
                    {
                        // out big weapon in main hand
                        TmpBest = BestSingle;
                        BestSingle = This;
                        // And choose best offhand from other two (potentially)
                        BestOffHand = OAI_SelectBetterWeapon(BestOffHand, TmpBest);
                    }
                }
                else
                {
                    // Small, could go in either hand
                    if (OAI_IsBetterWeapon(This, BestSingle))
                    {
                        // Better then best then shuffle down
                        BestOffHand = BestSingle;
                        BestSingle = This;
                    } else
                        // Pick better of two lesser
                        BestOffHand = OAI_SelectBetterWeapon(This, BestOffHand);
                }
            }
            break;

        case 2: // Bows
            //Upgrade Ranged Weapon
            OAI_UpgradeRangedWeapon(oItem);

            // Skip if we do not have the feat to weild it
            if ((Current.nReqFeat & nHaveFeats) == 0)
                break;

            // Ensure we can weild it
            if (nMySize + 1 >= Current.nWeaponSize) {
                switch (Current.nBaseType) {
                    case BASE_ITEM_LONGBOW:
                    case BASE_ITEM_SHORTBOW:
                        BestBow = OAI_SelectBetterWeapon(BestBow, This);
                        break;
                    case BASE_ITEM_LIGHTCROSSBOW:
                    case BASE_ITEM_HEAVYCROSSBOW:
                        BestXBow = OAI_SelectBetterWeapon(BestXBow, This);
                        break;
                    case BASE_ITEM_SLING:
                        BestSling = OAI_SelectBetterWeapon(BestSling, This);
                }
            }
            break;

        case 3: // Shields
            // Can we use a shield at all?
            if (!GetHasFeat(FEAT_SHIELD_PROFICIENCY,oSelf))
                break;

            // How big is the shield
            switch (Current.nBaseType) {
                case BASE_ITEM_SMALLSHIELD:
                case BASE_ITEM_LARGESHIELD: bCanUse = nMySize > 1; break;
                default: bCanUse = nMySize > 2;
            }

            // Can we use it?
            if (bCanUse)
                BestShield = OAI_SelectBetterWeapon(BestShield, This);
            break;

        case 6: // Ammo
            // Just denote we have some ammunition of this type
            switch (Current.nBaseType) {
                case BASE_ITEM_ARROW:  bHaveArrows  = TRUE; break;
                case BASE_ITEM_BOLT:   bHaveBolts   = TRUE; break;
                case BASE_ITEM_BULLET: bHaveBullets = TRUE;
            }
            break;

        case 7: // Thrown
            // Ensure we can weild it
            if (nMySize + 1 >= Current.nWeaponSize) {
                BestThrown = OAI_SelectBetterWeapon(BestThrown, This);
            }
            break;

        // Skip all others
    }
  }

  //Ranged Weapon
  TmpBest = BestThrown; // Either is is null or we have one
  if (bHaveArrows && BestBow.oWeapon != OBJECT_INVALID)
    if (OAI_IsBetterWeapon(BestBow, TmpBest))
        TmpBest = BestBow;
  if (bHaveBolts && BestXBow.oWeapon != OBJECT_INVALID)
    if (OAI_IsBetterWeapon(BestXBow, TmpBest))
        TmpBest = BestXBow;
  if (bHaveBullets && BestSling.oWeapon != OBJECT_INVALID)
    if (OAI_IsBetterWeapon(BestSling, TmpBest))
        TmpBest = BestSling;
  if(TmpBest.oWeapon != OBJECT_INVALID)
    SetLocalObject(OBJECT_SELF, "OAI_RANGED", TmpBest.oWeapon);
  else
    DeleteLocalObject(OBJECT_SELF, "OAI_RANGED");

  // If we have both the choice of 2H or 1H + shield and there is not much diff in value then
  // 50/50 chance
  int bForce2H = !GetIsObjectValid(BestDouble.oWeapon) &&   // We've got a 2H weapon
        !GetIsObjectValid(BestShield.oWeapon) &&            // We've got a shield
        !GetIsObjectValid(BestSingle.oWeapon) &&            // We've got a 1H weapon
        !OAI_IsMuchBetterWeapon(BestDouble, BestSingle) &&  // 2H not much better then 1H
        d2() == 1;  // 50% chance

  // Two hand or not
  if (bForce2H || OAI_IsBetterWeapon(BestDouble, BestSingle)) {
    SetLocalObject(OBJECT_SELF, "OAI_RH_MELEE", BestDouble.oWeapon);
    DeleteLocalObject(OBJECT_SELF, "OAI_LH_MELEE"); // Switch this off
  } else {
    //Right Hand Weapon
    if(BestSingle.oWeapon != OBJECT_INVALID)
      SetLocalObject(OBJECT_SELF, "OAI_RH_MELEE", BestSingle.oWeapon);
    else
      DeleteLocalObject(OBJECT_SELF, "OAI_RH_MELEE");

    //Left Hand Shield
    if(BestShield.oWeapon != OBJECT_INVALID)
      SetLocalObject(OBJECT_SELF, "OAI_LH_MELEE", BestShield.oWeapon);
    else
      DeleteLocalObject(OBJECT_SELF, "OAI_LH_MELEE");

    //Left Hand Weapon (Will Override Shield)
    // WisetoDualweild returns 1 or 2 based on two feats, we double it
    // Give +2 if sensible weapons
    // Give +1 for free
    // add em all up, if 1d8 < total then dual weild
    // nBonus we be 1-7 => always 12.5% of duel weild with no skill and silly weapons annd
    // 12.5% chance of being pretty good duel weilder and notdoing it
    // except I added +2 for improved two weapon fighting but thats okay as it means they would
    // alway duel weild.
    if(BestOffHand.oWeapon != OBJECT_INVALID)
    {
      int nBonus = 1;
      if (BestOffHand.nSize < nMySize)
        nBonus += 2;
      nBonus += 2 * OAI_WiseToDualWield(OBJECT_SELF);
      if (d8() <= nBonus)
        SetLocalObject(OBJECT_SELF, "OAI_LH_MELEE", BestOffHand.oWeapon);
    }
  }

  // Record we have done our job
  SetLocalInt(oSelf,"OAI_HPW",TRUE);
}

void OAI_WrapperActionAttack(object oTarget)
{
  if (!GetIsObjectValid(oTarget)) return;
  OAI_EquipAppropriateWeapons(oTarget);
  ActionAttack(oTarget);
}

void OAI_ResetWeapons()
{
  DeleteLocalInt(OBJECT_SELF, "OAI_HPW");
}

object OAI_SearchForLootable(int bCorpseOnly=FALSE, float fMaxDist=25.0, int bClosest=FALSE)
{
    object oPlaceable = OBJECT_INVALID;
    int nLoop, nStart;
    float fDist;

    // Looting the closest thing we can see within the distance
    if (bClosest)
    {
        float fOtherDist;
        object oOther;

        if (bCorpseOnly)
        {
            oPlaceable = GetNearestObjectByTag("invis_corpse_obj");
            fDist = GetDistanceToObject(oPlaceable);
            oOther = GetNearestObjectByTag("loot_bones_obj");
            fOtherDist = GetDistanceToObject(oOther);
            // Get Best choice into oPlaceable and fDist
            if (!GetIsObjectValid(oPlaceable) || (fOtherDist >= 0.0 && fOtherDist < fDist))
            {
                fDist = fOtherDist;
                oPlaceable = oOther;
            }
            // Is our best choice valid
            if (fDist < 0.0 || fDist > fMaxDist) return OBJECT_INVALID;
            else return oPlaceable;
        }
        else
        {
            // Grab the nearest item
            oOther = GetNearestObject(OBJECT_TYPE_ITEM);
            fOtherDist = GetDistanceToObject(oOther);
            if (fOtherDist > fMaxDist) fOtherDist = -1.0;

            // Look for the closest placeable in range with inventory
            nLoop = 1;
            while (GetIsObjectValid(oPlaceable = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nLoop)))
            {
                fDist = GetDistanceToObject(oPlaceable);
                // If outside of range return either the Item or failure
                if (fDist < 0.0 || fDist > fMaxDist)
                {
                    if (fOtherDist >= 0.0) return oOther;
                    else return OBJECT_INVALID;
                    break;
                }
                // If we have a suitable container (not specifically marked as non-lootable,
                // compare distance to item
                if (GetHasInventory(oPlaceable) &&
                        GetIsObjectValid(GetFirstItemInInventory(oPlaceable)) &&
                        !GetLocalInt(oPlaceable, "NOLOOTING") &&
                        !GetLocalInt(GetModule(), "NO_LOOT_" + GetResRef(oPlaceable)))
                {
                    if (fOtherDist >= 0.0 && fOtherDist < fDist) return oOther;
                    else return oPlaceable;
                }
                nLoop++;
            }
        }

        return OBJECT_INVALID;
    }

    // Here we are going to look around for something within rangebut not necessarily the closest
    // (So we don't all run at the same thing)

    // Generate two random numbers and we will start looking from the lowest number
    // (Nth thing away) scannning downward (closer to us)
    if (bCorpseOnly)
    {
        // Don't look too far away, corpses are interesting
        nStart = d3();
        nLoop = d4();
    }
    else
    {
        // Scan a bit further for placeables
        nStart = d6();
        nLoop = d6();
    }

    // Start at minimum random selection
    if (nLoop < nStart)
        nStart = nLoop;

    // Being a little random here will stop everyone from running for the one Corpse
    for (nLoop = nStart; nLoop > 0; nLoop--)
    {
        if (bCorpseOnly)
        {
            // Try for Corpse
            oPlaceable = GetNearestObjectByTag("invis_corpse_obj", OBJECT_SELF, nLoop);
            if (GetIsObjectValid(oPlaceable))
            {
                fDist = GetDistanceToObject(oPlaceable);
                if (fDist >= 0.0 && fDist <= fMaxDist)
                    break;
            }

            // Then try for bones
            oPlaceable = GetNearestObjectByTag("loot_bones_obj", OBJECT_SELF, nLoop);
            if (GetIsObjectValid(oPlaceable))
            {
                fDist = GetDistanceToObject(oPlaceable);
                if (fDist >= 0.0 && fDist <= fMaxDist) break;
                else oPlaceable = OBJECT_INVALID;
            }
        }
        else
        {
            // Try for first Items we can see
            oPlaceable = GetNearestObject(OBJECT_TYPE_ITEM, OBJECT_SELF, nLoop);
            if (GetIsObjectValid(oPlaceable))
            {
                fDist = GetDistanceToObject(oPlaceable);
                if (fDist >= 0.0 && fDist <= fMaxDist) break;
                else oPlaceable = OBJECT_INVALID;
            }
            // Now try for placeables with inventory
            oPlaceable = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nLoop);
            if (GetIsObjectValid(oPlaceable))
            {
                if (GetHasInventory(oPlaceable) && GetIsObjectValid(GetFirstItemInInventory(oPlaceable)) &&
                    !GetLocalInt(GetModule(), "NO_LOOT_" + GetResRef(oPlaceable)))
                {
                    fDist = GetDistanceToObject(oPlaceable);
                    if (fDist >= 0.0 && fDist <= fMaxDist) break;
                    else oPlaceable = OBJECT_INVALID;
                }
                else oPlaceable = OBJECT_INVALID;
            }
        }
    }

    return oPlaceable;
}

void OAI_CountMyInventory()
{
    struct OAIWeapon Current;       // Data on current weapon
    object oItem;
    int nMelee = 0, nBows = 0, nThrown = 0, nShields = 0, nItems = 0, nAmmo = 0;

    int nLoop = 4;
    while (nLoop > 0)
    {
        // Main Loop selection of next item
        // Tries to select weilded weapons first, falling through the cycling through invent
        // Switch must always choose an item otherwise the loop is over
        switch (nLoop)
        {
            case 4:  // Right hand
                oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
                nLoop--;
                if (GetIsObjectValid(oItem))
                    break;
            case 3:  // Left hand
                oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
                nLoop--;
                if (GetIsObjectValid(oItem))
                    break;
            case 2:  // First Item in inventory
                oItem = GetFirstItemInInventory();
                nLoop--;    // Now main loop is terminateable (ie. nLoop = 1)
                break;
            case 1:  // Subsequent items in inventory
                oItem = GetNextItemInInventory();
        }

        // Check if Finished
        if (!GetIsObjectValid(oItem)) break;

        Current = OAI_GetWeaponStats(oItem);
        switch (Current.nCategory)
        {
            case 1: // Melee
                nMelee++; break;
            case 2: // Bows
                nBows++; break;
            case 7: // Thrown
                nThrown++; break;
            case 3: // Shields
                nShields++; break;
            case 6: // Ammo
                nAmmo++; break;

            // The Ones we don't count, we want the all (Greedy Creatures)
            case 19: // Amulets
            case 44: // Magic Rod
            case 45: // Magic Staff
            case 46: // Magic Wand
            case 49: // Potions
            case 52: // Rings
            case 75: // Scrolls
            case 77: // Gems
                break;

            default: // Treasure
                nItems++;
        }
    }

    // Temporarily store Nmber of extras willing to take on self
    SetLocalInt(OBJECT_SELF, "nMelee",   4 - nMelee);
    SetLocalInt(OBJECT_SELF, "nBows",    3 - nBows);
    SetLocalInt(OBJECT_SELF, "nThrown",  2 - nThrown);
    SetLocalInt(OBJECT_SELF, "nShields", 2 - nShields);
    SetLocalInt(OBJECT_SELF, "nAmmo",   12 - nAmmo);
    SetLocalInt(OBJECT_SELF, "nItems",  15 - nItems);
}

void OAI_ForgetInventoryCount()
{
    DeleteLocalInt(OBJECT_SELF, "nMelee");
    DeleteLocalInt(OBJECT_SELF, "nBows");
    DeleteLocalInt(OBJECT_SELF, "nThrown");
    DeleteLocalInt(OBJECT_SELF, "nShields");
    DeleteLocalInt(OBJECT_SELF, "nAmmo");
    DeleteLocalInt(OBJECT_SELF, "nItems");
}

int OAI_DoILikeIt(object oItem)
{
    struct OAIWeapon Current = OAI_GetWeaponStats(oItem);   // Data on current weapon
    int nMyFeats = OAI_GetFeatMask(OBJECT_SELF);
    int nMySize = GetCreatureSize(OBJECT_SELF);
    int bTake = FALSE;
    string sGroup = "";

    // We may have been gicen a dud (ie. getfirst in inventory of empty corpse)
    if (!GetIsObjectValid(oItem)) return FALSE;

    // Inside this switch we determine ONLY if we can use the item and what tracked group it belongs to
    switch (Current.nCategory)
    {
        case 1: // Melee
        case 2: // Bows
        case 7: // Thrown
            if (Current.nCategory == 1) sGroup = "nMelee";
            else if (Current.nCategory == 2) sGroup = "nBows";
            else if (Current.nCategory == 7) sGroup = "nThrown";

            // Is the weapon too big for creature to consider
            if (Current.nWeaponSize > nMySize + 1)
                break;
            // Skip if we do not have the feat to weild it
            if ((Current.nReqFeat & nMyFeats) == 0)
                break;
            bTake = TRUE;
            break;

        case 3: // Shields
            if (GetHasFeat(FEAT_SHIELD_PROFICIENCY)) {
                sGroup = "nShields";
                bTake = TRUE;
            }
            break;

        case 6: // Ammo
            // Grab lots of ammo, doesn't weight anything
            sGroup = "nAmmo";
            bTake = TRUE;
            break;

        // The Always take treasures
        case 19: // Amulets
        case 44: // Magic Rod
        case 45: // Magic Staff
        case 46: // Magic Wand
        case 49: // Potions
        case 52: // Rings
        case 75: // Scrolls
        case 77: // Gems
            bTake = TRUE;
            break;

        default: // Generic Treasure :-)
            sGroup = "nItems";
            bTake = GetWeight(oItem) < 200;    // Don't take if heavy, usually special things (like corses)
    }

    // Creature size limits (baby creatures can only take very light stuff
    if (GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_TINY && GetWeight(oItem) > 15) bTake = FALSE;

    // Just before we take it, check if we have too many of that type of thing
    if (bTake && sGroup != "")
    {
        // Do we want another Item of this group?
        if (GetLocalInt(OBJECT_SELF, sGroup) > 0) SetLocalInt(OBJECT_SELF, sGroup, GetLocalInt(OBJECT_SELF, sGroup) - 1);
        else bTake = FALSE;  // Have too many of those
    }

    return bTake;
}

// Better Not call this routine too often in short time as temporary clones are
// created on each call and last 10 seconds
void TriggerTrap(object oBox)
{
    object oMe = GetObjectByTag("FACTION_1004");

    // If we are not hostile then we can activate the trap already
    if (!GetFactionEqual(oMe))
    {
        // Touch the trap
        ActionInteractObject(oBox);
        ActionWait(1.0);    // Makes sure next event doesn't cancel the touch
        return;
    }

    // We will change our faction temporarily so we can set the trap off
    // Where do we create the clone?
    object oCloneWP = GetObjectByTag("TrapCloneLocation");
    if (!GetIsObjectValid(oCloneWP))
        oCloneWP = OBJECT_SELF; // Not a good spot but it will do

    // So create a clone of ourselves to restore our faction
    oMe = CopyObject(OBJECT_SELF, GetLocation(oCloneWP));

    // Kill the clone later
    AssignCommand(oMe, DelayCommand(9.5, SetPlotFlag(oMe, FALSE)));
    AssignCommand(oMe, DelayCommand(10.0, DestroyObject(oMe)));

    // Make clone invisible, indestructable and immobile
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oMe);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneImmobilize(), oMe);
    SetPlotFlag(oMe, TRUE);

    // Force me to join the other faction
    // We will use a predfined Creatures faction is you TAG the creature with TrapFaction
    // Otherwise we will use the Merchant faction (hopefully nuetral to our current friends)
    // Nb! This may mean Merchants may not set the trap off, will test soon
    object oTrap = GetObjectByTag("TrapFaction");
    if (GetIsObjectValid(oTrap))
        ActionDoCommand(ChangeFaction(OBJECT_SELF, oTrap));
    else
        // No Specific Trap faction then use the Merchant faction (looks like Merchant are immune)
        ActionDoCommand(ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_MERCHANT));

    // Touch the trap
    ActionInteractObject(oBox);
    ActionWait(1.0);

    // Return to original faction
    ActionDoCommand(ChangeFaction(OBJECT_SELF, oMe));
}

// Loot the fallen (Note: this can loot more then just corpses)
int OAI_LootCorpse()
{
    // These guys don't care for weapons and treasure
    switch (GetRacialType(OBJECT_SELF))
    {
        case RACIAL_TYPE_ABERRATION:
        case RACIAL_TYPE_ANIMAL:
        case RACIAL_TYPE_BEAST:
        case RACIAL_TYPE_CONSTRUCT:
        case RACIAL_TYPE_DRAGON:    // hmm. Guess we don't want these wandering about too much
        case RACIAL_TYPE_ELEMENTAL:
        case RACIAL_TYPE_FEY:
        case RACIAL_TYPE_INVALID:
        case RACIAL_TYPE_MAGICAL_BEAST:
        case RACIAL_TYPE_OOZE:
            return FALSE;
    }

    // Get our module set looting limits
    int nLooting = GetLocalInt(GetModule(), "OAILOOTING");
    if (!nLooting) return FALSE;  // Oh, your no fun :-)

    // Here we are genericaly allowed to loot but the area says no
    // but we still want to be able to loot corpses
    if (GetLocalInt(GetArea(OBJECT_SELF), "NOLOOTING") || GetLocalInt(GetArea(OBJECT_SELF), "Town")) nLooting = 1;

    // Can I found something with an inventory close by
    object oLoot = OAI_SearchForLootable(nLooting == 1, 2.5, TRUE);

    // Do we have a corpse to loot
    int bHaveCorpse = GetIsObjectValid(oLoot) && GetHasInventory(oLoot);

    // Count up how many items we are carrying
    OAI_CountMyInventory();

    //
    // Looting time
    //
    // Bend down to loot if a corpse
    if (bHaveCorpse)
    {
        SetAIOff(OBJECT_SELF, 5);   // No heartbeats for 5 rounds while we loot
        ClearAllActions();
        ActionDoCommand(SetFacingPoint(GetPosition(oLoot)));
        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0);

        // Is it trapped
        if (GetIsTrapped(oLoot))
        {
            // Note set DC is given a free roll of 20, lets hack that down
            int nDC = GetTrapDetectDC(oLoot) - d20() + 3;   // +2 advantage to setter
            int nSkill = GetSkillRank(SKILL_SEARCH);

            // Testing, want to skip all of below if we can sensibly detect a friendly trap
            object oTrapper = GetTrapCreator(oLoot);
            if (oTrapper == OBJECT_INVALID || !GetFactionEqual(oTrapper))
            {
              // Did we see it?
              if (nSkill + d20() > nDC)
              {
                nDC = GetTrapDisarmDC(oLoot);
                nSkill = GetSkillRank(SKILL_DISABLE_TRAP);

                if (GetTrapDisarmable(oLoot) && nSkill > 0 && (d20() == 1 || nSkill + 18 > nDC))
                {
                    nDC -= nSkill + d20();
                    if (nDC >= 0)
                    {
                        ActionInteractObject(oLoot);
                        ActionDoCommand(SetTrapDisabled(oLoot));
                        ActionSpeakString("** Yes. Got It. **");
                        // We can continue on with the corpse now
                    }
                    else if (nDC < -9 || d100() == 1)   // Gee I'm mean
                    {
                        // Schedule finish of AI off if we forced it off while looting the corpse
                        ActionDoCommand(SetAIOn());
                        // Whoops, we hav set it off
                        ActionSpeakString("** Whoops **");
                        TriggerTrap(oLoot);
                        return TRUE; // Stop now if trap blew up in our face
                    }
                    else
                    {
                        ActionSpeakString("** hmmm **");
                        bHaveCorpse = FALSE;    // No longer have a corpse to look at
                    }
                }
                else
                {
                    ActionSpeakString("** Too hard **");
                    bHaveCorpse = FALSE;    // No longer have a corpse to look at
                }
              }
              else
              {
                // Schedule finish of AI off if we forced it off while looting the corpse
                ActionDoCommand(SetAIOn());
                ActionSpeakString("** What the ... **");
                TriggerTrap(oLoot);
                return TRUE; // Stop now if trap blew up in our face
              }
           } else
            bHaveCorpse = FALSE; // Leave friendly traps alone
        }

        // Is it locked (only check if we still consider this placeable lootable)
        if (bHaveCorpse && GetLocked(oLoot))
        {
            // Debug signal that we have been beaten by a lock
            ActionSpeakString("** Locked **");
            ActionInteractObject(oLoot);    // Play with the placeable

            // Again remember that lockers got a free 20 roll, so modify
            int nDC = GetLockUnlockDC(oLoot) - d20() + 3;   // +2 bonus for locker
            int nSkill = GetSkillRank(SKILL_OPEN_LOCK);

            // Try to unlock if we have some skill
            if (nSkill > 0)
            {
                ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0);
                if (nSkill > 0 && !GetLockKeyRequired(oLoot) && (nSkill + d20() >= nDC))
                {
                    ActionDoCommand(SetLocked(oLoot, FALSE));
                    ActionSpeakString("** Got It **");
                }
                else
                {
                    ActionSpeakString("** Dam **");
                    bHaveCorpse = FALSE;    // No longer have a corpse to look at
                }
            }
            else
                bHaveCorpse = FALSE;    //  Can't open, can't loot
        }

        // Take all the cash if we can still loot the corpse
        if (bHaveCorpse && GetGold(oLoot))
            ActionDoCommand(TakeGoldFromCreature(GetGold(oLoot), oLoot));
    }

    int nLoop = 1;  // Control search for closest item
    int nTaken = 0; // counts how many items we take
    float fDist;
    object oItem;
    while (TRUE)
    {
        // Get Next item to look at
        if (bHaveCorpse)
        {
            if (nLoop == 1)
            {
                oItem = GetFirstItemInInventory(oLoot);
                ActionInteractObject(oLoot);    // Play with the placeable
            }
            else oItem = GetNextItemInInventory(oLoot);
        }
        else
        {
            oItem = GetNearestObject(OBJECT_TYPE_ITEM, OBJECT_SELF, nLoop);
            fDist = GetDistanceToObject(oLoot);
            if (fDist < 0.0 || fDist > 20.0) break;
        }

        // See if we are interested in this item
        if (OAI_DoILikeIt(oItem))
        {
            if (bHaveCorpse)
            {
                nTaken++;
                ActionTakeItem(oItem, oLoot);
                SetDroppableFlag(oItem, TRUE);  // Make sure we can drop it later
                // Note: Some of the take action can be cancelled by other hearbeats
            }
            else
            {
                ClearAllActions();
                SetLocalObject(OBJECT_SELF, "WeaponRetrieve1", oItem);
                break;
            }
        }

        // Count up out iterations
        nLoop++;
        if (nLoop > 20) break;  // Don;t want to stay here too long
    }

    // Remove Temporary item counters
    OAI_ForgetInventoryCount();

    // Re-evaluate our weapon/shield selection in case we got some good stuff
    if (nTaken)
    {
        OAI_ResetWeapons();
        // Debug signal that we have taken stuff, might leave in, it looks cute
        ActionSpeakString("** Treasure **");
    }

    // Schedule finish of AI off if we forced it off while looting the corpse
    //if (bHaveCorpse)
    ActionDoCommand(SetAIOn());

    return nTaken;
}

//void main(){}
