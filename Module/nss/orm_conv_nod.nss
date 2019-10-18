////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_conv_nod
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
    case 1:message="*nods*";break;
    case 2:message="*nods to "+targname+"*";break;
    case 3:message="*nods*";break;
    case 4:message="*nods at "+targname+"*";break;
  }

  AssignCommand(oPC,SpeakString(message,TALKVOLUME_TALK));
}
