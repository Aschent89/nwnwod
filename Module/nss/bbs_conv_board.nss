#include "bbs_include"

void main()
{
  object oPC = GetLastUsedBy();
  if(GetIsPC(oPC))
  {
    ActionStartConversation(oPC, "", TRUE);
  }
}
