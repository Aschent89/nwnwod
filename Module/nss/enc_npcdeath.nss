//::///////////////////////////////////////////////
//::  Spawn Encounter System - npc death script
//::  enc_npcdeath
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: ShaDoOoW
//:: Created On: 9.7.2018
//:://////////////////////////////////////////////

void main()
{
    //exhausted event inicialization
    object oEncounter = GetLocalObject(OBJECT_SELF,"ENCOUNTER_FROM");
    int nAlive = GetLocalInt(oEncounter,"NUM_SPAWNED_CREATURES_ALIVE")-1;
    if(nAlive < 1)//OnExhausted!
    {
        SetLocalInt(oEncounter,"NUM_SPAWNED_CREATURES_ALIVE",0);
        object oKiller = GetLastKiller();
        SetLocalObject(oEncounter,"LAST_KILLER",oKiller == OBJECT_SELF ? OBJECT_INVALID : oKiller);
        ExecuteScript("enc_exhausted",oEncounter);
    }
    else
    {
        SetLocalInt(oEncounter,"NUM_SPAWNED_CREATURES_ALIVE",nAlive);
    }
    string script_original = GetLocalString(OBJECT_SELF,"ORIGINAL_SCRIPT_ONDEATH");
    if(script_original != "")
    {
        ExecuteScript(script_original,OBJECT_SELF);
    }
}
