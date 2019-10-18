#include "ccs_inc"

int StartingConditional()
{
    object oPC=GetPCSpeaker();
    int nClassType=GetLocalInt(oPC,"CLASS_TYPE");
    if(!GetIsTrainableClass(oPC,nClassType))
        return FALSE;
    else return TRUE;
}
