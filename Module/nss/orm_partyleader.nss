////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_partyleader
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

int StartingConditional()
{
  object oPC=GetPCSpeaker();

  if(!GetLocalInt(oPC,"plmode"))
  {
    SetCustomToken(6665,IntToString(GetLocalInt(oPC,"plmin")));
    SetCustomToken(6667,"");
    SetCustomToken(6666,"off");
  }
  else SetCustomToken(6666,"on");

  return TRUE;
}
