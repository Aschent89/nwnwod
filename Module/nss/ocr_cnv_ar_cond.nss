////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_ar_cond
//  By Don Anderson
//  dandersonru@msn.com
//
//  Available to Craft
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);

  if(GetIsObjectValid(oItem))
  {
    if(GetLocalInt(oItem,"NOCRAFT") > 0)
    {
      SendMessageToPC(oPC,"This Armor can NOT be Modified.");
      return FALSE;
    }

    return TRUE;
  }
  return FALSE;
}
