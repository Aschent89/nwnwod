////////////////////////////////////////////////////////////////////////////////
//  Give an Item When Entering the Trigger
//  ors_giv_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Trigger On Enter Event
//
//  With this script you set an Item ResRef and Tag of the Item on the Trigger
//  When a player enters the trigger they will get 1 item. You can use this for
//  giving rewards as players continue along on quests.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetEnteringObject();
  string sGiftRes = GetLocalString(oPC,"GIFT_RESREF");
  string sGiftTag = GetLocalString(oPC,"GIFT_TAG");

  //If Trigger Info is not configured....do nothing
  if(sGiftRes == "" || sGiftRes == "ResRef") return;
  if(sGiftTag == "" || sGiftTag == "Tag") return;

  //Only get 1 of these Items.
  object oGift = GetItemPossessedBy(oPC,sGiftTag);

  if(GetIsObjectValid(oGift))return;

  //Give the Gift Item
  CreateItemOnObject(sGiftRes,oPC);
}
