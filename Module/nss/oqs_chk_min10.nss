////////////////////////////////////////////////////////////////////////////////
//  Olander's and 9Fires' Quest/Commodities/Bounties System
//  oqs_chk_min10
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
  object oMod = GetModule();

  int nQTY = GetLocalInt(oNPC,"BUY_TOTALITEMS");

  //All Checks
  if(nQTY >= 10) return TRUE;
  else return FALSE;
}
