// Improved Extraordinary Effort

#include "inc_d20"
void main()
{
    object oPC = OBJECT_SELF;

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_STRENGTH, 8), oPC, 6.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackDecrease(4), oPC, 6.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageDecrease(4), oPC, 6.0);


}
