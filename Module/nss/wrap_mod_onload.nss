////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_onload
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////
#include "mvd_02_init"

void main()
{
  MvD_02_ModInit();  //LRES Roleplay Experience
    //: NOTE...KEEP THIS SCRIPT IN 1ST PLACE!!

    ExecuteScript("ors_mod_onload",OBJECT_SELF); // Olander's Realistic Systems - Master Configurations Script
    ExecuteScript("x2_mod_def_load",OBJECT_SELF); // Default Bioware
    ExecuteScript("oai_mod_onload",OBJECT_SELF); // Olander and Psycho's AI
    ExecuteScript("fvex_mod_onload",OBJECT_SELF); // Fallen's Vampire System
/*******************************************************************************/
//:: ABOVE HERE IS SEQUENCE SPECIFIC....PLACE BELOW HERE
    ExecuteScript("cnr_module_oml",OBJECT_SELF); // CNR Crafting System
    //ExecuteScript("pgs_mod_onload",OBJECT_SELF); // Player's Guild System
//    ExecuteScript("shop_mod_load",OBJECT_SELF); // Rami Ahmed's Persistent Player Shops
//SetLocalString(GetModule(), "X2_S_UD_SPELLSCRIPT", "vamp_spells"); //local varible for vampire scripts

}
