////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_ar_ntor
//  By Don Anderson
//  dandersonru@msn.com
//
//  Available to Craft
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nSection = GetLocalInt(oPC, "CR_PART");
  if(nSection == ITEM_APPR_ARMOR_MODEL_TORSO
    || nSection == ITEM_APPR_ARMOR_MODEL_BELT
    || nSection == ITEM_APPR_ARMOR_MODEL_NECK
    || nSection == ITEM_APPR_ARMOR_MODEL_PELVIS
    || nSection == ITEM_APPR_ARMOR_MODEL_ROBE)
  {
    return FALSE;
  }

  return TRUE;
}
