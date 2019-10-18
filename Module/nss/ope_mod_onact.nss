////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_mod_onact
//  By Don Anderson
//  dandersonru@msn.com
//
//  This controls how the Pet follows the player
//
//  This is placed in the Module OnActivate Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ope_inc"

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
  if(sItem != "PetControl") return;

  //Player Information
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  //Using the Animal Control to mark a Rally Point for the Animal
  if(oTarget == OBJECT_INVALID)
  {
    OPEHighLightLocation(lTarget);

    //Get the Previous Rally Point
    oTarget = GetObjectByTag(GetLocalString(oPC, "OPE_RALLYPOINT"));

    //Do not Destroy Previous Creatures,Doors, and Placeables
    if(GetIsObjectValid(oTarget) == TRUE
        && GetObjectType(oTarget) != OBJECT_TYPE_DOOR
        && GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE
        && GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
    {
      return;
    }

    //Make New Rally Point Waypoint and Set a New Tag
    string sTag = "WP_OPE_" + sPCU;
    oTarget = CreateObject(OBJECT_TYPE_WAYPOINT, "ope_rallypoint", lTarget, FALSE, sTag);
    SetLocalString(oPC, "OPE_RALLYPOINT", sTag);
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
    SetLocalString(oPC, "OPE_RALLYPOINT", "");
    AssignCommand(oPC,SpeakString("Come with me my Pet."));

    //Now we check to see if the Animal is Valid or not and create it again
    object oAnimal = GetLocalObject(oPC,"OPE_OWNER");
    int nHas = GetLocalInt(oItem,"OPE_PETTOTAL");
    string sAnimal = GetLocalString(oItem, "OPE_PETRESREF");
    if(sAnimal != "" && nHas == 1 && GetIsObjectValid(oAnimal) == FALSE) AnimalRecall(oPC);
    return;
  }

  //Targetted Creature
  if(oTarget != OBJECT_INVALID
      && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE
      && GetIsEnemy(oTarget, oPC) != TRUE
      && GetIsPC(oTarget) == FALSE)
  {
    int nAnimal = GetLocalInt(oTarget,"PET");

    //Scare the Animal Out of the Way
    if(nAnimal == 1)
    {
      AssignCommand(oPC,ActionSpeakString("Move out of my way Pet!"));
      AssignCommand(oTarget,ClearAllActions());
      AssignCommand(oTarget,ActionMoveAwayFromObject(oPC, TRUE, 5.0));
    }
  }
}
