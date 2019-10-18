////////////////////////////////////////////////////////////////////////////////
//
//  Check Levels
//  ors_chk_lvl10
//  By Don Anderson
//  dandersonru@msn.com
//
//  Check to See if the Speaker is at or greater than a specific level.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC=GetPCSpeaker();

  int nXP = GetXP(oPC);
  int nLvl = 45000 ;

  if(nXP >= nLvl) return TRUE;
  else return FALSE;
}
