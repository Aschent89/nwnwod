////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_onexit
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////
#include "mvd_02_init"

void main()
{
  MvD_02_PlayerExit();  //LRES Roleplay Experience
  ExecuteScript("fvex_mod_clntext",OBJECT_SELF); // Fallen's Vampire System
  //ExecuteScript("ors_mod_onexit",OBJECT_SELF);//Olander's Client Exit Event

}
