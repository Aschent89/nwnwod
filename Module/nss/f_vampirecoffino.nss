#include "f_vampirepenta_h"

void main()
{
effect eVis = EffectVisualEffect(VFX_IMP_HARM);
DeleteLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_HOLYWATER");
DeleteLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_GARLIC");
pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_EVIL, 1.5, 0.2);
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
}
