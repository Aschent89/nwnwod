////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems
//  ors_onunequip
//  By Don Anderson
//  dandersonru@msn.com
//
//  ORS OnEquip Event
//
////////////////////////////////////////////////////////////////////////////////
 /*
#include "ors_inc"

void main()
{
  object oItem = GetPCItemLastUnequipped();
  object oPC = GetPCItemLastUnequippedBy();

  //Polymorphed
  if(GetAppearanceType(oPC) > 6) return;

  //While in Melee Range
  if(GetWasWeaponUnequippedInMelee(oPC, oItem))
  {
    StepBackwards(oPC);
    SendMessageToPC(oPC, "You stumble as you try to unequip " + GetName(oItem) + " while in combat!");
  }
  //Not Ok...Force Equip
  else if(GetIsOkayToUnequip(oPC, oItem) == FALSE)
  {
    int nSlot = GetRestrictedInventorySlot(oItem);

    //Set Variables For Equipping
    SetLocalInt(oPC, "ORS_UNEQUIPPED_" + IntToString(nSlot), TRUE);
    SetLocalObject(oPC, "ORS_ITEM_UNEQUIPPED_" + IntToString(nSlot), oItem);

    AssignCommand(oPC, ActionEquipItem(oItem, nSlot));
    SendMessageToPC(oPC, "You need 5 Meters from an Enemy to Unequip an item.");
  }
}
