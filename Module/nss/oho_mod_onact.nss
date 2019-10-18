////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_mod_onact
//  By Don Anderson
//  dandersonru@msn.com
//
//  This controls how the Horse follows the player
//
//  This is placed in the Module OnActivate Event
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC        = GetItemActivator();
  object oItem      = GetItemActivated();
  string sItem      = GetTag(oItem);
  string sResItem   = GetResRef(oItem);
  object oMod       = GetModule();
  object oTarget    = GetItemActivatedTarget();
  location lTarget  = GetItemActivatedTargetLocation();

  //If this was not the Horse Control don't continue
  if(sItem != "HorseControl") return;

  //Player Information
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  //Using the Horse Control to mark a Rally Point for the Horse
  if(oTarget == OBJECT_INVALID)
  {
    OHOHighLightLocation(lTarget);

    //Get the Previous Rally Point
    oTarget = GetObjectByTag(GetLocalString(oPC, "OHO_RALLYPOINT"));

    //Do not Destroy Previous Creatures,Doors, and Placeables
    if(GetIsObjectValid(oTarget) == TRUE
        && GetObjectType(oTarget) != OBJECT_TYPE_DOOR
        && GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE
        && GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
    {
      DestroyObject(oTarget,0.1);
    }

    //Make New Rally Point Waypoint and Set a New Tag
    string sTag = "WP_OHO_" + sPCU;
    oTarget = CreateObject(OBJECT_TYPE_WAYPOINT, "oho_rallypoint", lTarget, FALSE, sTag);
    SetLocalString(oPC, "OHO_RALLYPOINT", sTag);
  }

  //Targetted Self for Follow Me
  if(oTarget == oPC)
  {
    //Destroy the Previous Rally Waypoint
    string sWPRally = GetLocalString(oPC, "OHO_RALLYPOINT");
    object oWPRally = GetObjectByTag(sWPRally);
    if(GetIsObjectValid(oWPRally) == TRUE
        && GetObjectType(oWPRally) != OBJECT_TYPE_DOOR
        && GetObjectType(oWPRally) != OBJECT_TYPE_PLACEABLE
        && GetObjectType(oWPRally) != OBJECT_TYPE_CREATURE)
    {
      DestroyObject(oWPRally,0.1);
    }

    //Now We Dismount if We Are Mounted
    if(OHOPCRidingHorse(oPC))
    {
      AssignCommand(oPC,SpeakString("Dismount!"));
      OHODismountHorse(oPC);
    }
    else
    {
      string sName = GetLocalString(oItem,"OHO_NAME");
      if(sName != "")
      {
        AssignCommand(oPC,SpeakString("Come with me "+sName+"."));
      }
      else AssignCommand(oPC,SpeakString("Come with me my Horse."));

      //Now we check to see if the Animal is Valid or not and create it again
      object oHorse = GetLocalObject(oPC,"OHO_OWNER");
      int nHas = GetLocalInt(oItem,"OHO_ANIMALTOTAL");
      string sHorse = GetLocalString(oItem, "OHO_ANIMALRESREF");
      location lPC = GetLocation(oPC);
      if(sHorse != "" && nHas == 1 && GetIsObjectValid(oHorse) == FALSE) OHOHorseRecall(oPC,lPC);
    }

    //Remove Rally Point Tag
    SetLocalString(oPC, "OHO_RALLYPOINT", "");

    return;
  }

  //Targetted Creature
  if(oTarget != OBJECT_INVALID
      && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE
      && GetIsEnemy(oTarget, oPC) != TRUE
      && GetIsPC(oTarget) == FALSE)
  {
    int nHorse = GetLocalInt(oTarget,"HORSE");

    //Move the Horse Out of the Way
    if(nHorse == 1)
    {
      AssignCommand(oPC,ActionSpeakString("Hee Yaa!"));
      AssignCommand(oTarget,ClearAllActions());
      AssignCommand(oTarget,ActionMoveAwayFromObject(oPC, TRUE, 5.0));
    }
  }
}
