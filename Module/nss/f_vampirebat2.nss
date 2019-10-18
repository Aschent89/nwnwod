#include "f_vampirepenta_h"
#include "f_vampire_persis"

void main()
{
object oPC = GetPCSpeaker();
Vampire_Set_Location(oPC, "FALLEN_VAMPIRE_MARK", GetLocation(oPC));
pentagram(GetLocation(oPC), VFX_BEAM_EVIL, 1.5, 0.2);
}
