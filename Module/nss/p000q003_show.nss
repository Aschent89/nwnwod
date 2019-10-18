#include "nw_i0_plotwizard"
int StartingConditional()
{
	int nShow = GetLocalInt(GetPCSpeaker(), "p000state_NW_ZOMBIEBOSS") >= 2;
	if (nShow)
	{
		object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "zombiehead");
		DestroyObject(oItemToTake);
		CreateItemOnObject("g_rcliath001", GetPCSpeaker());
		PWSetMinLocalIntPartyPCSpeaker("p000state_danceswithfleas", 3);
		PWSetMinLocalIntPartyPCSpeaker("p000state", 3);
		PWGiveExperienceParty(GetPCSpeaker(), 500);
		AddJournalQuestEntry("p000", 3, GetPCSpeaker(), TRUE, FALSE, FALSE);
	}
	return nShow;
}
