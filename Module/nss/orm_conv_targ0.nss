////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_conv_targ0
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
  object oTarg=GetLocalObject(oPC,"targ"+IntToString(GetLocalInt(oPC,"convtarg")));

  AssignCommand(oPC,ClearAllActions());
  SetLocalInt(oPC,"convtarg",0);
  TurnToFaceObject(oTarg,oPC);
  SetCustomToken(7100,GetName(oTarg));
}
