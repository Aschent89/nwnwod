#include "vamp_main_h"

int StartingConditional(){
    if(GetIsVampire(GetPCSpeaker())){
        return FALSE;
    }
    return GetLocalInt(OBJECT_SELF, "FALLEN_ROSEWARD");
}
