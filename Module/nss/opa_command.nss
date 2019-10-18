////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_command
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the NPC HB for Animal Command.
//
//  This is script should be cached.
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oNPC = OBJECT_SELF;

  string sPC = GetLocalString(oNPC, "OPA_OWNER_NAME");
  string sPCU = GetLocalString(oNPC, "OPA_OWNER_UNIQUE");
  string sCheck = "";

  object oPC = GetLocalObject(oNPC,"OPA_OWNER");
  string sPlayerName = GetPCPlayerName(oPC);

  string sWP = "PackAnimalShop";
  object oWP = GetNearestObjectByTag(sWP,oNPC,1);

  //No Player Owner But Shop Exists
  if(sPlayerName == "" && GetIsObjectValid(oWP)) return;

  //Player is Gone for 10 HB Cycles
  if(sPlayerName == "")
  {
    int nCCheck = GetLocalInt(oNPC,"OPA_CYCLE_CHECK");
    if(nCCheck > 10)
    {
      AssignCommand(oNPC,ClearAllActions(TRUE));
      DestroyObject(oNPC,0.1);
      return;
    }
    else
    {
      SetLocalInt(oNPC,"OPA_CYCLE_CHECK",nCCheck + 1);
      return;
    }
  }

  string sRally = GetLocalString(oPC, "OPA_RALLYPOINT");
  SetLocalString(oNPC, "OPA_RALLYPOINT", sRally);
  SetLocalInt(oNPC,"OPA_CYCLE_CHECK",0);

  //Play Random Voice Chats
  int D20 = d20(1);
  switch(D20)
  {
    case 1: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_ATTACK)); break;
    case 2: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_FLEE)); break;
    case 3: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_PAIN1)); break;
  }

  //Clear Hostility
  object oTarget = GetAttackTarget();
  ClearPersonalReputation(oTarget, OBJECT_SELF);
  ClearPersonalReputation(OBJECT_SELF, oTarget);

  //Player is the Rally
  if(sRally == "")
  {
    OPA_PackToPlayer(oPC, oNPC);
    return;
  }

  //Waypoint is Rally Point
  if(sRally == "WP_OPA_" + sPCU)
  {
    OPA_PackToRally(oNPC);
    return;
  }
}
