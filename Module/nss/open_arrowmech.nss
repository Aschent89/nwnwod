#include "nw_i0_plot"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("arrow_merchant");

gplotAppraiseOpenStore(oTarget, oPC, 0, 0);

}

