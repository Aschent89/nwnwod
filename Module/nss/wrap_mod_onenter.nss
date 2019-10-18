////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_onenter
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////
#include "subdual_inc"
#include "mvd_02_init"
void main()
{
    MvD_02_PlayerEnter();  //LRES Roleplay Experience
    ExecuteScript("ors_mod_onenter",OBJECT_SELF);//Unique ID and Misc OnEnter Stuff (DO NOT TURN OFF!!)
    ExecuteScript("obd_mod_onenter",OBJECT_SELF); //Soul Rune and Binding Stones System

/*******************************************************************************/
//:: ABOVE HERE IS SEQUENCE SPECIFIC....PLACE BELOW HERE
    ExecuteScript("cdkeylog_onenter",OBJECT_SELF); // Funky's CD key log by player name.
    ExecuteScript("fvex_mod_clntent",OBJECT_SELF); // Fallen's Vampire System
//    ExecuteScript("oho_mod_onenter",OBJECT_SELF); //Olander's Horses
//    ExecuteScript("ohtf_mod_onenter",OBJECT_SELF); //HTF System
//    ExecuteScript("ocr_mod_onenter",OBJECT_SELF); //Education/Crafting System
    ExecuteScript("wdm_mod_onenter",OBJECT_SELF); //Dead and Wild Magic System
    //ExecuteScript("pgs_mod_cl_enter",OBJECT_SELF); // Player's Guild System
    ExecuteScript("vamp_coffinenter",OBJECT_SELF); //Dead and Wild Magic System
    ExecuteScript("cnr_module_oce",OBJECT_SELF); //
    ExecuteScript("mr_client_enter",OBJECT_SELF); //
    ExecuteScript("replace_vampires",OBJECT_SELF); //     REplacement of Vampire disciplines
    ExecuteScript("sf_cl_enter",OBJECT_SELF); // HIPS control
//    ExecuteScript("amy_on_enter_mod",OBJECT_SELF); // Fix for Multiple account log ins


object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

AddJournalQuestEntry("History", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("Enchanting", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("RulesBasics", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("Rulescharacterconcepts", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("RulesExploits", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("Ruleshigherpowers", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("Rulesptp", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("Characterclasses", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("Pointsandenergy", 1, oPC, FALSE, FALSE);


//SetLocalString(oPC, "SUBDUAL", "SUBDUAL_MODE_SUBDUAL");
//SendMessageToPC(oPC, "**Doing Subdual Damage***");


     if(!GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"SubdualModeTog")))
       CreateItemOnObject("subdualmodetog",GetEnteringObject());
     if(!GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"rp_ce_marker")))
       CreateItemOnObject("rp_ce_marker",GetEnteringObject());
     if(!GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"mr_emote_wand")))
       CreateItemOnObject("mr_emote_wand",GetEnteringObject());


}
