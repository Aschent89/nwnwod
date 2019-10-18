////////////////////////////////////////////////////////////////////////////////
//
//  Replicates a Specific Key
//  ors_keyreplicate
//  by Don Anderson
//  dandersonru@msn.com
//
//  Place this on the On Used Event of a Sign
//  The Placeable's Tag MUST Equal the Key to be Replicated!!
//  Cost is 1000 Gold to Replicate.
//
//  Note...Make sure the Key can be Given away!!
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetLastUsedBy();
  object oSelf = OBJECT_SELF;
  string sSelf = GetTag(oSelf);

  object oKey = GetItemPossessedBy(oPC,sSelf);

  if(GetIsObjectValid(oKey))
  {
    //Now Check for Enough Gold
    int nGold = GetGold(oPC);
    if(nGold < 1000)
    {
      SpeakString("***You Need 1000 Gold To Make a Key Copy***");
      return;
    }

    //Make the Key
    string sKeyResRef = GetResRef(oKey);
    CreateItemOnObject(sKeyResRef,oPC,1);
    TakeGoldFromCreature(1000,oPC,TRUE);
  }
  else
  {
    SpeakString("***You Have No Proper Key***");
  }
}
