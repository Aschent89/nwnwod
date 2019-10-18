////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Universal Merchant Activator
//  ors_univ_merch
//  by Don Anderson
//  dandersonru@msn.com
//
//  Use this on a Creature to Dynamically Open Merchants
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"

void main()
{
  object oPC = GetPCSpeaker();
  object oMerchant = OBJECT_SELF;
  string sTag = GetTag(oMerchant);

  //Find the Store and Open it
  string sStore; int nNth = 1;
  object oStore = GetNearestObject(OBJECT_TYPE_STORE, oMerchant, nNth);
  while(GetIsObjectValid(oStore))
  {
    sStore = GetTag(oStore);
    if(sStore == sTag) break;

    nNth++;
    oStore = GetNearestObject(OBJECT_TYPE_STORE, oMerchant, nNth);
  }

  if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
  {
    gplotAppraiseOpenStore(oStore, oPC);
  }
}
