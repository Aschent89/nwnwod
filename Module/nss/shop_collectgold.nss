/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || !GetIsObjectValid(oArea)) return;
  if (GetOldOwner(oArea) == GetName(oPC))
  {    int nLostGold = GetCampaignInt(sDatabase, "ShopOldGold" + GetTag(oArea), oArea);
       if (nLostGold > 0)
       {   GiveGoldToCreature(oPC, nLostGold);
           SetCampaignInt(sDatabase, "ShopOldGold" + GetTag(oArea), 0, oArea);
       }
       int nLostVault = GetCampaignInt(sDatabase, "ShopOldVault" + GetTag(oArea), oArea);
       if (nLostVault > 0)
       {   GiveGoldToCreature(oPC, nLostVault);
           SetCampaignInt(sDatabase, "ShopOldVault" + GetTag(oArea), 0, oArea);
       }
   SetCampaignString(sDatabase, "ShopOldOwner" + GetTag(oArea), "", oArea);
  }
  else
  {  FloatingTextStringOnCreature("You are not the old owner and can not collect any gold!", oPC);
  }
}
