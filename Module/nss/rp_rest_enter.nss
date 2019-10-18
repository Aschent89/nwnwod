#include "rp_resting_area"
void main()
{
    object oPC = GetEnteringObject();

    //Inform the player they are in a resting area and flag them for resting.
    FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_CYAN, RP_STRING_REST_ZONE_ENTER), oPC, FALSE);
    SetLocalInt(oPC, RP_RESTING_FLAG, TRUE);
}
