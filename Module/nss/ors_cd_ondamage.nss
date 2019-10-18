////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Training Dummy and Training Target
//  ors_cd_ondamage
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the OnDamaged Event of a Combat Dummy
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
    object oSelf = OBJECT_SELF;
    string sName = GetName(oSelf);
    object oPC  = GetLastDamager();
    object oMod = GetModule();

    if(!GetIsPC(oPC)) return;

    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sWeapon = GetResRef(oWeapon);
    int nWeapon    = GetWeaponRanged(oWeapon);

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

    //If the Weapon is a ranged weapon cancel
    if(nWeapon == TRUE)
    {
      AssignCommand(oPC,ClearAllActions(TRUE));
      SendMessageToPC(oPC, "You can only use Melee Weapons on this Training Dummy.");
      return;
    }

    //No Enhanced Weapons Can Be Used
    if(GetIsEnhanced(oWeapon) == TRUE)
    {
      AssignCommand(oPC,ClearAllActions(TRUE));
      SendMessageToPC(oPC, "You can only use NON ENHANCED Melee Weapons on this Training Dummy.");
      return;
    }

    int nXP     = nTrainerXPS;
    int nReq    = nTrainerDPS;
    int nGive   = 0;
    int nDamage = GetTotalDamageDealt();
    int nTally  = GetLocalInt(oPC, "TDTALLY");
    int nMessage = 0;

    //These are the Messages given during the Session
    string sMessage1 = "I felt the breeze on that one =) !";
    string sMessage2 = "That was soft....hit like that and you'll be here forever!";
    string sMessage3 = "That was better....keep it up!";
    string sMessage4 = "Looks like you are improving.....Keep it up!";
    string sMessage5 = "Nice swing...this is becoming too easy!";
    string sMessage6 = "Looks like you are becoming a real professional at this!";

    //NO CHEATING =) ...the Weapon you start the session with is what you must finish with
    if(nTally == 0)
    {
      SetLocalString(oPC,"SESSIONMELEE",sWeapon);
    }
    if(nTally >= 1)
    {
      string sOWeapon = GetLocalString(oPC,"SESSIONMELEE");
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
      SetLocalInt(oPC,"TDTALLY",0);
    }
    else if(nTally < nReq)
    {
      nGive = 0;
      SetLocalInt(oPC,"TDTALLY",nTally);
    }

    //Give the Player information about the progress
    string sTally = IntToString(nTally);
    string sReq = IntToString(nReq);
    SendMessageToPC(oPC,"Tallied damage is: " +sTally+ " of the required: " +sReq );

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
        if(nMessage >= 1 && nMessage < 5) SendMessageToPC(oPC, sMessage2);
        if(nMessage >= 5 && nMessage < 10) SendMessageToPC(oPC, sMessage3);
        if(nMessage >= 10 && nMessage < 18) SendMessageToPC(oPC, sMessage4);
        if(nMessage >= 18 && nMessage < 25) SendMessageToPC(oPC, sMessage5);
        if(nMessage >= 25) SendMessageToPC(oPC, sMessage6);
      }
    }
}
