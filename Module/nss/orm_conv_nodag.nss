////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_conv_nodag
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
      case 1:alword="hearty";break;
      case 2:alword="considerate";break;
      case 3:alword="pleasant";break;
      case 4:alword="sympathetic";break;
    }
    break;

    case ALIGNMENT_NEUTRAL:
    switch(d4())
    {
      case 1:alword="quick";break;
      case 2:alword="spiritless";break;
      case 3:alword="curt";break;
      case 4:alword="gruff";break;
    }
    break;

    case ALIGNMENT_EVIL:
    switch(d4())
    {
      case 1:alword="stiff";break;
      case 2:alword="detached";break;
      case 3:alword="cold";break;
      case 4:alword="callous";break;
    }
    break;
  }

  switch(d4())
  {
    case 1:message="*gives "+targname+" a "+alword+" nod*";break;
    case 2:message="*acknowledges "+targname+" with a "+alword+" nod*";break;
    case 3:message="*listens then gives a "+alword+" nod*";break;
    case 4:message="*gives "+targname+" a "+alword+" nod*";break;
  }

  AssignCommand(oPC,SpeakString(message,TALKVOLUME_TALK));
}
