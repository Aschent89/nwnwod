#include "f_vampire_h"
#include "f_vampirepenta_h"

void main()
{
if(!GetIsVampire(OBJECT_SELF))
    { //this should not be able to happen, but may as well make sure.
    SetIsVampire(FALSE, OBJECT_SELF);
    return;
    }
if (GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_MIST")) return;
effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
int iPolyType = POLYMORPH_TYPE_WOLF;
if(Determine_Vampire_Level(OBJECT_SELF) >= DireWolfLevel) iPolyType = POLYMORPH_TYPE_DIRE_WOLF;
effect ePoly = SupernaturalEffect(EffectPolymorph(iPolyType));
ClearAllActions(TRUE);
ActionWait(3.5);
ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0);
SetCommandable(FALSE, OBJECT_SELF);
DelayCommand(0.5, pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_EVIL, 4.5));
DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, OBJECT_SELF));
DelayCommand(5.5, SetCommandable(TRUE, OBJECT_SELF));
DelayCommand(5.5, ClearAllActions());
}
