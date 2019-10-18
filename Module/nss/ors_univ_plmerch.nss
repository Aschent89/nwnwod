////////////////////////////////////////////////////////////////////////////////
//
//  Universal Merchant Activator
//  opw_univ_plmerch
//  by Don Anderson
//  dandersonru@msn.com
//
//  Use this on a Placeable to Dynamically Open Merchants
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"

void main()
{
  object oPC = GetLastUsedBy();
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
    PlaySound ("as_sw_chestop1");
    AssignCommand(oMerchant, PlayAnimation (ANIMATION_PLACEABLE_OPEN, 1.0, 0.0));
    DelayCommand(30.0, AssignCommand (oMerchant, PlayAnimation (ANIMATION_PLACEABLE_CLOSE, 1.0, 0.0f)));

    gplotAppraiseOpenStore(oStore, oPC);
  }
}
