//Archery Target Training script
//By: Stefanf
//Special thanks to: l3g4cy, for his useful Creating Archery/Combat targets script.
//Instructions: Put this in the OnDamaged event of creature with the appearance set to Archery Target.
//              Leave the Plot box UNCHECKED and set the AC and stats to the minimum.
//              Give it about 1000 or so HP, the script will prevent destruction.
void main()
{
object oPC = GetLastAttacker(OBJECT_SELF);
float  fDistance = GetDistanceToObject(oPC);
float  fExp = fDistance/1.5;
int    nExp = FloatToInt(fExp);
object oWeapon = GetLastWeaponUsed(oPC);
int    iCurrentHP = GetCurrentHitPoints(OBJECT_SELF);
int    iMaxHP = GetMaxHitPoints(OBJECT_SELF);
effect eHeal = EffectHeal(iMaxHP - iCurrentHP);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
}
