////////////////////////////////////////////////////////////////////////////////
//
//  Check Check for Death Deed
//  ors_chk_dd
//  By Don Anderson
//  dandersonru@msn.com
//
//  Check to See if the Speaker is at or greater than a specific level.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC=GetPCSpeaker();

  object oDD = GetItemPossessedBy(oPC,"DeathDeed");
  if(GetIsObjectValid(oDD)) return TRUE;
  else return FALSE;
}
