
#include "q_stackable_inc"
void main()
{


object oPC = GetPCSpeaker();

// Give the speaker the items
ActionTakeStackedItemsByTag("vamppoint",GetPCSpeaker(),2);
CreateItemOnObject("vamp_quie_1", GetPCSpeaker(), 1);

SendMessageToPC(oPC, "You have just grown one step closer to prefection in this art.");
}
