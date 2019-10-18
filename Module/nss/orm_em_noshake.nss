////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_em_noshake
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

  PlayUnivEmote(oPC,31);
  PlayUnivEmote(oPC,32);
  AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_NO,oPC)));
}
