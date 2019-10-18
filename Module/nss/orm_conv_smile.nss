////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_conv_smile
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
      case 1:alword="warm";break;
      case 2:alword="glowing";break;
      case 3:alword="earnest";break;
      case 4:alword="lively";break;
    }
    break;

    case ALIGNMENT_NEUTRAL:
    switch(d4())
    {
      case 1:alword="sly";break;
      case 2:alword="mischievous";break;
      case 3:alword="coy";break;
      case 4:alword="wily";break;
    }
    break;

    case ALIGNMENT_EVIL:
    switch(d4())
    {
      case 1:alword="wicked";break;
      case 2:alword="devilish";break;
      case 3:alword="fiendish";break;
      case 4:alword="impish";break;
    }
    break;
  }

  switch(d4())
  {
    case 1:message="*gives "+targname+" a "+alword+" smile*";break;
    case 2:message="*flashes a "+alword+" smile at "+targname+"*";break;
    case 3:message="*Slowly, a "+alword+" smile forms on "+GetName(oPC)+"'s face*";break;
    case 4:message="*gives "+targname+" a quick "+alword+" smile*";break;
  }

  AssignCommand(oPC,SpeakString(message,TALKVOLUME_TALK));
}
