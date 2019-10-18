#include "toy_source"
//Returns TRUE if they have a slave collar
object ReturnCollar(object oPC)
{
    object oItem;
    string sTag;

    oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);

    if (GetIsObjectValid(oItem)) {
        sTag = GetTag(oItem);
        if (GetStringLeft(sTag, 9) == COLLAR_PREFIX) return oItem; }

    oItem = GetFirstItemInInventory(oPC);

    while (GetIsObjectValid(oItem)) {
        sTag = GetTag(oItem);
        if (GetStringLeft(sTag, 9) == COLLAR_PREFIX) return oItem;
        oItem = GetNextItemInInventory(oPC); }

    return OBJECT_INVALID;
}
void main()
{
    object oCollar = ReturnCollar(OBJECT_SELF);

    SetLocalInt(OBJECT_SELF, "MR_COLLAR_OFF", 1);
    DestroyObject(oCollar);
    DelayCommand(1.0, DeleteLocalInt(OBJECT_SELF, "MR_COLLAR_OFF"));



}
