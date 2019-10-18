////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_sd_cond
//  By Don Anderson
//  dandersonru@msn.com
//
//  Available to Craft
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

  if(GetIsObjectValid(oItem))
  {
    if(GetLocalInt(oItem,"NOCRAFT") > 0)
    {
      SendMessageToPC(oPC,"This Shield can NOT be Modified.");
      return FALSE;
    }

    int nBaseItemType = GetBaseItemType(oItem);
    if(((nBaseItemType == BASE_ITEM_SMALLSHIELD) || (nBaseItemType == BASE_ITEM_LARGESHIELD)) || (nBaseItemType == BASE_ITEM_TOWERSHIELD))
    {
      return TRUE;
    }

    return FALSE;
  }
  return FALSE;
}
