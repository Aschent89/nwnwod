////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_chk_dd
//  By Don Anderson
//  dandersonru@msn.com
//
//  Checks a Death Deed
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC=GetPCSpeaker();

  object oDD = GetItemPossessedBy(oPC,"DeathDeed");
  if(GetIsObjectValid(oDD)) return TRUE;
  else return FALSE;
}
