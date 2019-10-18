//::///////////////////////////////////////////////
//::  Spawn System - default OnEnter script, placeable variant
//::  enc_exhausted
//:://////////////////////////////////////////////
/*
9.7.2018 - major rewrite
*/
//:://////////////////////////////////////////////
//:: Created By: ShaDoOoW
//:: Created On: 15.10.2007
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "enc_include"

void ResetEncounterStatus(object oSelf)
{
    EncounterSetStatus(oSelf);
    object oPC = GetFirstInPersistentObject(oSelf);
    while(oPC != OBJECT_INVALID)
    {
        if(GetIsPC(oPC))
        {
            if(GetLocalString(OBJECT_SELF,"OnEnter") != "")
            {
                //custom OnEnter script set by user
                if(ExecuteScriptAndReturnInt(GetLocalString(OBJECT_SELF,"OnEnter"),OBJECT_SELF) == X2_EXECUTE_SCRIPT_END)
                {
                    return;
                }
            }
            //spawn is active
            if(EncounterGetIsActive(OBJECT_SELF))
            {
                //set to inactive
                EncounterSetStatus(OBJECT_SELF,FALSE);
                //UserDefined - OnEnter
                SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_ENCOUNTER_ON_ENTER));
                //spawns creatures
                DelayCommand(0.1,SpawnCreatures(oPC,OBJECT_SELF));
            }
            break;
        }
        oPC = GetNextInPersistentObject(oSelf);
    }
}

void main()
{
    if(GetLocalString(OBJECT_SELF,"OnExhausted") != "")
    {
        //custom OnEnter script set by user
        if(ExecuteScriptAndReturnInt(GetLocalString(OBJECT_SELF,"OnExhausted"),OBJECT_SELF) == X2_EXECUTE_SCRIPT_END)
        {
            return;
        }
    }
    //UserDefined - OnExhausted
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_ENCOUNTER_ON_EXHAUSTED));
    int nXP = GetLocalInt(OBJECT_SELF,"XP");
    if(nXP > 0)
    {
        object oKiller = GetLocalObject(OBJECT_SELF,"LAST_KILLER");
        if(!GetIsPC(oKiller))
        {
            oKiller = GetMaster(oKiller);
            if(!GetIsPC(oKiller))
            {
                oKiller = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oKiller,1);
            }
        }
        if(GetIsPC(oKiller))
        {
            object oParty = GetFirstFactionMember(oKiller);
            while(oParty != OBJECT_INVALID)
            {
                SetXP(oParty,GetXP(oParty)+nXP);
                oParty = GetNextFactionMember(oKiller);
            }
        }
    }
    int nRespawn = GetLocalInt(OBJECT_SELF,"Respawn");
    if(!nRespawn)
    {
        nRespawn = 540; //default 9minutes
    }
    if(GetLocalInt(OBJECT_SELF,"NUM_TIMES_SPAWNED") >= GetLocalInt(OBJECT_SELF,"Limit"))
    {
        return;
    }
    DelayCommand(IntToFloat(nRespawn),ResetEncounterStatus(OBJECT_SELF));
    string snSkupina = IntToString(GetLocalInt(OBJECT_SELF,"LAST_SPAWNED_GROUP"));
    nRespawn = GetLocalInt(OBJECT_SELF,"GROUP_RESPAWN_"+snSkupina);
    if(nRespawn > 0)
    {
        DelayCommand(IntToFloat(nRespawn),SetLocalInt(OBJECT_SELF,snSkupina+"_GROUP_SPAWN_DONE",TRUE));
    }
}
