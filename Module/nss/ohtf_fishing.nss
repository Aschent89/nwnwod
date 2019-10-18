////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - HTF System - Fishing
//  ohtf_fishing
//  Modified by Don Anderson
//  dandersonru@msn.com
//
//  Original Script by Nouny (x@nouny.com)
//      Thanks for a nice base script!
//
//  Placed in the Module On Activate Item Event
//
//  You MUST equip the Fishing Rod.
//
//  You also must be in a body of water...basically
//  a water source trigger that can be used for filling
//  the Canteen or Fishing.
//
//  NOTE: You will get a message when you enter one
//        of these triggers letting you know you can
//        fish or fill the Canteen.
//
//  The Fresh Fish can be cooked on the campfire for roasted
//  fish you can eat =).
//
////////////////////////////////////////////////////////////////////////////////

#include "ohtf_inc"

void main()
{
    object oPC          = GetItemActivator();
    object oItem        = GetItemActivated();
    string sItemTag     = GetTag(oItem);
    object oWeapon      = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sWeaponTag   = GetTag(oWeapon);
    location lLoc       = GetLocation(oPC);
    int nDEX            = GetAbilityModifier (ABILITY_DEXTERITY, oPC);
    int nWIS            = GetAbilityModifier (ABILITY_WISDOM, oPC);
    string RED          = "<có  >";
    string GRAY         = "<c°°°>";
    string sWBody       = GetLocalString(oPC,"WATERBODY");//Set when entering and exiting Water Source Triggers
    int nWSource        = GetLocalInt(oPC,"WSOURCE");//Set when entering and exiting Water Source Triggers
    string sRod         = "FishingRod";

    if ((sWeaponTag != sRod) || (sItemTag != sRod)) return;

    //The Player DID NOT enter the water trigger
    else if ((nWSource == FALSE)
        && (sWeaponTag == sRod))
    {
      SendMessageToPC(oPC,NOFISHINGHERE);
      return;
    }
    //The Player DID enter the water trigger
    else if ((nWSource == TRUE)
        && (sWeaponTag == sRod))
    {
      //Fishing Skill Roll
      int nRoll     = d20(); //The roll

      //Cap Personal Abilities at +4
      if(nDEX > 4) nDEX = 4;
      if(nWIS > 4) nWIS = 4;

      int nTotal    = nRoll + nDEX + nDEX; //Total roll
      int nFishLong = d20() + 9; //The longer of the fish
      string sFish  = IntToString(nFishLong);

      string sNothing = GRAY+"I hooked nothing on this cast.";

      string sMessageGold1 = "I think I hooked a log.";
      string sMessageGold2 = "I hooked something.....lifeless.";

      string sMessageSnap1 = "Damn...snapped that line.";
      string sMessageSnap2 = "That was my favorite hook.";
      string sMessageSnap3 = "Another line break....I bet that was a DOOZY!";
      string sMessageSnap4 = "Yikes....the fish that broke the line was SOOO big it might have eaten me.";
      string sMessageSnap5 = "Grrr...&%$#@%$!!!";
      string sMessageSnap6 = "Come closer so I can bash ya!";
      string sMessageSnap7 = "Speckle Ridden Water Leech! Get BACK here with my HOOK!!";
      string sMessageSnap8 = "Ohhhh....for the love of Pete!!";
      string sMessageSnap9 = "Ouch. Cheap flaming fishing line.";
      string sMessageSnap10 = "Hmmm...that fish was a monster. Time to go drink.";

      string sMessageFish1 = "Oooo....easy now.";
      string sMessageFish2 = "Now I have ya.";
      string sMessageFish3 = "Not getting away this time.";
      string sMessageFish4 = "The campfire warm and ready.";
      string sMessageFish5 = "Now THIS feels like a DOOZY.";
      string sMessageFish6 = "Trying to Out fight me? Don't even think of it.";
      string sMessageFish7 = "Well....looky here!";
      string sMessageFish8 = "Get...in here now.";
      string sMessageFish9 = "This is ONE BIG FISH.";
      string sMessageFish10 = "Well now....what have we here?";

      string sGold = RED+"I drug out a Bag of Gold!";
      string sTrout = RED+"I caught a Trout!";
      string sSalmon = RED+"I caught a Salmon!";
      string sBass = RED+"I caught a Bass!";
      string sPike = RED+"I caught a Pike!";
      string sLhimil = RED+"I caught a Lhimil? Not sure if I want to touch it.";
      string sCrab = RED+"I caught a Crab!";
      string sLobster = RED+"I caught a Lobster!";
      string sTuna = RED+"I caught a Tuna!";

      //Start of Fishing
      AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_TALK_PLEADING, 1.0, 3.0));
      DelayCommand( 4.0, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_SALUTE)));
      DelayCommand( 8.0, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_SALUTE)));
      DelayCommand(12.0, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_SALUTE)));
      DelayCommand(16.0, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_SALUTE)));
      DelayCommand(20.0, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_SALUTE)));

      //Message Player Hooked Something
      if(nTotal >= 18)
      {
        int nMess = d10();
        string sHooked;
        if(nMess == 1) sHooked = sMessageFish1;
        if(nMess == 2) sHooked = sMessageFish2;
        if(nMess == 3) sHooked = sMessageFish3;
        if(nMess == 4) sHooked = sMessageFish4;
        if(nMess == 5) sHooked = sMessageFish5;
        if(nMess == 6) sHooked = sMessageFish6;
        if(nMess == 7) sHooked = sMessageFish7;
        if(nMess == 8) sHooked = sMessageFish8;
        if(nMess == 9) sHooked = sMessageFish9;
        if(nMess == 10) sHooked = sMessageFish10;

        DelayCommand(12.0, FloatingTextStringOnCreature(GRAY+sHooked, oPC, FALSE));
      }

      //50% Chance to Snap a Line
      if(nTotal >= 18 && d2() == 1)
      {
        int nSnap = d10();
        string sSnap;
        if(nSnap == 1) sSnap = sMessageSnap1;
        if(nSnap == 2) sSnap = sMessageSnap2;
        if(nSnap == 3) sSnap = sMessageSnap3;
        if(nSnap == 4) sSnap = sMessageSnap4;
        if(nSnap == 5) sSnap = sMessageSnap5;
        if(nSnap == 6) sSnap = sMessageSnap6;
        if(nSnap == 7) sSnap = sMessageSnap7;
        if(nSnap == 8) sSnap = sMessageSnap8;
        if(nSnap == 9) sSnap = sMessageSnap9;
        if(nSnap == 10) sSnap = sMessageSnap10;

        DelayCommand(20.0, FloatingTextStringOnCreature(RED+sSnap, oPC, FALSE));
      }

      //Tell Player Dice Roll
      string sTotal = GRAY+IntToString(nTotal);
      string sRoll = GRAY+IntToString(nRoll);
      string sFinal = "Fishing Skill Roll : "+sTotal+" vs. D20 : "+sRoll;
      DelayCommand(24.0, FloatingTextStringOnCreature(sFinal, oPC, FALSE));

      //DC check to catch a fish
      if(nTotal >= 18)
      {
        int nCatch= d100(); //ok, what did the PC catch?

        //PC gets a loot bag!
        if(nCatch == 100)
        {
          if(d2() == 1)
          {
            DelayCommand(12.0, FloatingTextStringOnCreature(sMessageGold1, oPC, FALSE));
          }
          else
          {
            DelayCommand(12.0, FloatingTextStringOnCreature(sMessageGold2, oPC, FALSE));
          }

          DelayCommand(24.0, FloatingTextStringOnCreature(sGold, oPC, FALSE));
          DelayCommand(25.0, AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_CHEER)));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY1)));
          CreateObject(OBJECT_TYPE_PLACEABLE, "tres_goldlow001", lLoc, TRUE);
        }

/******************************************************************************/
//:: STREAM FISHING

        //Trout Fishing from a Stream
        if ((nCatch >= 21) && (nCatch <= 99) && (sWBody == "Stream"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sTrout, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY3)));
          CreateObject(OBJECT_TYPE_ITEM, "freshtrout", lLoc, TRUE);
        }

        //Salmon Fishing from a Stream
        if ((nCatch >= 1) && (nCatch <= 20) && (sWBody == "Stream"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sSalmon, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY1)));
          CreateObject(OBJECT_TYPE_ITEM, "freshsalmon", lLoc, TRUE);
        }

/******************************************************************************/
//:: LAKE FISHING

        //Trout Fishing from a Lake
        if ((nCatch >= 51) && (nCatch <= 99) && (sWBody == "Lake"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sTrout, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY3)));
          CreateObject(OBJECT_TYPE_ITEM, "freshtrout", lLoc, TRUE);
        }

        //Bass Fishing from a Lake
        if ( (nCatch >= 21) && (nCatch <= 50) && (sWBody == "Lake"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sBass, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY2)));
          CreateObject(OBJECT_TYPE_ITEM, "freshbass", lLoc, TRUE);
        }

        //Pike Fishing from a Lake
        if ( (nCatch >= 1) && (nCatch <= 20) && (sWBody == "Lake"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sPike, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY1)));
          CreateObject(OBJECT_TYPE_ITEM, "freshpike", lLoc, TRUE);
        }

/******************************************************************************/
//:: SALT WATER FISHING

        //Lhimil Fishing
        if ((nCatch >= 71) && (nCatch <= 99) && (sWBody == "Salt Water"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sLhimil, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY3)));
          CreateObject(OBJECT_TYPE_ITEM, "freshlhimil", lLoc, TRUE);
        }

        //Salmon Fishing
        if ((nCatch >= 51) && (nCatch <= 70) && (sWBody == "Salt Water"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sSalmon, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY2)));
          CreateObject(OBJECT_TYPE_ITEM, "freshsalmon", lLoc, TRUE);
        }

        //Tuna Fishing
        if ((nCatch >= 41) && (nCatch <= 50) && (sWBody == "Salt Water"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sTuna, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY1)));
          CreateObject(OBJECT_TYPE_ITEM, "freshtuna", lLoc, TRUE);
        }

        //Crab Fishing
        if ((nCatch >= 21) && (nCatch <= 40) && (sWBody == "Salt Water"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sCrab, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY3)));
          CreateObject(OBJECT_TYPE_ITEM, "freshcrab", lLoc, TRUE);
        }

        //Lobster Fishing
        if ((nCatch >= 1) && (nCatch <= 20) && (sWBody == "Salt Water"))
        {
          DelayCommand(24.0, FloatingTextStringOnCreature(sLobster, oPC, FALSE));
          DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY3)));
          CreateObject(OBJECT_TYPE_ITEM, "freshlobster", lLoc, TRUE);
        }
      }

/******************************************************************************/

      //You caught nothing
      else
      {
        DelayCommand(24.0, FloatingTextStringOnCreature(sNothing, oPC, FALSE));
        DelayCommand(25.5, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
      }
    }
    else return;
}
