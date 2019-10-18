
#include "q_stackable_inc"
void main()
{


object oPC = GetPCSpeaker();

// Give the speaker the items
ActionTakeStackedItemsByTag("hunterspoint",GetPCSpeaker(),10);
CreateItemOnObject("hunter_forc_5", GetPCSpeaker(), 1);

SendMessageToPC(oPC, "You have just gotten as close to prefection in this art as you can.");
}
