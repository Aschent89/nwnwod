////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_conv_shake
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

  string targname=GetName(oTarg);
  string message;
  string alword;

  switch(d4())
  {
    case 1:message="*shakes head*";break;
    case 2:message="*shakes head at "+targname+"*";break;
    case 3:message="*shakes head firmly*";break;
    case 4:message="*shakes head*";break;
  }

  AssignCommand(oPC,SpeakString(message,TALKVOLUME_TALK));
}
