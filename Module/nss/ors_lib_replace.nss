////////////////////////////////////////////////////////////////////////////////
//  Olander's Library - Replace Library Books on Shelf
//  ors_lib_replace
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Bookshelf On Disturbed Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oShelf     = OBJECT_SELF;
  object oPC        = GetLastDisturbed();
  object oBook      = GetInventoryDisturbItem();
  string sRBook     = GetResRef(oBook);
  string sTBook     = GetTag(oBook);
  string sBook      = "LIBRARYBOOK";

  int nDType = GetInventoryDisturbType();

  //Destroy Added Book or Whatever
  if(nDType == INVENTORY_DISTURB_TYPE_ADDED)
  {
    DestroyObject(oBook,0.1);
    return;
  }

  //Refill Contents of Book Shelf
  if(nDType == INVENTORY_DISTURB_TYPE_REMOVED)
  {
    CreateItemOnObject(sRBook,oShelf,1,sTBook);
    SetLocalInt(oPC,sBook,1);
    return;
  }
}
