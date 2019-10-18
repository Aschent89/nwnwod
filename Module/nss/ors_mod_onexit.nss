////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Module On Exit
//  ors_mod_onexit
//  By Don Anderson
//  dandersonru@msn.com
//
//  Miscellaneous On Exit Event.
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
    object oPC      = GetExitingObject();
    object oMod     = GetModule();

    if(AVGetIsSpellCaster(oPC))
    {
      AVSaveSpells(oPC);
    }
}
