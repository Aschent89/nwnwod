#include "rp_htf"
void main()
{
    object oPC = GetExitingObject();

    DeleteLocalInt(oPC, RP_HTF_VAR_NEAR_WATER);
    FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_CYAN, RP_STRING_OASIS_EXIT), oPC);

}
