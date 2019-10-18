////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_mod_onact
//  By Don Anderson
//  dandersonru@msn.com
//
//  This controls how the Pack Animal follows the player
//
//  This is placed in the Module OnActivate Event
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oPC        = GetItemActivator();
  object oItem      = GetItemActivated();
  string sItem      = GetTag(oItem);
  string sResItem   = GetResRef(oItem);
  object oMod       = GetModule();
  object oTarget    = GetItemActivatedTarget();
  location lTarget  = GetItemActivatedTargetLocation();

  //If this was not the Animal Control don't continue
  if(sItem != "AnimalControl") return;

  //Player Information
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  //Using the Animal Control to mark a Rally Point for the Animal
  if(oTarget == OBJECT_INVALID)
  {
    OPAHighLightLocation(lTarget);

    //Get the Previous Rally Point
    oTarget = GetObjectByTag(GetLocalString(oPC, "OPA_RALLYPOINT"));

    //Do not Destroy Previous Creatures,Doors, and Placeables
    if(GetIsObjectValid(oTarget) == TRUE
        && GetObjectType(oTarget) != OBJECT_TYPE_DOOR
        && GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE
        && GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
    {
      DestroyObject(oTarget,0.1);
    }

    //Make New Rally Point Waypoint and Set a New Tag
    string sTag = "WP_OPA_" + sPCU;
    oTarget = CreateObject(OBJECT_TYPE_WAYPOINT, "opa_rallypoint", lTarget, FALSE, sTag);
    SetLocalString(oPC, "OPA_RALLYPOINT", sTag);
  }

  //Targetted Self for Follow Me
  if(oTarget == oPC)
  {
    //Destroy the Previous Rally Waypoint
    string sWPRally = GetLocalString(oPC, "OPA_RALLYPOINT");
    object oWPRally = GetObjectByTag(sWPRally);
    if(GetIsObjectValid(oWPRally) == TRUE
        && GetObjectType(oWPRally) != OBJECT_TYPE_DOOR
        && GetObjectType(oWPRally) != OBJECT_TYPE_PLACEABLE
        && GetObjectType(oWPRally) != OBJECT_TYPE_CREATURE)
    {
      DestroyObject(oWPRally,0.1);
    }

    //Remove Rally Point Tag
    string sName = GetLocalString(oItem,"OPA_NAME");
    if(sName != "")
    {
      AssignCommand(oPC,SpeakString("Come with me "+sName+"."));
    }
    else
    {
      AssignCommand(oPC,SpeakString("Come with me my Beast of Burden."));
    }

    SetLocalString(oPC, "OPA_RALLYPOINT", "");

    //Now we check to see if the Animal is Valid or not and create it again
    object oAnimal = GetLocalObject(oPC,"OPA_OWNER");
    int nHasPA = GetLocalInt(oItem,"OPA_ANIMALTOTAL");
    string sAnimal = GetLocalString(oItem, "OPA_ANIMALRESREF");
    if(sAnimal != "" && nHasPA == 1 && GetIsObjectValid(oAnimal) == FALSE) OPA_PackRecall(oPC);
    return;
  }

  //Targetted Creature
  if(oTarget != OBJECT_INVALID
      && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE
      && GetIsEnemy(oTarget, oPC) != TRUE
      && GetIsPC(oTarget) == FALSE)
  {
    int nAnimal = GetLocalInt(oTarget,"PACKANIMAL");

    //Scare the Animal Out of the Way
    if(nAnimal == 1)
    {
      AssignCommand(oPC,ActionSpeakString("Hee Yaa!"));
      AssignCommand(oTarget,ClearAllActions());
      AssignCommand(oTarget,ActionMoveAwayFromObject(oPC, TRUE, 5.0));
    }
  }
}
