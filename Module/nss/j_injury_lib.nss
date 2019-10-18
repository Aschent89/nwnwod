//Mr. E. Mustard's Injury System
/*
    Injury array notes:
    1, Right Arm Mangled
    2, Left Arm Mangled
    3, Reduced Dex Due to Right Arm Injury
    4, Reduced Dex Due to Left Arm Injury
    5, Reduced Con Due to Chest Injury
    6, Slow Effect Due to Leg Injury
*/



#include "x2_inc_intweapon"
#include "nw_o0_itemmaker"

//Constants
const int InjureDam = 10; //Amount of damage required to cause an injury
const int DeathDam = 25;  //Amount of damage required to cause death blows
const int HealTime = 6;    /*Determines how long after first rest it takes to
                            recover from an injury*/

/*Applies reduced strength if hp is low enough following a successful hit*/
void j_weaken(object oTarget)
{
   int iWeak = GetLocalInt(oTarget, "iWeaken");
   effect eWeaken = ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_STRENGTH, (iWeak+1)));
   int iHP = GetCurrentHitPoints(oTarget);
   int iMaxHP = GetMaxHitPoints(oTarget);
   object oPC = oTarget;
   if(!GetIsPC(oPC)) oPC = GetFirstPC();

   /*The following switch is designed to weaken the character's strength
   gradually as health drops.*/

  if(iWeak < 4)//No further weakening allowed, so no sense running the switch
  {
   switch(iWeak)
   {
     case 0:
        if (iHP < iMaxHP/2 && iWeak < 1)
        {
            SendMessageToPC(oPC, GetName(oTarget) + "'s strenght is waning!");
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWeaken, oTarget);
            SetLocalInt(oTarget, "iWeaken", 1);
        }
     break;
     case 1:
        if (iHP < iMaxHP*2/5 && iWeak < 2)
        {
            SendMessageToPC(oPC, GetName(oTarget) + "'s strenght is waning!");
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWeaken, oTarget);
            SetLocalInt(oTarget, "iWeaken", 2);
        }
     break;
     case 2:
        if (iHP < iMaxHP*3/10 && iWeak < 3)
        {
            SendMessageToPC(oPC, GetName(oTarget) + "'s strenght is waning!");
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWeaken, oTarget);
            SetLocalInt(oTarget, "iWeaken", 3);
        }
     break;
     case 3:
        if (iHP < iMaxHP*1/5)
         {
            SendMessageToPC(oPC, GetName(oTarget) + "'s strenght is waning!");
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWeaken, oTarget);
            SetLocalInt(oTarget, "iWeaken", 4);
         }
     break;
    }
   }
}


/*Applies an 'injury' if a hit does more than 10 points of damage (default).
Also, instant death is  possible if the damage is > 19 (default).
(20% chance if dmg > DeathDam)*/
void j_injure(object oTarget)
{
    //effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY); /*No bones, but red energy instead of blood*/
    effect eVis = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL); /*Bones fly out... a little odd*/
    int iHP = GetCurrentHitPoints(oTarget);
    int iDam = GetLocalInt(oTarget, "iOldHP")-iHP;
    object oPC;

    //Adjust old HP to reflect the damage just done
    SetLocalInt(oTarget, "iOldHP", iHP);

    if(GetIsPC(oTarget)) oPC = oTarget;
    else oPC = GetFirstPC();

    PrintString("The damage done to " + GetTag(oTarget) + " is:  ");
    PrintInteger(iDam);

   // SendMessageToPC(oPC, "Damage is " + IntToString(iDam));
    if(iDam>=InjureDam)
    {
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
       //Switch determines the type of injury sustained
       switch(d20())
       {

        //Head wound (10% chance)
        //50% chance that wound is fatal, otherwise daze effect applied
        case 1:
        case 2:
            if(d2()==1 && GetLocalInt(oTarget, "iAllowDeath")==1 && iDam >= DeathDam)
            {
                effect eDeath = EffectDeath(TRUE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                SendMessageToPC(oPC, GetName(oTarget) + " suffers a FATAL head wound!");
            }
            else
            {
                effect eDaze = EffectDazed();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, 5.0);
                SendMessageToPC(oPC, GetName(oTarget) + " suffers from a concussion!");
            }
            PrintString("The injury is head wound.");
        break;
        /*Chest wound (%30 chance)
        50% chance that chest wound is fatal(default), otherwise Con drops by 2.
        Also, there's no limit to the Con reduction, so repeated injury can be
        fatal.*/
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
            if(d2()==1 && GetLocalInt(oTarget, "iAllowDeath")==1 && iDam >= DeathDam)
            {
                effect eDeath = EffectDeath(TRUE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                SendMessageToPC(oPC, GetName(oTarget) + " recieves a FATAL chest wound!");
            }
            else
           {
                int iChestWound = GetLocalArrayInt(oTarget, "injury", 5);
                effect eInternal = SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, 2+2*iChestWound));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInternal, oTarget);
                SendMessageToPC(oPC, GetName(oTarget) + " suffers a chest wound that reduces stamina!");
                SetLocalArrayInt(oTarget, "injury", 5, 1+iChestWound);
                DelayCommand(0.25, SetLocalInt(oTarget, "iOldHP", GetCurrentHitPoints(oTarget)));
           }
        PrintString("The injury is chest wound.");
        break;
        /*Right arm wound  (15% chance)
        33.33% chance that it disarms and prevents usage of an arm
        Reduces Dex by 1 to a max of 3, if mangled max reduction applied
        Note: the two arm injury cases are exceedingly messy... sorry!*/
        case 9:
        case 10:
        case 11:
        //Checks if right arm is already mangled
         if(GetLocalArrayInt(oTarget, "injury", 1)==0)
         {
            int iReducedRTL = GetLocalArrayInt(oTarget, "injury", 4);
            int iReducedRTR = GetLocalArrayInt(oTarget, "injury", 3);

            //switch determines whether arm is mangled or just Dex penalty
            if(d3()==1)
            {
                if(GetIsPC(oTarget))
                    AssignCommand(oTarget, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget)));
                else  //AI script will just re-equip, so we destroy the weapon
                    DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget));
                SendMessageToPC(oPC, GetName(oTarget) + "'s right arm has been mangled!");
                SetLocalArrayInt(oTarget, "injury", 1, 1);
                if(iReducedRTR < 3)    //Maximize right arm Dex penalty
                {
                    effect eRArm = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, 3 + iReducedRTL));
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRArm, oTarget);
                    SetLocalArrayInt(oTarget, "injury", 3, 3);
                }
            }
            //Only apply a penalty for arm injury if penalty does not exceed 3
            else if(iReducedRTR < 3)
            {
                effect eRArm = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, 1+iReducedRTR+iReducedRTL));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRArm, oTarget);
                SendMessageToPC(oPC, GetName(oTarget) + " suffers an arm wound that reduces reaction time!");
                SetLocalArrayInt(oTarget, "injury", 3, 1+iReducedRTR);
            }
          }
        PrintString("The injury is right arm wound.");
        break;
        //Left arm wound (15% chance)
        //33.33% chance that it disarms and prevents usage of an arm
        //Reduces Dex by 1 to a max of 3, if mangled max reduction applied
        case 12:
        case 13:
        case 14:
        //Checks if left arm is mangled already
         if(GetLocalArrayInt(oTarget, "injury", 2)==0)
         {
            int iReducedRTL = GetLocalArrayInt(oTarget, "injury", 4);
            int iReducedRTR = GetLocalArrayInt(oTarget, "injury", 3);

            if(d3()==1)
            {
                object oWeapon = GetLastWeaponUsed(oTarget);
                if(GetIsPC(oTarget))
                {
                    //If weapon is two-handed, prevent equiping
                    if(MatchDoubleHandedWeapon(oWeapon))
                        AssignCommand(oTarget, ActionUnequipItem(oWeapon));
                    else
                        AssignCommand(oTarget, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget)));
                }
                else
                //AI script will just re-equip, so we destroy the weapon/shield
                {
                    if(MatchDoubleHandedWeapon(oWeapon))
                        DestroyObject(oWeapon);
                    else
                        DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget));
                }
                SendMessageToPC(oPC, GetName(oTarget) + "'s left arm has been mangled!");
                SetLocalArrayInt(oTarget, "injury", 2, 1);
                if(iReducedRTL < 3)
                {
                    effect eRArm = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, 3+iReducedRTR));
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRArm, oTarget);
                    SetLocalArrayInt(oTarget, "injury", 4, 3);
                }
            }
            else if(iReducedRTL < 3)
            {
                 effect eLArm = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, (1+iReducedRTL+iReducedRTR)));
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLArm, oTarget);
                 SendMessageToPC(oPC, GetName(oTarget) + " recieves an arm wound!");
                 SetLocalArrayInt(oTarget, "injury", 4, iReducedRTL+1);
            }
         }
        PrintString("The injury is left arm wound.");
        break;
        //Leg wound (%30 chance)
        //Applies slow effect and has a 33.33% chance of causing knockdown
        default:
            if(GetLocalArrayInt(oTarget, "injury", 6) == 0)
            {
               effect eSlow = SupernaturalEffect(EffectSlow());
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oTarget);
                SendMessageToPC(oPC, GetName(oTarget) + " recieves a leg wound and suffers hindered movement!");
                SetLocalArrayInt(oTarget, "injury", 6, 1);
            }
            if(d3()==1)
            {
                effect eKnockdown = EffectKnockdown();
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eKnockdown, oTarget);
                SendMessageToPC(oPC, GetName(oTarget) + " stumbles due to a leg injury!");
            }
        break;
        PrintString("The injury is leg wound.");
        }
   }
}


/*Mangled check- prevents equiping items requiring the damaged arm/hand*/
void j_mangle_chk(object oPC, object oItem)
{
     if(GetLocalArrayInt(oPC, "injury", 1)==1)
     {
         ClearAllActions(FALSE);
         AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)));
         FloatingTextStringOnCreature("Your right arm is injured and cannot wield a weapon.", oPC);
     }
     if(GetLocalArrayInt(oPC, "injury", 2)==1)
     {
         ClearAllActions(FALSE);
         if(MatchDoubleHandedWeapon(oItem))
            AssignCommand(oPC, ActionUnequipItem(oItem));
         else
            AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)));
         FloatingTextStringOnCreature("Your left arm is injured and cannot wield an item.", oPC);
     }
}


/* return the current time in hours */
int GetCurrentTimeStamp()
{
    return ( GetCalendarYear()  * 8064 )
         + ( GetCalendarMonth() * 672 )
         + ( GetCalendarDay()   * 24 )
         + ( GetTimeHour());
}

/*Removes injury effects*/
void injury_mend(object oPC, int iInjury)
{
    /*used to re-apply injuries that shouldn't be healed*/
    int iWound = GetLocalArrayInt(oPC, "injury", 5);
    int iRWound = GetLocalArrayInt(oPC, "injury", 3);
    int iLWound = GetLocalArrayInt(oPC, "injury", 4);
    effect e;

    //Set local variable to indicate the injury is gone
    SetLocalArrayInt(oPC, "injury", iInjury, 0);
    //Reset Injury Date so that next rest will set new injury dates
    SetLocalArrayInt(oPC, "iInjuryDate", iInjury, 0);

    SendMessageToPC(oPC, "Injuries have mended!");
/*This switch, though messy, is needed to remove each type of injury*/
    switch(iInjury)
    {
        case 1:
        case 2:
        break;
        case 3:
            e = GetFirstEffect(oPC);
            while (GetIsEffectValid(e))
            {
                if (GetEffectType(e) == EFFECT_TYPE_ABILITY_DECREASE
                && GetEffectSubType(e) == SUBTYPE_SUPERNATURAL)
                    RemoveEffect(oPC, e);
                e = GetNextEffect(oPC);
            }
            if(iWound > 0)  //Re-apply chest wound if removed in previous 'while' statement
            {
                effect eWound = SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, 2*iWound));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWound, oPC);
            }
            if(iLWound > 0) //Re-apply left arm injury
            {
                effect eWound = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, iLWound));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWound, oPC);
            }
        break;
        case 4:
            e = GetFirstEffect(oPC);
            while (GetIsEffectValid(e))
            {
                if (GetEffectType(e) == EFFECT_TYPE_ABILITY_DECREASE
                && GetEffectSubType(e) == SUBTYPE_SUPERNATURAL)
                    RemoveEffect(oPC, e);
                e = GetNextEffect(oPC);
            }
            if(iWound > 0)  //Re-apply chest wound if removed in previous 'while' statement
            {
                effect eWound = SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, 2*iWound));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWound, oPC);
            }
            if(iRWound > 0) //Re-apply right arm injury
            {
                effect eWound = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, iRWound));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWound, oPC);
            }
        break;
        case 5:
            e = GetFirstEffect(oPC);
            while (GetIsEffectValid(e))
            {
                if (GetEffectType(e) == EFFECT_TYPE_ABILITY_DECREASE
                && GetEffectSubType(e) == SUBTYPE_SUPERNATURAL)
                    RemoveEffect(oPC, e);
                e = GetNextEffect(oPC);
            }
            //Need to re-apply dextirity loss

            if(iRWound > 0 || iLWound > 0)
            {
                effect eWound = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, iRWound+iLWound));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWound, oPC);
            }
        break;
        case 6:
            e = GetFirstEffect(oPC);
            while (GetIsEffectValid(e))
            {
                if (GetEffectType(e) == EFFECT_TYPE_SLOW
                && GetEffectSubType(e) == SUBTYPE_SUPERNATURAL)
                    RemoveEffect(oPC, e);
                e = GetNextEffect(oPC);
            }
        break;
        default:
        break;
        }
}

/*Calculates when injury occured and whether enough time has passed for it to
heal*/
void injury_mend_chk(object oPC)
{
    /*Set hour of injury to the first rest after recieving it
    In RP terms, I'm thinking the injury can't begin to heal until stabilized
    via rest)*/

    int i;
    int iTime = GetCurrentTimeStamp();

    for(i = 1; i <= 6; i++)
    {
        //Checks for injury...
        if(GetLocalArrayInt(oPC, "injury", i) > 0)
            //Now check whether rest as occured since the injury
            if(GetLocalArrayInt(oPC, "iInjuryDate", i) == 0)
                //Set the current time as the first rest since injury
                SetLocalArrayInt(oPC, "iInjuryDate", i, iTime);
            //Finally, determine if enough time as passed for the injury to "mend"
            else if((GetLocalArrayInt(oPC, "iInjuryDate", i)+ HealTime) <= iTime)
                injury_mend(oPC, i);
   }
}


//void main(){}
