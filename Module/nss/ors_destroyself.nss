////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Destroy Self if Empty
//  ors_destroyself
//  by Don Anderson
//  dandersonru@msn.com
//
//  Place this on the On Closed Event of whatever will disappear if empty
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oSelf    = OBJECT_SELF;
  object oItem = GetFirstItemInInventory(oSelf);
  if(oItem == OBJECT_INVALID) DestroyObject(oSelf,5.0);
}
