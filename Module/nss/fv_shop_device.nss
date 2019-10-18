#include "vamp_define_h"

void FinallyTheEnd(object oPC, object oTarget)
{
string sTemp = (UseGuaranteedBloodTypes)?"gblood":"blood";

if(GetTag(OBJECT_SELF) == "FV_BADBLOOD")
    {
    if(d4()!=1) sTemp += "bad";
    }
else if(GetTag(OBJECT_SELF) == "FV_NORMALBLOOD")
    {
    if(d6()==1) sTemp += "bad";
    }
else if(GetTag(OBJECT_SELF) == "FV_CHILDBLOOD")
    {
    if(d10()==1) sTemp += "bad";
        else sTemp += "child";
    }
else if(GetTag(OBJECT_SELF) == "FV_VIRGINBLOOD")
    {
    if(d10()==1) sTemp += "bad";
        else if(d6()!=1) sTemp += "virgin";
    }
CreateItemOnObject(sTemp, oPC, 1);
FloatingTextStringOnCreature("You receive a vial of blood.", oPC);
SetCommandable(TRUE, oPC);
}

void OnlyOneStepLeft(object oPC, object oTarget)
{
SetCommandable(TRUE, oPC);
AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0));
DelayCommand(1.0, FinallyTheEnd(oPC, oTarget));
SetCommandable(FALSE, oPC);
}

void NextBloodStep(object oPC, object oTarget, object oItem)
{
effect eBeam = EffectBeam(VFX_BEAM_EVIL, oTarget, BODY_NODE_CHEST);
effect eVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED, TRUE);
if(!GetIsObjectValid(oItem) || !GetIsObjectValid(oTarget) || !GetIsObjectValid(oPC)) return;

if(GetItemStackSize(oItem) < 2) DestroyObject(oItem);
    else SetItemStackSize(oItem, GetItemStackSize(oItem) - 1);

AssignCommand(oTarget, ClearAllActions());
AssignCommand(oTarget, PlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 4.0));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, OBJECT_SELF, 3.0);
DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 0.3));
DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 0.3));
DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 0.3));
DelayCommand(1.6, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 0.3));
DelayCommand(2.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 0.3));
DelayCommand(2.6, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 0.3));
switch(Random(3))
    {
    case 0: PlayVoiceChat(VOICE_CHAT_PAIN1, oTarget); break;
    case 1: PlayVoiceChat(VOICE_CHAT_PAIN2, oTarget); break;
    case 2: PlayVoiceChat(VOICE_CHAT_PAIN3, oTarget); break;
    }
DelayCommand(3.0, OnlyOneStepLeft(oPC, oTarget));
}

void main()
{
object oPC = GetLastUsedBy();
object oTarget = GetNearestObjectByTag(GetTag(OBJECT_SELF));
object oItem = GetFirstItemInInventory(oPC);
if(!GetIsObjectValid(oTarget) || !GetIsObjectValid(oPC)) return;
while(GetIsObjectValid(oItem) && GetTag(oItem) != "FALLEN_VAMPIRE_EMPTY_VIAL") oItem = GetNextItemInInventory(oPC);
if(!GetIsObjectValid(oItem))
    {
    FloatingTextStringOnCreature("You do not have any empty vials of preservation.", oPC);
    return;
    }
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0));
SetCommandable(FALSE, oPC);
if(GetLocalString(oPC, "FV_SHOP_ACCESS") != GetTag(OBJECT_SELF))
    {
    AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0));
    if(GetItemStackSize(oItem) < 2) DelayCommand(1.0, DestroyObject(oItem));
        else DelayCommand(1.0, SetItemStackSize(oItem, GetItemStackSize(oItem) - 1));
    DelayCommand(1.0, FloatingTextStringOnCreature("The device destroys your vial and awaits a paying customer.", oPC));
    DelayCommand(1.0, SetCommandable(TRUE, oPC));
    return;
    }
DelayCommand(1.0, NextBloodStep(oPC, oTarget, oItem));
}

