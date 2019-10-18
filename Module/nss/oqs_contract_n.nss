////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_contract_n
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the NPC Commodity Convo
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;

  object oContract = GetItemPossessedBy(oPC,"QuestContract");

  //All Checks
  if(GetIsObjectValid(oContract) == FALSE) return TRUE;
  else return FALSE;
}
