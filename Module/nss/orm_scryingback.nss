////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_scryingback
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
  int nPage=GetLocalInt(oPC,"scryingpage");
  if(nPage>1) SetLocalInt(oPC,"scryingpage",nPage-1);
}
