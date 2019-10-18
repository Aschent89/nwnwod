#include "ccs_inc"

void main()
{
    RemoveVariables(GetPCSpeaker());
    if(GetTag(OBJECT_SELF) == "CCS_CONV_")
        DestroyObject(OBJECT_SELF);
}
