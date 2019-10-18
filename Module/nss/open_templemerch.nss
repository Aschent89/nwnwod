#include "nw_i0_plot"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("temple_divinemerchant");

gplotAppraiseOpenStore(oTarget, oPC, 0, 0);

}

