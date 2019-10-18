////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Destroy Self and Respawn if Empty
//  ocr_oc_place
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
  if(!GetIsObjectValid(oItem))
  {
    DestroyObject(oSelf,5.0);
  }
}
