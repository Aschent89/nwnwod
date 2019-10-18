////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Set Local For Armor Equips and Unequips
//  ocr_reequip
//  by Don Anderson
//  dandersonru@msn.com
//
//  Used in Crafting Conversations
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();

  object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
  AssignCommand(oPC, ActionUnequipItem(oArmor));
  DelayCommand(2.0,AssignCommand(oPC, ActionEquipItem(oArmor, INVENTORY_SLOT_CHEST)));

}
