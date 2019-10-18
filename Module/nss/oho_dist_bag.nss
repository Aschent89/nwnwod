////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_dist_bag
//  By Don Anderson
//  dandersonru@msn.com
//
//  place this in the OnDisturbed Event of the Saddle Bag
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oBag = OBJECT_SELF;
  object oItem = GetInventoryDisturbItem();

  int nDType = GetInventoryDisturbType();

  //Added an Item
  if(nDType == INVENTORY_DISTURB_TYPE_ADDED)
  {
    OHO_AddItemToBag(oBag,oItem);
  }

  //Removed an Item
  if(nDType == INVENTORY_DISTURB_TYPE_REMOVED)
  {
    OHO_RemoveItemFromBag(oBag,oItem);
  }
}
