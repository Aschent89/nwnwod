#include "ccs_inc"

int StartingConditional()
{
    if(!CCS_MULTICLASS_LEVEL_CONTROL)
        return FALSE;
    else return TRUE;
}
