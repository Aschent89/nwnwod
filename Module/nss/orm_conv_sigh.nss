////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_conv_sigh
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

  string message;

  switch(d4())
  {
    case 1:message="*sighs*";break;
    case 2:message="*sighs softly*";break;
    case 3:message="*shrugs shoulders and sighs*";break;
    case 4:message="*lets out a sigh*";break;
  }

  AssignCommand(oPC,SpeakString(message,TALKVOLUME_TALK));
}
