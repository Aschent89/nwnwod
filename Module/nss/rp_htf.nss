#include "rp_global"
///////////////////////////////////////////////////////////////////////////////
/////////////////////Mad Rabbit's Roleplaying World////////////////////////////
//////////////Code For Hunger, Thirst, and Fatigue System//////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////Constants////////////////////////////////////

//Tag for food items
const string RP_HTF_FOOD_TAG = "rp_food_item";

//Tag for drink items
const string RP_HTF_DRINK_TAG = "rp_drink_item";

//Tag and resref for empty bottle item
const string RP_HTF_BOTTLE_TAG = "rp_bottle_item";

//Tag for Fatigue Effect Generator
const string RP_HTF_FATIGUE_GENERATOR_TAG = "rp_htf_f_gen";

//Tag for Hunger Effect Generator
const string RP_HTF_HUNGER_GENERATOR_TAG = "rp_htf_h_gen";

//Tag for Thirst Effect Generator
const string RP_HTF_THIRST_GENERATOR_TAG = "rp_htf_t_gen";

//Prefix for Fatigue Time Stamp
const string RP_HTF_FATIGUE_TIME_STAMP = "RP_HTF_F_TS_";

//Prefix for Fatigue Effects 1
const string RP_HTF_FATIGUE_EFFECTS_1 = "RP_HTF_F_1_";

//Prefex for Fatigue Effects 2
const string RP_HTF_FATIGUE_EFFECTS_2 = "RP_HTF_F_1_2";

//Prefix for Hunger Check
const string RP_HTF_HUNGER_CHECK = "RP_HTF_H_C_";

//Prefix for Hunger Effects 1
const string RP_HTF_HUNGER_EFFECTS_1 = "RP_HTF_H_1_";

//Prefex for Hunger Effects 2
const string RP_HTF_HUNGER_EFFECTS_2 = "RP_HTF_H_1_2";

//Prefix for Thirst Check
const string RP_HTF_THIRST_CHECK = "RP_HTF_T_C_";

//Prefix for Thirst Effects 1
const string RP_HTF_THIRST_EFFECTS_1 = "RP_HTF_T_1_";

//Prefex for Thirst Effects 2
const string RP_HTF_THIRST_EFFECTS_2 = "RP_HTF_T_1_2";

//Flag for being in an Oasis area.
const string RP_HTF_VAR_NEAR_WATER = "RP_HTF_NEAR_WATER";

//////////////////////////////Declarations//////////////////////////////////////

//Returns a stored HTF Int for a player
//Returns 0 if no stored HTF Int
int RpHTFIntCheck(object oPC, string sPrefix);

//Deletes a stored HTF int for oPC
int RpHTFIntDelete(object oPC, string sPrefix);

//Saves a HTF Int for a player
void RpHTFIntSet(object oPC, string sPrefix, int nValue = 0);

//Checks for fatigue and applies effects
void RpHTFFatigueCheck(object oPC);

//Removes any effects created by a given generator. If a generator is not given,
//it will clear all effects by all three generators.
void RPHTFEffectClear(object oPC, object oGenerator);

//Applys Fatigue 1 or 2 effects to oPC
void RpHTFApplyFatigueEffects(object oPC, int EffectType, object oGenerator);

//Check for hunger and apply effects
void RpHTFHungerCheck(object oPC);

//Apply Hunger 1 or 2 Effects
void RpHTFApplyHungerEffects(object oPC, int EffectType, object oGenerator);

//Apply Thirst 1 or 2 Effects
void RpHTFApplyThirstEffects(object oPC, int EffectType, object oGenerator);

//Check for thirst and apply effects
void RpHTFThirstCheck(object oPC);

//Function for On Client Enter scripts
void RpHTFOnClientEnter(object oPC);

//Forces a HTF check and applys any effects needed
void RpHTFReApplyEffects(object oPC);

//Function for On Rest scripts
void RpHTFOnRestFinished(object oPC);

//Function for On Death scripts
void RpHTFOnDeath(object oPC);

//Function for On Respawn scripts
void RpHTFOnRespawn(object oPC);

//Function for Drink Items on On Activate script
void RpHTFManualDrinkConsume(object oPC, object oDrink);

//Function for Food Items on On Activate script
void RpHTFManualFoodConsume(object oPC, object oFood);

//Function for On Close script of Wells
void RPHTFWellOnClose(object oWell);

//Function for Empty Bottles on On Activate Script
void RPHTFBottleFillWithWater(object oPC, object oBottle);

///////////////////////////////Definitions//////////////////////////////////////

int RpHTFIntCheck(object oPC, string sPrefix)
{
    string sName = GetName(oPC);
    object oModule = GetModule();

    //Combine the prefix and the name
    string sTimeStamp = sPrefix + sName;

    //Return the int
    return GetLocalInt(oModule, sTimeStamp);
}

void RpHTFIntSet(object oPC, string sPrefix, int nValue = 0)
{
    string sName = GetName(oPC);
    object oModule = GetModule();

    //Combine the prefix and the name
    string sTimeStamp = sPrefix + sName;

    //Create a time stamp if no variable given
    if (nValue == 0) nValue = RpTimeStamp();

    //Store the int
    SetLocalInt(oModule, sTimeStamp, nValue);
}

void RpHTFIntDelete(object oPC, string sPrefix)
{
    string sName = GetName(oPC);
    object oModule = GetModule();

    //Combine the prefix and the name
    string sTimeStamp = sPrefix + sName;

    //Delete the int
    DeleteLocalInt(oModule, sTimeStamp);
}

void RpHTFFatigueCheck(object oPC)
{
    object oGenerator = GetObjectByTag(RP_HTF_FATIGUE_GENERATOR_TAG);

    //If no time stamp saved, create a new one
    if (RpHTFIntCheck(oPC, RP_HTF_FATIGUE_TIME_STAMP) == 0) {
        int nNewTimeStamp = RpTimeStamp();
        RpHTFIntSet(oPC, RP_HTF_FATIGUE_TIME_STAMP, nNewTimeStamp); }

    //If Fatigue 2 Effects are active, do nothing.
    if (RpHTFIntCheck(oPC, RP_HTF_FATIGUE_EFFECTS_2))    {
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_FATIGUE_PHASE_2), oPC);
        return;  }

    //If Fatigue 1 Effects are currently active, remove the effects
    //and apply Fatigue Effects 2
    if (RpHTFIntCheck(oPC, RP_HTF_FATIGUE_EFFECTS_1)) {
        RpHTFIntDelete(oPC, RP_HTF_FATIGUE_EFFECTS_1);
        AssignCommand(oGenerator, RPHTFEffectClear(oPC, oGenerator));
        DelayCommand(0.2, AssignCommand(oGenerator, RpHTFApplyFatigueEffects(oPC, 2, oGenerator)));
        RpHTFIntSet(oPC, RP_HTF_FATIGUE_EFFECTS_2, 1);
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_FATIGUE_PHASE_2), oPC);
        return; }

    //If no effects are active and the player has passed the time required
    //to rest, apply Fatigue Effects 1
    int nTimeStamp = RpTimeStamp();
    int nTimeBeforeRestHours = RP_HTF_FATIGUE_START +
                               GetAbilityModifier(ABILITY_CONSTITUTION, oPC);

    int nTimeBeforeRestSeconds = nTimeBeforeRestHours * 60 * 60;
    int nPlayerTimeStamp = RpHTFIntCheck(oPC, RP_HTF_FATIGUE_TIME_STAMP);

    if (nTimeStamp - nPlayerTimeStamp >= nTimeBeforeRestSeconds) {
        DelayCommand(0.2, AssignCommand(oGenerator, RpHTFApplyFatigueEffects(oPC, 1, oGenerator)));
        RpHTFIntSet(oPC, RP_HTF_FATIGUE_EFFECTS_1, 1);
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_ORANGE, RP_STRING_FATIGUE_PHASE_1), oPC);
        return; }
}

void RPHTFEffectClear(object oPC, object oGenerator)
{
    effect eEffect = GetFirstEffect(oPC);
    object oEffectGenerator;

        while (GetIsEffectValid(eEffect)) {

            oEffectGenerator = GetEffectCreator(eEffect);

            if (oGenerator == oEffectGenerator) {
                RemoveEffect(oPC, eEffect); }

            eEffect = GetNextEffect(oPC); }
}

void RpHTFApplyFatigueEffects(object oPC, int EffectType, object oGenerator)
{
    //Create an instance of fatigue effects
    struct HTF Fatigue = FatigueEffects();

    effect eEffect1;
    effect eEffect2;
    effect eEffect3;

    //Determine which effects to use based on EffectType
    if (EffectType == 1) {
        eEffect1 = SupernaturalEffect(Fatigue.Lvl1Effect1);
        eEffect2 = SupernaturalEffect(Fatigue.Lvl1Effect2);
        eEffect3 = SupernaturalEffect(Fatigue.Lvl1Effect3); }

    if (EffectType == 2) {
        eEffect1 = SupernaturalEffect(Fatigue.Lvl2Effect1);
        eEffect2 = SupernaturalEffect(Fatigue.Lvl2Effect2);
        eEffect3 = SupernaturalEffect(Fatigue.Lvl2Effect3); }

    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect1, oPC));
    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oPC));
    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect3, oPC));
}

void RpHTFHungerCheck(object oPC)
{
    object oFood = GetItemPossessedBy(oPC, RP_HTF_FOOD_TAG);
    object oGenerator = GetObjectByTag(RP_HTF_HUNGER_GENERATOR_TAG);
    //If the player has food, clear all effects.
    if (GetIsObjectValid(oFood)) {
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_GREEN, RP_STRING_HUNGER_FOOD), oPC);
        AssignCommand(oGenerator, RPHTFEffectClear(oPC, oGenerator));
        RpHTFIntDelete(oPC, RP_HTF_HUNGER_EFFECTS_1);
        RpHTFIntDelete(oPC, RP_HTF_HUNGER_EFFECTS_2);
        RpHTFIntDelete(oPC, RP_HTF_HUNGER_CHECK);
        DestroyObject(oFood);
        return; }

    //If Hunger 2 Effects are active and the player has no food, do nothing.
    if (RpHTFIntCheck(oPC, RP_HTF_HUNGER_EFFECTS_2) && !GetIsObjectValid(oFood))    {
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_HUNGER_PHASE_2), oPC);
        return;  }

    //If Hunger 1 Effects are currently active and the player has no food, remove the effects
    //and apply Hunger Effects 2
    if (RpHTFIntCheck(oPC, RP_HTF_HUNGER_EFFECTS_1) && !GetIsObjectValid(oFood)) {
        RpHTFIntDelete(oPC, RP_HTF_HUNGER_EFFECTS_1);
        AssignCommand(oGenerator, RPHTFEffectClear(oPC, oGenerator));
        DelayCommand(0.2, AssignCommand(oGenerator, RpHTFApplyHungerEffects(oPC, 2, oGenerator)));
        RpHTFIntSet(oPC, RP_HTF_HUNGER_EFFECTS_2, 1);
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_HUNGER_PHASE_2), oPC);
        return; }

    //If no effects are present and the player has already been checked for food and
    //still does not have any, apply Hunger Effects 1
    if (RpHTFIntCheck(oPC, RP_HTF_HUNGER_CHECK) && !GetIsObjectValid(oFood)) {
        DelayCommand(0.2, AssignCommand(oGenerator, RpHTFApplyHungerEffects(oPC, 1, oGenerator)));
        RpHTFIntSet(oPC, RP_HTF_HUNGER_EFFECTS_1, 1);
        RpHTFIntDelete(oPC, RP_HTF_HUNGER_CHECK);
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_ORANGE, RP_STRING_HUNGER_PHASE_1), oPC);
        return; }

    //If the player has no food, flag him as checked
    if (!GetIsObjectValid(oFood)) {
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_GREEN, RP_STRING_HUNGER_NO_FOOD), oPC);
        RpHTFIntSet(oPC, RP_HTF_HUNGER_CHECK, 1);
        return; }
}

void RpHTFApplyHungerEffects(object oPC, int EffectType, object oGenerator)
{
    //Create an instance of hunger effects
    struct HTF Hunger = HungerEffects();

    effect eEffect1;
    effect eEffect2;
    effect eEffect3;

    //Determine which effects to use based on EffectType
    if (EffectType == 1) {
        eEffect1 = SupernaturalEffect(Hunger.Lvl1Effect1);
        eEffect2 = SupernaturalEffect(Hunger.Lvl1Effect2);
        eEffect3 = SupernaturalEffect(Hunger.Lvl1Effect3); }

    if (EffectType == 2) {
        eEffect1 = SupernaturalEffect(Hunger.Lvl2Effect1);
        eEffect2 = SupernaturalEffect(Hunger.Lvl2Effect2);
        eEffect3 = SupernaturalEffect(Hunger.Lvl2Effect3); }

    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect1, oPC));
    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oPC));
    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect3, oPC));
}

void RpHTFThirstCheck(object oPC)
{
    object oDrink = GetItemPossessedBy(oPC, RP_HTF_DRINK_TAG);
    object oGenerator = GetObjectByTag(RP_HTF_THIRST_GENERATOR_TAG);

    //If the player has drink, clear all effects and create an empty bottle of water
    if (GetIsObjectValid(oDrink)) {
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_GREEN, RP_STRING_THIRST_DRINK), oPC);
        AssignCommand(oGenerator, RPHTFEffectClear(oPC, oGenerator));
        RpHTFIntDelete(oPC, RP_HTF_THIRST_EFFECTS_1);
        RpHTFIntDelete(oPC, RP_HTF_THIRST_EFFECTS_2);
        RpHTFIntDelete(oPC, RP_HTF_THIRST_CHECK);
        DestroyObject(oDrink);
        CreateItemOnObject(RP_HTF_BOTTLE_TAG, oPC);
        return; }

    //If Thirst 2 Effects are active and the player has no drink, do nothing.
    if (RpHTFIntCheck(oPC, RP_HTF_THIRST_EFFECTS_2) && !GetIsObjectValid(oDrink))    {
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_THIRST_PHASE_2), oPC);
        return;  }

    //If Thirst 1 Effects are currently active and the player has no drink, remove the effects
    //and apply Thirst Effects 2
    if (RpHTFIntCheck(oPC, RP_HTF_THIRST_EFFECTS_1) && !GetIsObjectValid(oDrink)) {
        RpHTFIntDelete(oPC, RP_HTF_THIRST_EFFECTS_1);
        AssignCommand(oGenerator, RPHTFEffectClear(oPC, oGenerator));
        DelayCommand(0.2, AssignCommand(oGenerator, RpHTFApplyThirstEffects(oPC, 2, oGenerator)));
        RpHTFIntSet(oPC, RP_HTF_THIRST_EFFECTS_2, 1);
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_THIRST_PHASE_2), oPC);
        return; }

    //If no effects are present and the player has already been checked for drink and
    //still does not have any, apply Thirst Effects 1
    if (RpHTFIntCheck(oPC, RP_HTF_THIRST_CHECK) && !GetIsObjectValid(oDrink)) {
        DelayCommand(0.2, AssignCommand(oGenerator, RpHTFApplyThirstEffects(oPC, 1, oGenerator)));
        RpHTFIntSet(oPC, RP_HTF_THIRST_EFFECTS_1, 1);
        RpHTFIntDelete(oPC, RP_HTF_THIRST_CHECK);
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_ORANGE, RP_STRING_THIRST_PHASE_1), oPC);
        return; }

    //If the player has no drink, flag him as checked
    if (!GetIsObjectValid(oDrink)) {
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_GREEN, RP_STRING_THIRST_NO_DRINK), oPC);
        RpHTFIntSet(oPC, RP_HTF_THIRST_CHECK, 1);
        return; }
}

void RpHTFApplyThirstEffects(object oPC, int EffectType, object oGenerator)
{
    //Create an instance of thirst effects
    struct HTF Thirst = ThirstEffects();

    effect eEffect1;
    effect eEffect2;
    effect eEffect3;

    //Determine which effects to use based on EffectType
    if (EffectType == 1) {
        eEffect1 = SupernaturalEffect(Thirst.Lvl1Effect1);
        eEffect2 = SupernaturalEffect(Thirst.Lvl1Effect2);
        eEffect3 = SupernaturalEffect(Thirst.Lvl1Effect3); }

    if (EffectType == 2) {
        eEffect1 = SupernaturalEffect(Thirst.Lvl2Effect1);
        eEffect2 = SupernaturalEffect(Thirst.Lvl2Effect2);
        eEffect3 = SupernaturalEffect(Thirst.Lvl2Effect3); }

    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect1, oPC));
    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oPC));
    AssignCommand(oGenerator, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect3, oPC));
}

void RpHTFReApplyEffects(object oPC)
{
    object oGenerator = GetObjectByTag(RP_HTF_FATIGUE_GENERATOR_TAG);

    //Check and apply Thirst 2 Effects
    if (RpHTFIntCheck(oPC, RP_HTF_THIRST_EFFECTS_2)) {
        AssignCommand(oGenerator, RpHTFApplyThirstEffects(oPC, 2, oGenerator));
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_THIRST_PHASE_2), oPC); }

    //Check and apply Thirst 1 Effects
    if (RpHTFIntCheck(oPC, RP_HTF_THIRST_EFFECTS_1)) {
        AssignCommand(oGenerator, RpHTFApplyThirstEffects(oPC, 1, oGenerator));
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_ORANGE, RP_STRING_THIRST_PHASE_1), oPC); }

    //Check and apply Hunger 2 Effects
    if (RpHTFIntCheck(oPC, RP_HTF_HUNGER_EFFECTS_2)) {
        AssignCommand(oGenerator, RpHTFApplyHungerEffects(oPC, 2, oGenerator));
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_HUNGER_PHASE_2), oPC); }

    //Check and apply Hunger 1 Effects
    if (RpHTFIntCheck(oPC, RP_HTF_HUNGER_EFFECTS_1)) {
        AssignCommand(oGenerator, RpHTFApplyHungerEffects(oPC, 1, oGenerator));
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_ORANGE, RP_STRING_HUNGER_PHASE_1), oPC); }

    //Check and apply Fatigue 2 Effects
    if (RpHTFIntCheck(oPC, RP_HTF_FATIGUE_EFFECTS_2)) {
        AssignCommand(oGenerator, RpHTFApplyFatigueEffects(oPC, 2, oGenerator));
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_RED, RP_STRING_FATIGUE_PHASE_2), oPC); }

    //Check and apply Fatigue 1 Effects
    if (RpHTFIntCheck(oPC, RP_HTF_FATIGUE_EFFECTS_1)) {
        AssignCommand(oGenerator, RpHTFApplyFatigueEffects(oPC, 1, oGenerator));
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_ORANGE, RP_STRING_FATIGUE_PHASE_1), oPC); }
}

void RpHTFOnClientEnter(object oPC)
{
    //If its a DM, don't bother
    if (GetIsDM(oPC)) return;

    //If one of the systems is on...
    if (RP_HTF_FATIGUE_ON || RP_HTF_HT_ON) {

        object oFatigue = GetObjectByTag(RP_HTF_FATIGUE_GENERATOR_TAG);
        object oHunger = GetObjectByTag(RP_HTF_HUNGER_GENERATOR_TAG);
        object oThirst = GetObjectByTag(RP_HTF_THIRST_GENERATOR_TAG);

        //Clear all supernatural effects
        AssignCommand(oFatigue, RPHTFEffectClear(oPC, oFatigue));
        DelayCommand(0.2, AssignCommand(oHunger, RPHTFEffectClear(oPC, oHunger)));
        DelayCommand(0.4, AssignCommand(oThirst, RPHTFEffectClear(oPC, oThirst)));

        //Apply any effects
        DelayCommand(0.8, RpHTFReApplyEffects(oPC));  }
}

void RpHTFOnRestFinished(object oPC)
{
    //If resting player is DM, then don't bother
    if (GetIsDM(oPC)) return;

    //If one of the systems is on...
    if (RP_HTF_FATIGUE_ON || RP_HTF_HT_ON) {

        object oGenerator = GetObjectByTag(RP_HTF_FATIGUE_GENERATOR_TAG);

        //If the player is fatigued, remove the fatigue
        if (RpHTFIntCheck(oPC, RP_HTF_FATIGUE_EFFECTS_2) ||
            RpHTFIntCheck(oPC, RP_HTF_FATIGUE_EFFECTS_1)) {
            //RemoveEffect(oPC, EFFECT_TYPE_BLINDNESS);
            AssignCommand(oGenerator, RPHTFEffectClear(oPC, oGenerator));
            RpHTFIntDelete(oPC, RP_HTF_FATIGUE_EFFECTS_2);
            RpHTFIntDelete(oPC, RP_HTF_FATIGUE_EFFECTS_1);

            FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_GREEN, RP_STRING_FATIGUE_REST), oPC); }

        //Regardless, reset their fatigue timer
        int nTimeStamp = RpTimeStamp();
        RpHTFIntSet(oPC, RP_HTF_FATIGUE_TIME_STAMP, nTimeStamp);   }
}

void RpHTFOnDeath(object oPC)
{
    //If one of the systems is on...
    if (RP_HTF_FATIGUE_ON || RP_HTF_HT_ON) {

        object oFatigue = GetObjectByTag(RP_HTF_FATIGUE_GENERATOR_TAG);
        object oHunger = GetObjectByTag(RP_HTF_HUNGER_GENERATOR_TAG);
        object oThirst = GetObjectByTag(RP_HTF_THIRST_GENERATOR_TAG);

        //Clear all supernatural effects
        AssignCommand(oFatigue, RPHTFEffectClear(oPC, oFatigue));
        DelayCommand(0.2, AssignCommand(oHunger, RPHTFEffectClear(oPC, oHunger)));
        DelayCommand(0.4, AssignCommand(oThirst, RPHTFEffectClear(oPC, oThirst))); }
}

void RpHTFOnRespawn(object oPC)
{
    //If one of the systems is on...
    if (RP_HTF_FATIGUE_ON || RP_HTF_HT_ON) {

        //If reapplying effects after respawn is on..
        if (RP_HTF_EFFECTS_ON_RESPAWN) {

            //Reapply the effects
            RpHTFReApplyEffects(oPC); } }
}

void RpHTFManualDrinkConsume(object oPC, object oDrink)
{
    object oGenerator = GetObjectByTag(RP_HTF_THIRST_GENERATOR_TAG);

    FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_GREEN, RP_STRING_THIRST_DRINK), oPC);
    AssignCommand(oGenerator, RPHTFEffectClear(oPC, oGenerator));
    RpHTFIntDelete(oPC, RP_HTF_THIRST_EFFECTS_1);
    RpHTFIntDelete(oPC, RP_HTF_THIRST_EFFECTS_2);
    RpHTFIntDelete(oPC, RP_HTF_THIRST_CHECK);
    CreateItemOnObject(RP_HTF_BOTTLE_TAG, oPC);
}

void RpHTFManualFoodConsume(object oPC, object oFood)
{
    object oGenerator = GetObjectByTag(RP_HTF_HUNGER_GENERATOR_TAG);

    FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_GREEN, RP_STRING_HUNGER_FOOD), oPC);
    AssignCommand(oGenerator, RPHTFEffectClear(oPC, oGenerator));
    RpHTFIntDelete(oPC, RP_HTF_HUNGER_EFFECTS_1);
    RpHTFIntDelete(oPC, RP_HTF_HUNGER_EFFECTS_2);
    RpHTFIntDelete(oPC, RP_HTF_HUNGER_CHECK);
}

void RPHTFWellOnClose(object oWell)
{
    object oItem = GetFirstItemInInventory(oWell);
    string sTag;

    //Search through inventory
    while (GetIsObjectValid(oItem)) {

        sTag = GetTag(oItem);

        //If it's an empty bottle of water, destroy it and create a fresh bottle of water
        if (sTag == RP_HTF_BOTTLE_TAG) {
            DestroyObject(oItem);
            CreateItemOnObject(RP_HTF_DRINK_TAG, oWell); }

        oItem = GetNextItemInInventory(oItem); }
}

void RPHTFBottleFillWithWater(object oPC, object oBottle)
{
    //If the PC is not near a stream or lake, they can't fill the bottle
    if (!GetLocalInt(oPC, RP_HTF_VAR_NEAR_WATER)) {
        FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_CYAN, RP_STRING_NOT_NEAR_WATER), oPC);
        return; }

    //Otherwise, destroy the empty bottle of water and create a fresh bottle of water...
    DestroyObject(oBottle);
    CreateItemOnObject(RP_HTF_DRINK_TAG, oPC);
    FloatingTextStringOnCreature(RGBColorText(TEXT_COLOR_CYAN, RP_STRING_FILL_BOTTLE), oPC);
}




