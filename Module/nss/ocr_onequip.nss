////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Realistic Armor and Weapon Rules
//  ocr_onequip
//  By Don Anderson
//  dandersonru@msn.com
//
//  Armor Rules Speed Idea by Kornstalx from his 3E Armor Rules...Thank You!
//
//  Place this script in the Module On Equip Event
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_spells"
#include "ocr_include"

void main()
{
    object oPC      = GetPCItemLastEquippedBy();
    object oMod     = GetModule();

    object oItem    = GetPCItemLastEquipped();
    float fTime;

    //From Master Configuration ors_mod_onload
    int nCRAFTGLOBAL = GetLocalInt(oMod,"CRAFTGLOBAL");
    if(nCRAFTGLOBAL == 0) return;

    //Don't go further if this is a DM
    if(GetIsDM(oPC) || GetIsDMPossessed(oPC) == TRUE) return;
    if(GetIsPC(oPC) == FALSE) return;

    //Gender Specific Gear ( "Male" or "Female" in Name )
    string sName = GetName(oItem);
    int nFemale = FindSubString(sName,"Female");
    int nMale = FindSubString(sName,"Male");
    int nGender = GetGender(oPC);

    //Female Player
    if(nGender == GENDER_FEMALE)
    {
      if(nMale != -1)
      {
        SendMessageToPC(oPC,"You can not wear Male Gear!");
        DelayCommand(0.5,AssignCommand(oPC, ActionUnequipItem(oItem)));
        return;
      }
    }

    //Male Player
    if(nGender == GENDER_MALE)
    {
      if(nFemale != -1)
      {
        SendMessageToPC(oPC,"You can not wear Female Gear!");
        DelayCommand(0.5,AssignCommand(oPC, ActionUnequipItem(oItem)));
        return;
      }
    }

    int nARMORRULES = GetLocalInt(oMod,"ARMORRULES");
    int nRMR = GetLocalInt(oMod,"SML_CREATURE_MOVEPEN");

    if(GetLocalInt(oPC, "CRAFTING_CONVO") == 1) return;//Kicks out if Crafting
    if(nARMORRULES == 0) return;//Armor Rules is OFF

    int nType       = GetBaseItemType(oItem);
    int nCurPCHP    = GetCurrentHitPoints(oPC);

/******************************************************************************/
//: CLEANER SECTION

    if(GetLocalInt(oItem,"ARMORNEW") == 0
      || GetLocalInt(oItem,"SHIELDNEW") == 0
      || GetLocalInt(oItem,"HELMNEW") == 0
      || GetLocalInt(oItem,"BRACERNEW") == 0
      || GetLocalInt(oItem,"CLOAKNEW") == 0
      || GetLocalInt(oItem,"BELTNEW") == 0
      || GetLocalInt(oItem,"BOOTSNEW") == 0
      || GetLocalInt(oItem,"WEAPONNEW") == 0)
    {
      ExecuteScript("ocr_cleaner",oItem);
    }

//: CLEANER SECTION
/******************************************************************************/

/******************************************************************************/
//: ARMOR SECTION

    object oArmor   = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    int nNetAC      = GetItemACValue(oArmor);
    int nBonus      = IPGetWeaponEnhancementBonus(oArmor, ITEM_PROPERTY_AC_BONUS);
    int nBaseAC     = nNetAC - nBonus;

    effect eVisual  = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eChangingarmor = EffectCutsceneImmobilize();
    effect eArmorpen;

    //Now we check and set the Armor Status
    if(nType == BASE_ITEM_ARMOR)
    {
      //Remove Previous Speed
      RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oPC);

      object oArmor = oItem;
      SetLocalInt(oArmor,"PCBASEHP",nCurPCHP);
      int nArmorType;
      int nDRSYS        = GetLocalInt(oMod,"DRSYS");
      int nARMORDAMAGE  = GetLocalInt(oMod,"ARMORDAMAGE");
      int nARMORDESTROY = GetLocalInt(oMod,"ARMORDESTROY");
      int nARMORLIGHT   = GetLocalInt(oMod,"ARMORLIGHT");
      int nARMORMED     = GetLocalInt(oMod,"ARMORMED");
      int nARMORHEAVY   = GetLocalInt(oMod,"ARMORHEAVY");
      int nARMOR10      = GetLocalInt(oMod,"ARMOR10");
      int nARMOR20      = GetLocalInt(oMod,"ARMOR20");
      int nARMOR30      = GetLocalInt(oMod,"ARMOR30");
      int nAHP          = GetLocalInt(oMod,"ARMORHP");
      int nLAMult       = GetLocalInt(oMod,"LAMULT");
      int nMAMult       = GetLocalInt(oMod,"MAMULT");
      int nHAMult       = GetLocalInt(oMod,"HAMULT");
      int nAC1Mult      = GetLocalInt(oMod,"AC1MULT");
      int nAC2Mult      = GetLocalInt(oMod,"AC2MULT");
      int nAC3Mult      = GetLocalInt(oMod,"AC3MULT");
      int nAC4Mult      = GetLocalInt(oMod,"AC4MULT");
      int nAC5Mult      = GetLocalInt(oMod,"AC5MULT");
      int nCurAHP       = GetLocalInt(oArmor,"ARMORHP");
      int nANew         = GetLocalInt(oArmor,"ARMORNEW");

      //Check to see if the Armor already needs repair
      int nOldHP = GetLocalInt(oArmor,"ARMOROLDHP");
      if(nOldHP <= 0 && nANew != 0)
      {
        DelayCommand(0.2,AssignCommand(oPC,ActionUnequipItem(oArmor)));
        return;
      }

      if(nBaseAC > 0 && nBaseAC < 4) nArmorType = 1;//Light Armor Check
      else if(nBaseAC > 3 && nBaseAC < 6) nArmorType = 2;//Medium Armor Check
      else if(nBaseAC > 5) nArmorType = 3;//Heavy Armor Check
      else //Clothing and don't continue
      {
        nArmorType = 0;
        SetLocalInt(oArmor,"ARMORHP",1);
        SetLocalInt(oArmor,"ARMOROLDHP",1);
        SetLocalInt(oArmor,"ARMORTYPE",nArmorType);
        SetLocalInt(oArmor,"ARMORNEW",1);//Set to Used
        SetLocalInt(oArmor,"ARMOREQUIP",1);
        SetLocalInt(oArmor,"ARMORDAMAGE",nARMORDAMAGE);
        SetLocalInt(oArmor,"ARMORDESTROY",nARMORDESTROY);

        //Racial Movement Rates
        int nRacial = GetLocalInt(oMod,"RACIALMOVE");
        if(nRacial == 1)
        {
          SetLocalInt(oPC, "RACIAL_MOVEMENT", 0);
          SetRacialMovementRate(oPC);
        }
        return;
      }

      //Set as New Armor and Equipped
      if(nCurAHP == 0 && nANew == 0)
      {
        //Set Up Armor
        int nMult = 0;
        int nBonus = GetACBonus(oArmor);
        if(nDRSYS == 1)
        {
          int nB = GetBludgDamageResistance(oArmor);
          int nP = GetPierceDamageResistance(oArmor);
          int nS = GetSlashDamageResistance(oArmor);
          nBonus =nB + nP +nS;
        }

        if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

        switch (nBonus)
        {
          case 0: nMult = 1; break;
          case 1: nMult = nAC1Mult; break;
          case 2: nMult = nAC2Mult; break;
          case 3: nMult = nAC3Mult; break;
          case 4: nMult = nAC4Mult; break;
          case 5: nMult = nAC5Mult; break;
        }

        if(nArmorType == 1)
        {
          int nTotal = (nAHP * nLAMult) * nMult;
          SetLocalInt(oArmor,"ARMORHP",nTotal);
          SetLocalInt(oArmor,"ARMOROLDHP",nTotal);
          SetLocalInt(oArmor,"ARMORTYPE",nArmorType);
          SetLocalInt(oArmor,"ARMORNEW",1);//Set to Used
          SetLocalInt(oArmor,"ARMOREQUIP",1);
          SetLocalInt(oArmor,"ARMORDAMAGE",nARMORDAMAGE);
          SetLocalInt(oArmor,"ARMORDESTROY",nARMORDESTROY);
        }
        if(nArmorType == 2)
        {
          int nTotal = (nAHP * nMAMult) * nMult;
          SetLocalInt(oArmor,"ARMORHP",nTotal);
          SetLocalInt(oArmor,"ARMOROLDHP",nTotal);
          SetLocalInt(oArmor,"ARMORTYPE",nArmorType);
          SetLocalInt(oArmor,"ARMORNEW",1);//Set to Used
          SetLocalInt(oArmor,"ARMOREQUIP",1);
          SetLocalInt(oArmor,"ARMORDAMAGE",nARMORDAMAGE);
          SetLocalInt(oArmor,"ARMORDESTROY",nARMORDESTROY);
        }
        if(nArmorType == 3)
        {
          int nTotal = (nAHP * nHAMult) * nMult;
          SetLocalInt(oArmor,"ARMORHP",nTotal);
          SetLocalInt(oArmor,"ARMOROLDHP",nTotal);
          SetLocalInt(oArmor,"ARMORTYPE",nArmorType);
          SetLocalInt(oArmor,"ARMORNEW",1);//Set to Used
          SetLocalInt(oArmor,"ARMOREQUIP",1);
          SetLocalInt(oArmor,"ARMORDAMAGE",nARMORDAMAGE);
          SetLocalInt(oArmor,"ARMORDESTROY",nARMORDESTROY);
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oArmor,"ARMOREQUIP",1);
      }

      //Racial Type of oPC
      int nRacialType = GetRacialType(oPC);

      //Light Armor Speed Decrease
      if(nArmorType == 1)
      {
        //Configure For Racial Properties
        if(GetCreatureSize(oPC) == CREATURE_SIZE_SMALL || nRacialType == RACIAL_TYPE_DWARF)
        {
          if(nARMOR10 < nRMR) nARMOR10 = nRMR;
        }

        //Remove and Add Speed Decreases
        RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oPC);
        eArmorpen = SupernaturalEffect(EffectMovementSpeedDecrease(nARMOR10));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eArmorpen, oPC);

        //Apply the Effects
        fTime = RoundsToSeconds(nARMORLIGHT);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChangingarmor, oPC, fTime);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, fTime);
        AssignCommand(oPC, DelayCommand(2.0, ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fTime-2.0))));
        SendMessageToPC(oPC,"*Equipping this armor will take "+IntToString(nARMORLIGHT)+" rounds*");
        DelayCommand(fTime, SendMessageToPC(oPC,"*Equipped Light Armor*"));
        DelayCommand(fTime, SendMessageToPC(oPC,"Your movement speed has been decreased: "+IntToString(nARMOR10)+"%"));
      }

      //Medium Armor Speed Decrease
      if(nArmorType == 2)
      {
        //Configure For Racial Properties
        if(GetCreatureSize(oPC) == CREATURE_SIZE_SMALL || nRacialType == RACIAL_TYPE_DWARF)
        {
          if(nARMOR20 < nRMR) nARMOR20 = nRMR;
        }

        //Remove and Add Speed Decreases
        RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oPC);
        eArmorpen = SupernaturalEffect(EffectMovementSpeedDecrease(nARMOR20));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eArmorpen, oPC);

        //Apply the Effects
        fTime = RoundsToSeconds(nARMORMED);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChangingarmor, oPC, fTime);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, fTime);
        AssignCommand(oPC, DelayCommand(2.0, ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fTime-2.0))));
        SendMessageToPC(oPC,"*Equipping this armor will take "+IntToString(nARMORMED)+" rounds*");
        DelayCommand(fTime, SendMessageToPC(oPC,"*Equipped Medium Armor*"));
        DelayCommand(fTime, SendMessageToPC(oPC,"Your movement speed has been decreased: "+IntToString(nARMOR20)+"%"));
      }

      //Heavy Armor Speed Decrease
      if(nArmorType == 3)
      {
        //Configure For Racial Properties
        if(GetCreatureSize(oPC) == CREATURE_SIZE_SMALL || nRacialType == RACIAL_TYPE_DWARF)
        {
          if(nARMOR30 < nRMR) nARMOR30 = nRMR;
        }

        //Remove and Add Speed Decreases
        RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oPC);
        eArmorpen = SupernaturalEffect(EffectMovementSpeedDecrease(nARMOR30));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eArmorpen, oPC);

        //Apply the Effects
        fTime = RoundsToSeconds(nARMORHEAVY);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChangingarmor, oPC, fTime);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, fTime);
        AssignCommand(oPC, DelayCommand(2.0, ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fTime-2.0))));
        SendMessageToPC(oPC,"*Equipping this armor will take "+IntToString(nARMORHEAVY)+" rounds*");
        DelayCommand(fTime, SendMessageToPC(oPC,"*Equipped Heavy Armor*"));
        DelayCommand(fTime, SendMessageToPC(oPC,"Your movement speed has been decreased: "+IntToString(nARMOR30)+"%"));
      }
    }

//: ARMOR SECTION
/******************************************************************************/

/******************************************************************************/
//: SHIELD SECTION

    //Now we check and set the Shield Status
    if(nType == BASE_ITEM_SMALLSHIELD
        || nType == BASE_ITEM_LARGESHIELD
        || nType == BASE_ITEM_TOWERSHIELD)
    {
      object oShield = oItem;
      int nShieldType;
      int nARMORDAMAGE  = GetLocalInt(oMod,"ARMORDAMAGE");
      int nARMORDESTROY = GetLocalInt(oMod,"ARMORDESTROY");
      int nAHP          = GetLocalInt(oMod,"ARMORHP");
      int nSSMult       = GetLocalInt(oMod,"SSMULT");
      int nLSMult       = GetLocalInt(oMod,"LSMULT");
      int nTSMult       = GetLocalInt(oMod,"TSMULT");
      int nAC1Mult      = GetLocalInt(oMod,"AC1MULT");
      int nAC2Mult      = GetLocalInt(oMod,"AC2MULT");
      int nAC3Mult      = GetLocalInt(oMod,"AC3MULT");
      int nAC4Mult      = GetLocalInt(oMod,"AC4MULT");
      int nAC5Mult      = GetLocalInt(oMod,"AC5MULT");
      int nCurSHP       = GetLocalInt(oShield,"SHIELDHP");
      int nSNew         = GetLocalInt(oShield,"SHIELDNEW");

      //Check to see if the Shield already needs repair
      int nOldHP = GetLocalInt(oShield,"SHIELDOLDHP");
      if(nOldHP <= 0 && nSNew != 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oShield));
        return;
      }

      if(nType == BASE_ITEM_SMALLSHIELD) nShieldType = 1;
      if(nType == BASE_ITEM_LARGESHIELD) nShieldType = 2;
      if(nType == BASE_ITEM_TOWERSHIELD) nShieldType = 3;

      //Set as New Shield and Equipped
      if(nCurSHP == 0 && nSNew == 0)
      {
        //Set Up Shield
        int nMult = 0;
        int nBonus = GetACBonus(oShield);
        if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

        switch (nBonus)
        {
          case 0: nMult = 1; break;
          case 1: nMult = nAC1Mult; break;
          case 2: nMult = nAC2Mult; break;
          case 3: nMult = nAC3Mult; break;
          case 4: nMult = nAC4Mult; break;
          case 5: nMult = nAC5Mult; break;
        }

        if(nShieldType == 1)
        {
          int nTotal = (nAHP * nSSMult) * nMult;
          SetLocalInt(oShield,"SHIELDHP",nTotal);
          SetLocalInt(oShield,"SHIELDOLDHP",nTotal);
          SetLocalInt(oShield,"SHIELDTYPE",nShieldType);
          SetLocalInt(oShield,"SHIELDNEW",1);//Set to Used
          SetLocalInt(oShield,"SHIELDEQUIP",1);
          SetLocalInt(oShield,"SHIELDDAMAGE",nARMORDAMAGE);
          SetLocalInt(oShield,"SHIELDDESTROY",nARMORDESTROY);
        }
        if(nShieldType == 2)
        {
          int nTotal = (nAHP * nLSMult) * nMult;
          SetLocalInt(oShield,"SHIELDHP",nTotal);
          SetLocalInt(oShield,"SHIELDOLDHP",nTotal);
          SetLocalInt(oShield,"SHIELDTYPE",nShieldType);
          SetLocalInt(oShield,"SHIELDNEW",1);//Set to Used
          SetLocalInt(oShield,"SHIELDEQUIP",1);
          SetLocalInt(oShield,"SHIELDDAMAGE",nARMORDAMAGE);
          SetLocalInt(oShield,"SHIELDDESTROY",nARMORDESTROY);
        }
        if(nShieldType == 3)
        {
          int nTotal = (nAHP * nTSMult) * nMult;
          SetLocalInt(oShield,"SHIELDHP",nTotal);
          SetLocalInt(oShield,"SHIELDOLDHP",nTotal);
          SetLocalInt(oShield,"SHIELDTYPE",nShieldType);
          SetLocalInt(oShield,"SHIELDNEW",1);//Set to Used
          SetLocalInt(oShield,"SHIELDEQUIP",1);
          SetLocalInt(oShield,"SHIELDDAMAGE",nARMORDAMAGE);
          SetLocalInt(oShield,"SHIELDDESTROY",nARMORDESTROY);
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oShield,"SHIELDEQUIP",1);
      }
    }

//: SHIELD SECTION
/******************************************************************************/

/******************************************************************************/
//: WEAPON SECTION

    //: MELEE WEAPONS
    if(IsMeleeWeapon(oItem))
    {
      object oWeapon = oItem;
      int nWeaponType;
      int nWEAPONDAMAGE = GetLocalInt(oMod,"WEAPONDAMAGE");
      int nWEAPONDESTROY = GetLocalInt(oMod,"WEAPONDESTROY");
      int nWHP          = GetLocalInt(oMod,"WEAPONHP");
      int nLWMult       = GetLocalInt(oMod,"LWMULT");
      int nMWMult       = GetLocalInt(oMod,"MWMULT");
      int nHWMult       = GetLocalInt(oMod,"HWMULT");
      int nAB1Mult      = GetLocalInt(oMod,"AB1MULT");
      int nAB2Mult      = GetLocalInt(oMod,"AB2MULT");
      int nAB3Mult      = GetLocalInt(oMod,"AB3MULT");
      int nAB4Mult      = GetLocalInt(oMod,"AB4MULT");
      int nAB5Mult      = GetLocalInt(oMod,"AB5MULT");
      int nCurWHP       = GetLocalInt(oWeapon,"WEAPONHP");
      int nWNew         = GetLocalInt(oWeapon,"WEAPONNEW");

      //Check to see if the Weapon already needs repair
      int nOldHP = GetLocalInt(oWeapon,"WEAPONOLDHP");
      if(nOldHP <= 0 && nWNew != 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
        return;
      }

      if(IsLightMeleeWeapon(oWeapon) == TRUE) nWeaponType = 1;
      if(IsMediumMeleeWeapon(oWeapon) == TRUE) nWeaponType = 2;
      if(IsHeavyMeleeWeapon(oWeapon) == TRUE) nWeaponType = 3;

      //Set as New Weapon and Equipped
      if(nCurWHP == 0 && nWNew == 0)
      {
        //Set Up Weapon
        int nMult = 0;
        int nBonus = GetABBonus(oWeapon);
        if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

        switch (nBonus)
        {
          case 0: nMult = 1; break;
          case 1: nMult = nAB1Mult; break;
          case 2: nMult = nAB2Mult; break;
          case 3: nMult = nAB3Mult; break;
          case 4: nMult = nAB4Mult; break;
          case 5: nMult = nAB5Mult; break;
        }

        if(nWeaponType == 1)
        {
          int nTotal = (nWHP * nLWMult) * nMult;
          SetLocalInt(oWeapon,"WEAPONHP",nTotal);
          SetLocalInt(oWeapon,"WEAPONOLDHP",nTotal);
          SetLocalInt(oWeapon,"WEAPONTYPE",nWeaponType);
          SetLocalInt(oWeapon,"WEAPONNEW",1);//Set to Used
          SetLocalInt(oWeapon,"WEAPONEQUIP",1);
          SetLocalInt(oWeapon,"WEAPONDAMAGE",nWEAPONDAMAGE);
          SetLocalInt(oWeapon,"WEAPONDESTROY",nWEAPONDESTROY);
        }
        if(nWeaponType == 2)
        {
          int nTotal = (nWHP * nMWMult) * nMult;
          SetLocalInt(oWeapon,"WEAPONHP",nTotal);
          SetLocalInt(oWeapon,"WEAPONOLDHP",nTotal);
          SetLocalInt(oWeapon,"WEAPONTYPE",nWeaponType);
          SetLocalInt(oWeapon,"WEAPONNEW",1);//Set to Used
          SetLocalInt(oWeapon,"WEAPONEQUIP",1);
          SetLocalInt(oWeapon,"WEAPONDAMAGE",nWEAPONDAMAGE);
          SetLocalInt(oWeapon,"WEAPONDESTROY",nWEAPONDESTROY);
        }
        if(nWeaponType == 3)
        {
          int nTotal = (nWHP * nHWMult) * nMult;
          SetLocalInt(oWeapon,"WEAPONHP",nTotal);
          SetLocalInt(oWeapon,"WEAPONOLDHP",nTotal);
          SetLocalInt(oWeapon,"WEAPONTYPE",nWeaponType);
          SetLocalInt(oWeapon,"WEAPONNEW",1);//Set to Used
          SetLocalInt(oWeapon,"WEAPONEQUIP",1);
          SetLocalInt(oWeapon,"WEAPONDAMAGE",nWEAPONDAMAGE);
          SetLocalInt(oWeapon,"WEAPONDESTROY",nWEAPONDESTROY);
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oWeapon,"WEAPONEQUIP",1);
      }
    }

    //: RANGED WEAPONS
    if(IsRangedWeapon(oItem))
    {
      object oWeapon    = oItem;
      int nWeaponType   = 1;//All Ranged Weapons are considered Light for this purpose
      int nWEAPONDAMAGE = GetLocalInt(oMod,"WEAPONDAMAGE");
      int nWEAPONDESTROY = GetLocalInt(oMod,"WEAPONDESTROY");
      int nWHP          = GetLocalInt(oMod,"WEAPONHP");
      int nLWMult       = GetLocalInt(oMod,"LWMULT");
      int nAB1Mult      = GetLocalInt(oMod,"AB1MULT");
      int nAB2Mult      = GetLocalInt(oMod,"AB2MULT");
      int nCurWHP       = GetLocalInt(oWeapon,"WEAPONHP");
      int nWNew         = GetLocalInt(oWeapon,"WEAPONNEW");

      //Set as New Ranged Weapon and Equipped
      if(nCurWHP == 0 && nWNew == 0)
      {
        //Set Up Weapon
        int nMult = 0;
        int nBonus = GetABBonus(oWeapon);
        //Because of the Strings/Straps on Ranged Weapons the max is +2
        //Also Note that Ranged Weapons ONLY Destroy Themselves by Chance NOT Over Used!
        if(nBonus > 2) nBonus = 2;

        switch (nBonus)
        {
          case 0: nMult = 1; break;
          case 1: nMult = nAB1Mult; break;
          case 2: nMult = nAB2Mult; break;
        }

        if(nWeaponType == 1)
        {
          int nTotal = (nWHP * nLWMult) * nMult;
          SetLocalInt(oWeapon,"WEAPONHP",nTotal);
          SetLocalInt(oWeapon,"WEAPONOLDHP",nTotal);
          SetLocalInt(oWeapon,"WEAPONTYPE",nWeaponType);
          SetLocalInt(oWeapon,"WEAPONNEW",1);//Set to Used
          SetLocalInt(oWeapon,"WEAPONEQUIP",1);
          SetLocalInt(oWeapon,"WEAPONDAMAGE",nWEAPONDAMAGE);
          SetLocalInt(oWeapon,"WEAPONDESTROY",nWEAPONDESTROY);
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oWeapon,"WEAPONEQUIP",1);
      }
    }

//: WEAPON SECTION
/******************************************************************************/

/******************************************************************************/
//: HELM SECTION

    //Now we check and set the Helm Status
    if(nType == BASE_ITEM_HELMET)
    {
      object oHelm = oItem;
      int nHelmType = 1;
      int nARMORDAMAGE  = GetLocalInt(oMod,"ARMORDAMAGE");
      int nARMORDESTROY = GetLocalInt(oMod,"ARMORDESTROY");
      int nAHP          = GetLocalInt(oMod,"ARMORHP");
      int nLAMult       = GetLocalInt(oMod,"LAMULT");
      int nAC1Mult      = GetLocalInt(oMod,"AC1MULT");
      int nAC2Mult      = GetLocalInt(oMod,"AC2MULT");
      int nAC3Mult      = GetLocalInt(oMod,"AC3MULT");
      int nAC4Mult      = GetLocalInt(oMod,"AC4MULT");
      int nAC5Mult      = GetLocalInt(oMod,"AC5MULT");
      int nCurHHP       = GetLocalInt(oHelm,"HELMHP");
      int nHNew         = GetLocalInt(oHelm,"HELMNEW");

      //Check to see if the Helm already needs repair
      int nOldHP = GetLocalInt(oHelm,"HELMOLDHP");
      if(nOldHP <= 0 && nHNew != 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oHelm));
        return;
      }

      //Set as New Helm and Equipped
      if(nCurHHP == 0 && nHNew == 0)
      {
        //Set Up Helm
        int nMult = 0;
        int nBonus = GetACBonus(oHelm);
        if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

        switch (nBonus)
        {
          case 0: nMult = 1; break;
          case 1: nMult = nAC1Mult; break;
          case 2: nMult = nAC2Mult; break;
          case 3: nMult = nAC3Mult; break;
          case 4: nMult = nAC4Mult; break;
          case 5: nMult = nAC5Mult; break;
        }

        if(nHelmType == 1)
        {
          int nTotal = (nAHP * nLAMult) * nMult;
          SetLocalInt(oHelm,"HELMHP",nTotal);
          SetLocalInt(oHelm,"HELMOLDHP",nTotal);
          SetLocalInt(oHelm,"HELMTYPE",nHelmType);
          SetLocalInt(oHelm,"HELMNEW",1);//Set to Used
          SetLocalInt(oHelm,"HELMEQUIP",1);
          SetLocalInt(oHelm,"HELMDAMAGE",nARMORDAMAGE);
          SetLocalInt(oHelm,"HELMDESTROY",nARMORDESTROY);
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oHelm,"HELMEQUIP",1);
      }
    }

//: HELM SECTION
/******************************************************************************/

/******************************************************************************/
//: CLOAK SECTION

    //Now we check and set the Cloak Status
    if(nType == BASE_ITEM_CLOAK)
    {
      object oCloak = oItem;
      int nCloakType = 1;
      int nCLOAKDAMAGE  = GetLocalInt(oMod,"CLOAKDAMAGE");
      int nCLOAKDESTROY = GetLocalInt(oMod,"CLOAKDESTROY");
      int nCHP          = GetLocalInt(oMod,"CLOAKHP");
      int nAC1Mult      = GetLocalInt(oMod,"AC1MULT");
      int nAC2Mult      = GetLocalInt(oMod,"AC2MULT");
      int nAC3Mult      = GetLocalInt(oMod,"AC3MULT");
      int nAC4Mult      = GetLocalInt(oMod,"AC4MULT");
      int nAC5Mult      = GetLocalInt(oMod,"AC5MULT");
      int nCurCHP       = GetLocalInt(oCloak,"CLOAKHP");
      int nCNew         = GetLocalInt(oCloak,"CLOAKNEW");

      //Check to see if the Cloak already needs repair
      int nOldHP = GetLocalInt(oCloak,"CLOAKOLDHP");
      if(nOldHP <= 0 && nCNew != 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oCloak));
        return;
      }

      //Set as New Cloak and Equipped
      if(nCurCHP == 0 && nCNew == 0)
      {
        //Set Up Cloak
        int nMult = 0;
        int nBonus = GetACBonus(oCloak);
        if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

        switch (nBonus)
        {
          case 0: nMult = 1; break;
          case 1: nMult = nAC1Mult; break;
          case 2: nMult = nAC2Mult; break;
          case 3: nMult = nAC3Mult; break;
          case 4: nMult = nAC4Mult; break;
          case 5: nMult = nAC5Mult; break;
        }

        if(nCloakType == 1)
        {
          int nTotal = nCHP * nMult;
          SetLocalInt(oCloak,"CLOAKHP",nTotal);
          SetLocalInt(oCloak,"CLOAKOLDHP",nTotal);
          SetLocalInt(oCloak,"CLOAKTYPE",nCloakType);
          SetLocalInt(oCloak,"CLOAKNEW",1);//Set to Used
          SetLocalInt(oCloak,"CLOAKEQUIP",1);
          SetLocalInt(oCloak,"CLOAKDAMAGE",nCLOAKDAMAGE);
          SetLocalInt(oCloak,"CLOAKDESTROY",nCLOAKDESTROY);
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oCloak,"CLOAKEQUIP",1);
      }
    }

//: CLOAK SECTION
/******************************************************************************/

/******************************************************************************/
//: BRACER SECTION

    //Now we check and set the Bracer Status
    if(nType == BASE_ITEM_BRACER)
    {
      object oBracer = oItem;
      int nBracerType = 1;
      int nBRACERDAMAGE  = GetLocalInt(oMod,"BRACERDAMAGE");
      int nBRACERDESTROY = GetLocalInt(oMod,"BRACERDESTROY");
      int nBHP          = GetLocalInt(oMod,"BRACERHP");
      int nLAMult       = GetLocalInt(oMod,"LAMULT");
      int nAC1Mult      = GetLocalInt(oMod,"AC1MULT");
      int nAC2Mult      = GetLocalInt(oMod,"AC2MULT");
      int nAC3Mult      = GetLocalInt(oMod,"AC3MULT");
      int nAC4Mult      = GetLocalInt(oMod,"AC4MULT");
      int nAC5Mult      = GetLocalInt(oMod,"AC5MULT");
      int nCurBHP       = GetLocalInt(oBracer,"BRACERHP");
      int nBNew         = GetLocalInt(oBracer,"BRACERNEW");

      //Check to see if the Bracer already needs repair
      int nOldHP = GetLocalInt(oBracer,"BRACEROLDHP");
      if(nOldHP <= 0 && nBNew != 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oBracer));
        return;
      }

      //Set as New Bracer and Equipped
      if(nCurBHP == 0 && nBNew == 0)
      {
        //Set Up Bracer
        int nMult = 0;
        int nBonus = GetACBonus(oBracer);
        if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

        switch (nBonus)
        {
          case 0: nMult = 1; break;
          case 1: nMult = nAC1Mult; break;
          case 2: nMult = nAC2Mult; break;
          case 3: nMult = nAC3Mult; break;
          case 4: nMult = nAC4Mult; break;
          case 5: nMult = nAC5Mult; break;
        }

        if(nBracerType == 1)
        {
          int nTotal = (nBHP * nLAMult) * nMult;
          SetLocalInt(oBracer,"BRACERHP",nTotal);
          SetLocalInt(oBracer,"BRACEROLDHP",nTotal);
          SetLocalInt(oBracer,"BRACERTYPE",nBracerType);
          SetLocalInt(oBracer,"BRACERNEW",1);//Set to Used
          SetLocalInt(oBracer,"BRACEREQUIP",1);
          SetLocalInt(oBracer,"BRACERDAMAGE",nBRACERDAMAGE);
          SetLocalInt(oBracer,"BRACERDESTROY",nBRACERDESTROY);
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oBracer,"BRACEREQUIP",1);
      }
    }

//: BRACER SECTION
/******************************************************************************/

/******************************************************************************/
//: BELT SECTION

    //Now we check and set the Belt Status
    if(nType == BASE_ITEM_BELT)
    {
      object oBelt = oItem;
      int nBeltType = 1;
      int nBELTDAMAGE  = GetLocalInt(oMod,"BELTDAMAGE");
      int nBELTDESTROY = GetLocalInt(oMod,"BELTDESTROY");
      int nLHP          = GetLocalInt(oMod,"BELTHP");
      int nCurLHP       = GetLocalInt(oBelt,"BELTHP");
      int nLNew         = GetLocalInt(oBelt,"BELTNEW");

      //Check to see if the Belt already needs repair
      int nOldHP = GetLocalInt(oBelt,"BELTOLDHP");
      if(nOldHP <= 0 && nLNew != 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oBelt));
        return;
      }

      //Set as New Belt and Equipped
      if(nCurLHP == 0 && nLNew == 0)
      {
        int nBonus = GetPersonalBonus(oBelt);
        if(nBonus == 0) nBonus = 1;
        if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

        //Set Up Belt
        if(nBeltType == 1)
        {
          int nTotal = nLHP * nBonus;
          SetLocalInt(oBelt,"BELTHP",nTotal);
          SetLocalInt(oBelt,"BELTOLDHP",nTotal);
          SetLocalInt(oBelt,"BELTTYPE",nBeltType);
          SetLocalInt(oBelt,"BELTNEW",1);//Set to Used
          SetLocalInt(oBelt,"BELTEQUIP",1);
          SetLocalInt(oBelt,"BELTDAMAGE",nBELTDAMAGE);
          SetLocalInt(oBelt,"BELTDESTROY",nBELTDESTROY);
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oBelt,"BELTEQUIP",1);
      }
    }

//: BELT SECTION
/******************************************************************************/

/******************************************************************************/
//: BOOTS SECTION

    //Now we check and set the Bracer Status
    if(nType == BASE_ITEM_BOOTS)
    {
      object oBoots = oItem;
      int nBootsType = 1;
      int nBOOTSDAMAGE  = GetLocalInt(oMod,"BOOTSDAMAGE");
      int nBOOTSDESTROY = GetLocalInt(oMod,"BOOTSDESTROY");

      int nBHP          = GetLocalInt(oMod,"BOOTSHP");
      int nAC1Mult      = GetLocalInt(oMod,"AC1MULT");
      int nAC2Mult      = GetLocalInt(oMod,"AC2MULT");
      int nAC3Mult      = GetLocalInt(oMod,"AC3MULT");
      int nAC4Mult      = GetLocalInt(oMod,"AC4MULT");
      int nAC5Mult      = GetLocalInt(oMod,"AC5MULT");
      int nCurBHP       = GetLocalInt(oBoots,"BOOTSHP");
      int nBNew         = GetLocalInt(oBoots,"BOOTSNEW");

      //Check to see if the Boots already needs repair
      int nOldHP = GetLocalInt(oBoots,"BOOTSOLDHP");
      if(nOldHP <= 0 && nBNew != 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oBoots));
        return;
      }

      //Set as New Boots and Equipped
      if(nCurBHP == 0 && nBNew == 0)
      {
        //Set Up Boots
        int nPersonal = GetPersonalBonus(oBoots);
        int nAC = GetACBonus(oBoots);
        int nBonus = nPersonal + nAC;
        if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

        if(nBonus > 0)
        {
          int nMult = 0;

          switch (nBonus)
          {
            case 0: nMult = 1; break;
            case 1: nMult = nAC1Mult; break;
            case 2: nMult = nAC2Mult; break;
            case 3: nMult = nAC3Mult; break;
            case 4: nMult = nAC4Mult; break;
            case 5: nMult = nAC5Mult; break;
          }

          if(nBootsType == 1)
          {
            int nTotal = nBHP * nMult;
            SetLocalInt(oBoots,"BOOTSHP",nTotal);
            SetLocalInt(oBoots,"BOOTSOLDHP",nTotal);
            SetLocalInt(oBoots,"BOOTSTYPE",nBootsType);
            SetLocalInt(oBoots,"BOOTSNEW",1);//Set to Used
            SetLocalInt(oBoots,"BOOTSEQUIP",1);
            SetLocalInt(oBoots,"BOOTSDAMAGE",nBOOTSDAMAGE);
            SetLocalInt(oBoots,"BOOTSDESTROY",nBOOTSDESTROY);
          }
        }
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oBoots,"BOOTSEQUIP",1);
      }
    }

//: BOOTS SECTION
/******************************************************************************/

    //ExecuteScript("ocr_pulses",oPC);

}
