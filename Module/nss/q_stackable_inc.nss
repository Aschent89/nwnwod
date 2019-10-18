/*
Include file for handling stacked items and multiple stacks
10.01.2004 created by Magic
*/
// Get the number of items tagged sItemTag possessed by oCreature
int GetNumPossessedItems(object oCreature, string sItemTag, int bIncludeSlotItems = TRUE);
// Transfer nNumber items of the item stack oItem to oTarget's inventory
// * if nNumber is greater than oItem's stack size, all items will be transfered without warning
void TransferStackedItems(object oItem, int nNumber, object oTarget, int bCopyVars = FALSE);
// Take nNumber stacked items with tag sItemTag from oTakeFrom
// * if nNumber is more than oTakeFrom has, all items will be transfered without warning
void ActionTakeStackedItemsByTag(string sItemTag, object oTakeFrom, int nNumber, int bIncludeSlotItems = TRUE);
// Give nNumber stacked items with tag sItemTag to oGiveTo
// * if nNumber is more than oTakeFrom has, all items will be transfered without warning
void ActionGiveStackedItemsByTag(string sItemTag, object oGiveTo, int nNumber, int bIncludeSlotItems = TRUE);
int GetNumPossessedItems(object oCreature, string sItemTag, int bIncludeSlotItems = TRUE) {
int nNumber = 0;
object oItem = GetFirstItemInInventory(oCreature);
while (GetIsObjectValid(oItem)) {
if (GetTag(oItem)==sItemTag) {
nNumber += GetNumStackedItems(oItem);
}
oItem = GetNextItemInInventory(oCreature);
}
if (!bIncludeSlotItems) return nNumber;
int i;
for (i = 0; i<NUM_INVENTORY_SLOTS; i++) {
oItem = GetItemInSlot(i,oCreature);
if (GetTag(oItem)==sItemTag) {
nNumber += GetNumStackedItems(oItem);
}
}
return nNumber;
}
void TransferStackedItems(object oItem, int nNumber, object oTarget, int bCopyVars = FALSE) {
int nStackSize = GetItemStackSize(oItem);
if (nStackSize<=nNumber) {
CopyItem(oItem,oTarget,bCopyVars);
DestroyObject(oItem);
}
else {
SetItemStackSize(oItem,nNumber);
CopyItem(oItem,oTarget,bCopyVars);
SetItemStackSize(oItem,nStackSize-nNumber);
}
}
void ActionTakeStackedItemsByTag(string sItemTag, object oTakeFrom, int nNumber, int bIncludeSlotItems = TRUE) {
if (nNumber<1) return;
object oItem = GetFirstItemInInventory(oTakeFrom);
while (GetIsObjectValid(oItem)) {
if (GetTag(oItem)==sItemTag) {
int nStackSize = GetItemStackSize(oItem);
ActionDoCommand(TransferStackedItems(oItem,nNumber,OBJECT_SELF,TRUE));
if (nStackSize>=nNumber) return;
nNumber -= nStackSize;
}
oItem = GetNextItemInInventory(oTakeFrom);
}
if (!bIncludeSlotItems) return;
int i;
for (i = 0; i<NUM_INVENTORY_SLOTS; i++) {
oItem = GetItemInSlot(i,oTakeFrom);
if (GetTag(oItem)==sItemTag) {
int nStackSize = GetItemStackSize(oItem);
ActionDoCommand(TransferStackedItems(oItem,nNumber,OBJECT_SELF,TRUE));
if (nStackSize>=nNumber) return;
nNumber -= nStackSize;
}
}
}
void ActionGiveStackedItemsByTag(string sItemTag, object oGiveTo, int nNumber, int bIncludeSlotItems = TRUE) {
if (nNumber<1) return;
object oItem = GetFirstItemInInventory();
while (GetIsObjectValid(oItem)) {
if (GetTag(oItem)==sItemTag) {
int nStackSize = GetItemStackSize(oItem);
ActionDoCommand(TransferStackedItems(oItem,nNumber,oGiveTo,TRUE));
if (nStackSize>=nNumber) return;
nNumber -= nStackSize;
}
oItem = GetNextItemInInventory();
}
if (!bIncludeSlotItems) return;
int i;
for (i = 0; i<NUM_INVENTORY_SLOTS; i++) {
oItem = GetItemInSlot(i);
if (GetTag(oItem)==sItemTag) {
int nStackSize = GetItemStackSize(oItem);
ActionDoCommand(TransferStackedItems(oItem,nNumber,oGiveTo,TRUE));
if (nStackSize>=nNumber) return;
nNumber -= nStackSize;
}
}
}
