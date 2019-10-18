#include "vamp_main_h"

int StartingConditional(){
    if(!GetIsVampire(GetPCSpeaker())){
        return FALSE;
    }
    object oOwner = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN");
    if(GetIsObjectValid(oOwner) && oOwner != GetPCSpeaker() && Determine_Vampire_Level(oOwner) >= Determine_Vampire_Level(GetPCSpeaker())){
        return TRUE;
    }
    return FALSE;
}
