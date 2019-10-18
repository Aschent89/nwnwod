////////////////////////////////////////////////////////////////////////////////
//  Capture the Flag
//  ors_ctf_death
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc_ctf"

void main()
{
  object oPC  = OBJECT_SELF;
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  string sBFText = "The Blue Flag Carrier has been killed. The Red Flag has been returned.";
  string sRFText = "The Red Flag Carrier has been killed. The Blue Flag has been returned.";

  //Check Team Info Blue = 1, Red = 2
  int nTeam = CTF_TeamNumber(oPC);

  //Blue Team
  if(nTeam == 1)
  {
    object oRedFlag = GetItemPossessedBy(oPC,"CTF_IRedFlag");
    if(GetIsObjectValid(oRedFlag))
    {
      DestroyObject(oRedFlag);

      AssignCommand(oCTFSK,SpeakString(sBFText,TALKVOLUME_SHOUT));

      CTF_CreateRedFlag();
      ClearAllActions(TRUE);
      CTF_RemoveEffects(oPC);
    }
  }

  //Red Team
  if(nTeam == 2)
  {
    object oBlueFlag = GetItemPossessedBy(oPC,"CTF_IBlueFlag");
    if(GetIsObjectValid(oBlueFlag))
    {
      DestroyObject(oBlueFlag);

      AssignCommand(oCTFSK,SpeakString(sRFText,TALKVOLUME_SHOUT));

      CTF_CreateBlueFlag();
      ClearAllActions(TRUE);
      CTF_RemoveEffects(oPC);
    }
  }
}
