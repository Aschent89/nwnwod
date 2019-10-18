void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    int nAppearance = 0;
    object oItem2 = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_BELT, nAppearance);
    DelayCommand(0.8, AssignCommand(oPC, ActionEquipItem(oItem2, INVENTORY_SLOT_CHEST)));
    DelayCommand(1.3, DestroyObject(oItem));
}
