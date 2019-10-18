//::///////////////////////////////////////////////
//:: Name x2_def_ondamage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDamaged script
   *Modified by Mr. E. Mustard to apply injury
    system to npcs*
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

#include "j_injury_lib"

void main()
{

    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    //Call weaken and injury functions
    DelayCommand(0.5, j_injure(OBJECT_SELF));
    DelayCommand(0.75, j_weaken(OBJECT_SELF));


    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
    ExecuteScript("mlb_ondamage", OBJECT_SELF); //Life Bar

}
