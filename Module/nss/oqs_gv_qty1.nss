////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_gv_qty1
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Conversation of the Quest Giver
//
//  This is Good for Giving a Quest for Minimum Quantity of Items Required To
//  Complete That Segment of the Quest.
//
//  These are Persistent Quests!
//
//  Simply use/copy this and set the Quantity to which Message this is.
//
//  NOTE: This SETS the Quest to a Player ONLY this is
//  Used in conjunction with  oqs_chk_qty1 (Does everything)
//
////////////////////////////////////////////////////////////////////////////////

#include "oqs_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nMessage = 1;
  string sQuestN = "OQS_QUEST" + IntToString(nMessage);
  string sQuest = GetLocalString(oNPC, sQuestN);

  //Remove Player From Party
  RemoveFromParty(oPC);

  AddPersistentJournalQuestEntry(sQuest, 1, oPC, FALSE, FALSE, FALSE);
}
