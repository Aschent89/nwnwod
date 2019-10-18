void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "StravokovManorSkeletonkey")== OBJECT_INVALID)
   return;

object oTarget;
oTarget = GetObjectByTag("stravohellgate");

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("StravokovDragonRoars");

DelayCommand(0.0, SoundObjectPlay(oTarget));

oTarget = GetObjectByTag("stravoportalvix");

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

effect eEffect;
eEffect = EffectVisualEffect(VFX_FNF_SUMMON_GATE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("Stravosummonvix");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "stravomonster", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_NEGATIVE), oTarget));
else DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_NEGATIVE), GetLocation(oTarget)));

}

