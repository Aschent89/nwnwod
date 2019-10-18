#include "f_vampire_h"

void VampireItemCheck()
{
string sTag = GetTag(GetItemActivated());
effect eRegen = SupernaturalEffect(EffectRegenerate(1, 1.0));
effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
object oPC = GetItemActivator();
object oTarget = GetItemActivatedTarget();
int isVampire = GetIsVampire(oPC);

//////////////These can be used by anyone........
if (sTag == "FALLEN_VAMPIRE_BLOOD_OF_VAMPIRE")
    {
    if(isVampire)
        {
        eVis = EffectVisualEffect(VFX_IMP_HARM);
        eRegen = SupernaturalEffect(EffectLinkEffects(eVis, eRegen));
        FloatingTextStringOnCreature("The delicious taste of another vampire's blood empowers you.", oPC, FALSE);
        eVis = SupernaturalEffect(EffectTemporaryHitpoints(Determine_Vampire_Level(oPC) * 5));
        eRegen = SupernaturalEffect(EffectLinkEffects(eVis, eRegen));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oPC, 60.0);
        Vampire_Fresh_Blood(oPC); //for the blood hunger system
        }
    else
        {
        DelayCommand(2.5, FloatingTextStringOnCreature("Drinking the vampires blood has brought you into the brotherhood of the undead.", OBJECT_SELF, FALSE));
        ExecuteScript("f_vampirebecome", oPC);
        }
    }
else if (sTag == "FALLEN_VAMPIRE_CHILD_BLOOD")
    {
    if(isVampire)
        {
        eRegen = SupernaturalEffect(EffectRegenerate(1, 2.0));
        eRegen = SupernaturalEffect(EffectLinkEffects(eVis, eRegen));
        FloatingTextStringOnCreature("The blood of a child strengthens you.", oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oPC, IntToFloat(60 + Random(61)));
        Vampire_Fresh_Blood(oPC); //for the blood hunger system
        }
    else
        {
        AdjustAlignment(oPC, ALIGNMENT_EVIL, 5);
        FloatingTextStringOnCreature("The blood tastes salty, but it's only effect is a slight stomach ache.", oPC, FALSE);
        }
    }
else if (sTag == "FALLEN_VAMPIRE_VIRGIN_BLOOD")
    {
    if(isVampire)
        {
        eRegen = SupernaturalEffect(EffectRegenerate(Determine_Vampire_Level(oPC), 1.0));
        eRegen = SupernaturalEffect(EffectLinkEffects(eVis, eRegen));
        FloatingTextStringOnCreature("The virgin blood rapidly strengthens you.", oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oPC, IntToFloat(20 + Random(31)));
        Vampire_Fresh_Blood(oPC); //for the blood hunger system
        }
    else
        {
        AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
        FloatingTextStringOnCreature("The blood tastes salty, but it's only effect is a slight stomach ache.", oPC, FALSE);
        }
    }
else if (sTag == "FALLEN_VAMPIRE_GOOD_BLOOD")
    {
    if(isVampire)
        {
        eRegen = SupernaturalEffect(EffectLinkEffects(eVis, eRegen));
        FloatingTextStringOnCreature("The fresh blood strengthens you.", oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oPC, IntToFloat(15 + Random(31)));
        Vampire_Fresh_Blood(oPC); //for the blood hunger system
        }
    else
        {
        FloatingTextStringOnCreature("The blood tastes salty, but it's only effect is a slight stomach ache.", oPC, FALSE);
        }
    }
else if (sTag == "FALLEN_VAMPIRE_BAD_BLOOD")
    {
    if(isVampire)
        {
        eRegen = SupernaturalEffect(EffectLinkEffects(eVis, eRegen));
        isVampire = Random(61);
        if(isVampire < 44) eVis = EffectPoison(isVampire);
            else eVis = EffectDisease(isVampire - 44);
        FloatingTextStringOnCreature("The blood was impure.", oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPC);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oPC, IntToFloat(1 + Random(16)));
        Vampire_Fresh_Blood(oPC); //for the blood hunger system
        }
    else
        {
        isVampire = Random(61);
        if(isVampire < 44) eVis = EffectPoison(isVampire);
            else eVis = EffectDisease(isVampire - 44);
        FloatingTextStringOnCreature("The blood tastes salty, but it's only effect is a slight stomach ache.", oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPC);
        }
    }
else if (sTag == "FALLEN_VAMPIRE_CURE")
    {
    if(isVampire)
        {
        FloatingTextStringOnCreature("The liquid purifies you of vampirism.", oPC, FALSE);
        eVis = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
        SetIsVampire(FALSE, oPC);
        }
    else
        {
        FloatingTextStringOnCreature("The liquid tastes somewhat bitter, but does not seem to do anything.", oPC, FALSE);
        }
    }
else if (sTag == "FALLEN_VAMPIRE_SUNSTONE")
    {
    if(GetIsDawn()) FloatingTextStringOnCreature("The stone is slowly warming.", oPC, FALSE);
    else if(GetIsDay()) FloatingTextStringOnCreature("The stone is hot to the touch.", oPC, FALSE);
    else if(GetIsDusk()) FloatingTextStringOnCreature("The stone is slowly cooling.", oPC, FALSE);
    else if(GetIsNight()) FloatingTextStringOnCreature("The stone is cold to the touch.", oPC, FALSE);
    }
else if (sTag == "FALLEN_VAMPIRE_BITE_TOKEN")
    {
    SetLocalInt(oPC, "FALLEN_VAMPIRE_BITE_PERMISSION", TRUE);
    DelayCommand(30.0, DeleteLocalInt(oPC, "FALLEN_VAMPIRE_BITE_PERMISSION"));
    FloatingTextStringOnCreature("Tell your vampire friend to bite you within the next 30 seconds.", oPC, FALSE);
    }
else if (sTag == "fv_DMVampireEpicReset")
    {
    if(GetIsObjectValid(oTarget) && GetIsVampire(oTarget) && GetIsDM(oPC))
        {
        int iVLevel = GetLocalInt(oTarget, "FALLEN_VAMPIRE_LEVEL");
        Vampire_Equipment_Removal(oTarget, FALSE);
        Vampire_Remove_Advancement_Books(oTarget); //prevent cheating...a little
        Vampire_Delete_Int(oTarget, "FALLEN_VAMPIRE_EPIC_ABILITIES");
        if(iVLevel > 20) CreateItemOnObject("bookofepicvampir", oTarget);
        if(iVLevel > 24) CreateItemOnObject("bookofepicvampir", oTarget);
        if(iVLevel > 28) CreateItemOnObject("bookofepicvampir", oTarget);
        if(iVLevel > 32) CreateItemOnObject("bookofepicvampir", oTarget);
        if(iVLevel > 36) CreateItemOnObject("bookofepicvampir", oTarget);
        Vampire_Fresh_Blood(oTarget);
        Vampire_Apply_Stats(oTarget);
        Vampire_Equipment_Creation(oTarget);
        FloatingTextStringOnCreature("Your epic vampire abilities have been reset, the appropriate number of advancement books have been placed in your inventory.", oTarget, FALSE);
        FloatingTextStringOnCreature(GetName(oTarget) + "'s epic vampire abilities have been reset.", oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    else
        {
        FloatingTextStringOnCreature("This item is only usable by a DM targeting a PC Vampire.", oPC, FALSE);
        }
    }

/////////////////The following are vampire only....
if(!isVampire) return;
if (sTag == "FALLEN_VAMPIRE_MIST_ABILITY")
    {
    ExecuteScript("f_vampiremist", oPC);
    }
else if (sTag == "FALLEN_VAMPIRE_WOLF_ABILITY")
    {
    ExecuteScript("f_vampirewolf", oPC);
    }
else if (sTag == "FALLEN_VAMPIRE_BAT_ABILITY")
    {
    ExecuteScript("f_vampirebat", oPC);
    }
else if (sTag == "FALLEN_VAMPIRE_FANGS")
    {
    object oNearest;
    if(!GetIsObjectValid(oTarget) || !GetIsPlayableRacialType(oTarget)) { FloatingTextStringOnCreature("You must select a humanoid target!", oPC, FALSE); return; }
    if(GetIsUnableToBite(oPC)) { FloatingTextStringOnCreature("You are in no condition to bite anyone!", oPC, FALSE); return; }
    if(!GetObjectSeen(oTarget, oPC)) { FloatingTextStringOnCreature("You cannot see your target!", oPC, FALSE); return; }
    if(GetIsVampire(oTarget)) { FloatingTextStringOnCreature(GetName(oTarget) + " is already a vampire.", oPC, FALSE); return; }
    if(GetHasGarlicProtection(oTarget)) { FloatingTextStringOnCreature(GetName(oTarget) + " has recently eaten garlic and cannot be bitten.", oPC, FALSE); return; }
    if(!GetIsBitable(oTarget))
        {
        if(GetIsPC(oTarget) && GetIsFriend(oTarget, oPC) && GetIsFriend(oPC, oTarget))
            {
            if(GetLocalInt(oPC, "FALLEN_VAMPIRE_TOKEN_DELAY"))
                { //prevent token spamming...
                FloatingTextStringOnCreature("You may only give out 1 vampirism token every 5 minutes.", oPC, FALSE);
                }
            SetLocalInt(oPC, "FALLEN_VAMPIRE_TOKEN_DELAY", TRUE);
            DelayCommand(600.0, DeleteLocalInt(oPC, "FALLEN_VAMPIRE_TOKEN_DELAY"));
            FloatingTextStringOnCreature(GetName(oTarget) + " has been given a vampirism permission token.", oPC, FALSE);
            FloatingTextStringOnCreature(GetName(oPC) + " has given you a vampire bite permission token, please check it's description carefully before using it!", oTarget, FALSE);
            oPC = CreateItemOnObject("vampirismtoken", oTarget);
            DelayCommand(60.0, DestroyObject(oPC));
            return;
            }
        FloatingTextStringOnCreature("Your target must be paralyzed, sleeping or stunned.", oPC, FALSE);
        return;
        }
    if(CheckForVampireSeen)
        {
        oNearest = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oTarget, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        if(GetIsObjectValid(oNearest) && oNearest == oPC) oNearest = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oTarget, 2, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        if(GetIsObjectValid(oNearest) && GetObjectSeen(oPC, oNearest))
            {
            doVampireRevealed(oPC, oNearest, oTarget);
            return;
            }
        }
    SetLocalObject(oPC, "FALLEN_VAMPIRE_VICTIM", oTarget);
    AssignCommand(oTarget, ClearAllActions(TRUE));
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(OBJECT_SELF, "f_vampirebite", TRUE, FALSE));
    }
else if (sTag == "FALLEN_VAMPIRE_AURA_ABILITY")
    {
    if(!Vampire_Remove_Aura(oPC)) ExecuteScript("f_vampireaura2", oPC);
    }
else if (sTag == "FALLEN_VAMPIRE_SUMMON")
    {
    if(isVampire && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, oPC))
      ExecuteScript("f_vampire_summon", oPC);
    }
else if (sTag == "FALLEN_VAMPIRE_LOOK_HUNGER")
    {
    if(isVampire && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER, oPC) && GetIsObjectValid(oTarget))
        {
        int iDrain = (GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget)) / 2;
        int myNeed = GetMaxHitPoints(oPC) - GetCurrentHitPoints(oPC);
        string sTemp = (UseGuaranteedBloodTypes)?"gblood":"blood";
        if(GetHasGarlicProtection(oTarget)) { FloatingTextStringOnCreature(GetName(oTarget) + " has recently eaten garlic and is immune to this attack.", oPC, FALSE); return; }
        if(iDrain > 0)
            {
            Vampire_Fresh_Blood(oPC);
            if(myNeed > 0)
                {
                if(iDrain > myNeed) iDrain -= myNeed;
                  else myNeed = iDrain; iDrain = 0;
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, IntToFloat(myNeed));
                FloatingTextStringOnCreature("The fresh blood strengthens you.", OBJECT_SELF, FALSE);
                }
            if(iDrain > 0)
                {
                iDrain /= HPPerBottle;
                if(iDrain < 1) iDrain = 1;
                if(UseVialOfPreservationSystem)
                    {
                    object oItem = GetFirstItemInInventory(OBJECT_SELF);
                    for(myNeed = 0; myNeed < iDrain && GetIsObjectValid(oItem); iDrain++)
                        {
                        while(GetIsObjectValid(oItem) && GetTag(oItem) != "FALLEN_VAMPIRE_EMPTY_VIAL") oItem = GetNextItemInInventory(OBJECT_SELF);
                        if(GetIsObjectValid(oItem))
                            {
                            if(GetItemStackSize(oItem) < 2) DestroyObject(oItem);
                                else SetItemStackSize(oItem, GetItemStackSize(oItem) - 1);
                            CreateItemOnObject(sTemp, OBJECT_SELF, 1);
                            FloatingTextStringOnCreature("You have filled a vial with excess blood for later use.", OBJECT_SELF, FALSE);
                            }
                        }
                    }
                else
                    {
                    for(myNeed = 0; myNeed < iDrain; myNeed++) CreateItemOnObject(sTemp, OBJECT_SELF, 1);
                    FloatingTextStringOnCreature("You have bottled the extra blood for later use.", OBJECT_SELF, FALSE);
                    }
                }
            }
        }
    } //end FALLEN_VAMPIRE_LOOK_HUNGER
else if (sTag == "FALLEN_VAMPIRE_REFUGE")
    {
    ExecuteScript("f_vampire_refuge", oPC);
    }
else if (sTag == "fv_BookofElderVampireAdvancement")
    {
    ExecuteScript("f_vampireepic", oPC);
    }
}

