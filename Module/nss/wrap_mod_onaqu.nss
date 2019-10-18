////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_onaqu
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////

//#include "ors_inc"
//#include "x2_inc_switches"
//#include "nw_i0_plotwizard"
void main()
{
    // PLOT WIZARD MANAGED CODE BEGINS
//    PWSetMinLocalIntAndJournalForItemAcquired("p000state", "p000", 2, "zombiehead", 250);
    // PLOT WIZARD MANAGED CODE ENDS
 // ExecuteScript("x2_mod_def_aqu",OBJECT_SELF); //Default Bioware
  ExecuteScript("fvex_mod_itemacq",OBJECT_SELF); // Fallen's Vampire System
  //ExecuteScript("wdm_mod_onaqu",OBJECT_SELF); //Dead and Wild Magic System
  ExecuteScript("as_pp", GetModule()); //Pickpocket fix

}
