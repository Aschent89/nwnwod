#include "q_stackable_inc"
#include "subdual_inc"

void main()
{  object oPC = OBJECT_SELF;
//    SetLocalInt(oPC, "shifted", 0);
if(CheckSubdual(GetLastPlayerDying())) return;

if (TestStringAgainstPattern("**Garou**", GetSubRace(oPC)) == TRUE)
{
    int nCheck = d10(1);
    SendMessageToPC(oPC, IntToString(nCheck));
    if (nCheck > 2)
    {ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal((GetMaxHitPoints(oPC))/2), oPC);
    ExecuteScript("garoucrinosshift",oPC);}

    FloatingTextStringOnCreature("*Your mind becomes clouded in rage*", oPC);
}


if ("Vampire" == GetSubRace(oPC))
{

int nCheck = 0;
//child
if (GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_CHILD_BLOOD") != OBJECT_INVALID)
{
    nCheck = 1;
    ActionTakeStackedItemsByTag("FALLEN_VAMPIRE_CHILD_BLOOD",oPC,1);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectRegenerate(15, 3.0f), oPC, RoundsToSeconds(10));
}
//virgin
else if (GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_VIRGIN_BLOOD") != OBJECT_INVALID && nCheck == 0)
{
    nCheck = 1;
    ActionTakeStackedItemsByTag("FALLEN_VAMPIRE_VIRGIN_BLOOD",oPC,1);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectRegenerate(10, 3.0f), oPC, RoundsToSeconds(10));

}
//fresh
else if (GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_GOOD_BLOOD") != OBJECT_INVALID && nCheck == 0)
{
    nCheck = 1;
    ActionTakeStackedItemsByTag("FALLEN_VAMPIRE_GOOD_BLOOD",oPC,1);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectRegenerate(5, 3.0f), oPC, RoundsToSeconds(10));

}
//impure
else if (GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_BAD_BLOOD") != OBJECT_INVALID && nCheck == 0)
{
    nCheck = 1;
    ActionTakeStackedItemsByTag("FALLEN_VAMPIRE_BAD_BLOOD",oPC,1);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectRegenerate(1, 3.0f), oPC, RoundsToSeconds(10));

}
}
    //From Master Configuration ors_mod_onload
   //ExecuteScript("habd_onpcdying",OBJECT_SELF); // Fallen's Vampire System

 string sDyingSystem = GetLocalString(GetModule(),"DYINGSYSTEM");
   ExecuteScript(sDyingSystem,OBJECT_SELF);
}

