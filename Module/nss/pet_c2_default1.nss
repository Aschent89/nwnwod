////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default1
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnHeartbeat
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_ai"

void main()
{
    object oNPC = OBJECT_SELF;

/******************************************************************************/
//:: CUSTOM HB SYSTEMS


    //Custom Scripts you Need to Execute
    ExecuteScript("oai_cust_hb", oNPC);


//:: CUSTOM HB SYSTEMS
/******************************************************************************/

/******************************************************************************/
//:: OLANDER'S SUICIDE BOMBERS =O

    if(GetBattleCondition(OAI_ROLE_SUICIDE))
    {
      OAI_Kaboom(oNPC);
      return;
    }

/******************************************************************************/
//:: OLANDER'S TRANSFORMING CREATURES

    //Transforming Creatures
    if(GetBattleCondition(OAI_ROLE_TRANSFORMER))
    {
      if(OAI_Transform(oNPC)) return;
    }

/******************************************************************************/
//:: OAI HB CODE

    // dk: 2-Jun-2006 Hearbeat guard againast fleeing (non-commandable) creatures who may have
    // called clearall thereforeactions and  not get they next KeepFleeing command
    // Actually there are several instances where
    //      SetCommandable(FALSE); ActionDoCommand(SetCommanable(TRUE);
    // sequences can cause grief
    // Now using a 3 round timeout for this case
    if(!GetCommandable())
    {
      int nRnds = GetLocalInt(OBJECT_SELF, "UNCOMMANDABLE") + 1;
      if(nRnds >= 3)
      {
        DeleteLocalInt(OBJECT_SELF, "UNCOMMANDABLE");
        SetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT",0);
        SetCommandable(TRUE);
        OAI_DetermineCombatRound();
      }
      else
      {
        switch(GetCurrentAction())
        {
          case ACTION_INVALID:
            // THIS SHOULD NOT HAPPEN so fix it if it does
            if (GetLocalInt(OBJECT_SELF, "RETREATED")) KeepFleeing(20.0);
            else
            {
              if (nRnds > 3)
              {
                DeleteLocalInt(OBJECT_SELF, "UNCOMMANDABLE");
                SetLocalInt(OBJECT_SELF,"OAI_ROUNDCOUNT",0);
                SetCommandable(TRUE);
                OAI_DetermineCombatRound();
              }
              else SetLocalInt(OBJECT_SELF, "UNCOMMANDABLE", nRnds);
            }

          //DEBUG
          FloatingTextStringOnCreature("** Awakes from a daze **", OBJECT_SELF);
        }
      }
    }

    // dk: 1-Jun Decrement AI counters here that are based on a number of rounds
    // NOTE: All such counters only work if NPC gets a Heartbeat (ie. player in area normally)
    OAI_DecrementCounter("OAI_ROUNDCOUNT");

    // dk: 10-Dec-2005 skip if performing special action
    // dk: 25-May-2006 Mod to allow automatic time out on stopped ai
    //     Allows to say no heartbeats for X rounds
    int nAIOff = GetAIOff();
    if(nAIOff)
    {
        // Handle AIOff automatic timeout
        if (nAIOff > 0) { SetAIOff(OBJECT_SELF, nAIOff - 1); }

        return;
    }

    //Skip if in combat
    if(GetAttemptedAttackTarget() != OBJECT_INVALID
      || GetAttackTarget() != OBJECT_INVALID
      || GetAttemptedSpellTarget() != OBJECT_INVALID
      || GetIsObjectValid(GetNearestSeenEnemy()))
    {
      // Force detect off if we have battle stations
      DeleteLocalInt(OBJECT_SELF, "OAI_DETECTING");
      SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, FALSE);
      return;
    }

    // Switch detect mode on/off and maintain counter
    int nDetect = GetLocalInt(OBJECT_SELF, "OAI_DETECTING") - 1;
    if (nDetect > 0)
    {
      SetLocalInt(OBJECT_SELF, "OAI_DETECTING", nDetect);
      SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, TRUE);
    }
    else if (nDetect == 0)
    {
      SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, FALSE);
      DeleteLocalInt(OBJECT_SELF, "OAI_DETECTING");
    }

    //Guard Check
    int nGuard = GetLocalInt(oNPC,"OAI_GUARD");
    if(nGuard == 1) { OAI_GuardCheck(oNPC); }

/******************************************************************************/
//:: TAVERNS / INNS

    object oTavern = GetNearestObjectByTag("NW_TAVERN",oNPC,1);
    string sTag = GetTag(oNPC);

    //Cook Check
    int nCook = GetLocalInt(oNPC,"OAI_COOK");
    if(GetIsObjectValid(oTavern) && nCook == 1) { OAI_Cooks(oNPC); return; }

    //Barmaid Check
    int nBarmaid = GetLocalInt(oNPC,"OAI_BARMAID");
    if(GetIsObjectValid(oTavern) && nBarmaid == 1) { OAI_Barmaid(oNPC); return; }

    //Stripper Check
    int nStripper = GetLocalInt(oNPC,"OAI_STRIPPER");
    if(GetIsObjectValid(oTavern) && nStripper == 1) { OAI_Stripper(oNPC); return; }

    //Bar Chatter Check (Only 1 Pair Has a Conversation...Others Just Say Stuff)
    if(GetIsObjectValid(oTavern)
      && sTag != "PackAnimal"
      && sTag != "Horse"
      && sTag != "Pet")
    {
      if(OAI_BarChatterCheck(oNPC,oTavern) == FALSE)
      {
        OAI_BarChatter(oNPC);
        return;
      }
    }

/******************************************************************************/
//:: SPECIAL HB ROLES

    //Trolls
    if(GetBattleCondition(OAI_ROLE_TROLL)) OAI_TrollHB();

    //Vampires
    if(GetBattleCondition(OAI_ROLE_VAMPIRE)) OAI_VampireHB();

/******************************************************************************/
//:: SEARCHING

    // No regular hearbeat for a little while if we are searching
    // Searching values over 10 means we are running at the target
    // This section dontinues any search or chase operation we were performing that
    // may have been inturrupted somehow.
    int nSearch = GetLocalInt(OBJECT_SELF, "OAI_SEARCHING");

    // If searching then we need to think about our search
    if(nSearch > 0)
    {
      location oLoc = GetLocalLocation(OBJECT_SELF, "OAI_SEARCH_LOC");

      // Are we close enough to finish our search?
      if (!GetIsObjectValid(GetAreaFromLocation(oLoc))
        || GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), oLoc) < 2.0)
      {
        nSearch = 0;
      }

      //Decrement search count
      else nSearch--;

      //If last round of searching then cancel search
      if(nSearch < 1 || nSearch == 10)
      {
        DeleteLocalInt(OBJECT_SELF, "OAI_SEARCHING");
        ClearAllActions();
        if (OAI_LootCorpse()) return;   // Loot a corpse, in case we are near one

        // If no looting then we will currently have no actions
        // So look about and detect for enemy
        if (GetCurrentAction() == ACTION_INVALID)
        {
          // Enter detect mode for a little bit
          SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, TRUE);
          SetLocalInt(OBJECT_SELF, "OAI_DETECTING", 2);

          //Some nice semi-random animations
          if (d3() > 1)
          {
            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.5);
            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.5);
          }
          if (d2() == 1) ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
          else if (d2() == 1) ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 0.5, 2.0);

          //Finally return to current waypoint if we have one
          object oWayPt = GetLocalObject(OBJECT_SELF, "WP_" + IntToString(GetLocalInt(OBJECT_SELF, "WP_CUR")));
          if(GetIsObjectValid(oWayPt)) ActionMoveToObject(oWayPt);
        }
        return;
      }

      //Falls through to normal hearbeat
      else
      {
        // Make sure we continue the search if not doing anything
        SetLocalInt(OBJECT_SELF, "OAI_SEARCHING", nSearch);
        switch (GetCurrentAction())
        {
          case ACTION_INVALID:
          case ACTION_RANDOMWALK:
          case ACTION_WAIT:
            ClearAllActions();
            if(nSearch == 2 || nSearch == 12)
            {
              ActionForceMoveToLocation(oLoc, nSearch > 10, 4.0);
            }
            else
            {
              ActionMoveToLocation(oLoc, nSearch > 10);
              if (nSearch > 10) ActionDoCommand(OAI_DetermineCombatRound());
            }
            return;
        }
      }
    }

//:: SEARCHING
/******************************************************************************/

/******************************************************************************/
//:: LIGHT SOURCES

    // Light sources will be wielded at night if all the conditions are met
    //  - if we have one
    //  - we are basically humanoid
    //  - it is night or we are below ground (not in buildings)
    //  - the area we are in does not have the "NOTORCH" int set
    object oWeapon;
    int bCheckLightUser;
    switch (GetRacialType(OBJECT_SELF))
    {
        case RACIAL_TYPE_DWARF:
        case RACIAL_TYPE_ELF:
        case RACIAL_TYPE_GNOME:
        case RACIAL_TYPE_HALFELF:
        case RACIAL_TYPE_HALFLING:
        case RACIAL_TYPE_HALFORC:
        case RACIAL_TYPE_HUMAN:
        case RACIAL_TYPE_HUMANOID_GOBLINOID:
        case RACIAL_TYPE_HUMANOID_ORC:
        case RACIAL_TYPE_HUMANOID_REPTILIAN:
            bCheckLightUser = TRUE;
            break;
        default:
            bCheckLightUser = FALSE;
    }

    if(bCheckLightUser)
    {
        object oArea = GetArea(OBJECT_SELF);
        int bWeildingLightSource = FALSE;
        int bNoTorch = GetLocalInt(oArea, "NOTORCH");
        oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);

        //Are we wielding a light source right now
        if(GetIsObjectValid(oWeapon))
        {
          bWeildingLightSource = GetModPropertyForItem(oWeapon, PROP_LIGHT, PROPV_LIGHT);
        }

        //If day (and in above ground setting), loose any wielded light source
        if((GetIsDay() && GetIsAreaAboveGround(oArea)) || bNoTorch)
        {
          if(bWeildingLightSource)
          {
            ClearAllActions();
            ActionUnequipItem(oWeapon);
            oWeapon = GetLocalObject(OBJECT_SELF, "OAI_LH_MELEE");

            //Reweild any prior item
            if(GetIsObjectValid(oWeapon)) ActionEquipItem(oWeapon, INVENTORY_SLOT_LEFTHAND);
            return;
          }
        }

        //Try to wield a light source if we have one
        else if(!bWeildingLightSource && d4() == 1 && !bNoTorch &&
                !GetIsAreaInterior(oArea) && !GetIsAreaNatural(oArea))
        {
          object oLight = GetModItemWithProperty(OBJECT_SELF, PROP_LIGHT, PROPV_LIGHT);

          //Found a Light Source
          if(GetIsObjectValid(oLight))
          {
            ClearAllActions();

            //Existing Something in Left Hand
            if(GetIsObjectValid(oWeapon)) ActionUnequipItem(oWeapon);

            ActionEquipItem(oLight, INVENTORY_SLOT_LEFTHAND);
            return;
          }
        }
    }

//:: LIGHT SOURCES
/******************************************************************************/

/******************************************************************************/
//:: WEAPONS

    //Sheath our weapons if weilded (based on chance to stop all NPCs doing at same time)
    if(d100() <= 5)
    {
      // Unweild weapons if not needed
      oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
      if(IsWeapon(oWeapon))
      {
        if(GetLocalInt(OBJECT_SELF,"OAI_KEEPEQUIP") != 1) OAI_UnequipWeapons();
      }
    }

//:: WEAPONS
/******************************************************************************/

/******************************************************************************/
//:: BEHAVIOR

    //Here we want to Walk around a bit (IF NOT IN Conversation: dk:2-Feb-2006)
    //We need to make sure we have set up our waypoints or not
    //Remember this routine is interupted easily and may not be run yet, so try again
    // To prevent NPC walking off while shop is open, have the onopen of shop set NrSpeakings
    // on NPC +1 and then -1 when closed
    if(!IsInConversation(OBJECT_SELF) && !GetLocalInt(OBJECT_SELF, "NrSpeakings"))
    {
        int nLooting = GetLocalInt(GetModule(), "OAILOOTING");

        // Honour area looting overide
        if (GetLocalInt(GetArea(OBJECT_SELF), "NOLOOTING")) nLooting = FALSE;

        if (nLooting && d10() == 1)
        {
            // Look for things to pick up
            object oSeen = OAI_SearchForLootable(nLooting == 1, 20.0);
            if (GetIsObjectValid(oSeen))
            {
                if (GetObjectType(oSeen) == OBJECT_TYPE_ITEM)
                {
                    if (!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "WeaponRetrieve1"))) SetLocalObject(OBJECT_SELF, "WeaponRetrieve1", oSeen);
                    else if (!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "WeaponRetrieve2"))) SetLocalObject(OBJECT_SELF, "WeaponRetrieve2", oSeen);
                }
                else
                {
                    SetLocalInt(OBJECT_SELF, "OAI_SEARCHING", 6);  // Have six rounds to get there
                    SetLocalLocation(OBJECT_SELF, "OAI_SEARCH_LOC", GetLocation(oSeen));
                    // Remember end of search causes us to loot nearby containers and look for items
                }
            }
        }
        else if(!GetWalkCondition(NW_WALK_FLAG_INITIALIZED))
        {
          WalkWayPoints();
        }

        // dk: 3-Mar-2006
        //
        // Have task to fetch dropped weapon(s)
        //
        // LATER: Incorporate into generic task system
        else if (GetIsObjectValid(GetLocalObject(OBJECT_SELF, "WeaponRetrieve1")))
        {
            // Have been instructed to retrieve something
            object oMe = OBJECT_SELF;
            object oItem = GetLocalObject(oMe, "WeaponRetrieve1");
            switch (GetCurrentAction(oMe))
            {
                case ACTION_INVALID:
                case ACTION_RANDOMWALK:
                case ACTION_WAIT:
                    // Don't delete the objective until someone has it
                    if (GetItemPossessor(oItem) == OBJECT_INVALID)
                    {
                        ClearAllActions();
                        ActionPickUpItem(oItem);
                        if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMe)))
                        {
                            ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND);
                        }
                    }
                    else
                    {
                        // Look for a second weapon
                        SetLocalObject(oMe, "WeaponRetrieve1", GetLocalObject(oMe, "WeaponRetrieve2"));
                        DeleteLocalObject(oMe, "WeaponRetrieve2");
                        OAI_ResetWeapons(); // dk: 25-May-2006 Consider choices on next weild
                    }
            }
        }

        // dk: special code: not part of OAI. Makes creatures follow assigned leaders
        // with occasional comments voiced in their native tongue (hls_lang)
        else if(GetIsObjectValid(GetLocalObject(OBJECT_SELF, "MyLeader")))
        {
          ExecuteScript("follow_leader", OBJECT_SELF);
        }
        // dK: 8-Jul-2006 Honour Return to Spawnpoint
        else if (GetBattleCondition(OAI_RETURN_TO_SPAWNPOINT)) {
            location lSpawn = GetLocalLocation(OBJECT_SELF, "OAI_SPAWN_LOCATION");
            ClearAllActions();
            ActionForceMoveToLocation(lSpawn);
            ActionDoCommand(SetFacing(GetFacingFromLocation(lSpawn)));
        }

        // If we have the 'constant' waypoints flag set, walk to the next
        // waypoint. 0.5% (plus value of 0.1 * CHANCE_SKIPWALK) chance of not waypoint walking
        // The skipping allows way point walkers to occasionally visit shops/toilets and have a break
        else if(GetWalkCondition(NW_WALK_FLAG_CONSTANT)
          && (Random(1000) > GetLocalInt(oNPC, "CHANCE_SKIPWALK") + 4))
        {
          // There is a 15% (plus 5% * value of CHANCE_NOWALK) chance of just standing there
          // These longer the normall pause add a bit of flavour
          if(d20() > GetLocalInt(oNPC, "CHANCE_NOWALK") + 3) // Allow some other actions to occur
          {
            // dk: 9-Feb-2006
            // Special unable to move condition detected
            // When an NPC is trying to get somewhere and is stuck we will detect this by being with a range
            // on last known location for several heartbeats in a row and having action WALKING
            // When detected make them move elsewhere for a bit
            int NoWalk = FALSE; // Set to true if we do not wish to do walkwaypoints this time around
            if (!GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS))
            {
              if (GetCurrentAction(OBJECT_SELF) == ACTION_MOVETOPOINT)
              {
                location lLastKnown = GetLocalLocation(OBJECT_SELF, "LastLocation");
                int nStuckCnt = GetLocalInt(OBJECT_SELF, "StuckCount") + 1;
                float fDist = GetDistanceBetweenLocations(lLastKnown, GetLocation(OBJECT_SELF));
                if (fDist < 2.0 && fDist >= 0.0)
                {
                  // We are stuck, so keep track of how many times
                  if (nStuckCnt > 3)
                  {
                      // We have been here too long, lets do something about it
                      if (GetLocalInt(GetModule(), "DEBUG")) SpeakString("I am stuck. Trying another path!");
                      ClearAllActions();
                      ActionMoveAwayFromLocation(GetAheadRightLocation(OBJECT_SELF), FALSE, 7.0);
                      DeleteLocalInt(OBJECT_SELF, "StuckCount");
                      NoWalk = TRUE;
                  }
                  else SetLocalInt(OBJECT_SELF, "StuckCount", nStuckCnt);
                }
                else
                {
                  // If not close to last known position
                  // Record variables for next test
                  SetLocalLocation(OBJECT_SELF, "LastLocation", GetLocation(OBJECT_SELF));
                  DeleteLocalInt(OBJECT_SELF, "StuckCount");
                }
              }
              else
              {
                // If not moving
                // Reset variables for next test
                SetLocalLocation(OBJECT_SELF, "LastLocation", GetLocation(OBJECT_SELF));
                DeleteLocalInt(OBJECT_SELF, "StuckCount");
              }
            }
            // Only try to walk waypoints if we are not walking at the moment
            // Might use a switch here later to allow for other actions
            switch (GetCurrentAction(OBJECT_SELF))
            {
              case ACTION_INVALID:
              case ACTION_WAIT:
              case ACTION_SIT:
                // We may have an empty action queue at the moment
                if (!NoWalk)
                {
                    WalkWayPoints();
                }
            }
          }
        }

        // This handles special attacking/fleeing behavior
        // for omnivores & herbivores.
        else if(GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) || GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
        {
          OAI_DetermineSpecialBehavior();
        }
        else
        {
          if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
            || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
            || GetIsEncounterCreature())
          {
            PlayMobileAmbientAnimations();
          }
          else if (GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS))
          {
            PlayImmobileAmbientAnimations();
          }
        }
    }

//:: BEHAVIOR
/******************************************************************************/

    // Send the user-defined event signal if specified
    // Note Search or Light weild/unweild operations will stop getting here
    // As will certain AIOff situations, so be careful what you use it for.
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
      SignalEvent(OBJECT_SELF, EventUserDefined(1001));
    }
}
