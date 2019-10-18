////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Banking
//  obk_bank_balance
//  By Don Anderson
//  dandersonru@msn.com
//
//  Gets Gold Deposited Amount
//
////////////////////////////////////////////////////////////////////////////////

//#include "oai_inc_weapstat"

//Bank Gold Database String
string OBK_GetBankGoldDBString(object oPC, object oBank);

//Bank Safe Database String
string OBK_GetBankSafeDBString(object oPC, object oSafe);

//Bank Safe Public Database String
string OBK_GetBankSafePublicDBString(object oPC, object oSafe);

//Open Safe Routine for Bank Safes
void OBK_OpenSafe(object oPC, object oSafe);

//Close Safe Routine for Bank Safes
void OBK_CloseSafe(object oPC, object oSafe);

//Add Item to Safe for Verbal Total
void OBK_AddItemToSafe(object oSafe, object oItem);

//Remove Item From Safe for Verbal Total
void OBK_RemoveItemFromSafe(object oSafe, object oItem);


string OBK_GetBankGoldDBString(object oPC, object oBank)
{
  string sPrefix = "OBK_GOLD_";
  string sBank = GetTag(oBank);
  string sPCID = GetName(oPC);
  string sPCU  = GetLocalString(oPC,"PCU");

  string sDB = sPrefix + sBank + sPCID + sPCU;

  return GetSubString(sDB, 0, 32);
}

string OBK_GetBankSafeDBString(object oPC, object oSafe)
{
  string sPrefix = "OBK_SAFE_";
  string sSafe = GetTag(oSafe);
  string sPCID = GetName(oPC);
  string sPCU  = GetLocalString(oPC,"PCU");

  string sDB = sPrefix + sSafe + sPCID + sPCU;

  return GetSubString(sDB, 0, 32);
}

string OBK_GetBankSafePublicDBString(object oPC, object oSafe)
{
  string sPrefix = "OBK_PUB_";
  string sSafe = GetTag(oSafe);

  string sDB = sPrefix + sSafe;

  return GetSubString(sDB, 0, 32);
}

void OBK_AddItemToSafe(object oSafe, object oItem)
{
  // Color Variables
  string RED = "<có  >";
  string GRAY = "<c°°°>";
  string YELLOW = "<cóó >";

  //Safe Maximum Amount
  object oPC = GetLocalObject(oSafe,"OBK_OWNER");
  int nOBKMAXITEMS = GetLocalInt(GetModule(),"OBKMAXITEMS");
  if(nOBKMAXITEMS < 1) nOBKMAXITEMS = 20;

  //Current Total of Items
  int nTotal = GetLocalInt(oSafe,"OBK_TOTAL");

  int nType = GetBaseItemType(oItem);

  nTotal = nTotal + 1;
  SetLocalInt(oSafe,"OBK_TOTAL",nTotal);

  //Give Player the Info
  nTotal = GetLocalInt(oSafe,"OBK_TOTAL");
  string sPrefix = YELLOW+"My Inventory Value Is : ";
  string sMid = YELLOW+" of ";
  string sTotal = GRAY+IntToString(nTotal);
  string sMax = RED+IntToString(nOBKMAXITEMS);
  string sSuffix = YELLOW+" Max.";

  string sNotify = sPrefix + sTotal + sMid + sMax + sSuffix;
  FloatingTextStringOnCreature(sNotify, oPC, FALSE);
}

void OBK_RemoveItemFromSafe(object oSafe, object oItem)
{
  // Color Variables
  string RED = "<có  >";
  string GRAY = "<c°°°>";
  string YELLOW = "<cóó >";

  //Safe Maximum Amount
  object oPC = GetLocalObject(oSafe,"OBK_OWNER");
  int nOBKMAXITEMS = GetLocalInt(GetModule(),"OBKMAXITEMS");
  if(nOBKMAXITEMS < 1) nOBKMAXITEMS = 20;

  //Current Total of Items
  int nTotal = GetLocalInt(oSafe,"OBK_TOTAL");

  int nType = GetBaseItemType(oItem);

  nTotal = nTotal - 1;
  SetLocalInt(oSafe,"OBK_TOTAL",nTotal);

  //Give Player the Info
  nTotal = GetLocalInt(oSafe,"OBK_TOTAL");
  string sPrefix = YELLOW+"My Inventory Value Is : ";
  string sMid = YELLOW+" of ";
  string sTotal = GRAY+IntToString(nTotal);
  string sMax = RED+IntToString(nOBKMAXITEMS);
  string sSuffix = YELLOW+" Max.";

  string sNotify = sPrefix + sTotal + sMid + sMax + sSuffix;
  FloatingTextStringOnCreature(sNotify, oPC, FALSE);
}

void OBK_OpenSafe(object oPC, object oSafe)
{
  location lLoc = GetLocation(oPC);
  string sDB = OBK_GetBankSafeDBString(oPC,oSafe);

  if(!GetIsPC(oPC)) return;
  if(GetIsDM(oPC)) return;
  if(GetIsDMPossessed(oPC)) return;
  if(GetIsPossessedFamiliar(oPC)) return;

  //Public Safe
  int nPublic = GetLocalInt(oSafe,"OBK_PUBLIC");
  if(nPublic == 1)
  {
    sDB = OBK_GetBankSafePublicDBString(oPC,oSafe);
  }

  object oStore = RetrieveCampaignObject("OBK_BANKING", sDB, GetLocation(oPC));
  DeleteCampaignVariable("OBK_BANKING", sDB);
  effect eVis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
  effect eImm = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oStore);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eImm,oStore);

  int nQty = 0;
  object oItem = GetFirstItemInInventory(oStore);
  while(GetIsObjectValid(oItem))
  {
    nQty++;

    CopyItem(oItem, oSafe, TRUE);
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oStore);
  }

  DestroyObject(oStore);

  SetLocalInt(oSafe,"OBK_TOTAL",nQty);

  SetLocalObject(oSafe,"OBK_OWNER",oPC);
}

void OBK_CloseSafe(object oPC, object oSafe)
{
  //Safe Maximum Amount
  int nOBKMAXITEMS = GetLocalInt(GetModule(),"OBKMAXITEMS");

  int nQty = 0;

  SetLocked(oSafe, TRUE);

  //Qty and Bag Check in Safe
  object oItem = GetFirstItemInInventory(oSafe);
  while (GetIsObjectValid(oItem))
  {
    nQty++;

    if(GetHasInventory(oItem))
    {
      SendMessageToPC(oPC,"Containers and Bags are NOT allowed to be stored. Please remove.");
      SetLocked(oSafe, FALSE);
      return;
    }

    if(nQty > nOBKMAXITEMS)
    {
      SendMessageToPC(oPC,"Only a Maximum of " + IntToString(nOBKMAXITEMS) +
      " can be stored. Please remove excess.");
      SetLocked(oSafe, FALSE);
      return;
    }

    oItem = GetNextItemInInventory(oSafe);
  }

  //Player is Not Valid
  string sPlayerName = GetPCPlayerName(oPC);
  if(sPlayerName == "")
  {
    SetLocked(oSafe, FALSE);
    return;
  }

  string sDB = OBK_GetBankSafeDBString(oPC,oSafe);

  //Public Safe
  int nPublic = GetLocalInt(oSafe,"OBK_PUBLIC");
  if(nPublic == 1)
  {
    sDB = OBK_GetBankSafePublicDBString(oPC,oSafe);
  }

  object oStore = CreateObject(OBJECT_TYPE_CREATURE, "storage", GetLocation(oPC), FALSE, sDB);
  effect eVis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
  effect eImm = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oStore);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eImm,oStore);

  oItem = GetFirstItemInInventory(oSafe);
  while (GetIsObjectValid(oItem))
  {
    CopyItem(oItem, oStore, TRUE);
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oSafe);
  }

  StoreCampaignObject("OBK_BANKING", sDB, oStore);
  DestroyObject(oStore);
  DelayCommand(20.0, SetLocked(OBJECT_SELF, FALSE));
}

//void main(){}
