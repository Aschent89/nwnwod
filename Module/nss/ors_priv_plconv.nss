////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Universal Placeable Conversation Activator
//  ors_priv_plconv
//  by Don Anderson
//  dandersonru@msn.com
//
//  Use this on a Placeable to Open the Conversation Attached to them
//
//  Private Conversation
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  ActionStartConversation(GetLastUsedBy(),"",TRUE,FALSE);
}
