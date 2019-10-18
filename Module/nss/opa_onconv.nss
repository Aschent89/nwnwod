////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Pack Animals
//  opa_onconv
//  by Don Anderson
//  dandersonru@msn.com
//
//  Conversation File for Horses
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  // * If dead, exit directly.
  if(GetIsDead(OBJECT_SELF) == TRUE) return;

  int nMatch = GetListenPatternNumber();
  object oShouter = GetLastSpeaker();
  object oOwner = GetLocalObject(OBJECT_SELF,"OPA_OWNER");

  if (nMatch == -1)
  {
    // Not a match -- start an ordinary conversation
    if (GetCommandable(OBJECT_SELF))
    {
      ClearAllActions();
      if(GetIsPC(oShouter) || GetIsDM(oShouter) || GetIsDMPossessed(oShouter))
      {
        ActionStartConversation(oShouter,"",TRUE,FALSE);
      }
    }
  }

  // Respond to Shouts From The Owner Only
  else if (GetIsObjectValid(oShouter)
               && GetIsPC(oShouter)
               && (oShouter == oOwner))
  {
    switch (nMatch)
    {
      case 60011:
        string sName = GetMatchedSubstring(0);
        int nLength = GetStringLength(sName);
        if(nLength > 32)
        {
          SendMessageToPC(oShouter,"You are allowed only 32 Characters Maximum!!");
          return;
        }
        else
        {
          SetName(OBJECT_SELF,sName);

          object oItem = GetItemPossessedBy(oShouter,"AnimalControl");
          SetLocalString(oItem,"OPA_NAME",sName);
          SetListening(OBJECT_SELF, FALSE);
        }
    }
  }
}
