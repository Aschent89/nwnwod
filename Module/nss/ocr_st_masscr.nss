////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Mass Critical Adding to a Keen Weapon
//  ocr_st_masscr
//  by Don Anderson
//  dandersonru@msn.com
//
//  Used in Crafting Conversation to Add Mass Criticals to a Weapon
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
    object oPC      = GetPCSpeaker();
    object oMod     = GetModule();

    int nQty = 10;

    //Count Total Diamonds....Need 10 For Each Mass Critical Add
    string sItemTag;
    object oItem = GetFirstItemInInventory(oPC);
    int nDiamond = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Diamonds
      if(sItemTag == "NW_IT_GEM005" || sItemTag == "Diamond")
      {
        nDiamond = GetItemStackSize(oItem);
        if(nDiamond >= 10)
        {
          SetLocalObject(oPC,"DIAMOND",oItem);
          break;
        }
        else
        {
          SendMessageToPC(oPC,"You will need 10 Diamonds (In a Stack) Per Mass Critical Addition.");
          DeleteLocalObject(oPC,"DIAMOND");
          return;
        }
      }
      oItem = GetNextItemInInventory(oPC);
    }

    //Now Check to see if Diamond Object is Valid
    object oDiamond = GetLocalObject(oPC,"DIAMOND");
    if(!GetIsObjectValid(oDiamond))
    {
      SendMessageToPC(oPC,"You will need 10 Diamonds (In a Stack) Per Mass Critical Addition.");
      DeleteLocalObject(oPC,"DIAMOND");
      return;
    }

    //Mass Critical Add
    object oWeapon  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    int nMC = GetMassCritical(oWeapon);

    //DEBUG
    SendMessageToPC(GetFirstPC(),"Current Mass Critical Value is : "+IntToString(nMC));

    if(nMC >= 10)
    {
      SendMessageToPC(oPC,"You already have the max 2d12 Mass Critical on your weapon. No Diamonds are taken.");
      return;
    }
    else
    {
      AddMassCritical(oWeapon, nMC);

      effect eFX1 = EffectVisualEffect(VFX_IMP_GOOD_HELP);
      DelayCommand(1.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1,  GetLocation(oPC)));
    }

    //Now Destroy 10 Diamonds
    object oDiamondStack = GetLocalObject(oPC,"DIAMOND");
    DestroyObject(oItem);
    DeleteLocalObject(oPC,"DIAMOND");
}
