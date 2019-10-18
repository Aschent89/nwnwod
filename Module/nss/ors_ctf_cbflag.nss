////////////////////////////////////////////////////////////////////////////////
//  Capture the Flag - Capture Blue Flag
//  ors_ctf_cbflag
//  By Don Anderson
//  dandersonru@msn.com
//
//  Red Team Captures Blue Flag
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc_ctf"

void main()
{
  object oPC = GetEnteringObject();
  string sName = GetName(oPC);
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Check Team Info Blue = 1, Red = 2
  int nTeam = CTF_TeamNumber(oPC);

  //Blue Flag Status
  int nBFtaken = GetLocalInt(oCTFSK, "CTF_BFTAKEN");

  //Red Team and Blue Flag Taken
  if(nTeam == 2 && nBFtaken == 1)
  {
    CTF_RedTeamScores(oPC);
    ClearAllActions(TRUE);
    CTF_RemoveEffects(oPC);

    int nScore = GetLocalInt(oCTFSK, "CTF_REDSCORE");
    //5 Scores and Game is Over
    if(nScore >= 5) CTF_EndGame();

    //Give Score
    else CTF_GiveScore(oCTFSK);
  }
}
