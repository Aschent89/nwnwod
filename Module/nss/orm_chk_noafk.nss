////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_chk_noafk
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
  int nReturn = GetLocalInt(oPC,"IsAFK");
  if(nReturn <= 0) return TRUE;

  return FALSE;
}
