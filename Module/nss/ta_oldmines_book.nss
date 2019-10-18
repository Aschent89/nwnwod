//author @ Khamul85
#include "inc_party"

int StartingConditional()
{
   object oPC = GetPCSpeaker();
    // Inspect local variables
   if(!(GetPartyInt(oPC, "oldMineQuest") == 1))
        return FALSE;

    return TRUE;
}

