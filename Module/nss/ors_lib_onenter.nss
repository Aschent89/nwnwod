////////////////////////////////////////////////////////////////////////////////
//  Olander's Library - Destroy Library Books On Client Enter
//  ors_lib_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Client On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetEnteringObject();
  string sBook = "LibraryBook";

  //Check For Library Books in Inventory
  object oItem = GetFirstItemInInventory(oPC);
  string sItem;
  while(GetIsObjectValid(oItem))
  {
    sItem = GetTag(oItem);
    if(sItem == sBook) DestroyObject(oItem,0.1);
    oItem = GetNextItemInInventory(oPC);
  }
}
