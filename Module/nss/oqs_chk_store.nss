////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_chk_store
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Rest Menu Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"

int StartingConditional()
{
  //Conversation or Placeable
  object oPC = GetPCSpeaker();
  object oMerchant = OBJECT_SELF;
  string sTag = GetTag(oMerchant);

  //Find the Store and Open it
  object oStore = GetNearestObjectByTag(sTag + "STORE");
  if(GetIsObjectValid(oStore) && GetObjectType(oStore) == OBJECT_TYPE_STORE) return TRUE;
  else return FALSE;
}
