#include "f_vampire_h"
#include "f_vampirepenta_h"


void main()
{
if(!GetIsVampire(OBJECT_SELF))
    { //this should not be able to happen, but may as well make sure.
    SetIsVampire(FALSE, OBJECT_SELF);
    return;
    }
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_REFUGE, OBJECT_SELF))
    { //anti-cheat
    Vampire_Equipment_Removal(OBJECT_SELF, FALSE);
    Vampire_Equipment_Creation(OBJECT_SELF);
    return;
    }
if(!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN")))
    {
    FloatingTextStringOnCreature("Your coffin is your refuge, without a placed coffin you may not use this ability.", OBJECT_SELF, FALSE);
    return;
    }
if(GetArea(GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN")) == GetArea(OBJECT_SELF))
    {
    FloatingTextStringOnCreature("Your coffin is within the same area you are, you would become trapped within your spell so you cannot cast it.", OBJECT_SELF, FALSE);
    return;
    }
location lMe = GetLocation(OBJECT_SELF);
effect eSee = SupernaturalEffect(EffectTrueSeeing());
effect eBlood = SupernaturalEffect(EffectAreaOfEffect(AOE_PER_FOGKILL, "****", "****", "****"));
effect eDark = SupernaturalEffect(EffectAreaOfEffect(AOE_PER_DARKNESS));
    //pulled from nw_s0_confusion
    effect eVis = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    effect eConfuse = EffectConfused();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    float fDelay;
    //Link duration VFX and confusion effects
    effect eLink = EffectLinkEffects(eMind, eConfuse);
    eLink = EffectLinkEffects(eLink, eDur);
object oDopp;  //this is the doppleganger
float fTime = IntToFloat(Determine_Vampire_Level(OBJECT_SELF));
int iMax = Determine_Vampire_Level(OBJECT_SELF) / 5;
SetLocalLocation(OBJECT_SELF, "FALLEN_VAMPIRE_DESTINATION", GetLocation(GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN")));
SetImmortal(OBJECT_SELF, TRUE);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDark, lMe, fTime);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eBlood, lMe, fTime);
eBlood = EffectLinkEffects(EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10), eBlood);
int iCounter = 1;
object oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
while(GetIsObjectValid(oTarget) && iMax > 0)
    {
    if(GetIsEnemy(oTarget))
        {
        iMax--;
        AssignCommand(oTarget, ClearAllActions());
        oDopp = CopyObject(oTarget, lMe);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fTime);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlood, oTarget, fTime);
        SetIsTemporaryFriend(oDopp, OBJECT_SELF);
        SetIsTemporaryFriend(OBJECT_SELF, oDopp);
        if(!GetIsEnemy(oTarget, oDopp))
            {
            if(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oTarget) < 11)
                {
                ChangeToStandardFaction(oDopp, STANDARD_FACTION_HOSTILE);
                }
            else if(GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oTarget) < 11)
                {
                ChangeToStandardFaction(oDopp, STANDARD_FACTION_DEFENDER);
                }
            else if(GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oTarget) < 11)
                {
                ChangeToStandardFaction(oDopp, STANDARD_FACTION_COMMONER);
                }
            else SetIsTemporaryEnemy(oDopp, oTarget);
            }
        SetIsTemporaryFriend(oDopp, OBJECT_SELF);
        SetIsTemporaryFriend(OBJECT_SELF, oDopp);
        SetImmortal(oDopp, TRUE); //you cannot kill what is not real...but it can kill you...
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSee, oDopp, fTime);
        AssignCommand(oDopp, ActionAttack(oTarget));
        AssignCommand(oDopp, DestroyObject(oDopp, fTime));
        if(GetIsPC(oTarget)) SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " explodes into darkness! Your soul feels defiled.");
        }
    iCounter++;
    oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, iCounter, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    }
ClearAllActions();
ExecuteScript("f_vampirebat6", OBJECT_SELF);
}



