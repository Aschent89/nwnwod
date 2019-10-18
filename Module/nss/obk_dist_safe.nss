////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Banking
//  obk_dist_safe
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the OnDisturbed Event of the Safe
//
////////////////////////////////////////////////////////////////////////////////

#include "obk_inc"

void main()
{
  object oSafe = OBJECT_SELF;
  object oItem = GetInventoryDisturbItem();

  int nDType = GetInventoryDisturbType();

  //Added an Item
  if(nDType == INVENTORY_DISTURB_TYPE_ADDED)
  {
    OBK_AddItemToSafe(oSafe,oItem);
  }

  //Removed an Item
  if(nDType == INVENTORY_DISTURB_TYPE_REMOVED)
  {
    OBK_RemoveItemFromSafe(oSafe,oItem);
  }
}
