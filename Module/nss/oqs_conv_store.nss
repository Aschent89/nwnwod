////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_conv_store
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the NPC Commodity Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"

void main()
{
  //Conversation or Placeable
  object oPC = GetPCSpeaker();
  object oMerchant = OBJECT_SELF;
  string sTag = GetTag(oMerchant);

  //Find the Store and Open it
  object oStore = GetNearestObjectByTag(sTag + "STORE");
  if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
  {
    gplotAppraiseOpenStore(oStore, oPC);
  }
}
