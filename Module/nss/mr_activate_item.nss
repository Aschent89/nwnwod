#include "toy_source"
void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    string sTag = GetTag(oItem);

    if (GetStringLeft(sTag, 6) == "mr_toy") {
        ToyOnActivate(oPC, oTarget, oItem); }

}
