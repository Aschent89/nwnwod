////////////////////////////////////////////////////////////////////////////////
//
//  Check Levels
//  ors_chk_less20
//  By Don Anderson
//  dandersonru@msn.com
//
//  Check to See if the Speaker is less than a specific level.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC=GetPCSpeaker();

  int nXP = GetXP(oPC);
  int nLvl = 190000 ;

  if(nXP < nLvl) return TRUE;
  else return FALSE;
}
