#include "toy_source"
void main()
{
    object oPC = GetPCItemLastEquippedBy();
    object oItem = GetPCItemLastEquipped();

    ToyOnEquip(oPC, oItem);

    //MR : Added this to solve exploit with forge
    DelayCommand(0.3, ExecuteScript("forge_exploit", oItem));


}
