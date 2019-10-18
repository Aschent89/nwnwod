/* Script Created By Rami_Ahmed */
#include "eds_include"
// Database in which everything is stored.
const string sDatabase = "Shop_Database";

// Sets oPC as owner of oArea.
// * Only if oPC does already own the shop
// * And oPC has enough gold to pay for the shop.
void SetOwner(object oPC, object oArea);

// Returns the name of the current owner of oArea.
string GetOwner(object oArea);

// Returns the current buy price for oArea.
int GetShopPrice(object oArea);

// Returns wheter or not the area is for sale.
// * 1 = Not for sale.
// * 0 (default) = for sale.
int GetBuySellState(object oArea);

// Sets wheter or not oArea is for sale.
// * if nValue is 1, the shop will be set not-for sale.
// * if nValue is 0, the shop will be for sale. (Default)
void SetBuySellState(object oArea, int nValue);

// Sets oArea's buy price.
void SetShopPrice(object oArea, int nValue);

// Retrieves all set-for-sale items in oArea. Creates them in oCreateIn's inventory.
void RetrieveItems(object oArea, object oCreateIn = OBJECT_SELF, int iType = 0);

// Saves all items in oChest's inventory, in oArea.
// * Stops if the number of items in oChest exceeds the allowed amount.
// iType is the store type.
void SaveItems(object oArea, object oPC, object oChest = OBJECT_SELF, int bDestroy = TRUE, int iType = 0);

// Creates a listener, makes it invisible and sets it to listen.
// * Note: Remember to SetListenPattern after creating it.
object SetUpListener(object oListenFor);

// Sets nValue of salesmen currently hired in oArea.
void SetNumberSalesman(object oArea, int nValue);

// Returns the number of salesmen currently hired in oArea
int GetNumberSalesman(object oArea);

// Makes oPC pay the salary to all salesmen in oArea.
void PaySalary(object oArea, float fTime);

// Returns the current salesman salary in oArea
int GetSalesmanSalary(object oArea);

// Sets the salesmen's salary to nValue in oArea.
// * nValue must be a positive integer.
void SetSalesmanSalary(object oArea, int nValue);

// Returns the first found Shop sign in oArea
// * returns OBJECT_INVALID on error
object GetSignInArea(object oArea = OBJECT_SELF);

// Changes the sign's name in oArea to sNewName.
void ChangeShopName(object oArea, string sNewName = "");

// Returns the current name of Area
// * If the shop is not owned by a player, this function returns "Shop".
string GetShopName(object oArea);

// Returns the current bonus mark up for oArea.
int GetShopBonusMarkUp(object oArea, int iType);

// Sets nValue to oAreas current bonus mark up.
void SetShopBonusMarkUp(object oArea, int nValue, int iType);

// Returns the current buy mark down for oArea
int GetShopBonusMarkDown(object oArea, int iType);

// Sets the current buy mark down for oArea to nValue
void SetShopBonusMarkUp(object oArea, int nValue, int iType);

// returns the current amount of gold in oAreas shop vault
int GetGoldInShopVault(object oArea, int iType);

// Sets nValue to be in oAreas shop vault
void SetGoldInShopVault(object oArea, int nValue, int iType);

// Returs TRUE or FALSE depending on the salary for oArea has been paid
int GetSalaryHasBeenPaid(object oArea);

// Sets wheter salary for oArea has been paid or not
void SetSalaryHasBeenPaid(object oArea, int nValue);


void SetOwner(object oPC, object oArea)
{  if (!GetIsObjectValid(oPC) || !GetIsObjectValid(oArea) || !GetIsPC(oPC)) return;
   if (GetOwner(oArea) == GetName(oPC))
   {  FloatingTextStringOnCreature("You already own this shop.", oPC);
     return;
   }
   if (GetBuySellState(oArea))
   {  FloatingTextStringOnCreature("This shop is not for sale.", oPC);
     return;
   }
   int nGold = GetShopPrice(oArea), iCount;
   if (nGold == 0)
   {  nGold = GetLocalInt(GetModule(), "ShopStartPrice");
   }
   if (GetGold(oPC) < nGold)
   {  FloatingTextStringOnCreature("You dont have enough gold.", oPC);
     return;
   }
   if (GetOwner(oArea) == "")
   { AssignCommand(oPC, TakeGoldFromCreature(nGold, oPC, TRUE));
     SetCampaignString(sDatabase, "ShopOwner" + GetTag(oArea), GetName(oPC), oArea);
     FloatingTextStringOnCreature(" * You are now the owner of this shop * ", oPC);
   }
   else
   { string sOwner = GetOwner(oArea);
     object oLoop = GetFirstPC();
     while (GetIsObjectValid(oLoop))
     {  if (GetName(oLoop) == sOwner)
        {  GiveGoldToCreature(oLoop, nGold);
           SendMessageToPC(oLoop, "Your shop has been sold to " + GetName(oPC) + ".");
           AssignCommand(oPC, TakeGoldFromCreature(nGold, oPC, TRUE));
           DelayCommand(0.1, SetCampaignString(sDatabase, "ShopOwner" + GetTag(oArea), GetName(oPC), oArea));
           FloatingTextStringOnCreature(" * You are now the owner of this shop * ", oPC);
           GiveGoldToCreature(oLoop, GetGoldInShopVault(oArea, 0));
           GiveGoldToCreature(oLoop, GetGoldInShopVault(oArea, 1));
           DelayCommand(0.2, SetGoldInShopVault(oArea, 0, 0));
           DelayCommand(0.2, SetGoldInShopVault(oArea, 0, 1));
           DelayCommand(1.0, RetrieveItems(oArea, oPC, 1));
           DelayCommand(2.0, RetrieveItems(oArea, oPC, 2));
           DelayCommand(0.5, DestroyCampaignDatabase("0SHOP_ITEM_DB" + GetTag(oArea)));
           DelayCommand(0.6, DestroyCampaignDatabase("1SHOP_ITEM_DB" + GetTag(oArea)));
          break;
        }
        else
        {  AssignCommand(oPC, TakeGoldFromCreature(nGold, oPC, TRUE));
           DelayCommand(0.1, SetCampaignString(sDatabase, "ShopOwner" + GetTag(oArea), GetName(oPC), oArea));
           FloatingTextStringOnCreature(" * You are now the owner of this shop * ", oPC);
           DelayCommand(0.2, SetCampaignString(sDatabase, "ShopOldOwner" + GetTag(oArea), sOwner, oArea));
           DelayCommand(0.3, SetCampaignInt(sDatabase, "ShopOldGold" + GetTag(oArea), nGold, oArea));
           int nShopVaultGold = GetGoldInShopVault(oArea, 1) + GetGoldInShopVault(oArea, 0);
           DelayCommand(0.4, SetCampaignInt(sDatabase, "ShopOldVault" + GetTag(oArea), nShopVaultGold, oArea));
           DelayCommand(0.5, SetGoldInShopVault(oArea, 0, 0));
           DelayCommand(0.5, SetGoldInShopVault(oArea, 0, 1));
           DelayCommand(1.0, DestroyCampaignDatabase("0SHOP_ITEM_DB" + GetTag(oArea)));
           DelayCommand(1.1, DestroyCampaignDatabase("1SHOP_ITEM_DB" + GetTag(oArea)));
          }
     oLoop = GetNextPC();
    }
  }
}

string GetOwner(object oArea)
{  return GetCampaignString(sDatabase, "ShopOwner" + GetTag(oArea), oArea);
}
int GetShopPrice(object oArea)
{  return GetCampaignInt(sDatabase, "ShopPrice" + GetTag(oArea), oArea);
}
int GetBuySellState(object oArea)
{  return GetCampaignInt(sDatabase, "ShopBuySell" + GetTag(oArea), oArea);
}
void SetBuySellState(object oArea, int nValue)
{ if ((nValue > 1 || nValue < 0) || !GetIsObjectValid(oArea)) return;
  SetCampaignInt(sDatabase, "ShopBuySell" + GetTag(oArea), nValue);
}
void SetShopPrice(object oArea, int nValue)
{ if (nValue < 1 || !GetIsObjectValid(oArea)) return;
  SetCampaignInt(sDatabase, "ShopPrice" + GetTag(oArea), nValue, oArea);
}
void RetrieveItems(object oArea, object oCreateIn, int iType)
{ if (!GetIsObjectValid(oArea)) return;
  int nLoop = GetCampaignInt(IntToString(iType) + "SHOP_ITEM_DB" + GetTag(oArea), "ShopItemCount", oArea);
  int i; for (i; i <= nLoop; i++)
  {  RetrieveCampaignObject(IntToString(iType) + "SHOP_ITEM_DB" + GetTag(oArea), "ShopItems" + IntToString(i), GetLocation(oCreateIn), oCreateIn, oArea);
  }
}

void SaveItems(object oArea, object oPC, object oChest, int bDestroy, int iType)
{ if (!GetIsObjectValid(oArea) || !GetIsObjectValid(oChest)) return;
  int iCount, nMaxItems = GetLocalInt(GetModule(), "ShopMaxItems");
  DestroyCampaignDatabase(IntToString(iType) + "SHOP_ITEM_DB" + GetTag(oArea));
  object oLoop = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oLoop))
  {  if (!GetPlotFlag(oLoop) && !GetStolenFlag(oLoop) && !GetItemCursedFlag(oLoop))
     {   if (GetHasInventory(oLoop))
         {  FloatingTextStringOnCreature("Can not save containers!", oPC);
            AssignCommand(oChest, ActionGiveItem(oLoop, oPC));
         }
         else if (iCount >= nMaxItems)
         {  FloatingTextStringOnCreature("Can not have any more items - max number of items are: " + IntToString(nMaxItems) + ".", oPC);
            AssignCommand(oChest, ActionGiveItem(oLoop, oPC));
         }
         else
         {  StoreCampaignObject(IntToString(iType) + "SHOP_ITEM_DB" + GetTag(oArea), "ShopItems" + IntToString(iCount), oLoop, oArea);
            if (bDestroy)
            {  DestroyObject(oLoop, 4.0);
            }
            iCount++;
         }
     }
     else
     {  AssignCommand(oChest, ActionGiveItem(oLoop, oPC));
        FloatingTextStringOnCreature("Can not store stolen, plot or undropable items.", oPC);
     }
   oLoop = GetNextItemInInventory(oChest);
  }
  SetCampaignInt(IntToString(iType) + "SHOP_ITEM_DB" + GetTag(oArea), "ShopItemCount", iCount, oArea);
}
void CheckDistance(object a, object b)
{  if (GetDistanceBetween(a, b) > 10.0)
   {  DestroyObject(a, 1.0);
   }
   else
   {  DelayCommand(10.0, CheckDistance(a, b));
   }
}
object SetUpListener(object oListenFor)
{  if (!GetIsObjectValid(oListenFor)) return OBJECT_INVALID;
   object oListener = CreateObject(OBJECT_TYPE_CREATURE, "shop_listener", GetLocation(oListenFor));
   effect eGone = EffectLinkEffects(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), EffectCutsceneGhost());
   ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eGone), oListener);
   SetLocalObject(oListener, "ShopListenFor", oListenFor);
   SetIsTemporaryFriend(oListener, oListenFor);
   SetIsTemporaryFriend(oListenFor, oListener);
   AssignCommand(oListener, ClearAllActions(TRUE));
   SetListening(oListener, TRUE);
   CheckDistance(oListener, oListenFor);
  return oListener;
}
void SetNumberSalesman(object oArea, int nValue)
{ if (!GetIsObjectValid(oArea) || nValue < 0) return;
  SetCampaignInt(sDatabase, "ShopSalesman" + GetTag(oArea), nValue, oArea);
}
int GetNumberSalesman(object oArea)
{ return GetCampaignInt(sDatabase, "ShopSalesman" + GetTag(oArea), oArea);
}
void SetSalesmanSalary(object oArea, int nValue)
{ if (!GetIsObjectValid(oArea) || nValue < 0) return;
  SetCampaignInt(sDatabase, "ShopSalary" + GetTag(oArea), nValue, oArea);
}
int GetSalesmanSalary(object oArea)
{ return GetLocalInt(GetModule(), "ShopMinSalary");
}
int GetSalaryHasBeenPaid(object oArea)
{  return GetCampaignInt(sDatabase, "ShopPayedSal" + GetTag(oArea), oArea);
}
void PaySalary(object oArea, float fTime)
{ SetSalaryHasBeenPaid(oArea, TRUE);
  EDS_SetDelay(oArea, "ShopPayIntrl" + GetTag(oArea), fTime);
}
void SetSalaryHasBeenPaid(object oArea, int nValue)
{ if (!GetIsObjectValid(oArea) || ( nValue != TRUE && nValue != FALSE) ) return;
  SetCampaignInt(sDatabase, "ShopPayedSal" + GetTag(oArea), nValue, oArea);
}
void ChangeShopName(object oArea, string sNewName)
{ if (!GetIsObjectValid(oArea)) return;
  object oSign = GetSignInArea(oArea);
  if (!GetIsObjectValid(oSign)) return;
  SetName(oSign, sNewName);
  SetCampaignString(sDatabase, "ShopName" + GetTag(oArea), sNewName, oArea);
}
object GetSignInArea(object oArea)
{ object oLoop = GetFirstObjectInArea(oArea);
  while (GetIsObjectValid(oLoop))
  {  if (GetObjectType(oLoop) == OBJECT_TYPE_PLACEABLE &&
     GetTag(oLoop) == "shop_signboard" && GetResRef(oLoop) == "shop_signboard")
     {  return oLoop;
       break;
     }
   oLoop = GetNextObjectInArea(oArea);
  }
 return OBJECT_INVALID;
}
string GetShopName(object oArea)
{ string sName = GetCampaignString(sDatabase, "ShopName" + GetTag(oArea), oArea);
  if (GetOwner(oArea) == "" || sName == "")
  {  return "Normal Shop";
  }
  else
  {  return sName;
  }
}
int GetShopBonusMarkUp(object oArea, int iType)
{  return GetCampaignInt(sDatabase, GetTag(oArea) + "ShopMarkUp" + IntToString(iType), oArea);
}
void SetShopBonusMarkUp(object oArea, int nValue, int iType)
{ if (!GetIsObjectValid(oArea)) return;
  if (nValue <-100) nValue =-100;
  if (nValue > 100) nValue = 100;
  SetCampaignInt(sDatabase, GetTag(oArea) + "ShopMarkUp" + IntToString(iType), nValue, oArea);
}
int GetShopBonusMarkDown(object oArea, int iType)
{  return GetCampaignInt(sDatabase, GetTag(oArea) + "ShopMarkDown" + IntToString(iType), oArea);
}
void SetShopBonusMarkDown(object oArea, int nValue, int iType)
{ if (!GetIsObjectValid(oArea)) return;
  if (nValue <-100) nValue =-100;
  if (nValue > 100) nValue = 100;
  SetCampaignInt(sDatabase, GetTag(oArea) + "ShopMarkDown" + IntToString(iType), nValue, oArea);
}
int GetGoldInShopVault(object oArea, int iType)
{ return GetCampaignInt(sDatabase, GetTag(oArea) + "ShopVGold" + IntToString(iType), oArea);
}
void SetGoldInShopVault(object oArea, int nValue, int iType)
{ if (!GetIsObjectValid(oArea) || nValue < 0) return;
  SetCampaignInt(sDatabase, GetTag(oArea) + "ShopVGold" + IntToString(iType), nValue, oArea);
}
string GetOldOwner(object oArea)
{ return GetCampaignString(sDatabase, GetTag(oArea) + "ShopOldOwner", oArea);
}

//
// void main() {}
