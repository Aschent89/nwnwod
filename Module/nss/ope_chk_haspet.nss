////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pet
//  ope_chk_haspet
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Merchant Convo.
//
//  Checks for Pack Animal Ownership
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;
  object oMod = GetModule();

  if(oPC == OBJECT_INVALID) return FALSE;

  //Player Information
  int nHas = GetLocalInt(oPC,"OPE_PETTOTAL");
  if(nHas == 1) return TRUE;
  else return FALSE;
}
