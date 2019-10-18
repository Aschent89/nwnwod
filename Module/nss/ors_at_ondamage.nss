////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Training Dummy and Training Target
//  ors_at_ondamage
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the OnDamaged Event of an Archery Target
//
////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_itemprop"

int GetIsEnhanced(object oItem)
{
    if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ON_HIT_PROPERTIES)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ONHITCASTSPELL)) return TRUE;
    else return FALSE;
}

void main()
{
    object oSelf    = OBJECT_SELF;
    string sName    = GetName(oSelf);
    object oPC      = GetLastDamager();
    object oMod     = GetModule();

    object oWeapon  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sWeapon  = GetResRef(oWeapon);
    int nWeapon     = GetWeaponRanged(oWeapon);

    //Module Settings See  opw_mod_onload
    int nTrainerXPS = GetLocalInt(oMod,"TRAINERXPS");
    int nTrainerDPS = GetLocalInt(oMod,"TRAINERDPS");
    int nTrainerXPL = GetLocalInt(oMod,"TRAINERXPL");

    //The Player is restricted by the Module Max Level Setting
    if(nTrainerXPL == 0) nTrainerXPL = 10000;//Level 5 Default
    int nPCXP = GetXP(oPC);
    if(nPCXP > nTrainerXPL)
    {
      AssignCommand(oPC,ClearAllActions(TRUE));
      SendMessageToPC(oPC, "You can no longer learn anything from this "+sName+ ".");
      return;
    }

    //If the Weapon is not a ranged weapon cancel
    if(nWeapon == FALSE)
    {
      AssignCommand(oPC,ClearAllActions(TRUE));
      SendMessageToPC(oPC, "You can only use Ranged Weapons on this Target.");
      return;
    }

    //No Enhanced Weapons Can Be Used
    if(GetIsEnhanced(oWeapon) == TRUE)
    {
      AssignCommand(oPC,ClearAllActions(TRUE));
      SendMessageToPC(oPC, "You can only use NON ENHANCED Ranged Weapons on this Target.");
      return;
    }

    int nXP     = nTrainerXPS;
    int nReq    = nTrainerDPS;
    int nGive   = 0;
    int nDamage = GetTotalDamageDealt();
    int nTally  = GetLocalInt(oPC, "ATTALLY");
    int nMessage = 0;

    //These are the Messages given during the Session
    string sMessage1 = "That one might have missed the Barn =) !";
    string sMessage2 = "Barely hit the target!";
    string sMessage3 = "Blue....could be better!";
    string sMessage4 = "White.....not bad at all!";
    string sMessage5 = "Red.....nice shot!";
    string sMessage6 = "Very Nice shot....dead center of the Red!";

    //NO CHEATING =) ...the Wepaon you start the session with is what you must finish with
    if(nTally == 0)
    {
      SetLocalString(oPC,"SESSIONRANGED",sWeapon);
    }
    if(nTally >= 1)
    {
      string sOWeapon = GetLocalString(oPC,"SESSIONRANGED");
      object oNWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
      string sNWeapon = GetResRef(oWeapon);

      if(sOWeapon != sNWeapon)
      {
        AssignCommand(oPC,ClearAllActions(TRUE));
        SendMessageToPC(oPC,"You must finish this Session with the SAME weapon you started it with!");
        return;
      }
    }

    //This is where we keep a running total
    nTally = nTally + nDamage;
    nMessage = nDamage;

    if(nTally >= nReq)
    {
      nGive = 1;
      SetLocalInt(oPC,"ATTALLY",0);
    }
    else if(nTally < nReq)
    {
      nGive = 0;
      SetLocalInt(oPC,"ATTALLY",nTally);
    }

    //Give the Player information about the progress
    string sTally = IntToString(nTally);
    string sReq = IntToString(nReq);
    SendMessageToPC(oPC,"Tallied damage is: " +sTally+ " of the required: " +sReq );

    if (!GetIsPC(oPC)) return;

    // Give Experience for this session
    if(nGive == 1)
    {
      AssignCommand(oPC,ClearAllActions(TRUE));
      GiveXPToCreature(oPC,nXP);
      SendMessageToPC(oPC, "Nice work!! You have gained " +IntToString(nXP)+ " Experience in this session.");
      DelayCommand(1.0, AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0,3.0)));
      DelayCommand(4.5, AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0)));
    }
    //Give a Message to Player
    else
    {
      if(d2() == 1)
      {
        //Decide which message to give to the Player
        if(nMessage == 0) SendMessageToPC(oPC, sMessage1);
        if(nMessage >= 1 && nMessage < 3) SendMessageToPC(oPC, sMessage2);
        if(nMessage >= 3 && nMessage < 6) SendMessageToPC(oPC, sMessage3);
        if(nMessage >= 6 && nMessage < 10) SendMessageToPC(oPC, sMessage4);
        if(nMessage >= 10 && nMessage < 15) SendMessageToPC(oPC, sMessage5);
        if(nMessage >= 15) SendMessageToPC(oPC, sMessage6);
      }
    }
}
