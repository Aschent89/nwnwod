////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_command
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the NPC HB for Horse Command.
//
//  This is script should be cached.
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oNPC = OBJECT_SELF;
  int nApp = OHOHorseBaseTailType(oNPC);

  string sPC = GetLocalString(oNPC, "OHO_OWNER_NAME");
  string sPCU = GetLocalString(oNPC, "OHO_OWNER_UNIQUE");
  string sCheck = "";

  object oPC = GetLocalObject(oNPC,"OHO_OWNER");
  string sPlayerName = GetPCPlayerName(oPC);

  string sWP = "HorseShop";
  object oWP = GetNearestObjectByTag(sWP,oNPC,1);

  //No Player Owner But Shop Exists
  if(sPlayerName == "" && GetIsObjectValid(oWP)) return;

  //Player is Gone for 10 HB Cycles
  if(sPlayerName == "")
  {
    int nCCheck = GetLocalInt(oNPC,"OHO_CYCLE_CHECK");
    if(nCCheck > 10)
    {
      AssignCommand(oNPC,ClearAllActions(TRUE));
      DestroyObject(oNPC,0.1);
      return;
    }
    else
    {
      SetLocalInt(oNPC,"OHO_CYCLE_CHECK",nCCheck + 1);
      return;
    }
  }

  string sRally = GetLocalString(oPC, "OHO_RALLYPOINT");
  SetLocalString(oNPC, "OHO_RALLYPOINT", sRally);

  //Play Random Voice Chats
  int D40 = Random(40) + 1;
  switch(D40)
  {
    case 1: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_GATTACK3)); break;
    case 2: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_PAIN1)); break;
    case 3: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_PAIN3)); break;
    case 4: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_NEARDEATH)); break;
    case 5: AssignCommand(oNPC,PlayVoiceChat(VOICE_CHAT_POISONED)); break;
  }

  //Armor Class
  int bNoCombat=GetLocalInt(GetModule(),"X3_NO_MOUNTED_COMBAT_FEAT");
  if(!bNoCombat && GetHasFeat(FEAT_MOUNTED_COMBAT,oPC) && HorseGetIsMounted(oPC))
  {
    int nRoll = d20() + GetSkillRank(SKILL_RIDE,oPC);
    nRoll = nRoll - 10;
    if(nRoll > 4)
    {
      nRoll = nRoll/5;
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACIncrease(nRoll),oPC,7.0);
    }
  }

  //Player is the Rally
  if(sRally == "")
  {
    OHOHorseToPlayer(oPC, oNPC);
    return;
  }

  //Waypoint is Rally Point
  if(sRally == "WP_OHO_" + sPCU)
  {
    OHOHorseToRally(oNPC);
    return;
  }
}
