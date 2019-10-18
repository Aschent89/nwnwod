

#include "q_stackable_inc"
void main()
{


object oPC = GetPCSpeaker();
object oTarget;

// Give the speaker the items
ActionTakeStackedItemsByTag("vamppoint",GetPCSpeaker(),4);
CreateItemOnObject("vamp_pote_3", GetPCSpeaker(), 1);
oTarget = GetObjectByTag("vamp_pote_2");

DestroyObject(oTarget, 0.0);

SendMessageToPC(oPC, "You have just grown one step closer to prefection in this art.");
}
