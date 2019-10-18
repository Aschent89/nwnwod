////////////////////////////////////////////////////////////////////////////////
//  Olander's Library - No Removal of Books
//  ors_lib_nrb
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Trigger On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetEnteringObject();
  string sLocal = "LIBRARYBOOK";
  string sBook = "LibraryBook";

  int nHasBook = GetLocalInt(oPC,sLocal);

  if(nHasBook == 1)
  {
    //Check For Library Books in Inventory
    object oItem = GetFirstItemInInventory(oPC);
    string sItem;
    while(GetIsObjectValid(oItem))
    {
      sItem = GetTag(oItem);
      if(sItem == sBook) DestroyObject(oItem,0.1);
      oItem = GetNextItemInInventory(oPC);
    }
    DeleteLocalInt(oPC,sLocal);
  }
}
