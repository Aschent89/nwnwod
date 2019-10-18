////////////////////////////////////////////////////////////////////////////////
//
//  Wrapper
//  wrap_mod_onequip
//  by Don Anderson
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ExecuteScript("x2_mod_def_equ",OBJECT_SELF); // Default Bioware
    //ExecuteScript("ors_onequip",OBJECT_SELF); //ORS
    ExecuteScript("ocr_onequip",OBJECT_SELF); //Education/Crafting System
    ExecuteScript("torch_onequip",OBJECT_SELF); // Realistic Torches
        ExecuteScript("mr_equip",OBJECT_SELF); //

}
