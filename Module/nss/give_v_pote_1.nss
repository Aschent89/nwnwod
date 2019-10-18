

#include "q_stackable_inc"
void main()
{


object oPC = GetPCSpeaker();

// Give the speaker the items
ActionTakeStackedItemsByTag("vamppoint",GetPCSpeaker(),2);
CreateItemOnObject("vamp_pote_1", GetPCSpeaker(), 1);

SendMessageToPC(oPC, "You have learned how to use your blood to gain strength.");
}
