#include "ccs_inc"

int StartingConditional()
{
    object oPC=GetPCSpeaker();
    int nClassType=GetLocalInt(oPC,"CLASS_TYPE");
    if(!CCS_MULTICLASS_LEVEL_CONTROL)
        return FALSE;
    if(!CCS_MULTICLASS_LEVEL_AMOUNT)
        return FALSE;
    else if(GetCanMulticlass(oPC))// && GetLevelByClass(nClassType,oPC))
        return TRUE;
    else return FALSE;
}
