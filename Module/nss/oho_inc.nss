////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_inc
//  By Don Anderson
//  dandersonru@msn.com
//
/*
Credits:
Thanks to DLA for making the Horses.
Thanks Deva Winblood for the math info for Mounting Horses

Notes:
1) All Horses have Saddle Bags. Configure the Maximum in  oho_mod_onload
2) DO NOT use the Bioware Horse Mounting and such for reliable persistent horses.
   There are MANY bugs for the Persistency Portion....please see included Modules
   For more information regarding this.
*/
//
////////////////////////////////////////////////////////////////////////////////

//#include "oai_inc_weapstat"
#include "x3_inc_horse"

string OHODBString(object oPC)
{
  string sPrefix = "OHO_";
  string sPCID = GetName(oPC);
  string sPCU  = GetLocalString(oPC,"PCU");

  string sDB = sPrefix + sPCID + sPCU;

  return GetSubString(sDB, 0, 32);
}

/******************************************************************************/
// :: OLANDER'S HORSE CONSTANTS

const int HORSE_PHENO_NORMAL_MOUNTED    = 3;
const int HORSE_PHENO_NORMAL_SHIELD     = 6;
const int HORSE_PHENO_LARGE_MOUNTED     = 5;
const int HORSE_PHENO_LARGE_SHIELD      = 8;

//:****************************************************************************/
//: HORSE LOCATION FUNCTIONS

void OHOHighLightObject(object oTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efx,oTarget,2.0);
}

void OHOHighLightLocation(location lTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, efx, lTarget, 2.0f);
}

//:****************************************************************************/
//: HORSE ALIGNMENT FUNCTIONS

void OHOAdjustAlign(object oHorse)
{
  object oPC = GetLocalObject(oHorse,"OHO_OWNER");

  string sAlign = GetLocalString(oPC,"OAI_FACTION");
  if(sAlign != "")
  {
    SetLocalString(oHorse,"OAI_FACTION",sAlign);
  }
}

//:****************************************************************************/
//: HORSE ASSIGNMENT AND MODELLING

int OHOHorseBaseTailType(object oHorse)
{
  int nType = HorseGetMountTail(oHorse);
  return nType;
}

int OHOGetPCScaling(object oPC)
{
  int nApp;
  int nRace = GetRacialType(oPC);
  if(nRace == RACIAL_TYPE_DWARF){ nApp = HORSE_NULL_RACE_DWARF; }
  if(nRace == RACIAL_TYPE_ELF){ nApp = HORSE_NULL_RACE_ELF; }
  if(nRace == RACIAL_TYPE_GNOME){ nApp = HORSE_NULL_RACE_GNOME; }
  if(nRace == RACIAL_TYPE_HALFELF){ nApp = HORSE_NULL_RACE_HALFELF; }
  if(nRace == RACIAL_TYPE_HALFLING){ nApp = HORSE_NULL_RACE_HALFLING; }
  if(nRace == RACIAL_TYPE_HALFORC){ nApp = HORSE_NULL_RACE_HALFORC; }
  if(nRace == RACIAL_TYPE_HUMAN){ nApp = HORSE_NULL_RACE_HUMAN; }

  return nApp;
}

void OHOHorseName(object oHorse,object oItem)
{
  string sName = GetLocalString(oItem,"OHO_NAME");
  if(sName != "") SetName(oHorse,sName);
}

int OHOPCRidingHorse(object oPC)
{
  int nPheno = GetPhenoType(oPC);
  if(nPheno == HORSE_PHENO_NORMAL_MOUNTED) return TRUE;
  if(nPheno == HORSE_PHENO_NORMAL_SHIELD) return TRUE;
  if(nPheno == HORSE_PHENO_LARGE_MOUNTED) return TRUE;
  if(nPheno == HORSE_PHENO_LARGE_SHIELD) return TRUE;

  return FALSE;
}

location OHOGetStepLeftLocation(object oPC, object oHorse)
{
  //Now get the Proper Distance (Thanks futurewave for the math info)
  int nApp = GetAppearanceType(oPC);
  string sWTS = Get2DAString("appearance","WING_TAIL_SCALE",nApp);
  float fDist = StringToFloat(sWTS) * 0.8;

  float fDir = GetFacing(oHorse);
  float fAngle = GetLeftDirection(fDir);

  return GenerateNewLocation(oHorse,fDist,fAngle,fDir);
}

void OHOHorseAssign(object oPC, object oHorse)
{
  //Give Horse Control Item
  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  if(oItem == OBJECT_INVALID)
  {
    oItem = CreateItemOnObject("horsecontrol",oPC,1);
  }
  else SetLocalString(oItem,"OHO_NAME","");

  //Set Base Pheno of Player
  SetLocalInt(oItem, "OHO_PHENOTYPE", GetPhenoType(oPC));

  //Set Strings on Animal
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  SetLocalString(oHorse, "OHO_OWNER_NAME", sPC);
  SetLocalString(oHorse, "OHO_OWNER_UNIQUE", sPCU);
  SetLocalString(oHorse, "OHO_RALLYPOINT", "");
  SetLocalInt(oHorse,"HORSE",1);
  SetLocalInt(oItem,"OHO_HORSE_SADDLE",1);

  //Saddle Bags
  int nSB = GetLocalInt(oHorse,"OHO_SADDLEBAGS");
  if(nSB == 1) SetLocalInt(oItem,"OHO_HORSE_SADDLE_BAG",1);

  //Add this Animal to PC
  string sResRef = GetResRef(oHorse);
  SetLocalInt(oItem,"OHO_ANIMALTOTAL",1);
  SetLocalString(oItem, "OHO_ANIMALRESREF", sResRef);
  SetLocalObject(oHorse,"OHO_OWNER",oPC);
  SetLocalObject(oPC,"OHO_OWNER",oHorse);

  //Set Type of Horse
  int nPCS = OHOGetPCScaling(oPC);
  int nApp = OHOHorseBaseTailType(oHorse);

  SetLocalInt(oItem,"OHO_HORSETYPE_ACUR",nApp);
  SetCreatureAppearanceType(oHorse,nPCS);
  SetCreatureTailType(nApp,oHorse);

  //Set Base Player Footsteps
  int nFS = GetFootstepType(oPC);
  SetLocalInt(oItem,"OHO_FOOTSTEP", nFS);

  //Disable Riding Via Radial Menu
  SetLocalInt(oHorse,"X3_HORSE_NOT_RIDEABLE_OWNER",1);
  SetLocalInt(oHorse,"bX3_HAS_SADDLEBAGS",0);

  //Set Hoof Foot Step Type
  SetFootstepType(FOOTSTEP_TYPE_HORSE,oHorse);

  //Follow Player
  SetLocalFloat(oHorse,"OHO_DISTANCE",3.0);
  AssignCommand(oHorse,ClearAllActions());
  AssignCommand(oHorse,ActionForceFollowObject(oPC,3.0));
}

void OHOHorseRecall(object oPC,location lLoc)
{
  //Check for Existing Horse
  object oExist = GetLocalObject(oPC,"OHO_OWNER");
  if(GetIsObjectValid(oExist)) return;

  //Create Player's Animal
  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  string sAnimal = GetLocalString(oItem, "OHO_ANIMALRESREF");
  object oHorse = CreateObject(OBJECT_TYPE_CREATURE,sAnimal,lLoc,FALSE);

  //Set The Name
  string sName = GetLocalString(oItem,"OHO_NAME");
  SetName(oHorse,sName);

  //Now Set Up the Proper Model For This Horse (Barding Included)
  int nPCS = OHOGetPCScaling(oPC);
  int nApp = GetLocalInt(oItem,"OHO_HORSETYPE_ACUR");
  SetCreatureAppearanceType(oHorse,nPCS);
  SetCreatureTailType(nApp,oHorse);

  //Set Hoof Foot Step Type
  SetFootstepType(FOOTSTEP_TYPE_HORSE,oHorse);

  //Set Strings on Animal
  string sPC = GetName(oPC);
  string sPCU = GetLocalString(oPC,"PCU");

  SetLocalString(oHorse, "OHO_OWNER_NAME", sPC);
  SetLocalString(oHorse, "OHO_OWNER_UNIQUE", sPCU);
  SetLocalString(oHorse, "OHO_RALLYPOINT", "");
  SetLocalInt(oHorse,"HORSE",1);
  SetLocalInt(oItem,"OHO_ANIMALTOTAL",1);

  //Set the Name if one Exists on the Horse Control
  OHOHorseName(oHorse,oItem);

  //Adjust Alignment Properly
  OHOAdjustAlign(oHorse);

  //Disable Riding Via Radial Menu
  SetLocalInt(oHorse,"X3_HORSE_NOT_RIDEABLE_OWNER",1);
  SetLocalInt(oHorse,"bX3_HAS_SADDLEBAGS",0);

  //Add this Animal to PC
  SetLocalObject(oHorse,"OHO_OWNER",oPC);
  SetLocalObject(oPC,"OHO_OWNER",oHorse);
  AssignCommand(oHorse,ClearAllActions());
  AssignCommand(oHorse,ActionForceFollowObject(oPC,3.0));
}

void OHOHorseToPlayer(object oPC, object oHorse)
{
  //Retrieve the New Rally Point Info (Will be "" here)
  string sMoveTo = GetLocalString(oPC,"OHO_RALLYPOINT");

  //Get the Lead Distance
  float fDist = GetLocalFloat(oHorse,"OHO_DISTANCE");

  //Send the Animal to the Player
  AssignCommand(oHorse,ClearAllActions());
  if(GetArea(oHorse) != GetArea(oPC))
  {
    AssignCommand(oHorse,ClearAllActions());
    AssignCommand(oHorse,ActionJumpToLocation(GetLocation(oPC)));
    SetLocalString(oHorse, "OHO_RALLYPOINT", sMoveTo);
  }

  //In the same area but Horse is Stuck
  if(GetArea(oHorse) == GetArea(oPC))
  {
    float fBetween = GetDistanceBetween(oPC, oHorse);
    if(fBetween > 30.0)
    {
      AssignCommand(oHorse,ClearAllActions());
      AssignCommand(oHorse,ActionJumpToLocation(GetLocation(oPC)));
      SetLocalString(oHorse, "OHO_RALLYPOINT", sMoveTo);
      AssignCommand(oHorse,ActionForceFollowObject(oPC,fDist));
    }
    else
    {
      if(fBetween > 4.0)
      {
        AssignCommand(oHorse,ClearAllActions());
        SetLocalString(oHorse, "OHO_RALLYPOINT", sMoveTo);
        AssignCommand(oHorse,ActionForceFollowObject(oPC,fDist));
      }
      else
      {
        AssignCommand(oHorse,ClearAllActions());
        SetLocalString(oHorse, "OHO_RALLYPOINT", sMoveTo);
      }
    }
  }
}

void OHOHorseToRally(object oHorse)
{
  if(GetIsInCombat(oHorse)) return;

  //Retrieve the New Rally Point Info
  string sMoveTo = GetLocalString(oHorse,"OHO_RALLYPOINT");

  if(sMoveTo != "")
  {
    object oMoveTo = GetNearestObjectByTag(sMoveTo,oHorse,1);

    AssignCommand(oHorse,ClearAllActions());
    AssignCommand(oHorse,ActionMoveToObject(oMoveTo,TRUE,1.0));
  }
}

void OHODismissHorse(object oPC, object oHorse)
{
  string sPC = GetLocalString(oHorse, "OHO_OWNER_NAME");
  string sPCU = GetLocalString(oPC, "PCU");
  string sSPCU = GetLocalString(oHorse, "OHO_OWNER_UNIQUE");

  //Send the Horse Away
  AssignCommand(oHorse,ClearAllActions());
  DestroyObject(oHorse,0.1);
  DeleteLocalObject(oPC,"OHO_OWNER");
  return;
}

//:****************************************************************************/
//: HORSE MOUNTING/DISMOUNTING

void OHOMount(object oPC, object oHorse)
{
  if(OHOPCRidingHorse(oPC))
  {
    FloatingTextStringOnCreature("*ALREADY MOUNTED*", oPC, FALSE);
    return;
  }

  //Mount Up!
  AssignCommand(oPC,SpeakString("Mount Up!"));

  //Remove Any Existing Speed Decreases Due to Armor or Racial
  RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oPC);

  //Shields Equipped
  int nSE = FALSE;
  object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
  if(GetIsObjectValid(oShield))
  {
    int nShield = GetBaseItemType(oShield);
    if(nShield == BASE_ITEM_SMALLSHIELD
      || nShield == BASE_ITEM_LARGESHIELD
      || nShield == BASE_ITEM_TOWERSHIELD)
    {
      nSE = TRUE;
    }
  }

  //Player Phenos
  int nPheno = GetPhenoType(oPC);
  if(nPheno == PHENOTYPE_NORMAL)
  {
    if(nSE == TRUE)SetPhenoType(HORSE_PHENO_NORMAL_SHIELD,oPC);
    else SetPhenoType(HORSE_PHENO_NORMAL_MOUNTED,oPC);
  }
  if(nPheno == PHENOTYPE_BIG)
  {
    if(nSE == TRUE)SetPhenoType(HORSE_PHENO_LARGE_SHIELD,oPC);
    else SetPhenoType(HORSE_PHENO_LARGE_MOUNTED,oPC);
  }

  //Set Hoof Foot Step Type
  SetFootstepType(FOOTSTEP_TYPE_HORSE,oPC);
  //SetFootstepType(FOOTSTEP_TYPE_HOOF,oPC);

  //Set Type of Horse
  object oHC = GetItemPossessedBy(oPC,"HorseControl");
  int nType = GetLocalInt(oHC,"OHO_HORSETYPE_ACUR");
  SetLocalInt(oHC,"OHO_PCAPPCUR",GetAppearanceType(oPC));
  SetCreatureAppearanceType(oPC,HORSE_SupportGetMountedAppearance(oPC));
  SetCreatureTailType(nType,oPC);

  //Now Set up Player on Horse
  AssignCommand(oPC,SetFacing(GetFacing(oHorse)));
  //AssignCommand(oPC,ActionJumpToLocation(GetLocation(oHorse)));

  //Now Destroy Horse
  effect eVis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
  effect eImm = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oHorse);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eImm,oHorse);
  DestroyObject(oHorse);

  //Add Mounted Bioware Stuff
  SetSkinInt(oPC,"bX3_IS_MOUNTED",TRUE);
  SetLocalInt(oPC,"bX3_M_ARCHERY",TRUE);
  HORSE_SupportIncreaseSpeed(oPC,oHorse);
  DelayCommand(0.4,HORSE_SupportApplyMountedSkillDecreases(oPC));
  HORSE_SupportApplyACBonus(oPC,oHorse);
  HORSE_SupportApplyHPBonus(oPC,oHorse);

  //Remover Previous Skill Effects
  effect eEffect = GetFirstEffect(oPC);
  while(GetIsEffectValid(eEffect))
  {
    if((GetEffectType(eEffect)==EFFECT_TYPE_ATTACK_DECREASE)
      && (GetEffectSubType(eEffect)==SUBTYPE_SUPERNATURAL)
      && (GetEffectDurationType(eEffect)==DURATION_TYPE_PERMANENT))
    {
      RemoveEffect(oPC,eEffect);
      break;
    }

    eEffect=GetNextEffect(oPC);
  }

  //Mounted Archery Skill
  int nNewPenalty = 4;
  if(GetHasFeat(FEAT_MOUNTED_ARCHERY,oPC)) nNewPenalty=2;
  ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAttackDecrease(nNewPenalty)),oPC);
}

void OHOMountHorse(object oPC, object oHorse)
{
  int nHorse = GetLocalInt(oHorse,"HORSE");
  if(nHorse != 1)
  {
    SendMessageToPC(oPC, "Not a Rideable Horse!");
    return;
  }

  //Stop Horse from Moving
  effect eMove = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eMove,oHorse);
  ClearAllActions(TRUE);
  SetCommandable(FALSE,oHorse);

  //Apply Ghost to Player to Walk Through Horse
  effect eGhost = EffectCutsceneGhost();
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oPC,5.0);
  DelayCommand(1.7,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oPC,5.0));

  //Now Get Mounting Location
  location lMount = OHOGetStepLeftLocation(oPC,oHorse);

  //Move Player to Location
  AssignCommand(oPC,ActionMoveToLocation(lMount));
  DelayCommand(1.8,AssignCommand(oPC,SetFacing(GetFacing(oPC)-180.0)));
  DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(HORSE_ANIMATION_MOUNT)));
  DelayCommand(2.9,AssignCommand(oPC,ActionDoCommand(OHOMount(oPC, oHorse))));
}

void OHORefreshCloak(object oPC)
{
  //Now we check for a Cloak and Re-Equip It
  object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
  if(GetIsObjectValid(oCloak))
  {
    DelayCommand(0.1,AssignCommand(oPC,ActionUnequipItem(oCloak)));
    DelayCommand(1.0,AssignCommand(oPC,ActionEquipItem(oCloak,INVENTORY_SLOT_CLOAK)));
  }
}

void OHODismount(object oPC)
{
  //Change Back
  SetCreatureTailType(0,oPC);

  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  int nPheno = GetLocalInt(oItem,"OHO_PHENOTYPE");
  int nFS = GetLocalInt(oItem,"OHO_FOOTSTEP");
  SetPhenoType(nPheno,oPC);
  SetFootstepType(nFS,oPC);

  int nApp = GetLocalInt(oItem,"OHO_PCAPPCUR");
  SetCreatureAppearanceType(oPC,nApp);

  //ORSv5 Armor/Racial Speed Penalties
  SetLocalInt(oPC,"ORS_MOVEMENT_CHANGE",1);

  //Remove Mounted Bioware Stuff
  HORSE_SupportOriginalSpeed(oPC);
  DelayCommand(0.4,HORSE_SupportRemoveMountedSkillDecreases(oPC));
  HORSE_SupportRemoveACBonus(oPC);
  HORSE_SupportRemoveHPBonus(oPC);

  effect eEffect = GetFirstEffect(oPC);
  while(GetIsEffectValid(eEffect))
  {
    if((GetEffectType(eEffect)==EFFECT_TYPE_ATTACK_DECREASE)
      && (GetEffectSubType(eEffect)==SUBTYPE_SUPERNATURAL)
      && (GetEffectDurationType(eEffect)==DURATION_TYPE_PERMANENT))
    {
      RemoveEffect(oPC,eEffect);
      break;
    }

    eEffect=GetNextEffect(oPC);
  }

  SetLocalInt(oPC,"bX3_M_ARCHERY",FALSE);
  SetSkinInt(oPC,"bX3_IS_MOUNTED",FALSE);
}

void OHODismountHorse(object oPC)
{
  if(!OHOPCRidingHorse(oPC))
  {
    FloatingTextStringOnCreature("**NOT MOUNTED**", oPC, FALSE);
    return;
  }

  //Now Get Mounting Location
  location lMount = OHOGetStepLeftLocation(oPC,oPC);
  location lPC = GetLocation(oPC);

  //Apply Ghost to Player to Walk Through Horse
  effect eGhost = EffectCutsceneGhost();
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oPC,5.0);

  DelayCommand(1.0,AssignCommand(oPC,ActionPlayAnimation(HORSE_ANIMATION_DISMOUNT)));
  DelayCommand(2.5,AssignCommand(oPC,ActionDoCommand(OHODismount(oPC))));
  DelayCommand(3.0,AssignCommand(oPC,ActionJumpToLocation(lMount)));
  DelayCommand(4.0,AssignCommand(oPC,ActionDoCommand(OHORefreshCloak(oPC))));

  //Now we check to see if the Animal is Valid or not and create it again
  object oHorse = GetLocalObject(oPC,"OHO_OWNER");
  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  int nHas = GetLocalInt(oItem,"OHO_ANIMALTOTAL");
  string sHorse = GetLocalString(oItem, "OHO_ANIMALRESREF");
  if(sHorse != "" && nHas == 1 && GetIsObjectValid(oHorse) == FALSE)
  {
    DelayCommand(2.6,AssignCommand(oPC,ActionDoCommand(OHOHorseRecall(oPC,lPC))));
  }
}

//:****************************************************************************/
//: SADDLE BAG FUNCTIONS

void OHOSetGroundingFacing(object oHorse,object oPC, object oBag)
{
  location lLoc = GetLocation(oHorse);
  float fFace = GetFacing(oPC);
  AssignCommand(oPC,ActionMoveAwayFromLocation(lLoc,TRUE,2.0));
  AssignCommand(oHorse,ActionMoveAwayFromLocation(lLoc,TRUE,2.0));
  AssignCommand(oBag,DelayCommand(3.5,SetFacing(fFace)));
}

void OHOAccessBag(object oPC, object oHorse)
{
  AssignCommand(oHorse,ClearAllActions(TRUE));
  location lHorse = GetLocation(oHorse);
  object oBag = CreateObject(OBJECT_TYPE_PLACEABLE,"oho_horsesaddle",lHorse,FALSE,"");
  SetLocalInt(oBag,"NOLOOTING",1);
  SetLocalObject(oHorse,"SADDLE_BAG",oBag);
  SetLocalObject(oPC,"SADDLE_BAG",oBag);
  SetLocalObject(oBag,"Horse",oHorse);
  SetLocalObject(oBag,"SADDLE_BAG_OWNER",oPC);
  OHOSetGroundingFacing(oHorse,oPC, oBag);
}

void OHODestroyBag(object oHorse)
{
  object oBag = GetLocalObject(oHorse,"SADDLE_BAG");
  DestroyObject(oBag,0.1);
  DeleteLocalObject(oHorse,"SADDLE_BAG");
}

void OHO_AddItemToBag(object oBag, object oItem)
{
  // Color Variables
  string RED = "<có  >";
  string GRAY = "<c°°°>";
  string YELLOW = "<cóó >";

  //Safe Maximum Amount
  object oPC = GetLocalObject(oBag,"SADDLE_BAG_OWNER");
  int nSBMAX = GetLocalInt(GetModule(),"SBMAX");

  //Current Total of Items
  int nTotal = GetLocalInt(oBag,"OHO_TOTAL");
  nTotal = nTotal + 1;
  SetLocalInt(oBag,"OHO_TOTAL",nTotal);

  //Give Player the Info
  nTotal = GetLocalInt(oBag,"OHO_TOTAL");
  string sPrefix = YELLOW+"My Inventory Value Is : ";
  string sMid = YELLOW+" of ";
  string sTotal = GRAY+IntToString(nTotal);
  string sMax = RED+IntToString(nSBMAX);
  string sSuffix = YELLOW+" Max.";

  string sNotify = sPrefix + sTotal + sMid + sMax + sSuffix;
  FloatingTextStringOnCreature(sNotify, oPC, FALSE);
}

void OHO_RemoveItemFromBag(object oBag, object oItem)
{
  // Color Variables
  string RED = "<có  >";
  string GRAY = "<c°°°>";
  string YELLOW = "<cóó >";

  //Safe Maximum Amount
  object oPC = GetLocalObject(oBag,"SADDLE_BAG_OWNER");
  int nSBMAX = GetLocalInt(GetModule(),"SBMAX");

  //Current Total of Items
  int nTotal = GetLocalInt(oBag,"OHO_TOTAL");
  nTotal = nTotal - 1;
  if(nTotal <= 0) nTotal = 0;
  SetLocalInt(oBag,"OHO_TOTAL",nTotal);

  //Give Player the Info
  nTotal = GetLocalInt(oBag,"OHO_TOTAL");
  string sPrefix = YELLOW+"My Inventory Value Is : ";
  string sMid = YELLOW+" of ";
  string sTotal = GRAY+IntToString(nTotal);
  string sMax = RED+IntToString(nSBMAX);
  string sSuffix = YELLOW+" Max.";

  string sNotify = sPrefix + sTotal + sMid + sMax + sSuffix;
  FloatingTextStringOnCreature(sNotify, oPC, FALSE);
}

void OHO_OpenBag(object oPC, object oBag)
{
  location lLoc = GetLocation(oPC);
  string sDB = OHODBString(oPC);

  if(!GetIsPC(oPC)) return;
  if(GetIsDM(oPC)) return;
  if(GetIsDMPossessed(oPC)) return;
  if(GetIsPossessedFamiliar(oPC)) return;

  object oStore = RetrieveCampaignObject("OHO_SADDLEBAG", sDB, GetLocation(oPC));
  DeleteCampaignVariable("OHO_SADDLEBAG", sDB);
  effect eVis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
  effect eImm = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oStore);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eImm,oStore);

  int nQty = 0;
  object oItem = GetFirstItemInInventory(oStore);
  while(GetIsObjectValid(oItem))
  {
    nQty++;

    CopyItem(oItem, oBag, TRUE);
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oStore);
  }

  DestroyObject(oStore);

  SetLocalInt(oBag,"OHO_TOTAL",nQty);
}

void OHO_CloseBag(object oPC, object oBag)
{
  //Safe Maximum Amount
  int nSBMAX = GetLocalInt(GetModule(),"SBMAX");

  int nQty = 0;

  SetLocked(oBag, TRUE);

  //Qty and Bag Check in Safe
  object oItem = GetFirstItemInInventory(oBag);
  while (GetIsObjectValid(oItem))
  {
    nQty++;

    if(GetHasInventory(oItem))
    {
      SendMessageToPC(oPC,"Containers and Bags are NOT allowed to be stored. Please remove.");
      SetLocked(oBag, FALSE);
      return;
    }

    if(nQty > nSBMAX)
    {
      SendMessageToPC(oPC,"Only a Maximum of " + IntToString(nSBMAX) +
      " can be stored. Please remove excess.");
      SetLocked(oBag, FALSE);
      return;
    }

    oItem = GetNextItemInInventory(oBag);
  }

  //Player is Not Valid
  string sPlayerName = GetPCPlayerName(oPC);
  if(sPlayerName == "")
  {
    SetLocked(oBag, FALSE);
    return;
  }

  string sDB = OHODBString(oPC);
  object oStore = CreateObject(OBJECT_TYPE_CREATURE, "storage", GetLocation(oPC), FALSE, sDB);
  effect eVis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
  effect eImm = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oStore);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eImm,oStore);

  oItem = GetFirstItemInInventory(oBag);
  while (GetIsObjectValid(oItem))
  {
    CopyItem(oItem, oStore, TRUE);
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oBag);
  }

  StoreCampaignObject("OHO_SADDLEBAG", sDB, oStore);
  DestroyObject(oStore);
  DelayCommand(20.0, SetLocked(OBJECT_SELF, FALSE));
}

//void main(){}
