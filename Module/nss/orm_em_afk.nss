////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_em_afk
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
  AssignCommand(oPC,ClearAllActions());
  AssignCommand(oPC,GoAFK(oPC));
  SetLocalInt(oPC,"REST_MENU",0);
}
