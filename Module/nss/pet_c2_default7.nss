////////////////////////////////////////////////////////////////////////////////
//
//  NPC On Death
//  nw_c2_default7
//  by Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_ai"

void main ()
{
    object oMod = GetModule();
    object oNPC = OBJECT_SELF;
    object oTarget = GetLastKiller();

    //Trolls
    if(GetBattleCondition(OAI_ROLE_TROLL))
    {
      if(!OAI_TrollDeath()) return;
    }

/******************************************************************************/
//: CUSTOM DEATH ADDITONS BELOW HERE





//: CUSTOM DEATH ADDITONS ABOVE HERE
/******************************************************************************/

    //Is it an Illusion?
    if(GetLocalInt(oNPC, "OAI_ILLUSION_DC") > 0 && GetIsObjectValid(oTarget))
    {
      if(OAI_BreakIllusion(oTarget)) {}
    }

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);

    //FOF: Sparks a RETREAT_CHECK among allies upon death via a shout.
    if(GetLocalInt(OBJECT_SELF,"FIGHT_OR_FLIGHT") == 1 && GetLocalInt(OBJECT_SELF,"RETREATED") == 0)
    {
      //The int is to help make sure dead creatures lying on
      //the ground are not counted toward f_OurCR.
      SetLocalInt(OBJECT_SELF,"FOF_DEAD",1);
      SpeakString("RETREAT_CHECK",TALKVOLUME_SILENT_TALK);
    }

    //Not Reliable....but left for probers =)
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
      SignalEvent(oNPC, EventUserDefined(1007));
    }

    //Process Dead Creatures
    ExecuteScript("oai_proc_dead", oNPC);
}
