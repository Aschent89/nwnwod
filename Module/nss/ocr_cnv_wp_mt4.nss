////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_wp_mt4
//  By Don Anderson
//  dandersonru@msn.com
//
//  Available to Craft
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);

    //Check for Greater than 4 on this Weapon
    int nBot = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_MODEL_BOTTOM);
    int nMid = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_MODEL_MIDDLE);
    int nTop = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_MODEL_TOP);

    if(nBot > 4 || nMid > 4 || nTop > 4) return TRUE;

    return FALSE;
}
