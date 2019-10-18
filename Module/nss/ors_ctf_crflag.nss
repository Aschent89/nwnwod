////////////////////////////////////////////////////////////////////////////////
//  Capture the Flag - Capture Red Flag
//  ors_ctf_crflag
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

  //Red Flag Status
  int nRFtaken = GetLocalInt(oCTFSK, "CTF_RFTAKEN");

  //Blue Team and Red Flag Taken
  if(nTeam == 1 && nRFtaken == 1)
  {
    CTF_BlueTeamScores(oPC);
    ClearAllActions(TRUE);
    CTF_RemoveEffects(oPC);

    int nScore = GetLocalInt(oCTFSK, "CTF_BLUESCORE");
    //5 Scores and Game is Over
    if(nScore >= 5) CTF_EndGame();

    //Give Score
    else CTF_GiveScore(oCTFSK);
  }
}
