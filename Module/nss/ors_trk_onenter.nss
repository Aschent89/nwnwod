////////////////////////////////////////////////////////////////////////////////
//  Treasure Room Key - Destroy Treasure Room Keys
//  ors_trk_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Trigger On Enter Event
//
//  Paint this Trigger in a Place where you know the player has gotten out of
//  Treasure Room (Since it Auto Locks) to remove the Treasure Room Key.
//
//  This makes ONE key viable for all treasure rooms. Nice!!
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetEnteringObject();
  string sKey = "Key_TreasureRoom";
  int nEnter = GetLocalInt(oPC,"TREASUREROOM");

  //First Enter Treasure Room Trigger
  object oTRK = GetItemPossessedBy(oPC,sKey);

  //No Key....Do Nothing
  if(!GetIsObjectValid(oTRK))return;

  //Check For Treasure Room Key in Inventory (Loop Just in Case MORE than 1 Exist)
  object oItem = GetFirstItemInInventory(oPC);
  string sItem;
  while(GetIsObjectValid(oItem))
  {
    sItem = GetTag(oItem);
    if(sItem == sKey)
    {
      SetLocalInt(oPC,"TREASUREROOM",FALSE);
      DestroyObject(oItem,0.1);
    }
    oItem = GetNextItemInInventory(oPC);
  }
}
