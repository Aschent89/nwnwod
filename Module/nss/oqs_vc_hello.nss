////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_vc_hello
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

  PlayVoiceChat(VOICE_CHAT_HELLO, oNPC);
  AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0));
}
