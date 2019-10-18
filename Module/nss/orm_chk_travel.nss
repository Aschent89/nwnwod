////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_chk_travel
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nReturn = GetLocalInt(oPC,"OHTF_TRAVEL");
  if(nReturn > 0) return TRUE;

  return FALSE;
}
