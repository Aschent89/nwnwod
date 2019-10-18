//::///////////////////////////////////////////////
//:: Vampire Aura of the Unnatural On Enter
//:: FV_S1_AuraUnata.nss
//:://////////////////////////////////////////////
/*
    Upon entering the aura, undead will be paralyzed
    if they fail a will save and are lower than
    your level. If they are 5 levels or more lower
    they will save or be dominated. All other
    creatures have a will save
    (DC=10+[Hit Dice/3]) to paralyze or fear depending
    on race/class/gender.
*/
//:://////////////////////////////////////////////
//:: Created By: Fallen
//:://////////////////////////////////////////////
#include "f_vampire_spls_h"
#include "f_vampirebite_h"

void main()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eCharm = EffectCutsceneParalyze();
    eCharm = EffectLinkEffects(eVis, eCharm);
    effect ePara = EffectParalyze();
    ePara = EffectLinkEffects(eVis, ePara);
    eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eDom = EffectCutsceneDominated();
    eDom = EffectLinkEffects(eVis, eDom);
    eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eFear = EffectFrightened();
    eFear = EffectLinkEffects(eVis, eFear);
    object oTarget = GetEnteringObject();
    int iRace = GetRacialType(oTarget);
    object oOwner = GetAreaOfEffectCreator();
    if(!GetIsObjectValid(oOwner))
        {
        DestroyObject(OBJECT_SELF);
        return;
        }
    int myHD = Determine_Vampire_Level(oOwner);
    int iHDDiff = (GetHitDice(oTarget) > FloatToInt(GetChallengeRating(oTarget))) ? GetHitDice(oTarget) : FloatToInt(GetChallengeRating(oTarget));
    int iDC = 10 + (myHD/3);
    if(GetHasGarlicProtection(oTarget)) return;
    if((GetGender(oTarget) == GENDER_MALE && GetGender(oOwner) == GENDER_FEMALE) ||
       (GetGender(oTarget) == GENDER_FEMALE && GetGender(oOwner) == GENDER_MALE) ||
       GetGender(oTarget) == GENDER_BOTH || FindSubString(GetName(oTarget), "Dire ") > -1)
        iDC += (myHD/10)+1; //gender attraction/dire bonus
    iHDDiff = myHD - iHDDiff;
    if(GetIsEnemy(oTarget, oOwner))
        {
        //Racial checks
        if(iRace == RACIAL_TYPE_MAGICAL_BEAST || iRace == RACIAL_TYPE_OUTSIDER ||
           (iRace == RACIAL_TYPE_DRAGON && GetCreatureSize(oTarget) >= CREATURE_SIZE_LARGE)) return;
        else if(iRace == RACIAL_TYPE_UNDEAD || GetIsVampire(oTarget))
            {
            if(iHDDiff >= 5)
                { //5 level difference, save for dominate, not using
                  //a mind based save since most undead are immune =p
                if (WillSave(oTarget, iDC, SAVING_THROW_TYPE_NONE, oOwner) == 0)
                    {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDom, oTarget, RoundsToSeconds(myHD/2));
                    }
                }
            else if(iHDDiff > 0)
                { //minor level difference, save for charm, not using
                  //a mind based save since most undead are immune =p
                if (WillSave(oTarget, iDC, SAVING_THROW_TYPE_NONE, oOwner) == 0)
                    {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCharm, oTarget, RoundsToSeconds(myHD/2));
                    }
                } //they are higher level...good luck!
            }
        else if(iHDDiff > 0)
            {
            if(GetIsPlayableRacialType(oTarget) && Random(iDC) > 7)
                {
                if (WillSave(oTarget, iDC, SAVING_THROW_TYPE_MIND_SPELLS, oOwner) == 0)
                    {
                    //Apply the VFX impact and effects
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, RoundsToSeconds(myHD/3));
                    }
                }
            else //not a playable race, or same gender and 'unlucky'
                {
                //Make a fear saving throw check
                if (WillSave(oTarget, iDC, SAVING_THROW_TYPE_FEAR, oOwner) == 0)
                    {
                    //Apply the VFX impact and effects
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oTarget, RoundsToSeconds(myHD/3));
                    }
                }
            }
        }
}
