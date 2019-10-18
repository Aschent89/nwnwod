////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_dist_packbox
//  By Don Anderson
//  dandersonru@msn.com
//
//  place this in the OnDisturbed Event of the Pack Box
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oPack = OBJECT_SELF;
  object oItem = GetInventoryDisturbItem();

  int nDType = GetInventoryDisturbType();

  //Added an Item
  if(nDType == INVENTORY_DISTURB_TYPE_ADDED)
  {
    OPA_AddItemToPack(oPack,oItem);
  }

  //Removed an Item
  if(nDType == INVENTORY_DISTURB_TYPE_REMOVED)
  {
    OPA_RemoveItemFromPack(oPack,oItem);
  }
}
