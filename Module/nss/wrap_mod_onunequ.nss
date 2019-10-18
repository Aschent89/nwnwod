////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_onunequ
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////

void main()
{

    ExecuteScript("x2_mod_def_unequ",OBJECT_SELF); // Default Bioware
    //ExecuteScript("ors_onunequip",OBJECT_SELF); //ORS
    ExecuteScript("ocr_onunequip",OBJECT_SELF); // Education/Crafting System
    //ExecuteScript("ocr_uneq_glove",OBJECT_SELF); // Education/Crafting System
    ExecuteScript("torch_onunequip",OBJECT_SELF); // Realistic Torches
    ExecuteScript("mr_unequip",OBJECT_SELF); //
}
