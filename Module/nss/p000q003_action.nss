#include "nw_i0_plotwizard"
void main()
{
	object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ChickenHead");
	DestroyObject(oItemToTake);
	object oItemToGive = GetItemPossessedBy(OBJECT_SELF, "ChickenSkeletonKey");
	ActionGiveItem(oItemToGive, GetPCSpeaker());
	PWSetMinLocalIntPartyPCSpeaker("p000state_Gran", 3);
}
