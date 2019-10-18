////////////////////////////////////////////////////////////////////////////////
//  Capture the Flag
//  ors_inc_ctf
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

void CTF_RemoveEffects(object oPC)
{
  effect eEffect = GetFirstEffect(oPC);
  while(GetIsEffectValid(eEffect))
  {
    int nType = GetEffectType(eEffect);
    if(GetEffectSubType(eEffect) == SUBTYPE_SUPERNATURAL
      && nType == EFFECT_TYPE_VISUALEFFECT
      && GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT
      && GetEffectSpellId(eEffect) == -1)
    {
      RemoveEffect(oPC, eEffect);
    }
    eEffect = GetNextEffect(oPC);
  }
}

void CTF_BlueEffectFlag(object oPC)
{
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectVisualEffect(VFX_DUR_FLAG_BLUE)),oPC);
}

void CTF_RedEffectFlag(object oPC)
{
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectVisualEffect(VFX_DUR_FLAG_RED)),oPC);
}

void CTF_BlueFlagTaken(object oPC)
{
  string sName = GetName(oPC);
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  string sText = "Red team has taken the Blue flag! It is carried by " + sName + ".";
  AssignCommand(oCTFSK,SpeakString(sText,TALKVOLUME_SHOUT));

  //Destroy Placeable Flag
  object oBlueFlag = GetObjectByTag("CTF_PBlueFlag");
  DestroyObject(oBlueFlag);

  SetLocalInt(oCTFSK,"CTF_BFTAKEN",1);
}

void CTF_RedFlagTaken(object oPC)
{
  string sName = GetName(oPC);
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  string sText = "Blue team has taken the Red flag! It is carried by " + sName + ".";
  AssignCommand(oCTFSK,SpeakString(sText,TALKVOLUME_SHOUT));

  //Destroy Placeable Flag
  object oRedFlag = GetObjectByTag("CTF_PRedFlag");
  DestroyObject(oRedFlag);

  SetLocalInt(oCTFSK,"CTF_RFTAKEN",1);
}

void CTF_CreateBlueFlag()
{
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Create the Red flag in its place again
  object oBFH = GetObjectByTag ("WP_BLUEFLAG_HOME");
  location lBFH = GetLocation(oBFH);
  CreateObject(OBJECT_TYPE_PLACEABLE, "ctf_blueflag", lBFH, FALSE);

  SetLocalInt(oCTFSK,"CTF_BFTAKEN",0);
}

void CTF_DestroyBlueFlag()
{
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Destroy Placeable Flag
  object oBlueFlag = GetObjectByTag("CTF_PBlueFlag");
  DestroyObject(oBlueFlag);

  SetLocalInt(oCTFSK,"CTF_BFTAKEN",0);
}

void CTF_CreateRedFlag()
{
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Create the Red flag in its place again
  object oRFH = GetObjectByTag ("WP_REDFLAG_HOME");
  location lRFH = GetLocation(oRFH);
  CreateObject(OBJECT_TYPE_PLACEABLE, "ctf_redflag", lRFH, FALSE);

  SetLocalInt(oCTFSK,"CTF_RFTAKEN",0);
}

void CTF_DestroyRedFlag()
{
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Destroy Placeable Flag
  object oRedFlag = GetObjectByTag("CTF_PRedFlag");
  DestroyObject(oRedFlag);

  SetLocalInt(oCTFSK,"CTF_BFTAKEN",0);
}

void CTF_CreatePCBlueFlag(object oPC)
{
  //Destroy Placeable Flag
  object oBlueFlag = GetNearestObjectByTag("CTF_PBlueFlag",oPC);
  DestroyObject(oBlueFlag);

  //Create Flag on Player
  CreateItemOnObject("ctf_iblueflag",oPC);
}

void CTF_CreatePCRedFlag(object oPC)
{
  //Destroy Placeable Flag
  object oRedFlag = GetNearestObjectByTag("CTF_PRedFlag",oPC);
  DestroyObject(oRedFlag);

  //Create Flag on Player
  CreateItemOnObject("ctf_iredflag",oPC);
}

void CTF_SetPCBlueTeam(object oPC)
{
  object oTeam = GetItemPossessedBy(oPC,"CTF_BlueTeam");
  if(!GetIsObjectValid(oTeam))
  {
    //Create Team Item on Player
    CreateItemOnObject("ctf_blueteam",oPC);
  }
}

void CTF_SetPCRedTeam(object oPC)
{
  object oTeam = GetItemPossessedBy(oPC,"CTF_RedTeam");
  if(!GetIsObjectValid(oTeam))
  {
    //Create Team Item on Player
    CreateItemOnObject("ctf_redteam",oPC);
  }
}

void CTF_RemovePCTeam(object oPC)
{
  object oBlueTeam = GetItemPossessedBy(oPC,"CTF_BlueTeam");
  if(GetIsObjectValid(oBlueTeam)) DestroyObject(oBlueTeam);
  object oRedTeam = GetItemPossessedBy(oPC,"CTF_RedTeam");
  if(GetIsObjectValid(oRedTeam)) DestroyObject(oRedTeam);
}

int CTF_TeamNumber(object oPC)
{
  //Check Team Items
  object oBlueTeam = GetItemPossessedBy(oPC,"CTF_BlueTeam");
  object oRedTeam = GetItemPossessedBy(oPC,"CTF_RedTeam");

  if(GetIsObjectValid(oBlueTeam)) return 1;
  if(GetIsObjectValid(oRedTeam)) return 2;

  return 0;
}

void CTF_BlueTeamScores(object oPC)
{
  string sName = GetName(oPC);
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Remove Flag From Player
  object oFlag = GetItemPossessedBy(oPC,"CTF_IRedFlag");
  DestroyObject(oFlag);

  CTF_CreateRedFlag();

  string sText = sName + " has captured the flag! Blue team scores!";
  AssignCommand(oCTFSK,SpeakString(sText,TALKVOLUME_SHOUT));

  int nScore = GetLocalInt(oCTFSK, "CTF_BLUESCORE");
  nScore++;
  SetLocalInt(oCTFSK,"CTF_BLUESCORE",nScore);
}

void CTF_RedTeamScores(object oPC)
{
  string sName = GetName(oPC);
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Remove Flag From Player
  object oFlag = GetItemPossessedBy(oPC,"CTF_IBlueFlag");
  DestroyObject(oFlag);

  CTF_CreateBlueFlag();

  string sText = sName + " has captured the flag! Red team scores!";
  AssignCommand(oCTFSK,SpeakString(sText,TALKVOLUME_SHOUT));

  int nScore = GetLocalInt(oCTFSK, "CTF_REDSCORE");
  nScore++;
  SetLocalInt(oCTFSK,"CTF_REDSCORE",nScore);
}

void CTF_GiveScore(object oCTFSK)
{
  int nBScore = GetLocalInt(oCTFSK,"CTF_BLUESCORE");
  int nRScore = GetLocalInt(oCTFSK,"CTF_REDSCORE");

  string sBScore = IntToString (nBScore);
  string sRScore = IntToString (nRScore);
  string sTally  = "Scores are: Blue Team: " + sBScore + " Red Team: " + sRScore + ".";

  AssignCommand(oCTFSK,SpeakString(sTally,TALKVOLUME_SHOUT));
}

void CTF_BeginGame()
{
  object oPC;
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Give Score
  CTF_GiveScore(oCTFSK);

  //Reset Scorekeeper
  SetLocalInt(oCTFSK,"CTF_BFTAKEN",0);
  SetLocalInt(oCTFSK,"CTF_RFTAKEN",0);
  SetLocalInt(oCTFSK,"CTF_BLUESCORE",0);
  SetLocalInt(oCTFSK,"CTF_REDSCORE",0);

  CTF_CreateBlueFlag();
  CTF_CreateRedFlag();
}

void CTF_EndGame()
{
  object oPC;
  object oCTFSK = GetObjectByTag("CTFScoreKeeper");

  //Give Final Score
  CTF_GiveScore(oCTFSK);

  //Reset Scorekeeper
  SetLocalInt(oCTFSK,"CTF_BFTAKEN",0);
  SetLocalInt(oCTFSK,"CTF_RFTAKEN",0);
  SetLocalInt(oCTFSK,"CTF_BLUESCORE",0);
  SetLocalInt(oCTFSK,"CTF_REDSCORE",0);

  //Destroy Flags (Items Carried by PC will be cleared when Leaving)
  CTF_DestroyBlueFlag();
  CTF_DestroyRedFlag();
}

//void main(){}
