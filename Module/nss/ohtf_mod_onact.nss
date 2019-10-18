////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - HTF System - Activate Item File
//  ohtf_mod_onact
//  By Don Anderson
//  dandersonru@msn.com
//
//  Original Script by Edward Beck
//
////////////////////////////////////////////////////////////////////////////////

#include "ohtf_inc"

void main()
{
    object oPC          = GetItemActivator();
    if(!GetIsPC(oPC)) return;

    object oMod         = GetModule();
    object oItem        = GetItemActivated();
    int nHUNGERSYSTEM   = GetLocalInt(oMod,"HUNGERSYSTEM");
    int nHungerHP       = GetLocalInt(oMod,HTFHUNGER);
    int nThirstHP       = GetLocalInt(oMod,HTFTHIRST);
    int nFatigueHP      = GetLocalInt(oMod,HTFFATIGUE);
    int nHCurrent       = GetLocalInt(oPC,HTFHUNGER);
    int nTCurrent       = GetLocalInt(oPC,HTFTHIRST);
    int nBuffer         = GetLocalInt(oMod,"BUFFER");
    float fHTotal       = (1.0 + nBuffer) * IntToFloat(nHungerHP);
    float fTTotal       = (1.0 + nBuffer) * IntToFloat(nThirstHP);

    //Bottles and Recreation Stuff
    string sItemRef = GetResRef(oItem);
    int nBottle     = GetItemCharges(oItem);
    string sName    = GetName(oItem);

    //Gets the Local String From Item (Used by others to implement my HTF Function)
    string sFood  = GetLocalString(oItem,"Food");
    string sDrink = GetLocalString(oItem,"Drink");

    //What is the Tag of the Item
    string sItemTag;
    if(sFood != "" && sDrink != "") sItemTag = "FoodDrink" +sFood +sDrink;
    else if(sFood != "") sItemTag = "Food" +sFood;
    else if(sDrink != "") sItemTag = "Drink" +sDrink;
    else sItemTag = GetTag(oItem);

    //Used Food item
    int nDualItem = 0;
    if (FindSubString(sItemTag,"Food") != -1)
    {
      nDualItem = 1;
      if(nHUNGERSYSTEM == 1)
      {
        if(IntToFloat(nHCurrent) >= fHTotal)
        {
          SendMessageToPC(oPC,NOTHUNGRY);

          int nCharges = GetItemCharges(oItem);
          if(nCharges > 1)
          {
            object oNew = CreateItemOnObject(GetResRef(oItem),oPC);
            SetItemCharges(oNew,nCharges);
            DestroyObject(oItem);
            return;
          }
          else
          {
            object oNew = CreateItemOnObject(GetResRef(oItem),oPC);
            SetItemCharges(oNew,1);
            DestroyObject(oItem);
            return;
          }
        }
        else
        {
          //FoodDrink Item....Drink Message Instead of Take a Bite Message
          if(FindSubString(sItemTag,"Drink") != -1) SendMessageToPC(oPC,TAKEADRINKOF + sName);
          else SendMessageToPC(oPC,TAKEABITEOF + sName);
          OHTF_UseFoodOrDrinkItem(oPC,oItem);
        }
      }
    }
    //Used Drink Item
    if ((FindSubString(sItemTag,"Drink") != -1) && (nDualItem != 1))
    {
      if(nHUNGERSYSTEM == 1)
      {
        if (IntToFloat(nTCurrent) >= fTTotal)
        {
          SendMessageToPC(oPC,NOTTHIRSTY);

          int nCharges = GetItemCharges(oItem);
          if(nCharges > 1)
          {
            object oNew = CreateItemOnObject(GetResRef(oItem),oPC);
            SetItemCharges(oNew,nCharges);
            DestroyObject(oItem);
            return;
          }
          else
          {
            object oNew = CreateItemOnObject(GetResRef(oItem),oPC);
            SetItemCharges(oNew,1);
            DestroyObject(oItem);
            return;
          }
        }
        else
        {
          SendMessageToPC(oPC,TAKEADRINKOF + sName);
          OHTF_UseFoodOrDrinkItem(oPC,oItem);
        }
      }
    }
    //Used Water Canteen
    if (sItemTag == "Canteen")
    {
      if(nHUNGERSYSTEM == 1)
      {
        OHTF_UseWaterCanteen(oPC,oItem);
      }
      else
      { //Just adds effects if the HTF System is off
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        DelayCommand(1.5,SpeakString(GULP));
      }
    }
}
