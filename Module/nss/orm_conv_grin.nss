////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_conv_grin
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

  switch(GetAlignmentGoodEvil(oPC))
  {
    case ALIGNMENT_GOOD:
    switch(d4())
    {
      case 1:alword="frolicsome";break;
      case 2:alword="jesting";break;
      case 3:alword="snappy";break;
      case 4:alword="funny";break;
    }
    break;

    case ALIGNMENT_NEUTRAL:
    switch(d4())
    {
      case 1:alword="keen";break;
      case 2:alword="mischievous";break;
      case 3:alword="quick";break;
      case 4:alword="sly";break;
    }
    break;

    case ALIGNMENT_EVIL:
    switch(d4())
    {
      case 1:alword="vicious";break;
      case 2:alword="hideous";break;
      case 3:alword="malicious";break;
      case 4:alword="beastly";break;
    }
    break;
  }

  switch(d4())
  {
    case 1:message="*gives "+targname+" a "+alword+" grin*";break;
    case 2:message="*flashes a "+alword+" grin at "+targname+"*";break;
    case 3:message="*Slowly, a "+alword+" grin forms on "+GetName(oPC)+"'s face*";break;
    case 4:message="*gives "+targname+" a quick "+alword+" grin*";break;
  }

  AssignCommand(oPC,SpeakString(message,TALKVOLUME_TALK));
}
