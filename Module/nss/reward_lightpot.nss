#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(3500, oPC, FALSE);

RewardPartyGP(2500, oPC, FALSE);

CreateItemOnObject("ks_potionlight", oPC);

}
