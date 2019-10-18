////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_command
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the NPC HB for Animal Command.
//
//  This is script should be cached.
//
////////////////////////////////////////////////////////////////////////////////

#include "ope_inc"

void main()
{
  object oNPC = OBJECT_SELF;

  string sPC = GetLocalString(oNPC, "OPE_OWNER_NAME");
  string sPCU = GetLocalString(oNPC, "OPE_OWNER_UNIQUE");
  string sCheck = "";

  object oPC = GetLocalObject(oNPC,"OPE_OWNER");
  string sPlayerName = GetPCPlayerName(oPC);

  string sWP = "PetShop";
  object oWP = GetNearestObjectByTag(sWP,oNPC,1);

  //No Player Owner But Shop Exists
  if(sPlayerName == "" && GetIsObjectValid(oWP)) return;

  //Player is Gone for 10 HB Cycles
  if(sPlayerName == "")
  {
    int nCCheck = GetLocalInt(oNPC,"OPE_CYCLE_CHECK");
    if(nCCheck > 10)
    {
      AssignCommand(oNPC,ClearAllActions(TRUE));
      DestroyObject(oNPC,0.1);
      return;
    }
    else
    {
      SetLocalInt(oNPC,"OPE_CYCLE_CHECK",nCCheck + 1);
      return;
    }
  }

  string sRally = GetLocalString(oPC, "OPE_RALLYPOINT");
  SetLocalString(oNPC, "OPE_RALLYPOINT", sRally);
  SetLocalInt(oNPC,"OPE_CYCLE_CHECK",0);

  //Play Random Voice Chats
  int D20 = d20(1);
  switch(D20)
  {
    case 1: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_ATTACK)); break;
    case 2: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_FLEE)); break;
    case 3: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_PAIN1)); break;
  }

  //Update Reputation of Pet
  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
  {
    SetLocalString(oNPC,"OAI_FACTION","AXIS");
    AdjustAlignment(oNPC,ALIGNMENT_EVIL,100);
    AdjustAlignment(oNPC,ALIGNMENT_GOOD,-100);
    AdjustAlignment(oNPC,ALIGNMENT_NEUTRAL,50);
  }

  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
  {
    SetLocalString(oNPC,"OAI_FACTION","ALLY");
    AdjustAlignment(oNPC,ALIGNMENT_EVIL,-100);
    AdjustAlignment(oNPC,ALIGNMENT_GOOD,100);
    AdjustAlignment(oNPC,ALIGNMENT_NEUTRAL,50);
  }

  //Player is the Rally
  if(sRally == "")
  {
    AnimalToPlayer(oPC, oNPC);
    return;
  }

  //Waypoint is Rally Point
  if(sRally == "WP_OPE_" + sPCU)
  {
    AnimalToRally(oNPC);
    return;
  }
}
