#include "f_vampire_h"
#include "f_vampirepenta_h"

location GetRandomCloseLocation(location lTarget, int iMetersAway = 5)
{ //perhaps make it determine a proper facing to look at the target location in the future.
object oArea = GetAreaFromLocation(lTarget);
vector V = GetPositionFromLocation(lTarget);
int xChange = (Random(3) * iMetersAway) - iMetersAway;
int yChange = (Random(3) * iMetersAway) - iMetersAway;
float fFacing = IntToFloat(Random(360));
while(xChange == 0 && yChange == 0 && iMetersAway != 0)
    {
    xChange = (Random(3) * iMetersAway) - iMetersAway;
    yChange = (Random(3) * iMetersAway) - iMetersAway;
    }
V.x += IntToFloat(xChange);
V.y += IntToFloat(yChange);
return Location(oArea, V, fFacing);
}

void RemoveAnyAOE()
{
effect eE = GetFirstEffect(OBJECT_SELF);
while(GetIsEffectValid(eE))
    {
    if(GetEffectType(eE) == EFFECT_TYPE_AREA_OF_EFFECT)
         RemoveEffect(OBJECT_SELF, eE);
    eE = GetNextEffect(OBJECT_SELF);
    }
}

void MakeComeBat(location lLoc)
{
location lRand = GetRandomCloseLocation(lLoc, 5);
effect eDisappear = EffectDisappear();
effect eVis = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);
object oBat = CreateObject(OBJECT_TYPE_CREATURE, "brainlessbat", lRand, TRUE);
DelayCommand(2.0, AssignCommand(oBat, ActionForceMoveToLocation(lLoc, TRUE, 3.0)));
DelayCommand(4.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
DelayCommand(4.5, DestroyObject(oBat));
}

void BatArrive()
{
location lSelf = GetLocation(OBJECT_SELF);
effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
//effect eAppear = EffectAppear();
MakeComeBat(lSelf);
MakeComeBat(lSelf);
MakeComeBat(lSelf);
MakeComeBat(lSelf);
DelayCommand(3.5, pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_EVIL, 2.5));
DelayCommand(4.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
DelayCommand(5.5, Vampire_Apply_Stats(OBJECT_SELF));
DelayCommand(5.5, SetImmortal(OBJECT_SELF, FALSE));
DelayCommand(6.0, SetCommandable(TRUE, OBJECT_SELF));
DelayCommand(6.0, DeleteLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_BAT"));
}

void BatJump()
{
location lDest = GetLocalLocation(OBJECT_SELF, "FALLEN_VAMPIRE_DESTINATION");
effect eInvis = SupernaturalEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY));
DeleteLocalLocation(OBJECT_SELF, "FALLEN_VAMPIRE_DESTINATION");
SetCommandable(TRUE, OBJECT_SELF);
ClearAllActions(TRUE);
ActionJumpToLocation(lDest);
ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF));
ActionDoCommand(FadeFromBlack(OBJECT_SELF, FADE_SPEED_FASTEST));
//ActionWait(1.0);
ActionDoCommand(BatArrive());
SetCommandable(FALSE, OBJECT_SELF);
}

void MakeGoBat(location lLoc, location lTarget)
{
location lRand = GetRandomCloseLocation(lLoc, 1);
location lDest = GetRandomCloseLocation(lTarget, 5);
effect eVis = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
effect eGone = EffectDisappear();
object oBat = CreateObject(OBJECT_TYPE_CREATURE, "brainlessbat", lRand);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oBat);
AssignCommand(oBat, ActionMoveToLocation(lDest, FALSE));
DelayCommand(1.0, AssignCommand(oBat, ClearAllActions(TRUE)));
DelayCommand(1.0, AssignCommand(oBat, ActionMoveToLocation(lDest, FALSE)));
DelayCommand(2.0, AssignCommand(oBat, ClearAllActions(TRUE)));
DelayCommand(2.0, AssignCommand(oBat, ActionMoveToLocation(lDest, FALSE)));
DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGone, oBat));
}

void BatLeave()
{
location lSelf = GetLocation(OBJECT_SELF);
location lDest = GetLocalLocation(OBJECT_SELF, "FALLEN_VAMPIRE_DESTINATION");
location lRand = GetRandomCloseLocation(lSelf, 20);
effect eInvis = SupernaturalEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY));
//effect eInvis = SupernaturalEffect(EffectPolymorph(POLYMORPH_TYPE_NULL_HUMAN, TRUE));
effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
if(GetAreaFromLocation(lSelf) == GetAreaFromLocation(lDest))
    {
    lRand = lDest;
    }
ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
RemoveAnyAOE();
MakeGoBat(lSelf, lRand);
MakeGoBat(lSelf, lRand);
MakeGoBat(lSelf, lRand);
MakeGoBat(lSelf, lRand);
DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF));
DelayCommand(3.0, FadeToBlack(OBJECT_SELF, FADE_SPEED_FASTEST));
DelayCommand(3.5, BatJump());
}

void main()
{
if(!GetIsVampire(OBJECT_SELF))
    { //this should not be able to happen, but may as well make sure.
    SetIsVampire(FALSE, OBJECT_SELF);
    return;
    }
SetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_BAT", TRUE);
//RemoveBothersomeEffects();
ClearAllActions(TRUE);
DelayCommand(0.5, pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_EVIL, 3.0));
SetCommandable(FALSE, OBJECT_SELF);
DelayCommand(3.0, BatLeave());
}
