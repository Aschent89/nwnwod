#include "f_vampire_persis"

void main()
{
SetLocalObject(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN", OBJECT_SELF);
SetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN", GetPCSpeaker());
Vampire_Set_Location(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN_LOC", GetLocation(OBJECT_SELF));
Vampire_Set_Int(GetPCSpeaker(), "FALLEN_VAMPIRE_COFFIN_VALID", TRUE);
ExecuteScript("f_vampirecoffin2", GetPCSpeaker());
}
