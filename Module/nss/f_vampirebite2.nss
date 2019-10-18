#include "f_vampirebite_h"

int StartingConditional()
{
object oTarget = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_VICTIM");
return !GetIsPC(oTarget) && CanMakeThralls && (Determine_Vampire_Level(OBJECT_SELF) >= MakeThrallLevel);
}
