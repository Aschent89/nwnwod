////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_mod_onequip
//  By Don Anderson
//  dandersonru@msn.com
//
//  Dismounts Riding a Horse On Entering the Module (DOES NOT Recall the Horse)
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC = GetPCItemLastEquippedBy();
  object oShield = GetPCItemLastEquipped();

  if(!OHOPCRidingHorse(oPC)) return;

  //Shields Equipped
  if(GetIsObjectValid(oShield))
  {
    int nShield = GetBaseItemType(oShield);
    if(nShield == BASE_ITEM_SMALLSHIELD
      || nShield == BASE_ITEM_LARGESHIELD
      || nShield == BASE_ITEM_TOWERSHIELD)
    {
      object oItem = GetItemPossessedBy(oPC,"HorseControl");
      int nPheno = GetLocalInt(oItem, "OHO_PHENOTYPE");
      if(nPheno == PHENOTYPE_NORMAL) SetPhenoType(HORSE_PHENO_NORMAL_SHIELD,oPC);
      if(nPheno == PHENOTYPE_BIG) SetPhenoType(HORSE_PHENO_LARGE_SHIELD,oPC);
    }
  }
}
