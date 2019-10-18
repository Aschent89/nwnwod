

#include "q_stackable_inc"
void main()
{


object oPC = GetPCSpeaker();

// Give the speaker the items
ActionTakeStackedItemsByTag("vamppoint",GetPCSpeaker(),10);
CreateItemOnObject("vamp_serp_5", GetPCSpeaker(), 1);

SendMessageToPC(oPC, "You have just gotten as close to prefection in this art as you can.");
}
