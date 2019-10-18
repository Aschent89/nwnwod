////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_conv_chuckle
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
      case 1:alword="warmly";break;
      case 2:alword="heartily";break;
      case 3:alword="jovialy";break;
      case 4:alword="happily";break;
    }
    break;

    case ALIGNMENT_NEUTRAL:
    switch(d4())
    {
      case 1:alword="rascally";break;
      case 2:alword="mischievous";break;
      case 3:alword="coyly";break;
      case 4:alword="playfully";break;
    }
    break;

    case ALIGNMENT_EVIL:
    switch(d4())
    {
      case 1:alword="wickedly";break;
      case 2:alword="devilishly";break;
      case 3:alword="fiendishly";break;
      case 4:alword="impishly";break;
    }
    break;
  }

  switch(d4())
  {
    case 1:message="*chuckles "+alword+"*";break;
    case 2:message="*chuckles "+alword+" at "+targname+"*";break;
    case 3:message="*laughs "+alword+"*";break;
    case 4:message="*laughs "+alword+" at "+targname+"*";break;
  }

  AssignCommand(oPC,SpeakString(message,TALKVOLUME_TALK));
}
