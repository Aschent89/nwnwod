////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_ondeath
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"
#include "subdual_inc"

void main()
{
 if (CheckSubdual(GetLastPlayerDied())) return;

  object oPC = GetLastPlayerDied();


 //xecuteScript("habd_onpcdeath",OBJECT_SELF);
// ExecuteScript("fvex_mod_death",OBJECT_SELF); // Fallen's Vampire System
// Player Kill XP
  ExecuteScript("xp_pvp_system",oPC);

  //From Master Configuration opw_mod_onload
  string sDeathSystem = GetLocalString(GetModule(),"DEATHSYSTEM");
  ExecuteScript(sDeathSystem,oPC);
}
