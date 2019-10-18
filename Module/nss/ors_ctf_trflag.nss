////////////////////////////////////////////////////////////////////////////////
//  Capture the Flag - Take Red Flag
//  ors_ctf_trflag
//  By Don Anderson
//  dandersonru@msn.com
//
//  Blue Team Takes Red Flag
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc_ctf"

void main()
{
  object oPC = GetEnteringObject();
  string sName = GetName(oPC);
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");
  object oRF = GetObjectByTag("CTF_RedFlag");

  //Check Team Info Blue = 1, Red = 2
  int nTeam = CTF_TeamNumber(oPC);

  //Red Flag Status
  int nRFtaken = GetLocalInt(oCTFSK, "CTF_RFTAKEN");

  //Blue Team and Red Flag Not Taken
  if(nTeam == 1 && nRFtaken == 0)
  {
    CTF_RedFlagTaken(oPC);
    CTF_RedEffectFlag(oPC);
  }
}
