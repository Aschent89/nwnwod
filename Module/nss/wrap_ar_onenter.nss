////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_ar_onenter
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////

#include "spawn_main"
#include "ors_inc"

void main()
{
    Spawn();
    ExecuteScript("orw_area_match",OBJECT_SELF); //Olander's Realistic Weather System
    ExecuteScript("ks_vampsun",OBJECT_SELF); //Waypoint Based Vampire Inside and outside system
}
