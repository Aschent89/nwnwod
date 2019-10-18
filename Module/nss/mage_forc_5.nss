/*void main()
{
object oPC;

effect eEffect;
eEffect = EffectDamage(150, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, GetItemActivatedTarget());

object oTarget;
oTarget = GetItemActivatedTarget();

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_METEOR_SWARM), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_METEOR_SWARM), GetLocation(oTarget));

}
*/
void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())|| (GetObjectType(GetItemActivatedTarget())!=OBJECT_TYPE_CREATURE))
{

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectDamage(150, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ICESTORM), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_METEOR_SWARM), GetLocation(oTarget));
}
