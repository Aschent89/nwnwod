#include "rp_htf"
void main()
{
    object oPC = GetEnteringObject();

    SetLocalInt(oPC, RP_HTF_VAR_NEAR_WATER, TRUE);
    FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_CYAN, RP_STRING_OASIS_ENTER), oPC);

}
