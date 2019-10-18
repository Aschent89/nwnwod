////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_gv_mssg1
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Conversation of the Sender
//
//  PLEASE NOTE: If the NPC WILL have Messages….even eventually….Quest 100 is
//               reserved for Message Send and receive!!
//
//  This is Good for Giving a Message to Someone. Simply
//  use/copy this and set the Quantity to which Message this is.
//
//  Format:  OQS_MESSAGE_GIVE# (Variable in String)
//           ResRef of Message (Actual Text Portion)
//
////////////////////////////////////////////////////////////////////////////////

#include "oqs_inc"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nMessage = 100;
  string sQuestN = "OQS_QUEST" + IntToString(nMessage);
  string sQuest = GetLocalString(oNPC, sQuestN);
  string sMessage = "OQS_MESSAGE_GIVE" + IntToString(nMessage);
  string sItem = GetLocalString(oNPC,sMessage);

  //Retrieve Highest Quest State
  int nHQS = PQJ_RetrieveHighestPartyQuestState(oPC, sQuest);

  //Has Started This Quest
  if(nHQS == 1) return FALSE;

  if(sMessage != "")
  {
    //Remove Player From Party
    RemoveFromParty(oPC);

    object oMessage = CreateItemOnObject(sItem,oPC,1);
    AddPersistentJournalQuestEntry(sQuest,1,oPC,FALSE,FALSE,FALSE);
    return TRUE;
  }

  return FALSE;
}
