#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(2500, oPC, FALSE);

RewardPartyGP(1000, oPC, FALSE);

CreateItemOnObject("ks_ringlghtrogue", oPC);

}
