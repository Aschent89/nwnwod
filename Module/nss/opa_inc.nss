////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_inc
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

//:****************************************************************************/
//: ANIMAL FUNCTIONS

void OPAHighLightObject(object oTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efx,oTarget,2.0);
}

void OPAHighLightLocation(location lTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, efx, lTarget, 2.0f);
}

int OPA_GetPackAnimalType(object oAnimal)
{
   int nType = 0;
   int nApp = GetAppearanceType(oAnimal);
   switch(nApp)
   {
     case 1021: nType = 1021; break;//Pack Badger (20 Items Max)
     case 1022: nType = 1022; break;//Pack Ox (50 Items Max)
     case 1024: nType = 1024; break;//Pack Ox (50 Items Max)
     case 1249: nType = 1249; break;//Pack Bear (60 Items Max)
     case 1250: nType = 1250; break;//Pack Beetle (30 Items Max)
     case 1251: nType = 1251; break;//Pack Boar (25 Items Max)
     case 1252: nType = 1252; break;//Pack Penguin (20 Items Max)
     case 1781: nType = 1781; break;//Pack Horse (40 Items Max)
     case 1792: nType = 1792; break;//Pack Pony (35 Items Max)
     case 1798: nType = 1798; break;//Pack Horse (40 Items Max)
   }

   return nType;
}

int OPA_GetPackBoxMax(object oAnimal)
{
   int nMax = 0;
   int nApp = GetAppearanceType(oAnimal);
   switch(nApp)
   {
     case 1021: nMax = 20; break;//Pack Badger (20 Items Max)
     case 1022: nMax = 50; break;//Pack Ox (50 Items Max)
     case 1024: nMax = 50; break;//Pack Ox (50 Items Max)
     case 1249: nMax = 60; break;//Pack Bear (60 Items Max)
     case 1250: nMax = 30; break;//Pack Beetle (30 Items Max)
     case 1251: nMax = 25; break;//Pack Boar (25 Items Max)
     case 1252: nMax = 20; break;//Pack Penguin (20 Items Max)
     case 1781: nMax = 40; break;//Pack Horse (40 Items Max)
     case 1792: nMax = 35; break;//Pack Pony (35 Items Max)
     case 1798: nMax = 40; break;//Pack Horse (40 Items Max)
   }

   return nMax;
}

void OPA_PackAssign(object oPC, object oAnimal)
{
  //Give Animal Control Staff
  object oItem = GetItemPossessedBy(oPC,"AnimalControl");
  if(oItem == OBJECT_INVALID)
  {
    oItem = CreateItemOnObject("animalcontrol",oPC,1);
  }

  //Set Strings on Animal
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  SetLocalString(oAnimal, "OPA_OWNER_NAME", sPC);
  SetLocalString(oAnimal, "OPA_OWNER_UNIQUE", sPCU);
  SetLocalString(oAnimal, "OPA_RALLYPOINT", "");
  SetLocalInt(oAnimal,"PACKANIMAL",1);

  //Add this Animal to PC
  string sResRef = GetResRef(oAnimal);
  SetLocalInt(oPC,"OPA_ANIMALTOTAL",1);
  SetLocalInt(oItem,"OPA_ANIMALTOTAL",1);
  SetLocalString(oItem, "OPA_ANIMALRESREF", sResRef);
  SetLocalObject(oAnimal,"OPA_OWNER",oPC);
  SetLocalObject(oPC,"OPA_OWNER",oAnimal);
  int nType = OPA_GetPackAnimalType(oAnimal);
  int nMax = OPA_GetPackBoxMax(oAnimal);
  SetLocalInt(oPC,"OPA_TYPE",nType);
  SetLocalInt(oPC,"OPA_BOXMAX",nMax);
  AssignCommand(oAnimal,ClearAllActions());
  AssignCommand(oAnimal,ActionForceFollowObject(oPC,3.0));
}

void OPA_PackRecall(object oPC)
{
  //Create Player's Animal
  object oItem = GetItemPossessedBy(oPC,"AnimalControl");
  string sAnimal = GetLocalString(oItem, "OPA_ANIMALRESREF");
  location lLoc = GetLocation(oPC);
  object oAnimal = CreateObject(OBJECT_TYPE_CREATURE,sAnimal,lLoc,FALSE);

  //Set The Name
  string sName = GetLocalString(oItem,"OPA_NAME");
  SetName(oAnimal,sName);

  //Set Strings on Animal
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  SetLocalString(oAnimal, "OPA_OWNER_NAME", sPC);
  SetLocalString(oAnimal, "OPA_OWNER_UNIQUE", sPCU);
  SetLocalString(oAnimal, "OPA_RALLYPOINT", "");
  SetLocalInt(oAnimal,"PACKANIMAL",1);
  SetLocalInt(oPC,"OPA_ANIMALTOTAL",1);
  SetLocalInt(oItem,"OPA_ANIMALTOTAL",1);

  //Add this Animal to PC
  SetLocalObject(oAnimal,"OPA_OWNER",oPC);
  SetLocalObject(oPC,"OPA_OWNER",oAnimal);
  int nType = OPA_GetPackAnimalType(oAnimal);
  int nMax = OPA_GetPackBoxMax(oAnimal);
  SetLocalInt(oPC,"OPA_TYPE",nType);
  SetLocalInt(oPC,"OPA_BOXMAX",nMax);
  AssignCommand(oAnimal,ClearAllActions());
  AssignCommand(oAnimal,ActionForceFollowObject(oPC,3.0));
}

void OPA_PackToPlayer(object oPC, object oAnimal)
{
  //Retrieve the New Rally Point Info (Will be "" here)
  string sMoveTo = GetLocalString(oPC,"OPA_RALLYPOINT");

  //Get the Lead Distance
  float fDist = GetLocalFloat(oAnimal,"OPA_DISTANCE");

  //Send the Animal to the Player
  AssignCommand(oAnimal,ClearAllActions());
  if(GetArea(oAnimal) != GetArea(oPC))
  {
    AssignCommand(oAnimal,ClearAllActions(TRUE));
    AssignCommand(oAnimal,ActionJumpToLocation(GetLocation(oPC)));
    SetLocalString(oAnimal, "OPA_RALLYPOINT", sMoveTo);
  }

  //In the same area but Animal is Stuck
  if(GetArea(oAnimal) == GetArea(oPC))
  {
    float fBetween = GetDistanceBetween(oPC, oAnimal);
    if(fBetween > 30.0)
    {
      AssignCommand(oAnimal,ClearAllActions(TRUE));
      AssignCommand(oAnimal,ActionJumpToLocation(GetLocation(oPC)));
      SetLocalString(oAnimal, "OPA_RALLYPOINT", sMoveTo);
      AssignCommand(oAnimal,ActionForceFollowObject(oPC,fDist));
    }
    else
    {
      AssignCommand(oAnimal,ClearAllActions());
      SetLocalString(oAnimal, "OPA_RALLYPOINT", sMoveTo);
      AssignCommand(oAnimal,ActionForceFollowObject(oPC,fDist));
    }
  }
}

void OPA_PackToRally(object oAnimal)
{
  //Retrieve the New Rally Point Info
  string sMoveTo = GetLocalString(oAnimal,"OPA_RALLYPOINT");

  if(sMoveTo != "")
  {
    object oMoveTo = GetNearestObjectByTag(sMoveTo,oAnimal,1);

    AssignCommand(oAnimal,ClearAllActions());
    AssignCommand(oAnimal,ActionMoveToObject(oMoveTo,TRUE,1.0));
  }
}

void OPA_DismissPack(object oPC, object oAnimal)
{
  string sPC = GetLocalString(oAnimal, "OPA_OWNER_NAME");
  string sPCU = GetLocalString(oPC, "PCU");
  string sSPCU = GetLocalString(oAnimal, "OPA_OWNER_UNIQUE");

  //Send the Animal Away
  AssignCommand(oAnimal,ClearAllActions());
  DestroyObject(oAnimal,0.1);
  DeleteLocalObject(oPC,"OPA_OWNER");
  return;
}

//: ANIMAL FUNCTIONS
//:****************************************************************************/

//:****************************************************************************/
//: PACK BOX FUNCTIONS

void SetGroundingFacing(object oAnimal,object oPC, object oBox)
{
  location lLoc = GetLocation(oAnimal);
  float fFace = GetFacing(oPC);
  AssignCommand(oPC,ActionMoveAwayFromLocation(lLoc,TRUE,3.5));
  AssignCommand(oAnimal,ActionMoveAwayFromLocation(lLoc,TRUE,3.5));
  AssignCommand(oBox,DelayCommand(3.5,SetFacing(fFace)));
}

void AccessBox(object oPC, object oAnimal)
{
  AssignCommand(oAnimal,ClearAllActions());
  location lAnimal = GetLocation(oAnimal);
  object oBox = CreateObject(OBJECT_TYPE_PLACEABLE,"packbox",lAnimal,FALSE,"");
  SetLocalInt(oBox,"NOLOOTING",1);
  SetLocalObject(oAnimal,"PackBox",oBox);
  SetLocalObject(oPC,"PackBox",oBox);
  SetLocalObject(oBox,"PackAnimal",oAnimal);
  SetLocalObject(oBox,"PackBoxOwner",oPC);
  SetGroundingFacing(oAnimal,oPC, oBox);
}

void DestroyBox(object oAnimal)
{
  object oBox = GetLocalObject(oAnimal,"PackBox");
  DestroyObject(oBox,0.1);
  DeleteLocalObject(oAnimal,"PackBox");
}

void ReassignBox(object oPC, object oAnimal)
{
  object oBox = GetLocalObject(oPC,"PackBox");
  SetLocalObject(oAnimal,"PackBox",oBox);

  //Now Destroy the Pack Box
  DestroyBox(oAnimal);
}

string OPA_GetDBString(object oPC)
{
  string sPrefix = "OPA_";
  string sPCID = GetName(oPC);
  string sPCU  = GetLocalString(oPC,"PCU");

  string sDB = sPrefix + sPCID + sPCU;

  return GetSubString(sDB, 0, 32);
}

void OPA_AddItemToPack(object oPack, object oItem)
{
  // Color Variables
  string RED = "<có  >";
  string GRAY = "<c°°°>";
  string YELLOW = "<cóó >";

  //Safe Maximum Amount
  object oPC = GetLocalObject(oPack,"PackBoxOwner");
  object oAnimal = GetLocalObject(oPack,"PackAnimal");
  int nMAX = OPA_GetPackBoxMax(oAnimal);
  if(nMAX < 1) nMAX = 20;

  //Current Total of Items
  int nTotal = GetLocalInt(oPack,"OPA_TOTAL");

  nTotal = nTotal + 1;
  SetLocalInt(oPack,"OPA_TOTAL",nTotal);

  //Give Player the Info
  nTotal = GetLocalInt(oPack,"OPA_TOTAL");
  string sPrefix = YELLOW+"My Inventory Value Is : ";
  string sMid = YELLOW+" of ";
  string sTotal = GRAY+IntToString(nTotal);
  string sMax = RED+IntToString(nMAX);
  string sSuffix = YELLOW+" Max.";

  string sNotify = sPrefix + sTotal + sMid + sMax + sSuffix;
  FloatingTextStringOnCreature(sNotify, oPC, FALSE);
}

void OPA_RemoveItemFromPack(object oPack, object oItem)
{
  // Color Variables
  string RED = "<có  >";
  string GRAY = "<c°°°>";
  string YELLOW = "<cóó >";

  //Safe Maximum Amount
  object oPC = GetLocalObject(oPack,"PackBoxOwner");
  object oAnimal = GetLocalObject(oPack,"PackAnimal");
  int nMAX = OPA_GetPackBoxMax(oAnimal);
  if(nMAX < 1) nMAX = 20;

  //Current Total of Items
  int nTotal = GetLocalInt(oPack,"OPA_TOTAL");

  int nType = GetBaseItemType(oItem);

  nTotal = nTotal - 1;
  if(nTotal < 1) nTotal = 0;
  SetLocalInt(oPack,"OPA_TOTAL",nTotal);

  //Give Player the Info
  nTotal = GetLocalInt(oPack,"OPA_TOTAL");
  string sPrefix = YELLOW+"My Inventory Value Is : ";
  string sMid = YELLOW+" of ";
  string sTotal = GRAY+IntToString(nTotal);
  string sMax = RED+IntToString(nMAX);
  string sSuffix = YELLOW+" Max.";

  string sNotify = sPrefix + sTotal + sMid + sMax + sSuffix;
  FloatingTextStringOnCreature(sNotify, oPC, FALSE);
}

void OPA_OpenPack(object oPC, object oPack)
{
  location lLoc = GetLocation(oPC);
  string sDB = OPA_GetDBString(oPC);

  if(!GetIsPC(oPC)) return;
  if(GetIsDM(oPC)) return;
  if(GetIsDMPossessed(oPC)) return;
  if(GetIsPossessedFamiliar(oPC)) return;

  object oStore = RetrieveCampaignObject("OPA_PACK", sDB, GetLocation(oPC));
  DeleteCampaignVariable("OPA_PACK", sDB);
  effect eVis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
  effect eImm = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oStore);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eImm,oStore);

  int nQty = 0;
  object oItem = GetFirstItemInInventory(oStore);
  while(GetIsObjectValid(oItem))
  {
    nQty++;

    CopyItem(oItem, oPack, TRUE);
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oStore);
  }

  DestroyObject(oStore);

  SetLocalInt(oPack,"OPA_TOTAL",nQty);
}

void OPA_ClosePack(object oPC, object oPack)
{
  //Safe Maximum Amount
  object oAnimal = GetLocalObject(oPack,"PackAnimal");
  int nMAX = OPA_GetPackBoxMax(oAnimal);
  if(nMAX < 1) nMAX = 20;

  int nQty = 0;

  SetLocked(oPack, TRUE);

  //Qty and Bag Check in Safe
  object oItem = GetFirstItemInInventory(oPack);
  while (GetIsObjectValid(oItem))
  {
    nQty++;

    if(GetHasInventory(oItem))
    {
      SendMessageToPC(oPC,"Containers and Bags are NOT allowed to be stored. Please remove.");
      SetLocked(oPack, FALSE);
      return;
    }

    if(nQty > nMAX)
    {
      SendMessageToPC(oPC,"Only a Maximum of " + IntToString(nMAX) +
      " can be stored. Please remove excess.");
      SetLocked(oPack, FALSE);
      return;
    }

    oItem = GetNextItemInInventory(oPack);
  }

  //Player is Not Valid
  string sPlayerName = GetPCPlayerName(oPC);
  if(sPlayerName == "")
  {
    SetLocked(oPack, FALSE);
    return;
  }

  string sDB = OPA_GetDBString(oPC);
  object oStore = CreateObject(OBJECT_TYPE_CREATURE, "storage", GetLocation(oPC), FALSE, sDB);
  effect eVis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
  effect eImm = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oStore);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eImm,oStore);

  oItem = GetFirstItemInInventory(oPack);
  while (GetIsObjectValid(oItem))
  {
    CopyItem(oItem, oStore, TRUE);
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oPack);
  }

  StoreCampaignObject("OPA_PACK", sDB, oStore);
  DestroyObject(oStore);
  DelayCommand(10.0, SetLocked(OBJECT_SELF, FALSE));
}

//: PACK BOX FUNCTIONS
//:****************************************************************************/

//void main(){}
