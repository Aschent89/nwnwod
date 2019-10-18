////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_em_defspeed
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

void main()
{
  object oPC=GetPCSpeaker();

  SetLocalFloat(oPC,"ORM_SPEED",1.0);
  SetCustomToken(6664,FloatToString(GetLocalFloat(oPC,"ORM_SPEED")));
}
