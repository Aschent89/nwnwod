//::///////////////////////////////////////////////
//::  Spawn Encounter System - example OnUserDefined script
//::  enc_udexample
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: ShaDoOoW
//:: Created On: 27.10.2006 22:52
//:://////////////////////////////////////////////

#include "enc_include"

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    if(nEvent == EVENT_ENCOUNTER_ON_ENTER)
    {
        //here goes extra code that executes when player enters active spawn trigger
        //at this point spawn didn't create npcs yet but will start 0.1 second later
        //to prevent spawn making npcs, you need to disable every group in spawn with
        //function EncounterDisableSpawnGroup
    }
    else if(nEvent == EVENT_ENCOUNTER_ON_INIT)
    {
        //here goes extra code that executes when the spawn is initialized, that happens
        //when its OnEnter script runs for the first time
    }
}
