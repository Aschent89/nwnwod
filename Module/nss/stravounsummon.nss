void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "StravokovManorSkeletonkey")== OBJECT_INVALID)
   return;

object oTarget;
oTarget = GetObjectByTag("VixThraTheDevourerOfSouls");

effect eEffect;
eEffect = EffectDeath();

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

eEffect = EffectDamage(1, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_ENERGY);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, GetObjectByTag("VixThraTheDevourerOfSouls"));

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget));

DestroyObject(oTarget, 0.0);

}

