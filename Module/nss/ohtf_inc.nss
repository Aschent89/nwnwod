////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - HTF System - Include Script
//  ohtf_inc
//  By Don Anderson
//  dandersonru@msn.com
//
//  Thank's to Ed Beck for a nice HTF System to use as a base for this system!
//
//  Please see Read Me for detailed System Information
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_weapstat"
#include "x2_inc_itemprop"
#include "nbde_inc"

// Color Variables
const string COLORRED       = "<cσ  >";
const string COLORBLUE      = "<c  σ>";
const string COLORGRAY      = "<c°°°>";
const string COLORGREEN     = "<c σ >";
const string COLORWHITE     = "<cσσσ>";
const string COLORCYAN      = "<c σσ>";
const string COLORYELLOW    = "<cσσ >";
const string COLORBLUISHG   = "<c °°>";
const string COLORBLUISHR   = "<c °σ>";

//HTF Variables
const string HTFHUNGER      = "HUNGER";
const string HTFTHIRST      = "THIRST";
const string HTFFATIGUE     = "FATIGUE";
const string HTFALC         = "ALCTOTAL";

//GENERAL VOCALS
    string WHOA             = "WHOOAAAH!";
    string WHOOPS           = "Whoops!";
    string HICCUP           = "Hiccup";
    string NOENEMIESNEAR    = "You can not use this when enemies are near.";

//THIRST AND DRINKING TEXT
    string TOOTHIRSTY0      = "I feel a little thirsty.";
    string TOOTHIRSTY1      = "I am feeling thirsty.";
    string TOOTHIRSTY2      = "I need something to drink!";
    string TOOTHIRSTY3      = "I am becoming dehydrated and really need something to drink soon.";
    string TOOTHIRSTY4      = "Water!...cough....must find...water...I fear I will die soon!";
    string THIRSTYMSG       = "* feels parched *";
    string BURP             = "* Burp *";
    string GULP             = "* Gulp *";
    string TAKEADRINKOF     = "I took a drink of ";
    string NOTTHIRSTY       = "I can not even look at something to drink right now.";
    string FULLYHYDRATED    = "I finished the drink, but am no longer thirsty.";
    string EMPTYCANTEEN     = "This canteen is empty, I should find a source of water and fill it.";
    string ALCLIGHTDRUNK    = "I feel great! Barkeep...I'll have another!";
    string ALCSEMIDRUNK     = "I meant to do that.....really.";
    string ALCDRUNK         = "I don't feel so good.......";
    string ALCHANGOVER      = "Ohh.....my freakin' head.";

//HUNGER AND EATING TEXT
    string TOOHUNGRY0       = "I feel a little hungry.";
    string TOOHUNGRY1       = "I am feeling hungry.";
    string TOOHUNGRY2       = "I am hungry. I can hear the growling from my stomach.";
    string TOOHUNGRY3       = "i am really hungry now.....must stop and eat soon.";
    string TOOHUNGRY4       = "Wasting away, no food anywhere....I fear I will die soon.";
    string HUNGRYGROWL      = "* stomach growls loudly *";
    string TAKEABITEOF      = "I took a bite of ";
    string STUFFED          = "I managed to eat the food, but I am no longer hungry.";
    string NOTHUNGRY        = "I am not hungry.";

//FATIGUE AND RESTING TEXT
    string LACKOFFOOD1      = "I have fatigued myself from no food!";
    string LACKOFFOOD2      = "I have exhausted myself from going so long without food!";
    string LACKOFWATER1     = "I have fatigued myself from no drink!";
    string LACKOFWATER2     = "I have exhausted myself from going so long without drink!";
    string TOOTIRED0        = "I feel a little worn down.";
    string TOOTIRED1        = "I am feeling tired.";
    string TOOTIRED2        = "I am really tired now and should rest soon.";
    string TOOTIRED3        = "I can barely stand...I really should rest now.";
    string YAWN             = "* yawns *";
    string NOTENOUGHREST1   = "I have become fatigued due to lack of rest.";

//DEATH AND SAVES TEXT
    string DEATHBYSTARVATION        ="You have starved to death.";
    string DEATHBYDEHYDRATION       ="You have died of dehydration.";
    string COLLAPSEFROMEXHAUSTION   ="You have collapsed from exhaustion. You need rest!";

//WATER SOURCE TEXT
    string FOULWATER        = "That water was foul! I empty and clean my canteen.";
    string NOWATERHERE      = "There is no water here.";
    string NOFISHINGHERE    = "Find a Lake or Stream to fish from.";
    string CANTEENFULL      = "My canteen is already full.";
    string FILLCANTEEN      = "I filled the canteen.";

//DISEASE AND POISON EFFECTS
    int POISONTYPE5         = POISON_HUGE_SPIDER_VENOM;
    int POISONTYPE4         = POISON_LARGE_SPIDER_VENOM;
    int POISONTYPE3         = POISON_MEDIUM_SPIDER_VENOM;
    int POISONTYPE2         = POISON_SMALL_SPIDER_VENOM;
    int POISONTYPE1         = POISON_TINY_SPIDER_VENOM;
    int DISEASETYPE5        = DISEASE_BLINDING_SICKNESS;
    int DISEASETYPE4        = DISEASE_BURROW_MAGGOTS;
    int DISEASETYPE3        = DISEASE_FILTH_FEVER;
    int DISEASETYPE2        = DISEASE_RED_ACHE;
    int DISEASETYPE1        = DISEASE_SHAKES;

//AREA HEAT AND COLD TEXTS
    //Outdoor
    string HEATMILD         = "A mild weather day. Easy travels.";
    string HEATWARM         = "A warm day today. Slightly more difficult travels.";
    string HEATWARMER       = "A hot day today. Difficult long days ahead.";
    string HEATWARMEST      = "A very hot day today. Maybe I should have stayed home.";
    string COLDMILD         = "Slightly chilly today. Grab a cloak or light winter clothing.";
    string COLDCOLD         = "A chilly day today. Bring some warmer clothing.";
    string COLDCOLDER       = "A cold day today. I should dress up warmly.";
    string COLDCOLDEST      = "A brutally cold day today. I hope to stay warm enough!";

    //Indoor
    string INDOORMILD       = "A Nice and comfortable temperature in this place.";
    string INDOORWARM       = "Warm in here.";
    string INDOORWARMER     = "Pretty warm in this place.";
    string INDOORWARMEST    = "This place is scorching.";
    string INDOORCOLD       = "It is chilly in here.";
    string INDOORCOLDER     = "It is cold in here.";
    string INDOORCOLDEST    = "It is very cold in here. A real freezer!";

    //Underwater
    string UNDERWATER       = "Nice day for a swim.";

/******************************************************************************/
//:PROTOTYPES

void OHTF_ApplyHungerBonus(string sItemTag, object oPC);
void OHTF_ApplyThirstBonus(string sItemTag, object oPC);
void OHTF_ApplyAlcoholEffectToPC(string sItemTag, object oPC);
void OHTF_ApplyDiseaseEffectToPC(object oPC, string sItemTag);
void OHTF_ApplyPoisonEffectToPC(object oPC, string sItemTag);
void OHTF_UseCanteenCharge(object oPC, object oCanteen);
void OHTF_ReFillCanteen(object oPC, object oCanteen, string sItemTag = "");
void OHTF_UseWaterCanteen(object oPC,object oCanteen);
void OHTF_ConsumeDrink(object oPC);
void OHTF_ConsumeFood(object oPC);
void OHTF_UseFoodOrDrinkItem(object oPC, object oItem);

//:PROTOTYPES
/******************************************************************************/

/******************************************************************************/
//:FUNCTIONS

string ORS_GetDBString()
{
  object oMod = GetModule();
  string sDB = GetLocalString(oMod,"ORS_DATABASE");

  return sDB;
}

void OHTF_UseFoodOrDrinkItem(object oPC, object oItem)
{
    //Gets the Local String From Item (Used by others to implement my HTF Function)
    string sFood  = GetLocalString(oItem,"Food");
    string sDrink = GetLocalString(oItem,"Drink");

    //What is the Tag of the Item
    string sItemTag;
    if(sFood != "" && sDrink != "") sItemTag = "FoodDrink" +sFood +sDrink;
    else if(sFood != "") sItemTag = "Food" +sFood;
    else if(sDrink != "") sItemTag = "Drink" +sDrink;
    else sItemTag = GetTag(oItem);

    //Returns TRUE or FALSE to each below
    int nPOISON  = FindSubString(sItemTag,"POISON");
    int nDISEASE = FindSubString(sItemTag,"DISEASE");
    int nFood    = FindSubString(sItemTag,"Food");
    int nDrink   = FindSubString(sItemTag,"Drink");

    if (nPOISON == -1 && nDISEASE == -1)
    {
      //Check for a Dual Item
      if (nDrink != -1 && nFood != -1)
      {
        AssignCommand (oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_SALUTE));
        OHTF_ApplyHungerBonus(sItemTag, oPC);
        OHTF_ApplyThirstBonus(sItemTag, oPC);
        return;
      }
      //Only a Food Item
      else if (nFood != -1)
      {
        AssignCommand (oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_SALUTE));
        OHTF_ApplyHungerBonus(sItemTag, oPC);
        return;
      }
      //Only a Drink Item
      else if (nDrink != -1)
      {
        AssignCommand (oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_DRINK));
        OHTF_ApplyThirstBonus(sItemTag, oPC);
        return;
      }
      else return;
    }
    else if (nDISEASE != -1 || nPOISON != -1)
    {
      if (nPOISON != -1)
      {
        OHTF_ApplyPoisonEffectToPC(oPC, sItemTag);
        return;
      }
      else
      {
        OHTF_ApplyDiseaseEffectToPC(oPC, sItemTag);
        return;
      }
    }
    else return;
}

void OHTF_ApplyHungerBonus(string sItemTag, object oPC)
{
    object oMod    = GetModule();
    int nHCurrent  = GetLocalInt(oPC,"HUNGER");
    int nHungerHP  = GetLocalInt(oMod,"HUNGER");
    int nBuffer    = GetLocalInt(oMod,"BUFFER");
    int nRICH      = GetLocalInt(oMod,"RICH");
    int nNORM      = GetLocalInt(oMod,"NORM");
    int nPOOR      = GetLocalInt(oMod,"POOR");
    int nHTotal    = FloatToInt((1.0 + nBuffer) * nHungerHP);

    //Apply the Hunger value of the Food
    int nOldHP = nHCurrent;
    int nNewHP = nOldHP + nPOOR;
    if (FindSubString(sItemTag,"RICH") != -1) nNewHP = nOldHP + nRICH;
    else if (FindSubString(sItemTag,"NORM") != -1) nNewHP = nOldHP + nNORM;
    if (nNewHP > nHTotal)
    {
      nNewHP = nHTotal;
      SendMessageToPC(oPC,STUFFED);
    }
    SetLocalInt(oPC,"HUNGER",nNewHP);
}

void OHTF_ApplyThirstBonus(string sItemTag, object oPC)
{
    object oMod    = GetModule();
    int nTCurrent  = GetLocalInt(oPC,"THIRST");
    int nThirstHP  = GetLocalInt(oMod,"THIRST"); // See htf_mod_onload
    int nBuffer    = GetLocalInt(oMod,"BUFFER");
    int nHIGH      = GetLocalInt(oMod,"HIGH");
    int nMED       = GetLocalInt(oMod,"MED");
    int nLOW       = GetLocalInt(oMod,"LOW");
    int nTTotal    = FloatToInt((1.0 + nBuffer) * nThirstHP);

    if (FindSubString(sItemTag,"Drink") == -1) return;
    if (FindSubString(sItemTag,"ALCOHOL") != -1)
    {
      OHTF_ApplyAlcoholEffectToPC(sItemTag, oPC);
    }
    //Apply the Thirst value of the Drink
    int nOldHP = nTCurrent;
    int nNewHP = nOldHP + nLOW;
    if (FindSubString(sItemTag,"HIGH") != -1) nNewHP = nOldHP + nHIGH;
    else if (FindSubString(sItemTag,"MED") != -1) nNewHP = nOldHP + nMED;
    if (nNewHP > nTTotal)
    {
      nNewHP = nTTotal;
      SendMessageToPC(oPC,FULLYHYDRATED);
    }
    SetLocalInt(oPC,"THIRST", nNewHP);
}

void OHTF_ApplyAlcoholEffectToPC(string sItemTag, object oPC)
{
    if (!GetIsPC(oPC)) return;

    //Declare Effects for Drunkeness
    effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
    effect eBlind =  EffectBlindness();
    effect eCollapse = EffectSleep();
    effect eInt = EffectAbilityDecrease(ABILITY_INTELLIGENCE,1);//Intelligence Penalty
    effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY,1);//Dexterity Penalty
    effect eMov  = EffectMovementSpeedDecrease(20); //Movement Decrease
    effect eStr  = EffectAbilityDecrease(ABILITY_STRENGTH,1); //Strength Decrease

    //Gets the Alcohol value from the Tag
    int nAlc;
    if (FindSubString(sItemTag,"ALCOHOL9")!=-1) nAlc = 9;
    else if (FindSubString(sItemTag,"ALCOHOL8")!=-1) nAlc = 8;
    else if (FindSubString(sItemTag,"ALCOHOL7")!=-1) nAlc = 7;
    else if (FindSubString(sItemTag,"ALCOHOL6")!=-1) nAlc = 6;
    else if (FindSubString(sItemTag,"ALCOHOL5")!=-1) nAlc = 5;
    else if (FindSubString(sItemTag,"ALCOHOL4")!=-1) nAlc = 4;
    else if (FindSubString(sItemTag,"ALCOHOL3")!=-1) nAlc = 3;
    else if (FindSubString(sItemTag,"ALCOHOL2")!=-1) nAlc = 2;
    else if (FindSubString(sItemTag,"ALCOHOL1")!=-1) nAlc = 1;
    else nAlc = 1;

    //This is where we start adding the alcohol to the Player
    int nAlcTotal = GetLocalInt(oPC,"ALCTOTAL");
    if (nAlcTotal <=0) nAlcTotal = 0;
    nAlcTotal = nAlcTotal + nAlc;
    int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    if (nCON > 3) nCON = 3;//Removes supernatural abilities
    nAlcTotal = nAlcTotal - nCON; //Subtract CON Bonus from total consumption
    if (nAlcTotal <=0) nAlcTotal = 0;//To make sure we don't go below zero

    //Now we set the new alcohol total so the Player can't escape the effects
    SetLocalInt(oPC,"ALCTOTAL", nAlcTotal);
    SpeakString(BURP);

    //Now to start applying effects based on total consumption over a period of time
    if(nAlcTotal > 10 && nAlcTotal <= 15)
    {
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInt, oPC, 120.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDex, oPC, 120.0);
      AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 7.0));
      DelayCommand(7.0, SpeakString(ALCLIGHTDRUNK));
    }
    else if (nAlcTotal > 15 && nAlcTotal <= 20)
    {
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInt, oPC, 240.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDex, oPC, 240.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMov, oPC, 240.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStr, oPC, 240.0);
      AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 7.0));
      DelayCommand( 7.0, SpeakString(WHOA));
      DelayCommand( 8.0, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 4.0)));
      DelayCommand( 4.0, SpeakString(ALCSEMIDRUNK));
    }
    else if (nAlcTotal > 20)
    {
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInt, oPC, 360.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDex, oPC, 360.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMov, oPC, 360.0);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStr, oPC, 360.0);
      DelayCommand( 2.0, AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 7.0)));
      DelayCommand( 3.0, SpeakString(HICCUP));
      DelayCommand( 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCollapse, oPC, 30.0));
      DelayCommand( 7.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 30.0));
      DelayCommand( 8.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0));
      DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0));
      DelayCommand(31.0, SpeakString(ALCHANGOVER));
    }
}

void OHTF_ApplyDiseaseEffectToPC(object oPC, string sItemTag)
{
    int diseasetype;
    if (FindSubString(sItemTag,"DISEASE5")!=-1) diseasetype = DISEASETYPE5;
    else if (FindSubString(sItemTag,"DISEASE4")!=-1) diseasetype = DISEASETYPE4;
    else if (FindSubString(sItemTag,"DISEASE3")!=-1) diseasetype = DISEASETYPE3;
    else if (FindSubString(sItemTag,"DISEASE2")!=-1) diseasetype = DISEASETYPE2;
    else diseasetype = DISEASETYPE1;

    effect eDisease = EffectDisease(diseasetype);
    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisease, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}

void OHTF_ApplyPoisonEffectToPC(object oPC, string sItemTag)
{
    int poisontype;
    if (FindSubString(sItemTag,"POISON5")!=-1) poisontype = POISONTYPE5;
    else if (FindSubString(sItemTag,"POISON4")!=-1) poisontype = POISONTYPE4;
    else if (FindSubString(sItemTag,"POISON3")!=-1) poisontype = POISONTYPE3;
    else if (FindSubString(sItemTag,"POISON2")!=-1) poisontype = POISONTYPE2;
    else poisontype = POISONTYPE1;

    effect ePoison = EffectPoison(poisontype);
    effect eVis = EffectVisualEffect(VFX_IMP_POISON_S);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}

void OHTF_UseCanteenCharge(object oPC, object oCanteen)
{
    string srctag = GetLocalString(oCanteen,"SRCTAG");
    int charges = GetLocalInt(oCanteen,"CHARGES");
    int usecharge = GetLocalInt(oPC,"USEFDC");

    //Returns TRUE or FALSE to each below
    int nPOISON  = FindSubString(srctag,"POISON");
    int nDISEASE = FindSubString(srctag,"DISEASE");
    int nDrink   = FindSubString(srctag,"Drink");

    if ((nPOISON == -1) && (nDISEASE == -1))
    {
      OHTF_ApplyThirstBonus(srctag, oPC);
      SetLocalInt(oCanteen,"CHARGES",charges - 1);
      AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
      DelayCommand(1.5,SpeakString(GULP));
      string sCharges = IntToString(GetLocalInt(oCanteen,"CHARGES"));
      DelayCommand(5.0,SendMessageToPC(oPC, "You now have " + sCharges + " drinks left in this Canteen."));
      return;
    }
    else
    {
      if ((nDISEASE != -1) || (nPOISON != -1))
      {
        if (nPOISON != -1)
        {
          OHTF_ApplyPoisonEffectToPC(oPC, srctag);
        }
        else
        {
          OHTF_ApplyDiseaseEffectToPC(oPC, srctag);
        }
      }
      AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
      DelayCommand(1.5,SpeakString(GULP));
      SendMessageToPC(oPC,FOULWATER);
      SetLocalInt(oCanteen,"CHARGES",0);
      SetLocalString(oCanteen,"SRCTAG","");
    }
}

void OHTF_ReFillCanteen(object oPC, object oCanteen, string sItemTag)
{
    int charges = GetLocalInt(oCanteen,"CHARGES");
    int nMax    = GetLocalInt(GetModule(),"MAXCANTEENCHARGES");// See htf_mod_onload
    if (charges == nMax)
    {
      SendMessageToPC(oPC,CANTEENFULL);
      return;
    }
    else
    {
      AssignCommand(oPC,PlaySound("fs_water_hard1"));
      AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0));
      SetLocalInt(oCanteen,"CHARGES",nMax);
      SetLocalString(oCanteen,"SRCTAG",sItemTag);
      SendMessageToPC(oPC,FILLCANTEEN);
      string sCharges = IntToString(GetLocalInt(oCanteen,"CHARGES"));
      SendMessageToPC(oPC, "You now have " + sCharges + " drinks left in this Canteen.");
    }
}

void OHTF_UseWaterCanteen(object oPC,object oCanteen)
{
    int Charges = GetLocalInt(oCanteen,"CHARGES");
    int Enter = GetLocalInt(oPC,"WSOURCE");

    if (Enter == TRUE)
    {
      string watersrc = GetLocalString(oPC,"WSOURCE");

      if (watersrc=="")
      {
        SendMessageToPC(oPC,NOWATERHERE);
      }
      //Refills the Canteen if the Player is 'IN' the Water Source Trigger
      else
      {
        OHTF_ReFillCanteen(oPC,oCanteen,watersrc);
      }
    }
    else
    {
      if (Charges >= 1)
      {
        OHTF_UseCanteenCharge(oPC,oCanteen);
      }
      else
      {
        SendMessageToPC(oPC,EMPTYCANTEEN);
      }
    }
}


void MakePlayerFatigued()
{
    object oPC;
    if (!GetIsPC(oPC)) return;
    effect eCon  = EffectAbilityDecrease(ABILITY_CONSTITUTION,1);
    effect eMov  = EffectMovementSpeedDecrease(20);
    effect eStr  = EffectAbilityDecrease(ABILITY_STRENGTH,1);
    effect eLight= EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eFull = EffectVisualEffect(VFX_IMP_SLOW);
    effect eDmg  = EffectDamage(1);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCon,oPC,140.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMov,oPC,130.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStr,oPC,120.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eFull,oPC,5.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oPC,1.0);
}

string MaxTemp(string sTVar)
{
   string sSL = GetStringLeft(sTVar,12);
   string sSR = GetStringRight(sSL,3);
   return sSR;
}

//void main(){}
