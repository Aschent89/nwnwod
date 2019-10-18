#include "toy_source"
void main()
{
    object oItem = GetPCItemLastUnequipped();
    object oPC = GetPCItemLastUnequippedBy();

    ToyOnUnEquip(oPC, oItem);
}
