

#include "q_stackable_inc"
void main()
{


object oPC = GetPCSpeaker();

// Give the speaker the items
ActionTakeStackedItemsByTag("garougnoisepoint",GetPCSpeaker(),6);
CreateItemOnObject("garou_gaia_4", GetPCSpeaker(), 1);

SendMessageToPC(oPC, "You have just grown one step closer to prefection in this art.");
}
