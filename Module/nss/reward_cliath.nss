
//Put this on action taken in the conversation editor
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("ks_ratkins");

DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("ks_annaleg");

DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("ks_ghheart");

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_MASS_HEAL), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_MASS_HEAL), GetLocation(oTarget));

DestroyObject(oTarget, 3.0);

RewardPartyXP(1500, oPC, FALSE);

CreateItemOnObject("g_rcliath", oPC);

}
