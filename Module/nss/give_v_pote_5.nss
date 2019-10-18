

#include "q_stackable_inc"
void main()
{


object oPC = GetPCSpeaker();
object oTarget;
// Give the speaker the items
ActionTakeStackedItemsByTag("vamppoint",GetPCSpeaker(),10);
CreateItemOnObject("vamp_pote_5", GetPCSpeaker(), 1);

oTarget = GetObjectByTag("vamp_pote_4");

DestroyObject(oTarget, 0.0);

SendMessageToPC(oPC, "You have just gotten as close to prefection in this art as you can.");
}
