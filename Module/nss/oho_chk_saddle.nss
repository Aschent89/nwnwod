////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_chk_saddle
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  int nSaddle = GetLocalInt(oItem,"OHO_HORSE_SADDLE");

  if(nSaddle != 1)
  {
    SendMessageToPC(oPC,"You MUST make a saddle to ride your horse. See the Barding Loom in the Stables.");
    return FALSE;
  }

  return TRUE;
}
