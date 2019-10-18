////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Realistic Armor and Weapon Rules
//  ocr_pulses
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is for the Armor/Shield/Weapon Cycle Executions
//  NOTE: This will work for NPC's too =)
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void ArmorPulse(object oArmor,object oPC)
{
   object oMod = GetModule();

   //Don't go further if the Armor was UnEquipped or
   //If the Armor Damage Settings are set to OFF
   int nEquip = GetLocalInt(oArmor,"ARMOREQUIP");
   int nDamage = GetLocalInt(oMod,"ARMORDAMAGE");
   if(nEquip < 1) return;
   if(nDamage < 1) return;

   ArmorUpdate(oArmor);
   //SendMessageToPC(oPC,"Armor Updated");
}

void ShieldPulse(object oShield,object oPC)
{
   object oMod = GetModule();

   //Don't go further if the Shield was UnEquipped or
   //If the Armor Damage Settings are set to OFF
   int nEquip = GetLocalInt(oShield,"SHIELDEQUIP");
   int nDamage = GetLocalInt(oMod,"SHIELDDAMAGE");
   if(nEquip < 1) return;
   if(nDamage < 1) return;

   ShieldUpdate(oShield);
   //SendMessageToPC(oPC,"Shield Updated");
}

void HelmPulse(object oHelm,object oPC)
{
   object oMod = GetModule();

   //Don't go further if the Helm was UnEquipped or
   //If the Armor Damage Settings are set to OFF
   int nEquip = GetLocalInt(oHelm,"HELMEQUIP");
   int nDamage = GetLocalInt(oMod,"HELMDAMAGE");
   if(nEquip < 1) return;
   if(nDamage < 1) return;

   HelmUpdate(oHelm);
   //SendMessageToPC(oPC,"Helm Updated");
}

void CloakPulse(object oCloak,object oPC)
{
   object oMod = GetModule();

   //Don't go further if the Cloak was UnEquipped or
   //If the Cloak Damage Settings are set to OFF
   int nEquip = GetLocalInt(oCloak,"CLOAKEQUIP");
   int nDamage = GetLocalInt(oMod,"CLOAKDAMAGE");
   if(nEquip < 1) return;
   if(nDamage < 1) return;

   CloakUpdate(oCloak);
   //SendMessageToPC(oPC,"Cloak Updated");
}

void BracerPulse(object oBracer,object oPC)
{
   object oMod = GetModule();

   //Don't go further if the Bracer was UnEquipped or
   //If the Armor Damage Settings are set to OFF
   int nEquip = GetLocalInt(oBracer,"BRACEREQUIP");
   int nDamage = GetLocalInt(oMod,"BRACERDAMAGE");
   if(nEquip < 1) return;
   if(nDamage < 1) return;

   BracerUpdate(oBracer);
   //SendMessageToPC(oPC,"Bracer Updated");
}

void BeltPulse(object oBelt,object oPC)
{
   object oMod = GetModule();

   //Don't go further if the Belt was UnEquipped or
   //If the Belt Damage Settings are set to OFF
   int nEquip = GetLocalInt(oBelt,"BELTEQUIP");
   int nDamage = GetLocalInt(oMod,"BELTDAMAGE");
   if(nEquip < 1) return;
   if(nDamage < 1) return;

   BeltUpdate(oBelt);
   //SendMessageToPC(oPC,"Belt Updated");
}

void WeaponPulse(object oWeapon,object oPC)
{
   object oMod = GetModule();

   //Don't go further if the Weapon was UnEquipped or
   //If the Weapon Damage Settings are set to OFF
   int nEquip = GetLocalInt(oWeapon,"WEAPONEQUIP");
   int nDamage = GetLocalInt(oMod,"WEAPONDAMAGE");
   if(nEquip < 1) return;
   if(nDamage < 1) return;

   WeaponUpdate(oWeapon);
   //SendMessageToPC(oPC,"Weapon Updated");
}

void BootsPulse(object oBoots,object oPC)
{
   object oMod = GetModule();

   //Don't go further if the Boots were UnEquipped or
   //If the Boots Damage Settings are set to OFF
   int nEquip = GetLocalInt(oBoots,"BOOTSEQUIP");
   int nDamage = GetLocalInt(oMod,"BOOTSDAMAGE");
   if(nEquip <= 0) return;
   if(nDamage <= 0) return;

   BootsUpdate(oBoots);
   //SendMessageToPC(oPC,"Boots Updated");
}

void Pulse(object oPC)
{
    object oMod         = GetModule();
    object oArmor       = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    object oWeapon      = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    object oLHand       = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    object oHelm        = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    object oCloak       = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
    object oArms        = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    object oBelt        = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
    object oBoots       = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);

    float fTime         = 6.0;

    int nARMORRULES     = GetLocalInt(oMod,"ARMORRULES");

    int nProcPulse = FALSE;
    if(nARMORRULES == 1) nProcPulse = TRUE;

    //Check the Armor FIRST
    if(oArmor != OBJECT_INVALID && nProcPulse == TRUE)
    {
      int nCombat = GetIsInCombat(oPC);
      int nType = GetLocalInt(oArmor,"ARMORTYPE");
      if(nType != 0 || nCombat == TRUE) ArmorPulse(oArmor,oPC);
    }

    //Then Check the Main Weapon
    if(oWeapon != OBJECT_INVALID && nProcPulse == TRUE)
    {
      int nCombat = GetIsInCombat(oPC);
      int nType = GetLocalInt(oWeapon,"WEAPONTYPE");
      if(nType != 0) WeaponPulse(oWeapon,oPC);
    }

    //Now check the Off Hand/Shield
    if(oLHand != OBJECT_INVALID && nProcPulse == TRUE)
    {
      int nWType = GetLocalInt(oLHand,"WEAPONTYPE");
      int nSType = GetLocalInt(oLHand,"SHIELDTYPE");
      if(nWType != 0) WeaponPulse(oLHand,oPC);
      if(nSType != 0) ShieldPulse(oLHand,oPC);
    }

    //Now Check the Helm
    if(oHelm != OBJECT_INVALID && nProcPulse == TRUE)
    {
      int nType = GetLocalInt(oHelm,"HELMTYPE");
      if(nType != 0) HelmPulse(oHelm,oPC);
    }

    //Now Check the Cloak
    if(oCloak != OBJECT_INVALID && nProcPulse == TRUE)
    {
      int nType = GetLocalInt(oCloak,"CLOAKTYPE");
      if(nType != 0) CloakPulse(oCloak,oPC);
    }

    //Now Check the Bracer/Gloves
    if(oArms != OBJECT_INVALID && nProcPulse == TRUE)
    {
      int nArmsType = GetBaseItemType(oArms);

      if(nArmsType == BASE_ITEM_BRACER)
      {
        int nType = GetLocalInt(oArms,"BRACERTYPE");
        if(nType != 0) BracerPulse(oArms,oPC);
      }
      if(nArmsType == BASE_ITEM_GLOVES)
      {
        //If there is not a weapon present then update
        if(oWeapon == OBJECT_INVALID)
        {
          int nType = GetLocalInt(oArms,"WEAPONTYPE");
          if(nType != 0) WeaponPulse(oArms,oPC);
        }
      }
    }

    //Now Check the Belt
    if(oBelt != OBJECT_INVALID && nProcPulse == TRUE)
    {
      int nType = GetLocalInt(oBelt,"BELTTYPE");
      if(nType != 0) BeltPulse(oBelt,oPC);
    }

    //Now Check the Boots
    if(oBoots != OBJECT_INVALID && nProcPulse == TRUE)
    {
      int nType = GetLocalInt(oBoots,"BOOTSTYPE");
      if(nType != 0) BootsPulse(oBoots,oPC);
    }

    if(nProcPulse == FALSE)
    {
      SetLocalInt(oPC,"PULSERUNNING",0);
      return;
    }
    else DelayCommand(fTime,Pulse(oPC));
}

void main()
{
    object oPC = OBJECT_SELF;

    //From Master Configuration opw_mod_onload
    int nCRAFTGLOBAL = GetLocalInt(GetModule(),"CRAFTGLOBAL");
    if(nCRAFTGLOBAL < 1) return;

    if(GetIsDM(oPC) == TRUE) return;
    if(GetLocalInt(oPC,"PULSERUNNING") == 1) return;

    //Start the Pulse Loop
    SetLocalInt(oPC,"PULSERUNNING",1);
    Pulse(oPC);
}
