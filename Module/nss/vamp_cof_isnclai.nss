#include "vamp_main_h"

int StartingConditional(){
    if(!GetIsVampire(GetPCSpeaker())){
        return FALSE;
    }
    object oOwner = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN");
    return !GetIsObjectValid(oOwner);
}
