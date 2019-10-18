////////////////////////////////////////////////////////////////////////////////
//  Capture the Flag - Take Blue Flag
//  ors_ctf_tbflag
//  By Don Anderson
//  dandersonru@msn.com
//
//  Red Team Takes Blue Flag
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc_ctf"

void main()
{
  object oPC = GetEnteringObject();
  string sName = GetName(oPC);
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");
  object oBF = GetObjectByTag("CTF_BlueFlag");

  //Check Team Info Blue = 1, Red = 2
  int nTeam = CTF_TeamNumber(oPC);

  //Blue Flag Status
  int nBFtaken = GetLocalInt(oCTFSK, "CTF_BFTAKEN");

  //Red Team and Blue Flag Not Taken
  if(nTeam == 2 && nBFtaken == 0)
  {
    CTF_BlueFlagTaken(oPC);
    CTF_BlueEffectFlag(oPC);
  }
}
