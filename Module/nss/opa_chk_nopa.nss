////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_chk_nopa
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Merchant Convo.
//
//  Checks for NO Pack Animal Ownership
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;
  object oMod = GetModule();

  if(oPC == OBJECT_INVALID) return FALSE;

  //Player Information
  int nHas = GetLocalInt(oPC,"OPA_ANIMALTOTAL");
  if(nHas == 0) return TRUE;
  else return FALSE;
}
