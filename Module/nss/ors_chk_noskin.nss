////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Checks for No Skin
//  ors_chk_noskin
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is FALSE if a Player has a Skin....Called from ORM
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC=GetPCSpeaker();

  object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
  if(GetIsObjectValid(oSkin)) return FALSE;
  else return TRUE;

}
