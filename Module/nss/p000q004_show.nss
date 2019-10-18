#include "nw_i0_plotwizard"
int StartingConditional()
{
	int nShow = GetLocalInt(GetPCSpeaker(), "p000state_Gran") >= 3;
	if (nShow)
	{
		PWSetMinLocalIntPartyPCSpeaker("p000state_Gran", 4);
		PWSetMinLocalIntPartyPCSpeaker("p000state", 4);
	}
	return nShow;
}
