////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_chk_ncomplet
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Conversation of the Quest Giver
//
//  This is Good for Checking if a Segment of the Quest is Not Complete.
//
//  These are Persistent Quests!
//
////////////////////////////////////////////////////////////////////////////////

#include "oqs_inc"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nItem = GetLocalInt(oPC,"OQS_TEMPCHECK");
  string sQuestN = "OQS_QUEST" + IntToString(nItem);
  string sQuest = GetLocalString(oNPC, sQuestN);

  //Retrieve Highest Quest State
  int nHQS = PQJ_RetrieveHighestPartyQuestState(oPC, sQuest);

  //Has Not Done This Quest
  if(nHQS < 2) return TRUE;

  else return FALSE;
}
