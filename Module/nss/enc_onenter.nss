//::///////////////////////////////////////////////
//::  Spawn System - default OnEnter script
//::  enc_onenter
//:://////////////////////////////////////////////
/*
9.7.2018 - major rewrite
14.3.2009 - oprava vypoctu spawnutych npc, nebral v potaz minimum
          - parametr vzdy zmenen na minimalni a maximalni pocet jednotlive priserky
v pripade ze WB spatne vytvori spawnscript coz by vypadalo asi jako ze max moznych priserek
bude 10 ale ve spawnu bude pouze jedna ktera bude mit svuj vlastni max na 2, spawn vyhodi
TOO MANY INSTRUCTION hlasku a co se stane dal neni znamo; proste resit tohle by bylo tak
slozite ze to delat nebudu, snazim se tenhle script drzet co nejmene narocny aby nedelal
lagy a jinou neplechu
15.10.2007 - uplne prepsani
29.10.2006 - vytvoreni vlastni funkce ktera spawne priserky
29.10.2006 - zpersistentneni setkani, prisery ktere tedy nebyly zabity do
pred restartem se po restartu znovu objevi
31.10.2006 - pridana moznost spustit v tomto eventu uzivatelem zadany
script
*/
//:://////////////////////////////////////////////
//:: Created By: ShaDoOoW
//:: Created On: 27.10.2006
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "enc_include"

void main()
{
    if(!GetLocalInt(OBJECT_SELF,"SPAWN_INITIALIZED"))
    {
        SpawnInitialize();
    }
    object oPC = GetEnteringObject();
    if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE) oPC = GetLastUsedBy();
    if(!GetIsPC(oPC))
    {
        return;
    }
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
}
