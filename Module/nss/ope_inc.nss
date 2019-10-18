////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_inc
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

//:****************************************************************************/
//: ANIMAL MOVEMENT FUNCTIONS

void OPEHighLightObject(object oTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efx,oTarget,2.0);
}

void OPEHighLightLocation(location lTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, efx, lTarget, 2.0f);
}

void OPEAdjustAlign(object oPet)
{
  object oPC = GetLocalObject(oPet,"OPE_OWNER");
  object oFaction;

  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
  {
    AdjustAlignment(oPet,ALIGNMENT_EVIL,100);
    AdjustAlignment(oPet,ALIGNMENT_GOOD,-100);
    SetLocalString(oPet,"OAI_FACTION","AXIS");

    oFaction = CreateObject(OBJECT_TYPE_CREATURE,"evil_faction",GetLocation(oPet));
    ChangeFaction(oPet,oFaction);
    DestroyObject(oFaction,2.0);
  }
  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
  {
    AdjustAlignment(oPet,ALIGNMENT_GOOD,100);
    AdjustAlignment(oPet,ALIGNMENT_EVIL,-100);
    SetLocalString(oPet,"OAI_FACTION","ALLY");

    oFaction = CreateObject(OBJECT_TYPE_CREATURE,"good_faction",GetLocation(oPet));
    ChangeFaction(oPet,oFaction);
    DestroyObject(oFaction,2.0);
  }
  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
  {
    AdjustAlignment(oPet,ALIGNMENT_GOOD,50);
    AdjustAlignment(oPet,ALIGNMENT_EVIL,50);
    SetLocalString(oPet,"OAI_FACTION","INDEPENDENT");

    oFaction = CreateObject(OBJECT_TYPE_CREATURE,"neut_faction",GetLocation(oPet));
    ChangeFaction(oPet,oFaction);
    DestroyObject(oFaction,2.0);
  }
}

void OPEResetReputations(object oPet)
{
  //Miscaneous Factions
  object oSpecial  = GetObjectByTag("FACTION_1000");
  object oCommoner = GetObjectByTag("FACTION_1001");
  object oMerchant = GetObjectByTag("FACTION_1002");
  object oDefender = GetObjectByTag("FACTION_1003");
  object oHostile  = GetObjectByTag("FACTION_1004");
  object oPackAnimal = GetObjectByTag("FACTION_1005");
  object oHorse = GetObjectByTag("FACTION_1006");
  object oPet = GetObjectByTag("FACTION_1007");

  //Commoner and Merchant Special Reset
  SetStandardFactionReputation(STANDARD_FACTION_COMMONER,50,oPet);
  SetStandardFactionReputation(STANDARD_FACTION_DEFENDER,50,oPet);
  SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPet);

  //Hostile Reset
  SetStandardFactionReputation(STANDARD_FACTION_HOSTILE,0,oPet);

  //Adjust Special Reputations
  AdjustReputation(oPet,oSpecial,50);
  AdjustReputation(oPet,oPackAnimal,50);
  AdjustReputation(oPet,oHorse,50);
}

void AnimalAssign(object oPC, object oAnimal)
{
  //Give Animal Control Staff
  object oItem = GetItemPossessedBy(oPC,"PetControl");
  if(oItem == OBJECT_INVALID)
  {
    oItem = CreateItemOnObject("petcontrol",oPC,1);
  }

  //Set Strings on Animal
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  SetLocalString(oAnimal, "OPE_OWNER_NAME", sPC);
  SetLocalString(oAnimal, "OPE_OWNER_UNIQUE", sPCU);
  SetLocalString(oAnimal, "OPE_RALLYPOINT", "");
  SetLocalInt(oAnimal,"PET",1);

  //Add this Animal to PC
  string sResRef = GetResRef(oAnimal);
  SetLocalInt(oPC,"OPE_PETTOTAL",1);
  SetLocalInt(oItem,"OPE_PETTOTAL",1);
  SetLocalString(oItem, "OPE_PETRESREF", sResRef);
  SetLocalObject(oAnimal,"OPE_OWNER",oPC);
  SetLocalObject(oPC,"OPE_OWNER",oAnimal);
  AssignCommand(oAnimal,ClearAllActions());
  AssignCommand(oAnimal,ActionForceFollowObject(oPC,3.0));
}

void AnimalRecall(object oPC)
{
  //Create Player's Animal
  object oItem = GetItemPossessedBy(oPC,"PetControl");
  string sAnimal = GetLocalString(oItem, "OPE_PETRESREF");
  location lLoc = GetLocation(oPC);
  object oAnimal = CreateObject(OBJECT_TYPE_CREATURE,sAnimal,lLoc,FALSE);

  //Set Strings on Animal
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  SetLocalString(oAnimal, "OPE_OWNER_NAME", sPC);
  SetLocalString(oAnimal, "OPE_OWNER_UNIQUE", sPCU);
  SetLocalString(oAnimal, "OPE_RALLYPOINT", "");
  SetLocalInt(oAnimal,"PET",1);
  SetLocalInt(oPC,"OPE_PETTOTAL",1);
  SetLocalInt(oItem,"OPE_PETTOTAL",1);

  //Adjust Alignment Properly
  OPEAdjustAlign(oAnimal);

  //Add this Animal to PC
  SetLocalObject(oAnimal,"OPE_OWNER",oPC);
  SetLocalObject(oPC,"OPE_OWNER",oAnimal);
  AssignCommand(oAnimal,ClearAllActions());
  AssignCommand(oAnimal,ActionForceFollowObject(oPC,3.0));
}

void AnimalToPlayer(object oPC, object oAnimal)
{
  //Retrieve the New Rally Point Info (Will be "" here)
  string sMoveTo = GetLocalString(oPC,"OPE_RALLYPOINT");

  //Get the Lead Distance
  float fDist = GetLocalFloat(oAnimal,"OPE_DISTANCE");

  //Send the Animal to the Player
  AssignCommand(oAnimal,ClearAllActions());
  if(GetArea(oAnimal) != GetArea(oPC))
  {
    AssignCommand(oAnimal,ClearAllActions());
    AssignCommand(oAnimal,ActionJumpToLocation(GetLocation(oPC)));
    SetLocalString(oAnimal, "OPE_RALLYPOINT", sMoveTo);
  }

  //In the same area but Animal is Stuck
  if(GetArea(oAnimal) == GetArea(oPC))
  {
    float fBetween = GetDistanceBetween(oPC, oAnimal);
    if(fBetween > 30.0)
    {
      AssignCommand(oAnimal,ClearAllActions());
      AssignCommand(oAnimal,ActionJumpToLocation(GetLocation(oPC)));
      SetLocalString(oAnimal, "OPE_RALLYPOINT", sMoveTo);
      AssignCommand(oAnimal,ActionForceFollowObject(oPC,fDist));
    }
    else
    {
      AssignCommand(oAnimal,ClearAllActions());
      SetLocalString(oAnimal, "OPE_RALLYPOINT", sMoveTo);
      AssignCommand(oAnimal,ActionForceFollowObject(oPC,fDist));
    }
  }
}

void AnimalToRally(object oAnimal)
{
  if(GetIsInCombat(oAnimal)) return;

  //Retrieve the New Rally Point Info
  string sMoveTo = GetLocalString(oAnimal,"OPE_RALLYPOINT");

  if(sMoveTo != "")
  {
    object oMoveTo = GetNearestObjectByTag(sMoveTo,oAnimal,1);

    AssignCommand(oAnimal,ClearAllActions());
    AssignCommand(oAnimal,ActionMoveToObject(oMoveTo,TRUE,1.0));
  }
}

void DismissAnimal(object oPC, object oAnimal)
{
  string sPC = GetLocalString(oAnimal, "OPE_OWNER_NAME");
  string sPCU = GetLocalString(oPC, "PCU");
  string sSPCU = GetLocalString(oAnimal, "OPE_OWNER_UNIQUE");

  //Remove Pet Control
  object oItem = GetItemPossessedBy(oPC,"PetControl");
  DestroyObject(oItem);

  //Send the Animal Away
  AssignCommand(oAnimal,ClearAllActions());
  DestroyObject(oAnimal,0.1);
  DeleteLocalObject(oPC,"OPE_OWNER");
  return;
}

//: ANIMAL MOVEMENT FUNCTIONS
//:****************************************************************************/

//void main(){}
