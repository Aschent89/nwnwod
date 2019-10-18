////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_vc_read
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

  AssignCommand(oNPC, PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
}
