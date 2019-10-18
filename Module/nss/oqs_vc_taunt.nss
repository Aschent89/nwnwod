////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_vc_taunt
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Conversation of the Quest Giver
//
//  This will make the NPC Speak a Voice Chat during a Conversation.
//  No need to use the Conversation Animations either. =)
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  PlayVoiceChat(VOICE_CHAT_TAUNT, oNPC);
  AssignCommand(oNPC, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
}
