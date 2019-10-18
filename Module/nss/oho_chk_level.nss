////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_chk_level
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Animal Convo.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nRideReq = GetLocalInt(oMod,"RIDEHORSE");
  int nLevel = GetHitDice(oPC);

  //Player has not enough levels to ride a Horse
  if(nLevel < nRideReq)
  {
    SendMessageToPC(oPC,"Server requires Level "+IntToString(nRideReq)+" to ride a horse.");
    return FALSE;
  }

  return TRUE;
}
