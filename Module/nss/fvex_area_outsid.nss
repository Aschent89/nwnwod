#include "f_vampire_area_h"
#include "spawn_functions"
#include "ors_inc"

void main()
{
Vampire_Enter(GetEnteringObject(), FALSE);

    ExecuteScript("ors_area_onenter",OBJECT_SELF); //Olander's Streetlights and Misc. Area Enter Stuff
    ExecuteScript("wdm_ar_onenter",OBJECT_SELF); //Dead and Wild Magic System
    ExecuteScript("orw_area_match",OBJECT_SELF); //Olander's Realistic Weather System
    ExecuteScript("oho_area_onenter",OBJECT_SELF); //Olander's Horses
    ExecuteScript("ouw_area_onenter",OBJECT_SELF); //Olander's Underwater System

    Spawn_OnAreaEnter("spawn_orig_hb",10.0,0.0);//NESS NPC Spawn/Respawn System

    //Custom Scripts Set Per Area
    string sCustom1 = GetLocalString(OBJECT_SELF,"ORS_AE_CUSTOM1");
    if(sCustom1 != "") ExecuteScript(sCustom1,OBJECT_SELF); //Rami Ahmed's Persistent Player Shops
}
