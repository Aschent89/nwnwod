////////////////////////////////////////////////////////////////////////////////
//
//  Check Levels
//  ors_chk_less9
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
  int nLvl = 36000 ;

  if(nXP < nLvl) return TRUE;
  else return FALSE;
}
