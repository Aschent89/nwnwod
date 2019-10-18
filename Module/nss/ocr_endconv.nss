////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Set Local For Armor Equips and Unequips
//  ocr_endconv
//  by Don Anderson
//  dandersonru@msn.com
//
//  Used in Crafting Conversations
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();

  DeleteLocalInt(oPC,"CRAFTING_CONVO");

  object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
  AssignCommand(oPC, ActionUnequipItem(oArmor));
  AssignCommand(oPC, ActionEquipItem(oArmor, INVENTORY_SLOT_CHEST));
}
