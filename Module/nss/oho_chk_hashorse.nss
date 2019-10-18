////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_chk_hashorse
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Merchant Convo.
//
//  Checks for NO Horse Ownership
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;
  object oMod = GetModule();

  if(oPC == OBJECT_INVALID) return FALSE;

  //Player Information
  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  int nHasH = GetLocalInt(oItem,"OHO_ANIMALTOTAL");
  if(nHasH == 1) return TRUE;
  else return FALSE;
}
