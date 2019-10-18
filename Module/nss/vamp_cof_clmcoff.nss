#include "vamp_pentagram_h"
#include "vamp_persistent"

void main(){
    object oOld = GetLocalObject(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN");
    if(GetIsObjectValid(oOld)){
        pentagram(GetLocation(oOld), VFX_BEAM_COLD, 1.5, 0.2);
        DeleteLocalObject(oOld, "FALLEN_VAMPIRE_COFFIN");
    }
    oOld = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN");
    if(GetIsObjectValid(oOld)){
        pentagram(GetLocation(oOld), VFX_BEAM_COLD, 1.5, 0.2);
        DeleteLocalObject(oOld, "FALLEN_VAMPIRE_COFFIN");
        FloatingTextStringOnCreature("The link with your coffin has been severed.", oOld, FALSE);
        Vampire_Delete_Location(oOld, "FALLEN_VAMPIRE_COFFIN_LOC");
        Vampire_Set_Int(oOld, "FALLEN_VAMPIRE_COFFIN_VALID", FALSE);
    }
    SetLocalObject(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN", OBJECT_SELF);
    SetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN", GetPCSpeaker());
    Vampire_Set_Location(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN_LOC", GetLocation(OBJECT_SELF));
    Vampire_Set_Int(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN_VALID", TRUE);
    pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_EVIL, 1.5, 0.2);
}
