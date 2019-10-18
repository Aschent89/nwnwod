////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems
//  ors_onequip
//  By Don Anderson
//  dandersonru@msn.com
//
//  ORS OnEquip Event
//
//  Implemented Sir Elric's Stop Swap v1.3
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
  object oPC      = GetPCItemLastEquippedBy();
  object oMod     = GetModule();
  object oItem    = GetPCItemLastEquipped();

  int nSlot = GetRestrictedInventorySlot(oItem);
  if(GetLocalObject(oPC, "ORS_ITEM_UNEQUIPPED_" + IntToString(nSlot)) == oItem)
  {
    //Unlock the Slot
    DeleteLocalInt(oPC, "ORS_UNEQUIPPED_" + IntToString(nSlot));
    DeleteLocalObject(oPC, "ORS_ITEM_UNEQUIPPED_" + IntToString(nSlot));
  }
}
