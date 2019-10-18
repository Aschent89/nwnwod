#include "vamp_persistent"

void main(){
    CreateItemOnObject("yourcoffin", GetPCSpeaker());
    DeleteLocalObject(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN");
    Vampire_Delete_Location(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN_LOC");
    Vampire_Set_Int(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN_VALID", FALSE);
    DestroyObject(OBJECT_SELF);
}
