////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_onact
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetItemActivator();

    ExecuteScript("x2_mod_def_act",OBJECT_SELF); // Default Bioware
    ExecuteScript("ors_mod_onact",OBJECT_SELF); //Olander's Realistic Systems
    ExecuteScript("ocf_mod_onact",OBJECT_SELF); //Camping and Resting System
    ExecuteScript("ohtf_mod_onact",OBJECT_SELF); //HTF System
    ExecuteScript("ohtf_fishing",OBJECT_SELF);  //HTF Fishing System
    ExecuteScript("torch_mod_onact",OBJECT_SELF); //Realistic Torches
    ExecuteScript("opa_mod_onact",OBJECT_SELF); //Olander's Pack Animals
    ExecuteScript("ope_mod_onact",OBJECT_SELF); //Olander's Pets
    ExecuteScript("oho_mod_onact",OBJECT_SELF); //Olander's Horses
//    ExecuteScript("os_mod_onact",OBJECT_SELF); //Olander's Siege System
    ExecuteScript("fvex_mod_itemact",OBJECT_SELF); // Fallen's Vampire System
//    ExecuteScript("cnr_module_onact",OBJECT_SELF); // CNR Crafting system

    ExecuteScript("scenttrueact",OBJECT_SELF); // scent of the true form activate
    ExecuteScript("on_item_activate",OBJECT_SELF); //
        ExecuteScript("mr_activate_item",OBJECT_SELF); //

    ExecuteScript("cnr_module_onact",oPC); // CNR on Activate

     if(GetTag(GetItemActivated())=="SubdualModeTog")
        AssignCommand(GetItemActivator(),ActionStartConversation(GetItemActivator(),"subdualconv",TRUE));

}

