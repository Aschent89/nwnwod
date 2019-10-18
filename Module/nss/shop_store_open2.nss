/* Script Created By Rami_Ahmed */
#include "shop_inc"
#include "nw_i0_plot"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF),
         oStore;
  if (!GetIsObjectValid(oPC) || !GetIsObjectValid(oArea)) return;
  SpeakString("Just a moment there...");
  int i; for (i; i <= 10; i++)
  {  oStore = GetNearestObject(OBJECT_TYPE_STORE, OBJECT_SELF, i);
     if (GetIsObjectValid(oStore) && GetTag(oStore) == "shop_store991")
     { oStore = oStore;
       break;
     }
     else
     { oStore = CreateObject(OBJECT_TYPE_STORE, "shopstore", GetLocation(OBJECT_SELF), FALSE, "shop_store991");
       DelayCommand(2.5, RetrieveItems(oArea, oStore, 1));
     }
  }
  int nMarkUp   = GetShopBonusMarkUp(oArea, 1),
      nMarkDown = GetShopBonusMarkDown(oArea, 1),
      nShopGold = GetGoldInShopVault(oArea, 1);
  SetLocalObject(oStore, "ShopPCObject", oPC);
  DelayCommand(3.5, SetStoreGold(oStore, nShopGold));
  if (!GetLocalInt(oArea, "ShopUseAppraise"))
  { DelayCommand(4.0, gplotAppraiseOpenStore(oStore, oPC, nMarkUp, nMarkDown));
  }
  else
  { DelayCommand(4.0, OpenStore(oStore, oPC, nMarkUp, nMarkDown));
  }
}
