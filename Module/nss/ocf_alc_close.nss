////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_alc_close
//  by Don Anderson
//  dandersonru@msn.com
//
//  Starts Herbology from the Cook Pot
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oItem = GetFirstItemInInventory(OBJECT_SELF);

    if(!GetIsObjectValid(oItem))
    {
      DestroyObject(OBJECT_SELF);
      CreateObject(OBJECT_TYPE_PLACEABLE, "campfire", GetLocation(oSelf));
    }
    else
    {
      ExecuteScript("ocr_herb_onclose",GetLastClosedBy());
    }
}
