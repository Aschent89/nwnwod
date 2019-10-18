////////////////////////////////////////////////////////////////////////////////
//  Unulduil's Labyrinth Custom Script to Set Quest Complete When Going Back
//  oqs_cus_unulduil
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "oqs_inc"

void main()
{
  object oPC = GetClickingObject();
  object oMod = GetModule();

  string sQuest = "Unulduil1";

  //Remove Player From Party
  RemoveFromParty(oPC);

  //Retrieve Highest Quest State
  int nHQS = PQJ_RetrieveHighestPartyQuestState(oPC, sQuest);

  //Set the Quest Persistently
  AddPersistentJournalQuestEntry(sQuest, 2, oPC, TRUE, FALSE, FALSE);
}
