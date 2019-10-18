////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Include File
//  ocr_include
//  by Don Anderson
//  dandersonru@msn.com
//
/*
Credits:
- Bioware...for Excellent Tools
- Robert Olsen (HunterAP) for Crafting Gloves
- CEP for Portions of their Crafting Scripts
- Invisible420 for the Color Codes
*/
//
////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_itemprop"
#include "oai_inc_weapstat"

// Color Variables
string RED = "<cσ  >";
string BLUE = "<c  σ>";
string GRAY = "<c°°°>";
string GREEN = "<c σ >";
string WHITE = "<cσσσ>";
string CYAN = "<c σσ>";
string YELLOW = "<cσσ >";
string BLUISHG = "<c °°>";
string BLUISHR = "<c °σ>";

const int IP_CONST_DAMAGERESIST_1 = 1;

void ActivateSwitch()
{
   DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
   DelayCommand(2.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}

/******************************************************************************/
//: INTEGERS

int GetIsEnhanced(object oItem)
{
    if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS)) return TRUE;
    else if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_RESISTANCE)) return TRUE;
    else return FALSE;
}

int GetIsKeen(object oItem)
{
    if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_KEEN)) return TRUE;
    else return FALSE;
}

int GetPersonalBonus(object oItem)
{
    itemproperty ipLoop = GetFirstItemProperty(oItem);
    int nBonusCheck = 0;int nIP = 0;int nAT = FALSE;
    while (GetIsItemPropertyValid(ipLoop))
    {
      nIP = GetItemPropertyType(ipLoop);
      if(nIP == ITEM_PROPERTY_ABILITY_BONUS) nAT = TRUE;
      else if(nIP == ITEM_PROPERTY_AC_BONUS) nAT = FALSE;
      else if(nIP == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP) nAT = FALSE;
      else if(nIP == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE) nAT = FALSE;
      else if(nIP == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP) nAT = FALSE;
      else if(nIP == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT) nAT = FALSE;
      else nAT = FALSE;

      if(nAT == TRUE && GetItemPropertySubType(ipLoop) == IP_CONST_ABILITY_STR)
      {
        nBonusCheck = nBonusCheck + (GetItemPropertyCostTableValue(ipLoop));
      }

      if(nAT == TRUE && GetItemPropertySubType(ipLoop) == IP_CONST_ABILITY_DEX)
      {
        nBonusCheck = nBonusCheck + (GetItemPropertyCostTableValue(ipLoop));
      }

      if(nAT == TRUE && GetItemPropertySubType(ipLoop) == IP_CONST_ABILITY_CON)
      {
        nBonusCheck = nBonusCheck + (GetItemPropertyCostTableValue(ipLoop));
      }

      if(nAT == TRUE && GetItemPropertySubType(ipLoop) == IP_CONST_ABILITY_INT)
      {
        nBonusCheck = nBonusCheck + (GetItemPropertyCostTableValue(ipLoop));
      }

      if(nAT == TRUE && GetItemPropertySubType(ipLoop) == IP_CONST_ABILITY_WIS)
      {
        nBonusCheck = nBonusCheck + (GetItemPropertyCostTableValue(ipLoop));
      }

      if(nAT == TRUE && GetItemPropertySubType(ipLoop) == IP_CONST_ABILITY_CHA)
      {
        nBonusCheck = nBonusCheck + (GetItemPropertyCostTableValue(ipLoop));
      }

      ipLoop = GetNextItemProperty(oItem);
    }

    if(nBonusCheck > 0) return nBonusCheck;
    else return 0;
}

int GetDamageBonus(object oItem, int nProp)
{
    int nR = 0; int nCT; int nCTV;
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    int nBonusCheck = 0;
    while (GetIsItemPropertyValid(ipLoop))
    {
      nCT = GetItemPropertyCostTable(ipLoop);
      nCTV = GetItemPropertyCostTableValue(ipLoop);

      if(nCT == 4 && GetItemPropertySubType(ipLoop) == nProp)
      {
        if(nCTV == 1 || nCTV == 6) nR = 1;
        if(nCTV == 2 || nCTV == 7) nR = 2;
        if(nCTV == 3 || nCTV == 8) nR = 3;
        if(nCTV == 4 || nCTV == 12) nR = 4;
        if(nCTV == 5 || nCTV == 9) nR = 5;
        if(nCTV == 16 || nCTV == 14) nR = 6;
        if(nCTV == 17 || nCTV == 10) nR = 7;
        if(nCTV == 18 || nCTV == 11) nR = 8;
        if(nCTV == 19 || nCTV == 13) nR = 9;
        if(nCTV == 20 || nCTV == 15) nR = 10;
        if(nCTV == 21) nR = 11;
        if(nCTV == 22) nR = 12;
        if(nCTV == 23) nR = 13;
        if(nCTV == 24) nR = 14;
        if(nCTV == 25) nR = 15;
        if(nCTV == 26) nR = 16;
        if(nCTV == 27) nR = 17;
        if(nCTV == 28) nR = 18;
        if(nCTV == 29) nR = 19;
        if(nCTV == 30) nR = 20;
      }
      ipLoop=GetNextItemProperty(oItem);
    }
    if(nR > 0) return nR;
    else return 0;
}

int GetDamageResistance(object oItem, int nProp)
{
    int nR = 0; int nCT; int nCTV;
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    int nBonusCheck = 0;
    while (GetIsItemPropertyValid(ipLoop))
    {
      nCT = GetItemPropertyCostTable(ipLoop);
      nCTV = GetItemPropertyCostTableValue(ipLoop);

      if(nCT == 7 && GetItemPropertySubType(ipLoop) == nProp)
      {
        if(nCTV == 11) nR = 1;
        if(nCTV == 12) nR = 2;
        if(nCTV == 13) nR = 3;
        if(nCTV == 14) nR = 4;
        if(nCTV == 1 || nCTV == 15) nR = 5;
        if(nCTV == 16) nR = 6;
        if(nCTV == 17) nR = 7;
        if(nCTV == 18) nR = 8;
        if(nCTV == 19) nR = 9;
        if(nCTV == 2 || nCTV == 20) nR = 10;
        if(nCTV == 3) nR = 15;
        if(nCTV == 4) nR = 20;
        if(nCTV == 5) nR = 25;
        if(nCTV == 6) nR = 30;
        if(nCTV == 7) nR = 35;
        if(nCTV == 8) nR = 40;
        if(nCTV == 9) nR = 45;
        if(nCTV == 10) nR = 50;
      }
      ipLoop=GetNextItemProperty(oItem);
    }
    if(nR > 0) return nR;
    else return 0;
}

int GetAcidDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_ACID);
  return nR;
}

int GetAcidDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_ACID);
  return nR;
}

int GetColdDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_COLD);
  return nR;
}

int GetColdDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_COLD);
  return nR;
}

int GetDivineDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_DIVINE);
  return nR;
}

int GetDivineDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_DIVINE);
  return nR;
}

int GetElectricDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_ELECTRICAL);
  return nR;
}

int GetElectricDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_ELECTRICAL);
  return nR;
}

int GetFireDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_FIRE);
  return nR;
}

int GetFireDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_FIRE);
  return nR;
}

int GetMagicalDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_MAGICAL);
  return nR;
}

int GetMagicalDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_MAGICAL);
  return nR;
}

int GetNegativeDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_NEGATIVE);
  return nR;
}

int GetNegativeDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_NEGATIVE);
  return nR;
}

int GetPositiveDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_POSITIVE);
  return nR;
}

int GetPositiveDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_POSITIVE);
  return nR;
}

int GetSonicDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_SONIC);
  return nR;
}

int GetSonicDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_SONIC);
  return nR;
}

int GetBludgDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_BLUDGEONING);
  return nR;
}

int GetBludgDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_BLUDGEONING);
  return nR;
}

int GetPierceDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_PIERCING);
  return nR;
}

int GetPierceDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_PIERCING);
  return nR;
}

int GetSlashDamageBonus(object oItem)
{
  int nR = GetDamageBonus(oItem, IP_CONST_DAMAGETYPE_SLASHING);
  return nR;
}

int GetSlashDamageResistance(object oItem)
{
  int nR = GetDamageResistance(oItem, IP_CONST_DAMAGETYPE_SLASHING);
  return nR;
}

int GetSaveBonus(object oItem)
{
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    int nBonusCheck = 0;
    while (GetIsItemPropertyValid(ipLoop))
    {
      if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_SAVING_THROW_BONUS)
      {
        nBonusCheck = nBonusCheck + GetItemPropertyCostTableValue(ipLoop);
      }
      ipLoop=GetNextItemProperty(oItem);
    }
    if(nBonusCheck > 0) return nBonusCheck;
    else return 0;
}

int GetACBase(object oItem)
{
  int nAC = GetItemACValue(oItem);
  int nBonus = IPGetWeaponEnhancementBonus(oItem, ITEM_PROPERTY_AC_BONUS);
  int nBaseAC = nAC - nBonus;

  return nBaseAC;
}

int GetACBonus(object oItem)
{
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    int nBonusCheck = 0;
    while(GetIsItemPropertyValid(ipLoop))
    {
      if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_AC_BONUS)
      {
        nBonusCheck = nBonusCheck + GetItemPropertyCostTableValue(ipLoop);
      }
      ipLoop=GetNextItemProperty(oItem);
    }
    if(nBonusCheck > 0) return nBonusCheck;
    else return 0;
}

int GetABBonus(object oItem)
{
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    int nBonusCheck = 0;
    while (GetIsItemPropertyValid(ipLoop))
    {
      if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_ATTACK_BONUS)
      {
        nBonusCheck = nBonusCheck + GetItemPropertyCostTableValue(ipLoop);
      }

      if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_ENHANCEMENT_BONUS)
      {
        nBonusCheck = nBonusCheck + GetItemPropertyCostTableValue(ipLoop);
      }
      ipLoop=GetNextItemProperty(oItem);
    }
    if(nBonusCheck > 0) return nBonusCheck;
    else return 0;
}

int GetFutureACBonus(object oPC, int nValue)
{
  object oMod = GetModule();
  int nMax = GetLocalInt(oMod,"ACMAX");
  int nAC = GetLocalInt(oPC,"DUSTYROSE");

  int nCheck = (nValue + nAC) - nAC;
  if(nCheck > nMax) return TRUE;

  return FALSE;
}

int GetFutureEBBonus(object oPC, int nValue)
{
  object oMod = GetModule();
  int nMax = GetLocalInt(oMod,"ABMAX");
  int nAB = GetLocalInt(oPC,"DIAMOND");

  int nCheck = (nValue + nAB) - nAB;
  if(nCheck > nMax) return TRUE;

  return FALSE;
}

int GetFutureABBonus(object oPC, int nValue)
{
  object oMod = GetModule();
  int nMax = GetLocalInt(oMod,"ABMAX");
  int nAB = GetLocalInt(oPC,"DIAMOND");

  int nCheck = (nValue + nAB) - nAB;
  if(nCheck > nMax) return TRUE;

  return FALSE;
}

int GetFutureDRBonus(object oPC, int nValue)
{
  object oMod = GetModule();
  int nMax = GetLocalInt(oMod,"DREMAX");
  int nAcid      = GetLocalInt(oPC,"ACIDFLASK");
  int nCold      = GetLocalInt(oPC,"COLDSTONE");
  int nDivine    = GetLocalInt(oPC,"HOLYWATER");
  int nElectric  = GetLocalInt(oPC,"QUARTZ");
  int nFire      = GetLocalInt(oPC,"ALCHEMISTFIRE");
  int nNegative  = GetLocalInt(oPC,"SKELETON");
  int nSonic     = GetLocalInt(oPC,"THUNDERSTONE");

  int nCheck = nValue + nAcid + nCold + nDivine + nElectric + nFire + nNegative + nSonic;
  if(nCheck > nMax) return TRUE;

  return FALSE;
}

int GetFutureDamageBonus(object oPC, int nValue)
{
  object oMod = GetModule();
  int nMax = GetLocalInt(oMod,"DBEMAX");
  int nAcid      = GetLocalInt(oPC,"ACIDFLASK");
  int nCold      = GetLocalInt(oPC,"COLDSTONE");
  int nDivine    = GetLocalInt(oPC,"HOLYWATER");
  int nElectric  = GetLocalInt(oPC,"QUARTZ");
  int nFire      = GetLocalInt(oPC,"ALCHEMISTFIRE");
  int nNegative  = GetLocalInt(oPC,"SKELETON");
  int nSonic     = GetLocalInt(oPC,"THUNDERSTONE");

  int nCheck = nValue + nAcid + nCold + nDivine + nElectric + nFire + nNegative + nSonic;
  if(nCheck > nMax) return TRUE;

  return FALSE;
}

int GetFutureElemComboBonus(object oPC, object oItem)
{
  object oMod = GetModule();
  int nMax = GetLocalInt(oMod,"TMAX");
  int nAcid      = GetLocalInt(oPC,"ACIDFLASK") + GetAcidDamageBonus(oItem);
  int nCold      = GetLocalInt(oPC,"COLDSTONE") + GetColdDamageBonus(oItem);
  int nDivine    = GetLocalInt(oPC,"HOLYWATER") + GetDivineDamageBonus(oItem);
  int nElectric  = GetLocalInt(oPC,"QUARTZ") + GetElectricDamageBonus(oItem);
  int nFire      = GetLocalInt(oPC,"ALCHEMISTFIRE") + GetFireDamageBonus(oItem);
  int nNegative  = GetLocalInt(oPC,"SKELETON") + GetNegativeDamageBonus(oItem);
  int nSonic     = GetLocalInt(oPC,"THUNDERSTONE") + GetSonicDamageBonus(oItem);

  int nElem = 0;
  if(nAcid > 0) nElem = nElem + 1;
  if(nCold > 0) nElem = nElem + 1;
  if(nDivine > 0) nElem = nElem + 1;
  if(nElectric > 0) nElem = nElem + 1;
  if(nFire > 0) nElem = nElem + 1;
  if(nNegative > 0) nElem = nElem + 1;
  if(nSonic > 0) nElem = nElem + 1;

  if(nElem > nMax) return TRUE;

  return FALSE;
}

int GetFuturePBonus(object oPC, int nValue)
{
  object oMod = GetModule();
  int nMax = GetLocalInt(oMod,"PMAX");
  int nSTR       = GetLocalInt(oPC,"PALEBLUE");
  int nDEX       = GetLocalInt(oPC,"DEEPRED");
  int nCON       = GetLocalInt(oPC,"PINK");
  int nINT       = GetLocalInt(oPC,"SANDBLUE");
  int nWIS       = GetLocalInt(oPC,"BLUE");
  int nCHA       = GetLocalInt(oPC,"PANDGREEN");

  int nCheck = nValue + nSTR + nDEX + nCON + nINT + nWIS + nCHA;
  if(nCheck > nMax) return TRUE;

  return FALSE;
}

void AddElemDamage(object oItem, int nElem, int nVal)
{
  int nAdd = IP_CONST_DAMAGEBONUS_1d4;
  if(nVal > 10) nAdd = IP_CONST_DAMAGEBONUS_2d12;
  else
  {
    switch(nVal)
    {
      case 1: nAdd = IP_CONST_DAMAGEBONUS_1d4; break;
      case 2: nAdd = IP_CONST_DAMAGEBONUS_1d6; break;
      case 3: nAdd = IP_CONST_DAMAGEBONUS_1d8; break;
      case 4: nAdd = IP_CONST_DAMAGEBONUS_2d4; break;
      case 5: nAdd = IP_CONST_DAMAGEBONUS_1d10; break;
      case 6: nAdd = IP_CONST_DAMAGEBONUS_1d12; break;
      case 7: nAdd = IP_CONST_DAMAGEBONUS_2d6; break;
      case 8: nAdd = IP_CONST_DAMAGEBONUS_2d8; break;
      case 9: nAdd = IP_CONST_DAMAGEBONUS_2d10; break;
      case 10: nAdd = IP_CONST_DAMAGEBONUS_2d12; break;
    }
  }

  IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(nElem, nAdd), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}

void AddElemResistance(object oItem, int nElem, int nVal)
{
  int nDRSys = GetLocalInt(GetModule(),"DRSYS");
  if(nDRSys == 1)
  {
    int nMult = IP_CONST_DAMAGERESIST_1;
    int nAdd = nVal * nMult;

    IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(nElem, nAdd), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
  }
  else
  {
    int nMult = IP_CONST_DAMAGERESIST_5;
    int nAdd = nVal * nMult;

    IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(nElem, nAdd), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
  }
}

void AddBPSDR(object oItem, int nB, int nP, int nS)
{
  if(nB > 0)IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_BLUDGEONING, ((nB * IP_CONST_DAMAGERESIST_1) + 10)), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
  if(nP > 0)IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_PIERCING, ((nP * IP_CONST_DAMAGERESIST_1) + 10)), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
  if(nS > 0)IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_SLASHING, ((nS * IP_CONST_DAMAGERESIST_1) + 10)), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}

void AddArmorDR(object oItem, int nDR)
{
  string sAName = GetName(oItem);
  int nArmor    = GetItemACValue(oItem) - 10;
  int nPlate    = FindSubString(sAName,"Plate");
  int nBanded   = FindSubString(sAName,"Banded");
  int nLamellar = FindSubString(sAName,"Lamellar");
  int nSplint   = FindSubString(sAName,"Splint");
  int nScale    = FindSubString(sAName,"Scale");
  int nChain    = FindSubString(sAName,"Chain");
  int nMithral  = FindSubString(sAName,"Mithral");
  int nMithril  = FindSubString(sAName,"Mithril");
  int nLeather  = FindSubString(sAName,"Leather");
  int nHide     = FindSubString(sAName,"Hide");
  int nStudded  = FindSubString(sAName,"Studded");

  if(nPlate != -1)
  {
    int nBMax = 10;
    int nPMax = 10;
    int nSMax = 10;

    //Bludgeoning DR
    int nB = nDR;
    if(nDR > nBMax) nB = nBMax;

    //Piercing DR
    int nP = nDR;
    if(nDR > nPMax) nP = nPMax;

    //Slashing DR
    int nS = nDR;
    if(nDR > nSMax) nS = nSMax;

    AddBPSDR(oItem,nB,nP,nS);

  }
  else if(nBanded != -1 || nLamellar != -1)
  {
    int nBMax = 10;
    int nPMax = 6;
    int nSMax = 8;

    //Bludgeoning DR
    int nB = nDR;
    if(nDR > nBMax) nB = nBMax;

    //Piercing DR
    int nP = nDR;
    if(nDR > nPMax) nP = nPMax;

    //Slashing DR
    int nS = nDR;
    if(nDR > nSMax) nS = nSMax;

    AddBPSDR(oItem,nB,nP,nS);
  }
  else if(nSplint != -1)
  {
    int nBMax = 8;
    int nPMax = 8;
    int nSMax = 6;

    //Bludgeoning DR
    int nB = nDR;
    if(nDR > nBMax) nB = nBMax;

    //Piercing DR
    int nP = nDR;
    if(nDR > nPMax) nP = nPMax;

    //Slashing DR
    int nS = nDR;
    if(nDR > nSMax) nS = nSMax;

    AddBPSDR(oItem,nB,nP,nS);
  }
  else if(nScale != -1 || nMithril != -1 || nMithral != -1)
  {
    int nBMax = 8;
    int nPMax = 8;
    int nSMax = 6;

    //Bludgeoning DR
    int nB = nDR;
    if(nDR > nBMax) nB = nBMax;

    //Piercing DR
    int nP = nDR;
    if(nDR > nPMax) nP = nPMax;

    //Slashing DR
    int nS = nDR;
    if(nDR > nSMax) nS = nSMax;

    AddBPSDR(oItem,nB,nP,nS);
  }
  else if(nChain != -1)
  {
    int nBMax = 8;
    int nPMax = 4;
    int nSMax = 8;

    //Bludgeoning DR
    int nB = nDR;
    if(nDR > nBMax) nB = nBMax;

    //Piercing DR
    int nP = nDR;
    if(nDR > nPMax) nP = nPMax;

    //Slashing DR
    int nS = nDR;
    if(nDR > nSMax) nS = nSMax;

    AddBPSDR(oItem,nB,nP,nS);
  }
  else if(nStudded != -1)
  {
    int nBMax = 6;
    int nPMax = 3;
    int nSMax = 4;

    //Bludgeoning DR
    int nB = nDR;
    if(nDR > nBMax) nB = nBMax;

    //Piercing DR
    int nP = nDR;
    if(nDR > nPMax) nP = nPMax;

    //Slashing DR
    int nS = nDR;
    if(nDR > nSMax) nS = nSMax;

    AddBPSDR(oItem,nB,nP,nS);

  }
  else if(nHide != -1)
  {
    int nBMax = 4;
    int nPMax = 1;
    int nSMax = 4;

    //Bludgeoning DR
    int nB = nDR;
    if(nDR > nBMax) nB = nBMax;

    //Piercing DR
    int nP = nDR;
    if(nDR > nPMax) nP = nPMax;

    //Slashing DR
    int nS = nDR;
    if(nDR > nSMax) nS = nSMax;

    AddBPSDR(oItem,nB,nP,nS);
  }
  else if(nLeather != -1)
  {
    int nBMax = 4;
    int nPMax = 0;
    int nSMax = 4;

    //Bludgeoning DR
    int nB = nDR;
    if(nDR > nBMax) nB = nBMax;

    //Piercing DR
    int nP = nDR;
    if(nDR > nPMax) nP = nPMax;

    //Slashing DR
    int nS = nDR;
    if(nDR > nSMax) nS = nSMax;

    AddBPSDR(oItem,nB,nP,nS);
  }
}

void AddArmorAC(object oItem, int nAC)
{
  IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nAC), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}

int GetMassBonus(object oItem, int nProp)
{
    int nR = 0; int nCT; int nCTV;
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    int nBonusCheck = 0;
    while (GetIsItemPropertyValid(ipLoop))
    {
      nCT = GetItemPropertyCostTable(ipLoop);
      nCTV = GetItemPropertyCostTableValue(ipLoop);

      if(nCT == 4 && GetItemPropertySubType(ipLoop) < 1)
      {
        if(nCTV == 1 || nCTV == 6) nR = 1;
        if(nCTV == 2 || nCTV == 7) nR = 2;
        if(nCTV == 3 || nCTV == 8) nR = 3;
        if(nCTV == 4 || nCTV == 12) nR = 4;
        if(nCTV == 5 || nCTV == 9) nR = 5;
        if(nCTV == 16 || nCTV == 14) nR = 6;
        if(nCTV == 17 || nCTV == 10) nR = 7;
        if(nCTV == 18 || nCTV == 11) nR = 8;
        if(nCTV == 19 || nCTV == 13) nR = 9;
        if(nCTV == 20 || nCTV == 15) nR = 10;
        if(nCTV == 21) nR = 11;
        if(nCTV == 22) nR = 12;
        if(nCTV == 23) nR = 13;
        if(nCTV == 24) nR = 14;
        if(nCTV == 25) nR = 15;
        if(nCTV == 26) nR = 16;
        if(nCTV == 27) nR = 17;
        if(nCTV == 28) nR = 18;
        if(nCTV == 29) nR = 19;
        if(nCTV == 30) nR = 20;
      }
      ipLoop=GetNextItemProperty(oItem);
    }
    if(nR > 0) return nR;
    else return 0;
}

int GetMassCritical(object oItem)
{
  int nR = GetMassBonus(oItem, ITEM_PROPERTY_MASSIVE_CRITICALS);
  return nR;
}

void AddMassCritical(object oItem, int nVal)
{
  int nAdd = IP_CONST_DAMAGEBONUS_1d4;
  if(nVal > 9) nAdd = IP_CONST_DAMAGEBONUS_2d12;
  else
  {
    switch(nVal)
    {
      case 0: nAdd = IP_CONST_DAMAGEBONUS_1d4; break;
      case 1: nAdd = IP_CONST_DAMAGEBONUS_1d6; break;
      case 2: nAdd = IP_CONST_DAMAGEBONUS_1d8; break;
      case 3: nAdd = IP_CONST_DAMAGEBONUS_2d4; break;
      case 4: nAdd = IP_CONST_DAMAGEBONUS_1d10; break;
      case 5: nAdd = IP_CONST_DAMAGEBONUS_1d12; break;
      case 6: nAdd = IP_CONST_DAMAGEBONUS_2d6; break;
      case 7: nAdd = IP_CONST_DAMAGEBONUS_2d8; break;
      case 8: nAdd = IP_CONST_DAMAGEBONUS_2d10; break;
      case 9: nAdd = IP_CONST_DAMAGEBONUS_2d12; break;
    }
  }

  IPSafeAddItemProperty(oItem, ItemPropertyMassiveCritical(nAdd), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}

int GetNumberOfArmorAppearances(int nPart)
{
  switch (nPart)
  {
    case ITEM_APPR_ARMOR_MODEL_RFOOT:
    case ITEM_APPR_ARMOR_MODEL_LFOOT:
    case ITEM_APPR_ARMOR_MODEL_RSHIN:
    case ITEM_APPR_ARMOR_MODEL_LSHIN:
    case ITEM_APPR_ARMOR_MODEL_LTHIGH:
    case ITEM_APPR_ARMOR_MODEL_RTHIGH:
    case ITEM_APPR_ARMOR_MODEL_PELVIS:
    case ITEM_APPR_ARMOR_MODEL_TORSO:
    case ITEM_APPR_ARMOR_MODEL_BELT:
    case ITEM_APPR_ARMOR_MODEL_NECK:
    case ITEM_APPR_ARMOR_MODEL_RFOREARM:
    case ITEM_APPR_ARMOR_MODEL_LFOREARM:
    case ITEM_APPR_ARMOR_MODEL_RBICEP:
    case ITEM_APPR_ARMOR_MODEL_LBICEP:
    case ITEM_APPR_ARMOR_MODEL_RSHOULDER:
    case ITEM_APPR_ARMOR_MODEL_LSHOULDER:
    case ITEM_APPR_ARMOR_MODEL_RHAND:
    case ITEM_APPR_ARMOR_MODEL_LHAND:
    case ITEM_APPR_ARMOR_MODEL_ROBE:  return 255;
  }

  return 0;
}

string ListReverse(string s)
{
  string sCache;
  int n;
  int l = GetStringLength(s);
  s = GetSubString(s, 1, l);
  while (s!="")
  {
    //Take string upto next seperator and put this in front of cache
    n = FindSubString(s, ":")+1;
    sCache = GetStringLeft(s, n) + sCache;
    s = GetSubString(s, n, l);
  }
  return ":"+sCache;
}

string PreReadArmorACList(string sAC)
{
  // pick the right 2da to read the parts from
  string s2DA = "parts_chest";
  string sCache= ":";
  string sLine;

  int nMax = GetNumberOfArmorAppearances(ITEM_APPR_ARMOR_MODEL_TORSO);
  int n=1;
  sAC = GetStringLeft(sAC, 1);
  while(n <= nMax)
  {
    //Verify validity of the ID and add to the list
    sLine = Get2DAString(s2DA, "ACBONUS", n);
    if(GetStringLeft(sLine, 1) == sAC)
    {
      sCache+= IntToString(n)+":";
    }
    n++;
  }

  // Store the list in a modulestring, once normal, once reversed, both with ID 0 added as first index for cycling
  SetLocalString(GetModule(), "IDPreReadAC_"+GetStringLeft(sAC,1), sCache);
  SetLocalString(GetModule(), "IDPreReadACR_"+GetStringLeft(sAC,1), ListReverse(sCache));

  return sCache;
}

string PreReadArmorPartList(int nPart)
{
  // pick the right 2da to read the parts from
  string s2DA = "parts_";
  switch (nPart)
  {
    case ITEM_APPR_ARMOR_MODEL_LBICEP:
    case ITEM_APPR_ARMOR_MODEL_RBICEP: s2DA+= "bicep"; break;
    case ITEM_APPR_ARMOR_MODEL_LFOOT:
    case ITEM_APPR_ARMOR_MODEL_RFOOT: s2DA+= "foot"; break;
    case ITEM_APPR_ARMOR_MODEL_LFOREARM:
    case ITEM_APPR_ARMOR_MODEL_RFOREARM: s2DA+= "forearm"; break;
    case ITEM_APPR_ARMOR_MODEL_LHAND:
    case ITEM_APPR_ARMOR_MODEL_RHAND: s2DA+= "hand"; break;
    case ITEM_APPR_ARMOR_MODEL_LSHIN:
    case ITEM_APPR_ARMOR_MODEL_RSHIN: s2DA+= "shin"; break;
    case ITEM_APPR_ARMOR_MODEL_LSHOULDER:
    case ITEM_APPR_ARMOR_MODEL_RSHOULDER: s2DA+= "shoulder"; break;
    case ITEM_APPR_ARMOR_MODEL_LTHIGH:
    case ITEM_APPR_ARMOR_MODEL_RTHIGH: s2DA+= "legs"; break;
    case ITEM_APPR_ARMOR_MODEL_NECK: s2DA+= "neck"; break;
    case ITEM_APPR_ARMOR_MODEL_BELT: s2DA+= "belt"; break;
    case ITEM_APPR_ARMOR_MODEL_PELVIS: s2DA+= "pelvis"; break;
    case ITEM_APPR_ARMOR_MODEL_ROBE: s2DA+= "robe"; break;
  }

  string sCache= ":";
  string sLine;

  int nMax = GetNumberOfArmorAppearances(nPart);
  int n=1;
  while(n<=nMax)
  {
    // Verify validity of the ID and add to the list
    sLine = Get2DAString(s2DA, "ACBONUS", n);
    if(sLine!="")
    {
      sCache+= IntToString(n)+":";
    }
    n++;
  }

  // Store the list in a modulestring, once normal, once reversed, both with ID 0 added as first index for cycling
  SetLocalString(GetModule(), "IDPreRead_"+IntToString(nPart), ":0" + sCache);
  SetLocalString(GetModule(), "IDPreReadR_"+IntToString(nPart), ":0" + ListReverse(sCache));
  return sCache;
}

void RemakeArmor(object oPC, int nMode)
{
  int nSlot = INVENTORY_SLOT_CHEST;
  object oItem = GetItemInSlot(nSlot, oPC);
  int nSection = GetLocalInt(oPC, "CR_PART");
  int nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nSection);
  object oNew;
  string sPreRead;

  if(nSection == ITEM_APPR_ARMOR_MODEL_TORSO)
  {
    string sAC = Get2DAString("parts_chest", "ACBONUS", nCurrApp);
    sPreRead = GetLocalString(GetModule(), "IDPreReadAC_"+GetStringLeft(sAC,1));
    if(sPreRead=="") sPreRead = PreReadArmorACList(sAC);
    if(nMode == 1) sPreRead = GetLocalString(GetModule(), "IDPreReadACR_"+GetStringLeft(sAC,1));
  }
  else
  {
    sPreRead = GetLocalString(GetModule(), "IDPreRead_"+IntToString(nSection));
    if(sPreRead=="") sPreRead = PreReadArmorPartList(nSection);
    if(nMode == 1) sPreRead = GetLocalString(GetModule(), "IDPreReadR_"+IntToString(nSection));
  }

  string sID;
  string sCurrApp = IntToString(nCurrApp);
  int n = FindSubString(sPreRead, ":"+sCurrApp+":");
  sID = GetSubString(sPreRead, n+GetStringLength(sCurrApp)+2, 5);
  n = FindSubString(sID, ":");
  sID = GetStringLeft(sID, n);
  if(sID=="" && nSection == ITEM_APPR_ARMOR_MODEL_TORSO)
  {
    sID = GetSubString(sPreRead, 1, 5);
    n = FindSubString(sID, ":");
    sID = GetStringLeft(sID, n);
  }
  nCurrApp = StringToInt(sID);

  oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nSection, nCurrApp, TRUE);

  if(GetIsObjectValid(oNew))
  {
    SetCommandable(TRUE, oPC);
    DestroyObject(oItem);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
  }
}

void RemakeSym(object oPC)
{
  int nSlot = INVENTORY_SLOT_CHEST;
  object oItem = GetItemInSlot(nSlot, oPC);
  int nSection = GetLocalInt(oPC, "CR_PART");
  object oNew;

  int nCur; int nNew;
  switch(nSection)
  {
    case ITEM_APPR_ARMOR_MODEL_RBICEP:    {nCur = ITEM_APPR_ARMOR_MODEL_LBICEP; break;}
    case ITEM_APPR_ARMOR_MODEL_RFOOT:     {nCur = ITEM_APPR_ARMOR_MODEL_LFOOT; break;}
    case ITEM_APPR_ARMOR_MODEL_RFOREARM:  {nCur = ITEM_APPR_ARMOR_MODEL_LFOREARM; break;}
    case ITEM_APPR_ARMOR_MODEL_RHAND:     {nCur = ITEM_APPR_ARMOR_MODEL_LHAND; break;}
    case ITEM_APPR_ARMOR_MODEL_RSHIN:     {nCur = ITEM_APPR_ARMOR_MODEL_LSHIN; break;}
    case ITEM_APPR_ARMOR_MODEL_RSHOULDER: {nCur = ITEM_APPR_ARMOR_MODEL_LSHOULDER; break;}
    case ITEM_APPR_ARMOR_MODEL_RTHIGH:    {nCur = ITEM_APPR_ARMOR_MODEL_LTHIGH; break;}
    case ITEM_APPR_ARMOR_MODEL_LBICEP:    {nCur = ITEM_APPR_ARMOR_MODEL_RBICEP; break;}
    case ITEM_APPR_ARMOR_MODEL_LFOOT:     {nCur = ITEM_APPR_ARMOR_MODEL_RFOOT; break;}
    case ITEM_APPR_ARMOR_MODEL_LFOREARM:  {nCur = ITEM_APPR_ARMOR_MODEL_RFOREARM; break;}
    case ITEM_APPR_ARMOR_MODEL_LHAND:     {nCur = ITEM_APPR_ARMOR_MODEL_RHAND; break;}
    case ITEM_APPR_ARMOR_MODEL_LSHIN:     {nCur = ITEM_APPR_ARMOR_MODEL_RSHIN; break;}
    case ITEM_APPR_ARMOR_MODEL_LSHOULDER: {nCur = ITEM_APPR_ARMOR_MODEL_RSHOULDER; break;}
    case ITEM_APPR_ARMOR_MODEL_LTHIGH:    {nCur = ITEM_APPR_ARMOR_MODEL_RTHIGH; break;}

    default:  return;
  }

  nNew = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nCur);
  oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nSection, nNew, TRUE);

  if(GetIsObjectValid(oNew))
  {
    SetCommandable(TRUE, oPC);
    DestroyObject(oItem);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
  }
}

void ColorItem(object oPC)
{
  int nSlot = GetLocalInt(oPC, "ItemToDye");
  object oItem = GetItemInSlot(nSlot, oPC);
  int nMatDye = GetLocalInt(oPC, "MaterialToDye");
  int nCGroup = GetLocalInt(oPC, "ColorGroup");
  int nCDye = GetLocalInt(oPC, "ColorToDye");

  int nColor = (nCGroup * 8) + nCDye;

  if(GetIsObjectValid(oItem))
  {
    // Copy Item to the Chest
    object oChest = GetObjectByTag("OCR_Backup");
    object oInChest = CopyItem(oItem, oChest, TRUE);
    DestroyObject(oItem);

    object oDyedItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nMatDye, nColor, TRUE);
    DestroyObject(oInChest);

    // Copy the Item Back to the PC
    object oOnPC = CopyItem(oDyedItem, oPC, TRUE);
    DestroyObject(oDyedItem);

    DelayCommand(0.5f, AssignCommand(oPC, ActionEquipItem(oOnPC, nSlot)));
  }
}

void ColorPC(object oPC, int nMode, int nChannel)
{
  int nCColor = GetColor(oPC,nChannel);

  int nNColor;

  //Next Color
  if(nMode == 0)
  {
    nNColor = nCColor + 1;
    if(nNColor > 175) nNColor = 0;
    SetColor(oPC,nChannel,nNColor);
  }

  //Previous Color
  if(nMode == 1)
  {
    nNColor = nCColor - 1;
    if(nNColor < 0) nNColor = 175;
    SetColor(oPC,nChannel,nNColor);
  }
}

void ChangeHead(object oPC, int nMode)
{
  int nHead = GetCreatureBodyPart(CREATURE_PART_HEAD,oPC);
  int nNext = nHead;

  int nRace = GetRacialType(oPC);
  int nGender = GetGender(oPC);

  //Dwarf
  if(nRace == RACIAL_TYPE_DWARF)
  {
    //Females 1-27
    if(nGender == GENDER_FEMALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 27;
      else if(nHead == 27 && nMode == 0) nNext = 1;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }

    //Males 1-28
    if(nGender == GENDER_MALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 28;
      else if(nHead == 28 && nMode == 0) nNext = 1;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }
  }

  //Elf
  if(nRace == RACIAL_TYPE_ELF)
  {
    //Elf Females 1-49, 101-103, 111, 112, 122, 179-186
    if(nGender == GENDER_FEMALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 186;
      else if(nHead == 186 && nMode == 0) nNext = 1;
      else if(nHead == 49 && nMode == 0) nNext = 101;
      else if(nHead == 101 && nMode == 1) nNext = 49;
      else if(nHead == 103 && nMode == 0) nNext = 111;
      else if(nHead == 111 && nMode == 1) nNext = 103;
      else if(nHead == 112 && nMode == 0) nNext = 122;
      else if(nHead == 122 && nMode == 1) nNext = 112;
      else if(nHead == 122 && nMode == 0) nNext = 179;
      else if(nHead == 179 && nMode == 1) nNext = 122;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }

    //Elf Males 1-39
    if(nGender == GENDER_MALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 39;
      else if(nHead == 39 && nMode == 0) nNext = 1;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }
  }

  //Halfling
  if(nRace == RACIAL_TYPE_HALFLING)
  {
    //Halfling Female 1-15, 161-172
    if(nGender == GENDER_FEMALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 172;
      else if(nHead == 172 && nMode == 0) nNext = 1;
      else if(nHead == 15 && nMode == 0) nNext = 161;
      else if(nHead == 161 && nMode == 1) nNext = 15;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }

    //Halfling Males 1-26, 160-165
    if(nGender == GENDER_MALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 165;
      else if(nHead == 165 && nMode == 0) nNext = 1;
      else if(nHead == 26 && nMode == 0) nNext = 160;
      else if(nHead == 160 && nMode == 1) nNext = 26;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }
  }

  //Human and Half-Elf
  if(nRace == RACIAL_TYPE_HUMAN || nRace == RACIAL_TYPE_HALFELF)
  {
    //Females 1-49, 100-115, 132-134,140-144,147-152,155-160,168,172,175,180-191
    if(nGender == GENDER_FEMALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 191;
      else if(nHead == 191 && nMode == 0) nNext = 1;
      else if(nHead == 49 && nMode == 0) nNext = 100;
      else if(nHead == 100 && nMode == 1) nNext = 49;
      else if(nHead == 115 && nMode == 0) nNext = 132;
      else if(nHead == 132 && nMode == 1) nNext = 115;
      else if(nHead == 134 && nMode == 0) nNext = 140;
      else if(nHead == 140 && nMode == 1) nNext = 134;
      else if(nHead == 144 && nMode == 0) nNext = 147;
      else if(nHead == 147 && nMode == 1) nNext = 144;
      else if(nHead == 152 && nMode == 0) nNext = 155;
      else if(nHead == 155 && nMode == 1) nNext = 152;
      else if(nHead == 160 && nMode == 0) nNext = 168;
      else if(nHead == 168 && nMode == 1) nNext = 160;
      else if(nHead == 168 && nMode == 0) nNext = 172;
      else if(nHead == 172 && nMode == 1) nNext = 168;
      else if(nHead == 172 && nMode == 0) nNext = 175;
      else if(nHead == 175 && nMode == 1) nNext = 172;
      else if(nHead == 175 && nMode == 0) nNext = 180;
      else if(nHead == 180 && nMode == 1) nNext = 175;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }

    //Males 1-49,100-123,135,138,140-165
    if(nGender == GENDER_MALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 165;
      else if(nHead == 165 && nMode == 0) nNext = 1;
      else if(nHead == 49 && nMode == 0) nNext = 100;
      else if(nHead == 100 && nMode == 1) nNext = 49;
      else if(nHead == 123 && nMode == 0) nNext = 135;
      else if(nHead == 135 && nMode == 1) nNext = 123;
      else if(nHead == 135 && nMode == 0) nNext = 138;
      else if(nHead == 138 && nMode == 1) nNext = 135;
      else if(nHead == 138 && nMode == 0) nNext = 140;
      else if(nHead == 140 && nMode == 1) nNext = 138;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }
  }

  //Half-Orc
  if(nRace == RACIAL_TYPE_HALFORC)
  {
    //Females 1-23
    if(nGender == GENDER_FEMALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 23;
      else if(nHead == 23 && nMode == 0) nNext = 1;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }

    //Males 1-36
    if(nGender == GENDER_MALE)
    {
      if(nHead == 1 && nMode == 1) nNext = 36;
      else if(nHead == 36 && nMode == 0) nNext = 1;
      else
      {
        if(nMode == 0) nNext = nNext + 1;
        if(nMode == 1) nNext = nNext - 1;
      }

      SetCreatureBodyPart(CREATURE_PART_HEAD,nNext,oPC);
    }
  }
}

void RemakeHelm(object oPC, int nMode)
{
  int nSlot = INVENTORY_SLOT_HEAD;
  object oItem = GetItemInSlot(nSlot, oPC);
  int nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0);
  object oNew;

  int nBaseType = GetBaseItemType(oItem);
  int nMin = 1;
  int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType));

  do
  {
    if(nMode == 0) nCurrApp++;
    else nCurrApp--;
    if(nCurrApp > nMax) nCurrApp = nMin;
    if(nCurrApp < nMin) nCurrApp = nMax;

    oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0, nCurrApp, TRUE);
  }
  while(!GetIsObjectValid(oNew));

  if(GetIsObjectValid(oNew))
  {
    SetCommandable(TRUE, oPC);
    DestroyObject(oItem);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
  }
}

void RemakeCloak(object oPC, int nMode)
{
  int nSlot = INVENTORY_SLOT_CLOAK;
  object oItem = GetItemInSlot(nSlot, oPC);
  int nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0);
  object oNew;

  int nBaseType = GetBaseItemType(oItem);
  int nMin = 1;
  int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType));

  do
  {
    if(nMode == 0) nCurrApp++;
    else nCurrApp--;
    if(nCurrApp > nMax) nCurrApp = nMin;
    if(nCurrApp < nMin) nCurrApp = nMax;

    oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0, nCurrApp, TRUE);
  }
  while(!GetIsObjectValid(oNew));

  if(GetIsObjectValid(oNew))
  {
    SetCommandable(TRUE, oPC);
    DestroyObject(oItem);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
  }
}

void RemakeShield(object oPC, int nMode)
{
  int nSlot = INVENTORY_SLOT_LEFTHAND;
  object oItem = GetItemInSlot(nSlot, oPC);
  int nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
  object oNew;

  int nBaseType = GetBaseItemType(oItem);
  int nMin = StringToInt(Get2DAString("baseitems", "MinRange", nBaseType));
  int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType));

  do
  {
    if(nMode == 0) nCurrApp++;
    else nCurrApp--;
    if(nCurrApp > nMax) nCurrApp = nMin;
    if(nCurrApp < nMin) nCurrApp = nMax;

    oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
  }
  while(!GetIsObjectValid(oNew));

  if(GetIsObjectValid(oNew))
  {
    SetCommandable(TRUE, oPC);
    DestroyObject(oItem);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
  }
}

void RemakeWeapon(object oPC, int nMode)
{
  int nSlot = INVENTORY_SLOT_RIGHTHAND;
  object oItem = GetItemInSlot(nSlot, oPC);
  int nSection = GetLocalInt(oPC, "CR_PART");
  int nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, nSection);
  object oNew;

  int nBaseType = GetBaseItemType(oItem);
  int nMin = StringToInt(Get2DAString("baseitems", "MinRange", nBaseType)) /10;
  int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType)) /10;

  do
  {
    if(nMode == 0) nCurrApp++;
    else nCurrApp--;
    if(nCurrApp > nMax) nCurrApp = nMin;
    if(nCurrApp < nMin) nCurrApp = nMax;

    oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, nSection, nCurrApp, TRUE);
  }
  while(!GetIsObjectValid(oNew));

  if(GetIsObjectValid(oNew))
  {
    SetCommandable(TRUE, oPC);
    DestroyObject(oItem);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
  }
}

void ColorWeapon(object oPC, int nMode)
{
  int nSlot = INVENTORY_SLOT_RIGHTHAND;
  object oItem = GetItemInSlot(nSlot, oPC);
  int nSection = GetLocalInt(oPC,"CR_PART");
  int nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, nSection);
  object oNew;

  int nBaseType = GetBaseItemType(oItem);
  int nMin = 1;
  int nMax = 4;//Hard Coded Max 4

  do
  {
    if(nMode == 0) nCurrApp++;
    else nCurrApp--;
    if(nCurrApp > nMax) nCurrApp = nMin;
    if(nCurrApp < nMin) nCurrApp = nMax;

    oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, nSection, nCurrApp, TRUE);
  }
  while(!GetIsObjectValid(oNew));

  if(GetIsObjectValid(oNew))
  {
    SetCommandable(TRUE, oPC);
    DestroyObject(oItem);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
  }
}

//Checks to See if an Enemy is Within a Specified Distance
int IsEnemyInRange(object oPC, float fRange)
{
  object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oPC,1,CREATURE_TYPE_IS_ALIVE,TRUE,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
  float fDist = GetDistanceBetween(oPC, oEnemy);

  if(fDist <= fRange) return TRUE;
  return FALSE;
}

//: INTEGERS
/******************************************************************************/

void ArmorUpdate(object oArmor)
{
    object oPC  = GetItemPossessor(oArmor);
    object oMod = GetModule();

    int nDefMess = GetLocalInt(oMod,"DEFLECTMESSAGE");

    //Only run through if the PC is in Combat
    int nCombat = GetIsInCombat(oPC);
    if(nCombat == TRUE)
    {
      int nDestroy = GetLocalInt(oArmor,"ARMORDESTROY");
      int nAType = GetLocalInt(oArmor,"ARMORTYPE");

      int nCurPCHP = GetCurrentHitPoints(oPC);//New Update

      //Math and Analysis
      int nPCBaseHP = GetLocalInt(oArmor,"PCBASEHP");
      int nTDiff = 0;
      if(nCurPCHP > nPCBaseHP) nTDiff = 0;//Maybe the Player was healed
      else
      {
        int nDiff1 = 1000 + nPCBaseHP;
        int nDiff2 = 1000 + nCurPCHP;
        if(nDiff1 == nDiff2) nTDiff = 0;
        if(nDiff1 > nDiff2) nTDiff = nDiff1 - nDiff2;
        if(nDiff2 > nDiff1) nTDiff = nDiff2 - nDiff1;
      }

      //Set up Deflected Portion
      int nTDeflect = 0;//Total Deflection
      int nSDeflect = 0;//Shield Portion
      int nHDeflect = 0;//Helm Portion
      int nCDeflect = 0;//Cloak Deflection
      int nBDeflect = 0;//Bracer Deflection
      int nLDeflect = 0;//Belt Deflection
      int nGDeflect = 0;//Total Gear Deflection
      int nADeflect = 0;//Add Deflection Back In
      if(nTDiff > 0)
      {
        object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
        object oHelm = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
        object oCloak = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
        object oBracer = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
        object oBelt = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);

        int nSType = GetBaseItemType(oShield);
        int nHType = GetBaseItemType(oHelm);
        int nCType = GetBaseItemType(oCloak);
        int nBType = GetBaseItemType(oBracer);
        int nLType = GetBaseItemType(oBelt);

        //Now we need the Total Deflection
        if(nSType == BASE_ITEM_SMALLSHIELD
          || nSType == BASE_ITEM_LARGESHIELD
          || nSType == BASE_ITEM_TOWERSHIELD
          || nHType == BASE_ITEM_HELMET
          || nCType == BASE_ITEM_CLOAK
          || nBType == BASE_ITEM_BRACER
          || nLType == BASE_ITEM_BELT)
        {
          int nD4 = d4(1);
          float fDivide = IntToFloat(nTDiff)/IntToFloat(nD4);
          int nDivide = FloatToInt(fDivide);
          nTDeflect = nTDiff - nDivide;//Random Amount Total Deflected

          if(nDefMess == 1) SendMessageToPC(oPC,"Deflected Damage: "+IntToString(nTDeflect));

          //A Shield will carry some or all of the deflection
          if(nSType == BASE_ITEM_SMALLSHIELD
            || nSType == BASE_ITEM_LARGESHIELD
            || nSType == BASE_ITEM_TOWERSHIELD)
          {
            int nD4 = d4(1);
            float fDivide = IntToFloat(nTDeflect)/IntToFloat(nD4);
            int nDivide = FloatToInt(fDivide);
            nSDeflect = nTDeflect - nDivide;//Random Amount Deflected by Shield
          }

          //Rest of gear portion of deflection
          if(nTDeflect > nSDeflect)
          {
            nGDeflect = nTDeflect - nSDeflect;

            //A Helm can deflect only some of the damage
            if(nHType == BASE_ITEM_HELMET)
            {
              int nD2 = d2(1);//Deflection Chance
              float fDivide = IntToFloat(nGDeflect)/IntToFloat(nD2);
              int nDivide = FloatToInt(fDivide);
              nHDeflect = nDivide;//Random Amount Deflected by Helm
            }

            //A Cloak can deflect only some of the damage
            if(nCType == BASE_ITEM_CLOAK)
            {
              int nD2 = d2(1);//Deflection Chance
              float fDivide = IntToFloat(nGDeflect)/IntToFloat(nD2);
              int nDivide = FloatToInt(fDivide);
              nCDeflect = nDivide;//Random Amount Deflected by Cloak
            }

            //A Bracer can deflect only some of the damage
            if(nBType == BASE_ITEM_BRACER)
            {
              int nD2 = d2(1);//Deflection Chance
              float fDivide = IntToFloat(nGDeflect)/IntToFloat(nD2);
              int nDivide = FloatToInt(fDivide);
              nBDeflect = nDivide;//Random Amount Deflected by Bracer
            }

            //A Belt can deflect only some of the damage
            if(nLType == BASE_ITEM_BELT)
            {
              int nD4 = d4(1);//Deflection Chance
              float fDivide = IntToFloat(nGDeflect)/IntToFloat(nD4);
              int nDivide = FloatToInt(fDivide);
              nLDeflect = nDivide;//Random Amount Deflected by Belt
            }
          }

          SetLocalInt(oShield,"SHIELDDEFLECT",nSDeflect);//For Use in Shield Update
          SetLocalInt(oHelm,"HELMDEFLECT",nHDeflect);//For Use in Helm Update
          SetLocalInt(oCloak,"CLOAKDEFLECT",nCDeflect);//For Use in Cloak Update
          SetLocalInt(oBracer,"BRACERDEFLECT",nBDeflect);//For Use in Bracer Update
          SetLocalInt(oBelt,"BELTDEFLECT",nLDeflect);//For Use in Belt Update

          if(nDefMess == 1)
          {
            SendMessageToPC(oPC,"Shield Deflected: "+IntToString(nSDeflect));
            SendMessageToPC(oPC,"Helm Deflected: "+IntToString(nHDeflect));
            SendMessageToPC(oPC,"Cloak Deflected: "+IntToString(nCDeflect));
            SendMessageToPC(oPC,"Bracer Deflected: "+IntToString(nBDeflect));
            SendMessageToPC(oPC,"Belt Deflected: "+IntToString(nLDeflect));
          }
        }
      }

      int nOldHP = GetLocalInt(oArmor,"ARMOROLDHP");
      int nNewHP = nOldHP - nTDiff + nTDeflect;

      //Messages During Combat
      if(nAType > 0)
      {
        SendMessageToPC(oPC,"Armor HP: "+IntToString(nNewHP));
      }

      //Now we set the New Armor Total
      if(nAType > 0)
      {
        SetLocalInt(oArmor,"ARMOROLDHP",nNewHP);//Set the New Armor Total
      }
      SetLocalInt(oArmor,"PCBASEHP",nCurPCHP);//Set a New PC Base HP

      //Now we do the application of the Armor
      int nCurAHP = GetLocalInt(oArmor,"ARMOROLDHP");
      if(nCurAHP <= 0 && nAType > 0)
      {
        if(nDestroy == 1)
        {
          DestroyObject(oArmor);
          SendMessageToPC(oPC,"My Armor has been destroyed beyond repair.");
          return;
        }
        else
        {
          object oNewArmor;
          oNewArmor = CopyItem(oArmor, oPC, TRUE);
          DestroyObject(oArmor);
          SendMessageToPC(oPC,"My Armor needs repair.");
          return;
        }
      }
    }
}

void ShieldUpdate(object oShield)
{
    object oPC      = GetItemPossessor(oShield);
    object oMod     = GetModule();

    //Only run through if the PC is in Combat
    int nCombat = GetIsInCombat(oPC);
    if(nCombat == TRUE)
    {
      int nDestroy  = GetLocalInt(oShield,"SHIELDDESTROY");
      int nSHP      = GetLocalInt(oShield,"SHIELDHP");

      int nOldHP = GetLocalInt(oShield,"SHIELDOLDHP");
      int nSDeflect = GetLocalInt(oShield,"SHIELDDEFLECT");
      int nNewHP = nOldHP - nSDeflect;

      SendMessageToPC(oPC,"Shield HP: "+IntToString(nNewHP));

      //Now we set the New Shield Total
      SetLocalInt(oShield,"SHIELDOLDHP",nNewHP);//Set the New Shield Total
      SetLocalInt(oShield,"SHIELDDEFLECT",0);//Reset Shield Deflection

      //Now we do the application of the Shield
      int nCurSHP = GetLocalInt(oShield,"SHIELDOLDHP");
      if(nCurSHP <= 0)
      {
        if(nDestroy == 1)
        {
          DestroyObject(oShield);
          SendMessageToPC(oPC,"My Shield has been destroyed beyond repair.");
          return;
        }
        else
        {
          DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oShield)));
          SendMessageToPC(oPC,"My Shield needs repair.");
          return;
        }
      }
    }
}

void WeaponUpdate(object oWeapon)
{
    object oPC      = GetItemPossessor(oWeapon);
    object oMod     = GetModule();

    int nRollMess = GetLocalInt(oMod,"ROLLMESSAGE");

    //Only run through if the PC is in Combat
    int nCombat = GetIsInCombat(oPC);
    int nEnemy  = IsEnemyInRange(oPC, 3.0);
    if(nCombat == TRUE && nEnemy == TRUE)
    {
      int nDestroy  = GetLocalInt(oWeapon,"WEAPONDESTROY");
      int nType     = GetLocalInt(oWeapon,"WEAPONTYPE");
      int nBonus    = GetLocalInt(oWeapon,"WEAPONBONUS");
      int nWHP      = GetLocalInt(oWeapon,"WEAPONHP");

      //Math and Analysis
      //Now we create a synthetic Random Damage Roll...we only need to be approximate
      //NOTE: Critical Hits are NOT calculated because they are critical ONLY to the subject not the Weapon
      //Light Weapon
      if(nType == 1)
      {
        int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oPC);
        if(nSTR > 4) nSTR = 4;
        int nD6 = d6(1);
        int nMaxRoll = nSTR + nD6;

        //Now we need a Bad Hit or Critical Failure of the Weapon
        int nD100 = d100(1);

        if(nRollMess == 1) SendMessageToPC(oPC,"Light Weapon Roll: "+IntToString(nD100));

        //Current HPs of Weapon
        int nOldHP = GetLocalInt(oWeapon,"WEAPONOLDHP");

        //Bad Hit
        if(nD100 > 1 && nD100 < 10) nMaxRoll = nMaxRoll * 2;

        //Check for Critical Breaks
        if(nD100 == 1)
        {
          //Only Critical Break on less than Half HPs
          if(nOldHP < (nWHP/2))
          {
            //Enhanced Weapons Are Harder to Break
            int nChance = d6(1);
            int nBonus = GetABBonus(oWeapon);
            if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

            if(nBonus == 0) nMaxRoll = 10000;//Pretty much makes the Weapon Destroy itself
            if(nBonus == 1 && nChance > 1) nMaxRoll = 10000;
            if(nBonus == 2 && nChance > 2) nMaxRoll = 10000;
            if(nBonus == 3 && nChance > 3) nMaxRoll = 10000;
            if(nBonus == 4 && nChance > 4) nMaxRoll = 10000;
            if(nBonus == 5 && nChance > 5) nMaxRoll = 10000;
          }
        }

        int nNewHP = nOldHP - nMaxRoll;

        if(nNewHP > 0) SendMessageToPC(oPC,"Light Weapon HP: "+IntToString(nNewHP));
        if(nMaxRoll == 10000 && nNewHP <= 0) SendMessageToPC(oPC,"CRITICAL WEAPON BREAK!!");

        //Now we set the New Weapon Total
        SetLocalInt(oWeapon,"WEAPONOLDHP",nNewHP);
      }

      //Medium Weapon
      if(nType == 2)
      {
        int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oPC);
        if(nSTR > 4) nSTR = 4;
        int nD6 = d6(1);
        int nMaxRoll = nSTR + nD6;

        //Now we need a Bad Hit or Critical Failure of the Weapon
        int nD100 = d100(1);

        if(nRollMess == 1) SendMessageToPC(oPC,"Medium Weapon Roll: "+IntToString(nD100));

        //Current HPs of Weapon
        int nOldHP = GetLocalInt(oWeapon,"WEAPONOLDHP");

        //Bad Hit
        if(nD100 > 1 && nD100 < 10) nMaxRoll = nMaxRoll * 2;

        //Check for Critical Breaks
        if(nD100 == 1)
        {
          //Only Critical Break on less than Half HPs
          if(nOldHP < (nWHP/2))
          {
            //Enhanced Weapons Are Harder to Break
            int nChance = d6(1);
            int nBonus = GetABBonus(oWeapon);
            if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

            if(nBonus == 0) nMaxRoll = 10000;//Pretty much makes the Weapon Destroy itself
            if(nBonus == 1 && nChance > 1) nMaxRoll = 10000;
            if(nBonus == 2 && nChance > 2) nMaxRoll = 10000;
            if(nBonus == 3 && nChance > 3) nMaxRoll = 10000;
            if(nBonus == 4 && nChance > 4) nMaxRoll = 10000;
            if(nBonus == 5 && nChance > 5) nMaxRoll = 10000;
          }
        }

        int nNewHP = nOldHP - nMaxRoll;

        if(nNewHP > 0) SendMessageToPC(oPC,"Medium Weapon HP: "+IntToString(nNewHP));
        if(nMaxRoll == 10000 && nNewHP <= 0) SendMessageToPC(oPC,"CRITICAL WEAPON BREAK!!");

        //Now we set the New Weapon Total
        SetLocalInt(oWeapon,"WEAPONOLDHP",nNewHP);
      }
      //Heavy Weapon
      if(nType == 3)
      {
        int nSTR = GetAbilityModifier(ABILITY_STRENGTH,oPC);
        if(nSTR > 4) nSTR = 4;
        int nD6 = d6(1);
        int nMaxRoll = nSTR + nD6;

        //Now we need a Bad Hit or Critical Failure of the Weapon
        int nD100 = d100(1);

        if(nRollMess == 1) SendMessageToPC(oPC,"Light Weapon Roll: "+IntToString(nD100));

        //Current HPs of Weapon
        int nOldHP = GetLocalInt(oWeapon,"WEAPONOLDHP");

        //Bad Hit
        if(nD100 > 1 && nD100 < 10) nMaxRoll = nMaxRoll * 2;

        //Check for Critical Breaks
        if(nD100 == 1)
        {
          //Only Critical Break on less than Half HPs
          if(nOldHP < (nWHP/2))
          {
            //Enhanced Weapons Are Harder to Break
            int nChance = d6(1);
            int nBonus = GetABBonus(oWeapon);
            if(nBonus > 5) nBonus = 5;//+5 is Maximum Allowed

            if(nBonus == 0) nMaxRoll = 10000;//Pretty much makes the Weapon Destroy itself
            if(nBonus == 1 && nChance > 1) nMaxRoll = 10000;
            if(nBonus == 2 && nChance > 2) nMaxRoll = 10000;
            if(nBonus == 3 && nChance > 3) nMaxRoll = 10000;
            if(nBonus == 4 && nChance > 4) nMaxRoll = 10000;
            if(nBonus == 5 && nChance > 5) nMaxRoll = 10000;
          }
        }

        int nNewHP = nOldHP - nMaxRoll;

        if(nNewHP > 0) SendMessageToPC(oPC,"Heavy Weapon HP: "+IntToString(nNewHP));
        if(nMaxRoll == 10000 && nNewHP <= 0) SendMessageToPC(oPC,"CRITICAL WEAPON BREAK!!");

        //Now we set the New Weapon Total
        SetLocalInt(oWeapon,"WEAPONOLDHP",nNewHP);
      }

      //Now we do the application of the Weapon
      int nCurWHP = GetLocalInt(oWeapon,"WEAPONOLDHP");
      if(nCurWHP <= 0)
      {
        if(nDestroy == 1)
        {
          DestroyObject(oWeapon);
          SendMessageToPC(oPC,"My Weapon has been destroyed beyond repair.");
          return;
        }
        else
        {
          DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oWeapon)));
          SendMessageToPC(oPC,"My Weapon is now not usable until repaired.");
          return;
        }
      }
      else
      {
        int n50 = nWHP/2;
        if(nCurWHP <= n50)
        {
          //Don't give message more than once
          if(GetLocalInt(oWeapon,"WEAPONKEEN") == 1) return;

          //Damaged Weapons can lose their sharp edge but NOT their Bonus
          int nHasKeen = GetItemHasItemProperty(oWeapon,ITEM_PROPERTY_KEEN);
          if(nHasKeen == TRUE)
          {
            SetLocalInt(oWeapon,"WEAPONKEEN",1);
            IPRemoveMatchingItemProperties(oWeapon, ITEM_PROPERTY_KEEN, -1);
            SendMessageToPC(oPC,"My Weapon has lost it's Keen Edge. It will need to be sharpened.");
          }
        }
      }
    }
}

void HelmUpdate(object oHelm)
{
    object oPC      = GetItemPossessor(oHelm);
    object oMod     = GetModule();

    //Only run through if the PC is in Combat
    int nCombat = GetIsInCombat(oPC);
    if(nCombat == TRUE)
    {
      int nDestroy  = GetLocalInt(oHelm,"HELMDESTROY");
      int nHHP      = GetLocalInt(oHelm,"HELMHP");

      int nOldHP = GetLocalInt(oHelm,"HELMOLDHP");
      int nHDeflect = GetLocalInt(oHelm,"HELMDEFLECT");
      int nNewHP = nOldHP - nHDeflect;

      SendMessageToPC(oPC,"Helm HP: "+IntToString(nNewHP));

      //Now we set the New Helm Total
      SetLocalInt(oHelm,"HELMOLDHP",nNewHP);//Set the New Helm Total
      SetLocalInt(oHelm,"HELMDEFLECT",0);//Reset Helm Deflection

      //Now we do the application of the Helm
      int nCurHHP = GetLocalInt(oHelm,"HELMOLDHP");
      if(nCurHHP <= 0)
      {
        if(nDestroy == 1)
        {
          DestroyObject(oHelm);
          SendMessageToPC(oPC,"My Helm has been destroyed beyond repair.");
          return;
        }
        else
        {
          DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oHelm)));
          SendMessageToPC(oPC,"My Helm needs repair.");
          return;
        }
      }
    }
}

void CloakUpdate(object oCloak)
{
    object oPC      = GetItemPossessor(oCloak);
    object oMod     = GetModule();

    //Only run through if the PC is in Combat
    int nCombat = GetIsInCombat(oPC);
    if(nCombat == TRUE)
    {
      int nDestroy  = GetLocalInt(oCloak,"CLOAKDESTROY");
      int nCHP      = GetLocalInt(oCloak,"CLOAKHP");

      int nOldHP = GetLocalInt(oCloak,"CLOAKOLDHP");
      int nCDeflect = GetLocalInt(oCloak,"CLOAKDEFLECT");
      int nNewHP = nOldHP - nCDeflect;

      SendMessageToPC(oPC,"Cloak HP: "+IntToString(nNewHP));

      //Now we set the New Cloak Total
      SetLocalInt(oCloak,"CLOAKOLDHP",nNewHP);//Set the New Cloak Total
      SetLocalInt(oCloak,"CLOAKDEFLECT",0);//Reset Cloak Deflection

      //Now we do the application of the Cloak
      int nCurCHP = GetLocalInt(oCloak,"CLOAKOLDHP");
      if(nCurCHP <= 0)
      {
        if(nDestroy == 1)
        {
          DestroyObject(oCloak);
          SendMessageToPC(oPC,"My Cloak has been destroyed beyond repair.");
          return;
        }
        else
        {
          DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oCloak)));
          SendMessageToPC(oPC,"My Cloak needs repair.");
          return;
        }
      }
    }
}

void BracerUpdate(object oBracer)
{
    object oPC      = GetItemPossessor(oBracer);
    object oMod     = GetModule();

    //Only run through if the PC is in Combat
    int nCombat = GetIsInCombat(oPC);
    if(nCombat == TRUE)
    {
      int nDestroy  = GetLocalInt(oBracer,"BRACERDESTROY");
      int nBHP      = GetLocalInt(oBracer,"BRACERHP");

      int nOldHP = GetLocalInt(oBracer,"BRACEROLDHP");
      int nBDeflect = GetLocalInt(oBracer,"BRACERDEFLECT");
      int nNewHP = nOldHP - nBDeflect;

      SendMessageToPC(oPC,"Bracer HP: "+IntToString(nNewHP));

      //Now we set the New Bracer Total
      SetLocalInt(oBracer,"BRACEROLDHP",nNewHP);//Set the New Bracer Total
      SetLocalInt(oBracer,"BRACERDEFLECT",0);//Reset Bracer Deflection

      //Now we do the application of the Bracer
      int nCurBHP = GetLocalInt(oBracer,"BRACEROLDHP");
      if(nCurBHP <= 0)
      {
        if(nDestroy == 1)
        {
          DestroyObject(oBracer);
          SendMessageToPC(oPC,"My Bracer has been destroyed beyond repair.");
          return;
        }
        else
        {
          DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oBracer)));
          SendMessageToPC(oPC,"My Bracer needs repair.");
          return;
        }
      }
    }
}

void BeltUpdate(object oBelt)
{
    object oPC      = GetItemPossessor(oBelt);
    object oMod     = GetModule();

    //Only run through if the PC is in Combat
    int nCombat = GetIsInCombat(oPC);
    if(nCombat == TRUE)
    {
      int nDestroy  = GetLocalInt(oBelt,"BELTDESTROY");
      int nLHP      = GetLocalInt(oBelt,"BELTHP");

      int nOldHP = GetLocalInt(oBelt,"BELTOLDHP");
      int nLDeflect = GetLocalInt(oBelt,"BELTDEFLECT");
      int nNewHP = nOldHP - nLDeflect;

      SendMessageToPC(oPC,"Belt HP: "+IntToString(nNewHP));

      //Now we set the New Belt Total
      SetLocalInt(oBelt,"BELTOLDHP",nNewHP);//Set the New Belt Total
      SetLocalInt(oBelt,"BELTDEFLECT",0);//Reset Belt Deflection

      //Now we do the application of the Belt
      int nCurLHP = GetLocalInt(oBelt,"BELTOLDHP");
      if(nCurLHP <= 0)
      {
        if(nDestroy == 1)
        {
          DestroyObject(oBelt);
          SendMessageToPC(oPC,"My Belt has been destroyed beyond repair.");
          return;
        }
        else
        {
          DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oBelt)));
          SendMessageToPC(oPC,"My Belt needs repair.");
          return;
        }
      }
    }
}

void BootsUpdate(object oBoots)
{
    object oPC      = GetItemPossessor(oBoots);
    object oMod     = GetModule();

    int nDestroy  = GetLocalInt(oBoots,"BOOTSDESTROY");
    int nBTHP     = GetLocalInt(oBoots,"BOOTSHP");

    int nCombat = GetIsInCombat(oPC);
    int nOldHP = GetLocalInt(oBoots,"BOOTSOLDHP");
    int nD4 = d4(1);

    //We double boot wear during combat
    if(nCombat == TRUE) nD4 = nD4 * 2;

    int nNewHP = nOldHP - nD4;
    if(nNewHP < 100) SendMessageToPC(oPC,"Boots HP: "+IntToString(nNewHP));

    //Now we set the New Boots Total
    SetLocalInt(oBoots,"BOOTSOLDHP",nNewHP);//Set the New Boots Total

    //Now we do the application of the Boots
    int nCurBTHP = GetLocalInt(oBoots,"BOOTSOLDHP");
    if(nCurBTHP <= 0)
    {
      if(nDestroy == 1)
      {
        DestroyObject(oBoots);
        SendMessageToPC(oPC,"My Boots have been destroyed beyond repair.");
        return;
      }
      else
      {
        DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oBoots)));
        SendMessageToPC(oPC,"My Boots need repair.");
        return;
      }
    }
}

/******************************************************************************/
//:: OLANDER'S SMITH WORKS

//This is from a DM Tool to Reset the Smith's Fire
void DMSmithFireReset(object oSmithFire)
{
  object oItem = GetFirstItemInInventory(oSmithFire);
  while(GetIsObjectValid(oItem))
  {
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oSmithFire);
  }

  SetLocalInt(oSmithFire,"OCR_CURHEAT",0);
  SetLocalInt(oSmithFire,"OCR_HASITEM",FALSE);
  DeleteLocalObject(oSmithFire,"OCR_HEATBAR");
}

//This is from a DM Tool to Reset the Smith's Fire
void DMAnvilReset(object oAnvil)
{
  object oItem = GetFirstItemInInventory(oAnvil);
  while(GetIsObjectValid(oItem))
  {
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oAnvil);
  }

  /*
  SetLocalInt(oAnvil,"OCR_CURHEAT",0);
  SetLocalInt(oAnvil,"OCR_HASITEM",FALSE);
  DeleteLocalObject(oAnvil,"OCR_HEATBAR");
  */
}

void SmithFireReset(object oSmithFire)
{
  object oItem = GetFirstItemInInventory(oSmithFire);
  while(GetIsObjectValid(oItem))
  {
    DestroyObject(oItem);

    oItem = GetNextItemInInventory(oSmithFire);
  }

  SetLocalInt(oSmithFire,"OCR_HASITEM",FALSE);
  DeleteLocalObject(oSmithFire,"OCR_HEATBAR");
}

void VerifyFlame(object oForge)
{
  int nCurHeat = GetLocalInt(oForge,"OCR_CURHEAT");

  object oLowFlame = GetNearestObjectByTag("LowFlame",oForge);
  object oHighFlame = GetNearestObjectByTag("HighFlame",oForge);

  //Less than 20 Input Air - No Flame
  if(nCurHeat < 20)
  {
    //No need for Flames
    if(GetIsObjectValid(oLowFlame)) DestroyObject(oLowFlame);
    if(GetIsObjectValid(oHighFlame)) DestroyObject(oHighFlame);
  }

  //20 to 39 - Low Fire
  if(nCurHeat >= 20 && nCurHeat < 40)
  {
    //No need for High Flame
    if(GetIsObjectValid(oHighFlame)) DestroyObject(oHighFlame);

    //Make Low Flame if not there
    if(!GetIsObjectValid(oLowFlame)) CreateObject(OBJECT_TYPE_PLACEABLE,"lowflame",GetLocation(oForge));
  }

  //40 and Up - High Fire
  if(nCurHeat >= 40)
  {
    //No need for Low Flame
    if(GetIsObjectValid(oLowFlame)) DestroyObject(oLowFlame);

    //Make Low Flame if not there
    if(!GetIsObjectValid(oHighFlame)) CreateObject(OBJECT_TYPE_PLACEABLE,"highflame",GetLocation(oForge));
  }
}

void AddForgeHeat(object oForge)
{
  int nCurHeat = GetLocalInt(oForge,"OCR_CURHEAT");
  int nNewHeat = nCurHeat + 5;
  SetLocalInt(oForge,"OCR_CURHEAT",nNewHeat);
}

void RemoveForgeHeat(object oForge)
{
  int nCurHeat = GetLocalInt(oForge,"OCR_CURHEAT");
  int nNewHeat = nCurHeat - 1;
  SetLocalInt(oForge,"OCR_CURHEAT",nNewHeat);
}

void TransferHeat(object oForge)
{
  int nCurHeat = GetLocalInt(oForge,"OCR_CURHEAT");

  object oSmithFire = GetNearestObjectByTag("SmithFire",oForge);
  int nSmithHeat = GetLocalInt(oSmithFire,"OCR_CURHEAT");
  int nNewHeat = nSmithHeat + nCurHeat;
  SetLocalInt(oSmithFire,"OCR_CURHEAT",nNewHeat);

  string sSpeak = IntToString(nNewHeat)+" Degrees Celcius";
  string sColor = GRAY;

  //Smith Fire Speaks Temp
  if(nNewHeat < 400) sColor = BLUE;
  if(nNewHeat >= 400 && nNewHeat < 475) sColor = YELLOW;
  if(nNewHeat >= 475 && nNewHeat < 525) sColor = GREEN;
  if(nNewHeat > 525) sColor = RED;

  //Check to see if Smith's Fire has an Item
  int nItem = GetLocalInt(oSmithFire,"OCR_HASITEM");
  if(nItem == TRUE) AssignCommand(oSmithFire,SpeakString(sColor + sSpeak));
}

int ValidateBar(object oPC, object oSmithFire)
{
  string sItemTag;
  string sDMBar         = "DMResetBar";
  string sAdamantineBar = "AdamatineBar";
  string sMithrilBar    = "MithrilBar";
  string sSteelBar      = "SteelBar";
  string sIronBar       = "IronBar";
  string sCopperBar     = "CopperBar";
  string sSilverBar     = "SilverBar";
  string sGoldBar       = "GoldBar";
  string sPlatinumBar   = "PlatinumBar";

  object oItem = GetFirstItemInInventory(oSmithFire);
  int nBar = 0;
  while(GetIsObjectValid(oItem))
  {
    sItemTag = GetTag(oItem);

    if(sItemTag == sDMBar)
    {
      DMSmithFireReset(oSmithFire);
      SendMessageToPC(oPC,"DM Reset Bar used. Smith's Fire has been Reset.");
      return 0;
    }

    if(sItemTag == sAdamantineBar) nBar++;
    else if(sItemTag == sMithrilBar) nBar++;
    else if(sItemTag == sSteelBar) nBar++;
    else if(sItemTag == sIronBar) nBar++;
    else if(sItemTag == sCopperBar) nBar++;
    else if(sItemTag == sSilverBar) nBar++;
    else if(sItemTag == sGoldBar) nBar++;
    else if(sItemTag == sPlatinumBar) nBar++;

    oItem = GetNextItemInInventory(oSmithFire);
  }

  if(nBar == 0)
  {
    SendMessageToPC(oPC,"Place a valid bar in Smith's Fire to heat it.");
    return 0;
  }

  if(nBar > 1)
  {
    SendMessageToPC(oPC,"The Smith's Fire can only heat 1 bar at a time.");
    return 0;
  }

  //Set Bar of Metal to be Heated.
  oItem = GetFirstItemInInventory();
  SetLocalObject(oSmithFire,"OCR_HEATBAR",oItem);
  SetLocalInt(oSmithFire,"OCR_HASITEM",TRUE);
  SetLocked(oSmithFire,TRUE);
  SendMessageToPC(oPC,"The Smith's Fire will heat the : "+GetName(oItem));
  SendMessageToPC(oPC,"Use the Forge to control the Smith's Fire's Heat in the 'Green' Temperatures.");
  SendMessageToPC(oPC,"Overheating the Bar will destroy it.");

  return 1;
}

void BarHeat(object oSmithFire)
{
  object oBar = GetLocalObject(oSmithFire,"OCR_HEATBAR");
  int nCurHeat = GetLocalInt(oSmithFire,"OCR_CURHEAT");
  int nBarHeat = GetLocalInt(oBar,"OCR_CURHEAT");

  //Heat Bar in Increments of Maximum 20
  //Check Difference in Temp
  int nDiff = nCurHeat - nBarHeat;

  //Smith's Fire has Cooled...Cool Bar as Well
  int nNewHeat = 0;
  if(nDiff < 0)
  {
    nNewHeat = nCurHeat;
    SetLocalInt(oBar,"OCR_CURHEAT",nNewHeat);
  }
  //Heat Bar
  else
  {
    if(nDiff > 20) nNewHeat = nBarHeat + 20;
    if(nDiff < 20 && nDiff > 2) nNewHeat = nBarHeat + (nDiff/2);
    if(nDiff < 2) nNewHeat = nCurHeat;
    SetLocalInt(oBar,"OCR_CURHEAT",nNewHeat);
  }

  string sSpeak = GetName(oBar)+" is "+IntToString(nNewHeat)+" Degrees Celcius";
  string sBarDone = GetName(oBar)+" is heated and ready for the Anvil.";
  string sBarDestroyed = GetName(oBar)+" has over-heated and is destroyed.";
  string sColor = GRAY;

  //Verify Bar Temp
  if(nNewHeat < 400) sColor = BLUE;
  if(nNewHeat >= 400 && nNewHeat < 490) sColor = YELLOW;
  if(nNewHeat >= 490 && nNewHeat < 511)
  {
    sColor = GREEN;

    //At Temperature....Hold for 5 Cycles
    int nHeating = GetLocalInt(oBar,"OCR_HEATING");
    if(nHeating >= 5)
    {
      SetLocalInt(oBar,"OCR_HEATED",TRUE);
      AssignCommand(oSmithFire,SpeakString(sColor + sBarDone));
      SetLocked(oSmithFire,FALSE);
      return;
    }
    else SetLocalInt(oBar,"OCR_HEATING",nHeating+1);
  }
  if(nNewHeat > 510)
  {
    sColor = RED;

    AssignCommand(oSmithFire,SpeakString(sColor + sBarDestroyed));
    SetLocked(oSmithFire,FALSE);
    DestroyObject(oBar);
    DeleteLocalObject(oSmithFire,"OCR_HEATBAR");
    return;
  }

  AssignCommand(oSmithFire,SpeakString(sColor + sSpeak));
}

int ValidateBarOnAnvil(object oPC, object oAnvil)
{
  string sItemTag;
  string sDMBar         = "DMResetBar";
  string sAdamantineBar = "AdamatineBar";
  string sMithrilBar    = "MithrilBar";
  string sSteelBar      = "SteelBar";
  string sIronBar       = "IronBar";
  string sCopperBar     = "CopperBar";
  string sSilverBar     = "SilverBar";
  string sGoldBar       = "GoldBar";
  string sPlatinumBar   = "PlatinumBar";

  object oItem = GetFirstItemInInventory(oAnvil);
  int nBar = 0;
  while(GetIsObjectValid(oItem))
  {
    sItemTag = GetTag(oItem);

    if(sItemTag == sDMBar)
    {
      DMAnvilReset(oAnvil);
      SendMessageToPC(oPC,"DM Reset Bar used. Anvil has been Reset.");
      return 0;
    }

    if(sItemTag == sAdamantineBar) nBar++;
    else if(sItemTag == sMithrilBar) nBar++;
    else if(sItemTag == sSteelBar) nBar++;
    else if(sItemTag == sIronBar) nBar++;
    else if(sItemTag == sCopperBar) nBar++;
    else if(sItemTag == sSilverBar) nBar++;
    else if(sItemTag == sGoldBar) nBar++;
    else if(sItemTag == sPlatinumBar) nBar++;

    oItem = GetNextItemInInventory(oAnvil);
  }

  if(nBar == 0)
  {
    SendMessageToPC(oPC,"Place a valid bar on the Anvil.");
    return 0;
  }

  if(nBar > 1)
  {
    SendMessageToPC(oPC,"The Anvil can only have 1 bar at a time.");
    return 0;
  }

  //Set Bar of Metal to be Hammered/Cast.
  oItem = GetFirstItemInInventory();

  //Check to see if this Bar was Heated
  int nHeated = GetLocalInt(oItem,"OCR_HEATED");
  if(nHeated == FALSE)
  {
    AssignCommand(oAnvil,SpeakString("The "+GetName(oItem)+" has not been heated yet."));
    return 0;
  }

  //Now Prepared the Anvil for Hammering the Bar
  SetLocalObject(oAnvil,"OCR_HEATBAR",oItem);
  SetLocalInt(oAnvil,"OCR_HASITEM",TRUE);
  SetLocked(oAnvil,TRUE);
  AssignCommand(oAnvil,SpeakString("The "+GetName(oItem)+" is ready for hammering."));

  return 1;
}

int ValidateDieOnAnvil(object oPC, object oAnvil)
{
  string sItemTag;
  string sBands     = "DieIronBands";
  string sHammer    = "DieIronHHead";
  string sOrb       = "DieIronOrb";
  string sChain     = "DieIronChain";
  string sRings     = "DieIronRings";
  string sSpikes    = "DieIronSpikes";
  string sStuds     = "DieIronStuds";

  object oItem = GetFirstItemInInventory(oAnvil);
  int nDie = 0;
  while(GetIsObjectValid(oItem))
  {
    sItemTag = GetTag(oItem);

    if(sItemTag == sBands) nDie++;
    else if(sItemTag == sHammer) nDie++;
    else if(sItemTag == sOrb) nDie++;
    else if(sItemTag == sChain) nDie++;
    else if(sItemTag == sRings) nDie++;
    else if(sItemTag == sSpikes) nDie++;
    else if(sItemTag == sStuds) nDie++;

    oItem = GetNextItemInInventory(oAnvil);
  }

  if(nDie == 0)
  {
    SendMessageToPC(oPC,"Place a valid Casting Die on the Anvil.");
    return 0;
  }

  if(nDie > 1)
  {
    SendMessageToPC(oPC,"The Anvil can only have 1 Casting Die at a time.");
    return 0;
  }

  return 1;
}


//void main(){}
