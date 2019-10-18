////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_em_yesnod
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

  PlayUnivEmote(oPC,46);
  AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_YES,oPC)));
}
