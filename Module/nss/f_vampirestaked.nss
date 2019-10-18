#include "f_vampire_h"

void TheStaking()
{
effect eHurt = SupernaturalEffect(EffectDamage(((GetMaxHitPoints() + GetCurrentHitPoints()) * 6), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY));
SetCommandable(TRUE);
    ClearAllActions(TRUE);
    SetPlotFlag(OBJECT_SELF, FALSE);
    SetImmortal(OBJECT_SELF, FALSE);
    Vampire_Apply_Stats();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHurt, OBJECT_SELF);
}

void main()
{
if(GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_STAKED"))
    {
    DelayCommand(1.0, TheStaking());
    SetCommandable(FALSE);
    }
}
