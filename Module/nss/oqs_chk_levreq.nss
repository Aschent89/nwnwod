////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_chk_levreq
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Conversation of the Quest Giver
//
//  This checks whether Level Requirement Is Enough to Start Quest(s)
//  Actually Checks if Player Hit Dice is LOWER than Requirement.
//
////////////////////////////////////////////////////////////////////////////////

#include "oqs_inc"

int StartingConditional()
{
  object oPC=GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nLevel = GetLocalInt(oNPC,"OQS_LEVELREQ");

  int nXP = GetHitDice(oPC);

  if(nXP < nLevel) return TRUE;
  else return FALSE;
}
