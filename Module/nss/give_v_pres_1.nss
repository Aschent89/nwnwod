

#include "q_stackable_inc"
void main()
{


object oPC = GetPCSpeaker();

// Give the speaker the items
ActionTakeStackedItemsByTag("vamppoint",GetPCSpeaker(),2);
CreateItemOnObject("vamp_pres_1", GetPCSpeaker(), 1);

SendMessageToPC(oPC, "You have now learned how to use your curse to dazzle and awe people.");
}
