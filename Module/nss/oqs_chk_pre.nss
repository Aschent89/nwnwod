////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_chk_pre
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Conversation of the Quest Giver
//
//  Message Format:  OQS_PREITEM (Variable in String)
//          Tag of Item Required (Actual Text Portion)
//
////////////////////////////////////////////////////////////////////////////////

#include "oqs_inc"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  string sItemS = "OQS_PREITEM";
  string sItem = GetLocalString(oNPC,sItemS);

  object oItem = GetItemPossessedBy(oPC,sItem);

  if(!GetIsObjectValid(oItem)) return TRUE;
  else return FALSE;
}
