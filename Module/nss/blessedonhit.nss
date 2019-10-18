#include "X0_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void main()
{
object oTarget = GetSpellTargetObject();
string sVictim = GetSubRace(oTarget);
effect eDam = EffectDamage(d6(2), DAMAGE_TYPE_DIVINE);

if (sVictim == "Vampire")
{ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
return;}

if (TestStringAgainstPattern("**Garou**", sVictim) == TRUE)
{
eDam = EffectDamage(d6(2), DAMAGE_TYPE_MAGICAL);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
return;}

if ( 31 > GetGoodEvilValue(oTarget))
{ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);}
}
