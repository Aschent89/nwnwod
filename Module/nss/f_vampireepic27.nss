#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetIsVampire(GetPCSpeaker()))
    {
    object oItem = GetFirstItemInInventory(GetPCSpeaker());
    while (GetIsObjectValid(oItem) && GetTag(oItem) != "fv_BookofElderVampireAdvancement") oItem = GetNextItemInInventory(GetPCSpeaker());
    if(!GetIsObjectValid(oItem) || GetTag(oItem) != "fv_BookofElderVampireAdvancement") return TRUE;
    DestroyObject(oItem);
    return TRUE;
    }
return FALSE;
}
