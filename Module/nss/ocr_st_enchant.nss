////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Start of Enchanting Table Preparation
//  ocr_st_enchant
//  by Don Anderson
//  dandersonru@msn.com
//
//  Place this in the On Closed Event of the Enchanting Table
//
//  Thanks to Robert Olsen for the Crafting Gloves
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"
#include "x0_i0_match"

void main()
{
    object oPC      = GetLastClosedBy();
    object oMod     = GetModule();

    //From Master Configuration opw_mod_onload
    int nCRAFTGLOBAL = GetLocalInt(oMod,"CRAFTGLOBAL");
    if(nCRAFTGLOBAL == 0) return;

    object oTable   = OBJECT_SELF;
    object oItem; object oBaseItem;
    string sItemTag;
    string sCBackup = "OCR_Backup";//The Tag of the Crafting ILR Container

    int nDRSYS      = GetLocalInt(oMod,"DRSYS");
    int nABMax      = GetLocalInt(oMod,"ABMAX");
    int nHWALLOW    = GetLocalInt(oMod,"HWALLOW");
    int nHWEBMAX    = GetLocalInt(oMod,"HWEBMAX");
    int nDRMax      = GetLocalInt(oMod,"DRMAX");
    int nDRSysMax   = 10;
    int nACMax      = GetLocalInt(oMod,"ACMAX");
    int nDBEMax     = GetLocalInt(oMod,"DBEMAX");
    int nDREMax     = GetLocalInt(oMod,"DREMAX");
    int nTMax       = GetLocalInt(oMod,"TMAX");
    int nPMax       = GetLocalInt(oMod,"PMAX");
    int nEncDC      = GetLocalInt(oMod,"ENCDC");
    int nILRSYS     = GetLocalInt(oMod,"ILRSYS");
    int nILRGOLD    = GetLocalInt(oMod,"ILRGOLD");
    int nILRGMAX    = GetLocalInt(oMod,"ILRGMAX");
    int nCollege    = 0;
    int nBonus      = 0;
    int nEnchanted;
    int nBType = 0;//1 will be Damage Bonus   2 will be Damage Resistance

    //Clear All Variables To Begin
    DeleteLocalInt(oPC, "ITEMTOENCHANT");
    DeleteLocalInt(oPC, "NOSKILL");
    DeleteLocalInt(oPC, "NOCLEANUP");
    SetLocalString(oPC, "CRAFTBASE", "NONE");
    DeleteLocalString(oPC, "CRAFTTAG");
    DeleteLocalInt(oPC, "ACIDFLASK");
    DeleteLocalInt(oPC, "COLDSTONE");
    DeleteLocalInt(oPC, "HOLYWATER");
    DeleteLocalInt(oPC, "QUARTZ");
    DeleteLocalInt(oPC, "ALCHEMISTFIRE");
    DeleteLocalInt(oPC, "SKELETON");
    DeleteLocalInt(oPC, "THUNDERSTONE");
    DeleteLocalInt(oPC, "DIAMOND");
    DeleteLocalInt(oPC, "DUSTYROSE");
    DeleteLocalInt(oPC, "MITHRIL");
    DeleteLocalInt(oPC, "PALEBLUE");
    DeleteLocalInt(oPC, "DEEPRED");
    DeleteLocalInt(oPC, "PINK");
    DeleteLocalInt(oPC, "SANDBLUE");
    DeleteLocalInt(oPC, "BLUE");
    DeleteLocalInt(oPC, "PANDGREEN");

    //Don't bother going through the script if inventory is empty
    oItem = GetFirstItemInInventory(oTable);
    if(oItem == OBJECT_INVALID) return;

/******************************************************************************/
//: CHECK FOR REQUIREMENT OF INTELLIGENCE OR WISDOM OF 14(+2)

    int nIWReq = GetLocalInt(oMod,"IWREQ");

    if(nIWReq == 1)
    {
      int nINT = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
      int nWIS = GetAbilityModifier(ABILITY_WISDOM,oPC);

      int nIWC = FALSE;
      int nHigher = 0;
      if(nINT >= nWIS) nHigher = nINT;
      if(nWIS >= nINT) nHigher = nWIS;
      if(nHigher >= 2) nIWC = TRUE;
      if(nIWC == FALSE)
      {
        SendMessageToPC(oPC,"You do not have the Minimum Wisdom or Intelligence to use the Enchanting Table.");
        return;
      }
    }

//: CHECK FOR REQUIREMENT OF INTELLIGENCE OR WISDOM OF 14(+2)
/******************************************************************************/

/******************************************************************************/
//: SKILL CHECKS

    //We need to get the Skill Level of the Player
    int nLore = GetSkillRank(SKILL_LORE, oPC);
    int nSC = GetSkillRank(SKILL_SPELLCRAFT, oPC);
    if(nLore > nSC) nCollege = nCollege + nLore;
    if(nSC > nLore) nCollege = nCollege + nSC;
    if(nSC == nLore) nCollege = nCollege + nLore;
    int nSkillCheck = d20() + nCollege;

    //Enchanting Requires a DC set by ors_mod_onload
    if(nSkillCheck <= nEncDC)
    {
      SendMessageToPC(oPC,"The DC of " +IntToString(nEncDC)+ " for Enchanting was not met. You had " +IntToString(nSkillCheck)+ " Total. Try again.");
      SetLocalInt(oPC, "NOSKILL", 1);
      SetLocalInt(oPC, "NOCLEANUP", 0);
    }

//: SKILL CHECKS
/******************************************************************************/

/******************************************************************************/
//: EQUIPABLE ITEMS IN THE FORGE

    //Check For Staves on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_MAGICSTAFF)
        {
          SendMessageToPC(oPC,"You can not enhance a Magic Staff.");
          return;
        }
      }

      oItem = GetNextItemInInventory();
    }

    //Check For Non Craftable Items on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      if(GetLocalInt(oItem,"NOCRAFT") > 0)
      {
        string sName = GetName(oItem);
        SendMessageToPC(oPC,"The "+sName+" can NOT be Enchanted.");
        return;
      }

      oItem = GetNextItemInInventory();
    }


    //Check For Armors on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_ARMOR)
        {
          string sCheck = "Armor";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          if(nAC <= 0) SetLocalString(oPC, "CRAFTBASE", "CLOTHING");
          else SetLocalString(oPC, "CRAFTBASE", "ARMOR");

          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Helms on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_HELMET)
        {
          string sCheck = "Helmet";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "HELM");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Cloaks on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_CLOAK)
        {
          string sCheck = "Cloak";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "CLOAK");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Tower Shields on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD)
        {
          string sCheck = "Shield";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "TSHIELD");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Large Shields on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD)
        {
          string sCheck = "Shield";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "LSHIELD");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Small Shields on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD)
        {
          string sCheck = "Shield";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "SSHIELD");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Bracers on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_BRACER)
        {
          string sCheck = "Bracer";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "BRACER");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Belts on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_BELT)
        {
          string sCheck = "Belt";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "BELT");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Boots on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_BOOTS)
        {
          string sCheck = "Boots";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          int nBResist = GetBludgDamageResistance(oItem);
          int nPResist = GetPierceDamageResistance(oItem);
          int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "BOOTS");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Amulets on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_AMULET)
        {
          string sCheck = "Amulet";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          //int nBResist = GetBludgDamageResistance(oItem);
          //int nPResist = GetPierceDamageResistance(oItem);
          //int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          /*
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }
          */

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "AMULET");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Rings on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_RING)
        {
          string sCheck = "Ring";

          int nACBonus = GetACBonus(oItem);
          int nAcid    = GetAcidDamageResistance(oItem);
          int nCold    = GetColdDamageResistance(oItem);
          int nDivine  = GetDivineDamageResistance(oItem);
          int nElectric = GetElectricDamageResistance(oItem);
          int nFire    = GetFireDamageResistance(oItem);
          int nMag     = GetMagicalDamageResistance(oItem);
          int nNegative = GetNegativeDamageResistance(oItem);
          int nPos     = GetPositiveDamageResistance(oItem);
          int nSonic   = GetSonicDamageResistance(oItem);
          int nDRBonus = nAcid + nCold + nDivine + nElectric + nFire + nMag + nNegative + nPos + nSonic;
          //int nBResist = GetBludgDamageResistance(oItem);
          //int nPResist = GetPierceDamageResistance(oItem);
          //int nSResist = GetSlashDamageResistance(oItem);
          int nPBonus  = GetPersonalBonus(oItem);
          int nAC      = GetItemACValue(oItem);

          //More AC
          if(nACBonus >= nACMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more AC Bonus than the maximum. You can not enhance this further.");
            return;
          }

          //B/P/S Damage Resistance
          /*
          if(nAC >= 0)
          {
            int nMessage = FALSE;

            if(nBResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Bludgeoning Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nPResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Piercing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }
            if(nSResist >= nDRSysMax)
            {
              SendMessageToPC(oPC,"This "+ sCheck +" is at or above the Maximum Slashing Damage Resistance allowed. You can not enhance this further.");
              nMessage = TRUE;
            }

            if(nMessage == TRUE) return;

          }
          */

          //More Elemental Resistance
          if(nDRBonus >= nDREMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Elemental Damage Resistance than the maximum. You can not enhance this further.");
            return;
          }

          //More Personal Bonus
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" has more Personal Bonuses than the maximum. You can not enhance this further.");
            return;
          }

          //Future AC
          if(GetFutureACBonus(oPC, nACBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more AC Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          //Future Elemental DR
          if(GetFutureDRBonus(oPC, nDRBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Resistance than the maximum. Please recheck quantities.");
            return;
          }

          //Future Personal Bonus
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "RING");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 2;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Gloves on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_GLOVES)
        {
          string sCheck = "Gloves";

          int nABBonus = GetABBonus(oItem);
          int nAcid = GetAcidDamageBonus(oItem);
          int nCold = GetColdDamageBonus(oItem);
          int nDivine = GetDivineDamageBonus(oItem);
          int nElectric = GetElectricDamageBonus(oItem);
          int nFire = GetFireDamageBonus(oItem);
          int nMagical = GetMagicalDamageBonus(oItem);
          int nNegative = GetNegativeDamageBonus(oItem);
          int nPositive = GetPositiveDamageBonus(oItem);
          int nSonic = GetSonicDamageBonus(oItem);
          int nBludge = GetBludgDamageBonus(oItem);
          int nPierce = GetPierceDamageBonus(oItem);
          int nSlash = GetSlashDamageBonus(oItem);
          int nDBonus = nAcid + nCold + nDivine + nElectric + nFire + nNegative + nSonic + nBludge +nPierce +nSlash;
          int nPBonus = GetPersonalBonus(oItem);

          //More Attack or Enhancement
          if(nABBonus >= nABMax)
          {
            SendMessageToPC(oPC,"These "+ sCheck +" have more Enhancement Bonuses than the maximum. You can not enhance these further.");
            return;
          }
          //More Damage
          if(nDBonus >= nDBEMax)
          {
            SendMessageToPC(oPC,"These "+ sCheck +" have more Damage Bonuses than the maximum. You can not enhance these further.");
            return;
          }
          //More Personal
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"These "+ sCheck +" have more Personal Bonus than the maximum. You can not enhance these further.");
            return;
          }
          //Now Check to see if Item will Surpase Maximums
          if(GetFutureABBonus(oPC, nDBonus))
          {
            SendMessageToPC(oPC,"These "+ sCheck +" WILL HAVE more Enhancement Bonuses than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFutureDamageBonus(oPC, nDBonus))
          {
            SendMessageToPC(oPC,"These "+ sCheck +" WILL HAVE more Damage Bonuses than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFutureElemComboBonus(oPC, oItem))
          {
            SendMessageToPC(oPC,"These "+ sCheck +" WILL HAVE more Elemental Combinations than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"These "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "GLOVES");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 1;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Enchanted/Normal Weapons on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(IsMeleeWeapon(oItem)
          || IsRangedWeapon(oItem))
        {
          string sCheck = "Weapon";

          int nABBonus = GetABBonus(oItem);
          int nAcid = GetAcidDamageBonus(oItem);
          int nCold = GetColdDamageBonus(oItem);
          int nDivine = GetDivineDamageBonus(oItem);
          int nElectric = GetElectricDamageBonus(oItem);
          int nFire = GetFireDamageBonus(oItem);
          int nMagical = GetMagicalDamageBonus(oItem);
          int nNegative = GetNegativeDamageBonus(oItem);
          int nPositive = GetPositiveDamageBonus(oItem);
          int nSonic = GetSonicDamageBonus(oItem);
          int nBludge = GetBludgDamageBonus(oItem);
          int nPierce = GetPierceDamageBonus(oItem);
          int nSlash = GetSlashDamageBonus(oItem);
          int nDBonus = nAcid + nCold + nDivine + nElectric + nFire + nNegative + nSonic + nBludge +nPierce +nSlash;
          int nPBonus = GetPersonalBonus(oItem);

          //More Attack or Enhancement
          if(nABBonus >= nABMax)
          {
            //Check for Heavy Weapon Allowed
            if(!MatchDoubleHandedWeapon(oItem))
            {
              SendMessageToPC(oPC,"This "+ sCheck +" have more Enhancement Bonuses than the maximum. You can not enhance these further.");
              return;
            }

            //Now check for Heavy Weapon Allowed Adder
            if(MatchDoubleHandedWeapon(oItem) && (nABBonus >= (nABMax + nHWEBMAX)))
            {
              SendMessageToPC(oPC,"This "+ sCheck +" have more Enhancement Bonuses than the maximum. You can not enhance these further.");
              return;
            }
          }
          //More Damage
          if(nDBonus >= nDBEMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" have more Damage Bonuses than the maximum. You can not enhance these further.");
            return;
          }
          //More Personal
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" have more Personal Bonus than the maximum. You can not enhance these further.");
            return;
          }
          //Now Check to see if Item will Surpase Maximums
          if(GetFutureABBonus(oPC, nDBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Enhancement Bonuses than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFutureDamageBonus(oPC, nDBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Bonuses than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFutureElemComboBonus(oPC, oItem))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Elemental Combinations than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "WEAPON");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 1;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

    //Check For Arrows/Bolts/Bullets on the Enchanting Table
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      if(GetLocalString(oPC,"CRAFTBASE") == "NONE")
      {
        if(GetBaseItemType(oItem) == BASE_ITEM_ARROW
          || GetBaseItemType(oItem) == BASE_ITEM_BOLT
          || GetBaseItemType(oItem) == BASE_ITEM_BULLET)
        {
          string sCheck = "Ammunition";

          int nABBonus = GetABBonus(oItem);
          int nAcid = GetAcidDamageBonus(oItem);
          int nCold = GetColdDamageBonus(oItem);
          int nDivine = GetDivineDamageBonus(oItem);
          int nElectric = GetElectricDamageBonus(oItem);
          int nFire = GetFireDamageBonus(oItem);
          int nMagical = GetMagicalDamageBonus(oItem);
          int nNegative = GetNegativeDamageBonus(oItem);
          int nPositive = GetPositiveDamageBonus(oItem);
          int nSonic = GetSonicDamageBonus(oItem);
          int nBludge = GetBludgDamageBonus(oItem);
          int nPierce = GetPierceDamageBonus(oItem);
          int nSlash = GetSlashDamageBonus(oItem);
          int nDBonus = nAcid + nCold + nDivine + nElectric + nFire + nNegative + nSonic + nBludge +nPierce +nSlash;
          int nPBonus = GetPersonalBonus(oItem);

          //More Attack or Enhancement
          if(nABBonus >= nABMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" have more Enhancement Bonuses than the maximum. You can not enhance these further.");
            return;
          }
          //More Damage
          if(nDBonus >= nDBEMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" have more Damage Bonuses than the maximum. You can not enhance these further.");
            return;
          }
          //More Personal
          if(nPBonus >= nPMax)
          {
            SendMessageToPC(oPC,"This "+ sCheck +" have more Personal Bonus than the maximum. You can not enhance these further.");
            return;
          }
          //Now Check to see if Item will Surpase Maximums
          if(GetFutureABBonus(oPC, nDBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Enhancement Bonuses than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFutureDamageBonus(oPC, nDBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Damage Bonuses than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFutureElemComboBonus(oPC, oItem))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Elemental Combinations than the maximum. Please recheck quantities.");
            return;
          }
          if(GetFuturePBonus(oPC, nPBonus))
          {
            SendMessageToPC(oPC,"This "+ sCheck +" WILL HAVE more Personal Bonuses than the maximum. Please recheck quantities.");
            return;
          }

          SetLocalString(oPC, "CRAFTBASE", "AMMO");
          SetLocalString(oPC, "CRAFTTAG", sItemTag);
          SetLocalInt(oPC, "ITEMTOENCHANT", 1);
          nBType = 1;
          break;
        }
      }
      else break;
      oItem = GetNextItemInInventory();
    }

//: EQUIPABLE ITEMS IN THE FORGE
/******************************************************************************/

/******************************************************************************/
//: AB, KEEN AND AC BONUS IN THE FORGE

    //Large Weapon Overage
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      if(MatchDoubleHandedWeapon(oItem)) nABMax = nABMax + nHWEBMAX;

      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nDiamond = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Diamonds (AB +1 Each) on the Enchanting Table
      if(sItemTag == "NW_IT_GEM005" || sItemTag ==  "Diamond")
      {
        nDiamond = nDiamond + GetItemStackSize(oItem);
        if (nDiamond > nABMax)
        {
          int nMany = nDiamond - nABMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Diamond.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "DIAMOND", nDiamond);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nMithril = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For a Bar of Mithril (Keen) on the Enchanting Table
      if(sItemTag == "x2_it_cmat_mith" || sItemTag == "BarofMithril")
      {
        nMithril = nMithril + 1;
        if (nMithril > 1)
        {
          int nMany = nMithril - 1;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " bar of Mithril.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "MITHRIL", nMithril);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nDRose = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Dusty Rose Ioun Stone (AC +1 Each or DR 1/- Each) on the Enchanting Table
      if(sItemTag == "x2_is_drose" || sItemTag == "IounStoneDustyRose")
      {
        nDRose = nDRose + GetItemStackSize(oItem);
        string sArmor = GetLocalString(oPC, "CRAFTBASE");

        //DRSys is ON
        if (nDRSYS && sArmor == "ARMOR" && nDRose > nDRSysMax)
        {
          int nMany = nDRose - nDRSysMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Dusty Rose Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if (!nDRSYS && sArmor == "ARMOR" && nDRose > nACMax)
        {
          int nMany = nDRose - nACMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Dusty Rose Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if (sArmor != "ARMOR" && nDRose > nACMax)
        {
          int nMany = nDRose - nACMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Dusty Rose Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "DUSTYROSE", nDRose);
      }
      oItem = GetNextItemInInventory();
    }

//: AB, KEEN AND AC BONUS IN THE FORGE
/******************************************************************************/

/******************************************************************************/
//: PERSONAL BONUS IN THE FORGE

    oItem = GetFirstItemInInventory();
    int nPBlue = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Pale Blue Ioun Stone (STR +1 Each) on the Enchanting Table
      if(sItemTag == "x2_is_paleblue" || sItemTag == "IounStonePaleBlue")
      {
        nPBlue = nPBlue + GetItemStackSize(oItem);
        if (nPBlue > nPMax)
        {
          int nMany = nPBlue - nPMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Pale Blue Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "PALEBLUE", nPBlue);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nDRed = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Deep Red Ioun Stone (DEX +1 Each) on the Enchanting Table
      if(sItemTag == "x2_is_deepred" || sItemTag == "IounStoneDeepRed")
      {
        nDRed = nDRed + GetItemStackSize(oItem);
        if (nDRed > nPMax)
        {
          int nMany = nDRed - nPMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Deep Red Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "DEEPRED", nDRed);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nPink = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Pink Ioun Stone (CON +1 Each) on the Enchanting Table
      if(sItemTag == "x2_is_pink" || sItemTag == "IounStonePink")
      {
        nPink = nPink + GetItemStackSize(oItem);
        if (nPink > nPMax)
        {
          int nMany = nPink - nPMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Pink Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "PINK", nPink);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nSandBlue = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Scarlet and Blue Ioun Stone (INT +1 Each) on the Enchanting Table
      if(sItemTag == "x2_is_sandblue" || sItemTag == "IounStoneScarletBlue")
      {
        nSandBlue = nSandBlue + GetItemStackSize(oItem);
        if (nSandBlue > nPMax)
        {
          int nMany = nSandBlue - nPMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Scarlet and Blue Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "SANDBLUE", nSandBlue);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nBlue = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Blue Ioun Stone (WIS +1 Each) on the Enchanting Table
      if(sItemTag == "x2_is_blue" || sItemTag == "IounStoneIncandescentBlue")
      {
        nBlue = nBlue + GetItemStackSize(oItem);
        if (nBlue > nPMax)
        {
          int nMany = nBlue - nPMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Blue Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "BLUE", nBlue);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nPandGreen = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Pink and Green Ioun Stone (CHA +1 Each) on the Enchanting Table
      if(sItemTag == "x2_is_pandgreen" || sItemTag == "IounStonePinkGreen")
      {
        nPandGreen = nPandGreen + GetItemStackSize(oItem);
        if (nPandGreen > nPMax)
        {
          int nMany = nPandGreen - nPMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Pink and Green Ioun Stone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "PANDGREEN", nPandGreen);
      }
      oItem = GetNextItemInInventory();
    }

//: PERSONAL BONUS IN THE FORGE
/******************************************************************************/

/******************************************************************************/
//: ELEMENTAL BONUS IN THE FORGE

    oItem = GetFirstItemInInventory();
    int nAcidFlask = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Acid Flask (DR Acid 5/- or DB 4 Each) on the Enchanting Table
      if(sItemTag == "X1_WMGRENADE001")
      {
        nAcidFlask = nAcidFlask + GetItemStackSize(oItem);

        if(nBType == 1 && nAcidFlask > nDBEMax)
        {
          int nMany = nAcidFlask - nDBEMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Acid Flask.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if(nBType == 2 && nAcidFlask > nDREMax)
        {
          int nMany = nAcidFlask - nDREMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Acid Flask.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "ACIDFLASK", nAcidFlask);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nAlFire = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Alchemist's Fire (DR Fire 5/- or DB 4 Each) on the Enchanting Table
      if(sItemTag == "X1_WMGRENADE002")
      {
        nAlFire = nAlFire + GetItemStackSize(oItem);

        if(nBType == 1 && nAlFire > nDBEMax)
        {
          int nMany = nAlFire - nDBEMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Alchemist's Fire.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if(nBType == 2 && nAlFire > nDREMax)
        {
          int nMany = nAlFire - nDREMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Alchemist's Fire.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "ALCHEMISTFIRE", nAlFire);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nColdstone = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Coldstone (DR Cold 5/- or DB 4 Each) on the Enchanting Table
      if(sItemTag == "X1_IT_MSMLMISC01")
      {
        nColdstone = nColdstone + GetItemStackSize(oItem);

        if(nBType == 1 && nColdstone > nDBEMax)
        {
          int nMany = nColdstone - nDBEMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Coldstone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if(nBType == 2 && nColdstone > nDREMax)
        {
          int nMany = nColdstone - nDREMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Coldstone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "COLDSTONE", nColdstone);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nHolyWater = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Holy Water (DR Divine 5/- or DB 4 Each) on the Enchanting Table
      if(sItemTag == "X1_WMGRENADE005")
      {
        nHolyWater = nHolyWater + GetItemStackSize(oItem);

        if(nBType == 1 && nHolyWater > nDBEMax)
        {
          int nMany = nHolyWater - nDBEMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Holy Water.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if(nBType == 2 && nHolyWater > nDREMax)
        {
          int nMany = nHolyWater - nDREMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Holy Water.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "HOLYWATER", nHolyWater);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nSkeleton = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Skeleton Knuckle (DR Negative 5/- or DB 4 Each) on the Enchanting Table
      if(sItemTag == "NW_IT_MSMLMISC13" || sItemTag == "SkeletonsKnuckle")
      {
        nSkeleton = nSkeleton + GetItemStackSize(oItem);

        if(nBType == 1 && nSkeleton > nDBEMax)
        {
          int nMany = nSkeleton - nDBEMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Skeleton's Knuckle.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if(nBType == 2 && nSkeleton > nDREMax)
        {
          int nMany = nSkeleton - nDREMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Skeleton's Knuckle.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "SKELETON", nSkeleton);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nTstone = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Thunderstone (DR Sonic 5/- or DB 4 Each) on the Enchanting Table
      if(sItemTag == "X1_WMGRENADE007")
      {
        nTstone = nTstone + GetItemStackSize(oItem);

        if(nBType == 1 && nTstone > nDBEMax)
        {
          int nMany = nTstone - nDBEMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Thunderstone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if(nBType == 2 && nTstone > nDREMax)
        {
          int nMany = nTstone - nDREMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Thunderstone.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "THUNDERSTONE", nTstone);
      }
      oItem = GetNextItemInInventory();
    }

    oItem = GetFirstItemInInventory();
    int nQuartz = 0;
    while (GetIsObjectValid(oItem))
    {
      sItemTag = GetTag(oItem);
      //Check For Quartz (DR Electrical 5/- or DB 4 Each) on the Enchanting Table
      if(sItemTag == "NW_IT_MSMLMISC11" || sItemTag == "QuartzCrystal")
      {
        nQuartz = nQuartz + GetItemStackSize(oItem);

        if(nBType == 1 && nQuartz > nDBEMax)
        {
          int nMany = nQuartz - nDBEMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Quartz.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else if(nBType == 2 && nQuartz > nDREMax)
        {
          int nMany = nQuartz - nDREMax;
          SendMessageToPC(oPC,"Please REMOVE " +IntToString(nMany)+ " Quartz.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
          return;
        }
        else SetLocalInt(oPC, "QUARTZ", nQuartz);
      }
      oItem = GetNextItemInInventory();
    }

//: ELEMENTAL BONUS IN THE FORGE
/******************************************************************************/

/******************************************************************************/
//: PRECHECKS

    //Elemental Enhancement Quantities
    int nAcid      = GetLocalInt(oPC,"ACIDFLASK");
    int nCold      = GetLocalInt(oPC,"COLDSTONE");
    int nDivine    = GetLocalInt(oPC,"HOLYWATER");
    int nElectric  = GetLocalInt(oPC,"QUARTZ");
    int nFire      = GetLocalInt(oPC,"ALCHEMISTFIRE");
    int nNegative  = GetLocalInt(oPC,"SKELETON");
    int nSonic     = GetLocalInt(oPC,"THUNDERSTONE");

    //Armor and Weapon AC/AB/Keen Enhancements
    int nAB        = GetLocalInt(oPC,"DIAMOND");
    int nAC        = GetLocalInt(oPC,"DUSTYROSE");
    int nKeen      = GetLocalInt(oPC,"MITHRIL");

    //Personal Quantities
    int nSTR       = GetLocalInt(oPC,"PALEBLUE");
    int nDEX       = GetLocalInt(oPC,"DEEPRED");
    int nCON       = GetLocalInt(oPC,"PINK");
    int nINT       = GetLocalInt(oPC,"SANDBLUE");
    int nWIS       = GetLocalInt(oPC,"BLUE");
    int nCHA       = GetLocalInt(oPC,"PANDGREEN");

    //Now we check to see if there are more TYPES of Elemental items than allowed
    int nElem = 0;
    if(nAcid > 0) nElem = nElem + 1;
    if(nCold > 0) nElem = nElem + 1;
    if(nDivine > 0) nElem = nElem + 1;
    if(nElectric > 0) nElem = nElem + 1;
    if(nFire > 0) nElem = nElem + 1;
    if(nNegative > 0) nElem = nElem + 1;
    if(nSonic > 0) nElem = nElem + 1;

    if(nElem > nTMax)
    {
      SendMessageToPC(oPC,"You are combining more Elemental items than allowed on the Enchanting Table.");
      SetLocalString(oPC, "CRAFTBASE", "NONE");
      SetLocalInt(oPC, "ITEMTOENCHANT", 0);
      return;
    }

    if((nSTR + nDEX + nCON + nINT + nWIS + nCHA) > nPMax)
    {
      SendMessageToPC(oPC,"You are combining more Personal Enhancement items than allowed on the Enchanting Table.");
      SetLocalString(oPC, "CRAFTBASE", "NONE");
      SetLocalInt(oPC, "ITEMTOENCHANT", 0);
      return;
    }

    //Now Check for an AB and AC combination
    if(nAB != 0 && nAC != 0)
    {
      SendMessageToPC(oPC,"You can not have a Diamond and a Dusty Rose Ioun Stone together on the Enchanting Table.");
      SetLocalString(oPC, "CRAFTBASE", "NONE");
      SetLocalInt(oPC, "ITEMTOENCHANT", 0);
      return;
    }

//: PRECHECKS
/******************************************************************************/

/******************************************************************************/
//: ANALYSIS OF WHAT IS IN THE FORGE

    //Now we validate the total Elemental quanties to be within maximums
    if(nBType == 1 && ((nAcid + nCold + nDivine + nElectric + nFire + nNegative + nSonic) > (nDBEMax * nTMax)))
    {
      SendMessageToPC(oPC,"You are combining more elemental Damage Bonus items than allowed on the Enchanting Table.");
      SetLocalString(oPC, "CRAFTBASE", "NONE");
      SetLocalInt(oPC, "ITEMTOENCHANT", 0);
      return;
    }

    if(nBType == 2 && ((nAcid + nCold + nDivine + nElectric + nFire + nNegative + nSonic) > (nDREMax * nTMax)))
    {
      SendMessageToPC(oPC,"You are combining more elemental Damage Resistance items than allowed on the Enchanting Table.");
      SetLocalString(oPC, "CRAFTBASE", "NONE");
      SetLocalInt(oPC, "ITEMTOENCHANT", 0);
      return;
    }

    //Now make sure that a Dusty Rose Ioun Stone is used with an Armor/Helm/Shields/Bracers/Belts/Boots/Amulets/Rings
    string sACCheck = GetLocalString(oPC,"CRAFTBASE");
    if(nAC >= 1)
    {
      if( sACCheck == "WEAPON"
       || sACCheck == "AMMO"
       || sACCheck == "GLOVES"
       || sACCheck == "NONE")
      {
        SendMessageToPC(oPC,"You can not have a Dusty Rose Ioun Stone on the Enchanting Table without an Armor,Helm,Shields,Bracers,Belts,Boots, or Amulet.");
        SetLocalString(oPC, "CRAFTBASE", "NONE");
        SetLocalInt(oPC, "ITEMTOENCHANT", 0);
        return;
      }
    }

    //Now make sure that a Diamond is only used with a Weapon,Ammunition, or Gloves
    string sABCheck = GetLocalString(oPC,"CRAFTBASE");
    if(nAB >= 1)
    {
      if( sABCheck == "ARMOR"
       || sABCheck == "CLOTHING"
       || sABCheck == "HELM"
       || sABCheck == "CLOAK"
       || sABCheck == "BRACER"
       || sABCheck == "TSHIELD"
       || sABCheck == "LSHIELD"
       || sABCheck == "SSHIELD"
       || sABCheck == "BELT"
       || sABCheck == "BOOTS"
       || sABCheck == "AMULET"
       || sACCheck == "RING"
       || sABCheck == "NONE")
      {
        SendMessageToPC(oPC,"You can not have a Diamond on the Enchanting Table without a Weapon,Ammunition, or Gloves.");
        SetLocalString(oPC, "CRAFTBASE", "NONE");
        SetLocalInt(oPC, "ITEMTOENCHANT", 0);
        return;
      }
    }

    //Now make sure that Mithril is only used with a Weapon
    if(nKeen >= 1 && GetLocalString(oPC,"CRAFTBASE") != "WEAPON")
    {
      SendMessageToPC(oPC,"You can not have Mithril on the Enchanting Table without a Weapon.");
      SetLocalString(oPC, "CRAFTBASE", "NONE");
      SetLocalInt(oPC, "ITEMTOENCHANT", 0);
      return;
    }

//: ANALYSIS OF WHAT IS IN THE FORGE
/******************************************************************************/

/******************************************************************************/
//: APPLY ENCHANTMENTS TO ITEM

    string sBaseItem = GetLocalString(oPC,"CRAFTBASE");
    string sBaseTag = GetLocalString(oPC,"CRAFTTAG");
    int nReady = GetLocalInt(oPC, "ITEMTOENCHANT");

    /*
    By this point...only viable items should be in the forge
    so we go through the inventory and grab each item in there
    to start the enchanting process.
    */

    //First we check to see if an Item is ready to enchant
    //And if the Player had enough skill to enchant
    if(nReady == 1 && GetLocalInt(oPC,"NOSKILL") != 1)
    {
      //Now we need the Equipable Item in the inventory
      object oBaseItem = GetItemPossessedBy(oTable,sBaseTag);
      if(nILRSYS == 1)
      {
        //Make a Backup of the original for ILR Checks
        object oChest = GetObjectByTag(sCBackup,1);
        object oBackup = CopyItem(oBaseItem, oChest, TRUE);

        //Now we get the Temp Item and make sure it is a New Item
        oBaseItem = GetItemPossessedBy(oTable,sBaseTag);
        SetLocalInt(oBaseItem,"NEWITEM",1);
      }

      //Get the AB Bonus of the Item
      int nABBonus = GetABBonus(oBaseItem);

      //Now we need the Enhancing Items
      //Elemental Enhancement Quantities
      nAcid      = GetLocalInt(oPC,"ACIDFLASK");
      nCold      = GetLocalInt(oPC,"COLDSTONE");
      nDivine    = GetLocalInt(oPC,"HOLYWATER");
      nElectric  = GetLocalInt(oPC,"QUARTZ");
      nFire      = GetLocalInt(oPC,"ALCHEMISTFIRE");
      nNegative  = GetLocalInt(oPC,"SKELETON");
      nSonic     = GetLocalInt(oPC,"THUNDERSTONE");

      //Armor and Weapon AC-DR/AB/Keen Enhancements
      nAB        = GetLocalInt(oPC,"DIAMOND");
      nAC        = GetLocalInt(oPC,"DUSTYROSE");
      if(nAC > 6) nAC = 6;//Hard Cap on AC
      int nDR    = GetLocalInt(oPC,"DUSTYROSE");
      nKeen      = GetLocalInt(oPC,"MITHRIL");

      //Now we check whether there are enough Dusty Rose in to Not Remove AC (When DR Sys is Off)
      int nCAC    = GetACBonus(oBaseItem);
      if(nAC > 0 && nAC <= nCAC && nDRSYS == 0)
      {
        int nACItem = FALSE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_ARMOR) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BRACER) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_HELMET) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_CLOAK) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_TOWERSHIELD) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_LARGESHIELD) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_SMALLSHIELD) nACItem = TRUE;

        if(nACItem == TRUE)
        {
          SendMessageToPC(oPC,"You do not have enough Dusty Rose Ioun Stones to overcome the Current AC.");
          SetLocalString(oPC, "CRAFTBASE", "NONE");
          SetLocalInt(oPC, "ITEMTOENCHANT", 0);
          return;
        }
      }

      //Now we check whether there are enough Dusty Rose in to Not Remove AC (When DR Sys is On)
      if(nAC > 0 && nAC <= nCAC && nDRSYS == 1)
      {
        int nACItem = FALSE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BRACER) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_HELMET) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_CLOAK) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_TOWERSHIELD) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_LARGESHIELD) nACItem = TRUE;
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_SMALLSHIELD) nACItem = TRUE;

        if(nACItem == TRUE)
        {
          SendMessageToPC(oPC,"You do not have enough Dusty Rose Ioun Stones to overcome the Current AC.");
          SetLocalString(oPC, "CRAFTBASE", "NONE");
          SetLocalInt(oPC, "ITEMTOENCHANT", 0);
          return;
        }
      }

      //Personal Quantities
      nSTR       = GetLocalInt(oPC,"PALEBLUE");
      nDEX       = GetLocalInt(oPC,"DEEPRED");
      nCON       = GetLocalInt(oPC,"PINK");
      nINT       = GetLocalInt(oPC,"SANDBLUE");
      nWIS       = GetLocalInt(oPC,"BLUE");
      nCHA       = GetLocalInt(oPC,"PANDGREEN");

      //These are for the Equipable Gear Reality System
      //Set Armor as New
      if(GetLocalInt(oBaseItem,"ARMORNEW") == 1)
      {
        SetLocalInt(oBaseItem,"ARMORNEW",0);
      }
      //Set Shield as New
      if(GetLocalInt(oBaseItem,"SHIELDNEW") == 1)
      {
        SetLocalInt(oBaseItem,"SHIELDNEW",0);
      }
      //Set Helm as New
      if(GetLocalInt(oBaseItem,"HELMNEW") == 1)
      {
        SetLocalInt(oBaseItem,"HELMNEW",0);
      }
      //Set Bracer as New
      if(GetLocalInt(oBaseItem,"BRACERNEW") == 1)
      {
        SetLocalInt(oBaseItem,"BRACERNEW",0);
      }
      //Set Cloak as New
      if(GetLocalInt(oBaseItem,"CLOAKNEW") == 1)
      {
        SetLocalInt(oBaseItem,"CLOAKKNEW",0);
      }
      //Set Belt as New
      if(GetLocalInt(oBaseItem,"BELTNEW") == 1)
      {
        SetLocalInt(oBaseItem,"BELTNEW",0);
      }
      //Set Boots as New
      if(GetLocalInt(oBaseItem,"BOOTSNEW") == 1)
      {
        SetLocalInt(oBaseItem,"BOOTSNEW",0);
      }
      //Set Weapon as New
      if(GetLocalInt(oBaseItem,"WEAPONNEW") == 1)
      {
        SetLocalInt(oBaseItem,"WEAPONNEW",0);
      }

      int nWeapon = FALSE;
      int nArmor = FALSE;
      if(sBaseItem == "WEAPON" || sBaseItem == "AMMO" || sBaseItem == "GLOVES") nWeapon = TRUE;
      if(GetBaseItemType(oBaseItem) == BASE_ITEM_ARMOR
          || GetBaseItemType(oBaseItem) == BASE_ITEM_BRACER
          || GetBaseItemType(oBaseItem) == BASE_ITEM_HELMET
          || GetBaseItemType(oBaseItem) == BASE_ITEM_CLOAK
          || GetBaseItemType(oBaseItem) == BASE_ITEM_TOWERSHIELD
          || GetBaseItemType(oBaseItem) == BASE_ITEM_LARGESHIELD
          || GetBaseItemType(oBaseItem) == BASE_ITEM_SMALLSHIELD) nArmor = TRUE;

      if(nAcid > 0)
      {
        if(nWeapon == TRUE)
        {
          AddElemDamage(oBaseItem, IP_CONST_DAMAGETYPE_ACID, nAcid);
        }
        if(nArmor == TRUE)
        {
          AddElemResistance(oBaseItem, IP_CONST_DAMAGETYPE_ACID, nAcid);
        }
      }
      if(nCold > 0)
      {
        if(nWeapon == TRUE)
        {
          AddElemDamage(oBaseItem, IP_CONST_DAMAGETYPE_COLD, nCold);
        }
        if(nArmor == TRUE || GetBaseItemType(oBaseItem) == BASE_ITEM_BOOTS)
        {
          AddElemResistance(oBaseItem, IP_CONST_DAMAGETYPE_COLD, nCold);
        }
      }
      if(nDivine > 0)
      {
        if(nWeapon == TRUE)
        {
          AddElemDamage(oBaseItem, IP_CONST_DAMAGETYPE_DIVINE, nDivine);
        }
        if(nArmor == TRUE
          || GetBaseItemType(oBaseItem) == BASE_ITEM_AMULET
          || GetBaseItemType(oBaseItem) == BASE_ITEM_BELT)
        {
          AddElemResistance(oBaseItem, IP_CONST_DAMAGETYPE_DIVINE, nDivine);
        }
      }
      if(nElectric > 0)
      {
        if(nWeapon == TRUE)
        {
          AddElemDamage(oBaseItem, IP_CONST_DAMAGETYPE_ELECTRICAL, nElectric);
        }
        if(nArmor == TRUE)
        {
          AddElemResistance(oBaseItem, IP_CONST_DAMAGETYPE_ELECTRICAL, nElectric);
        }
      }
      if(nFire > 0)
      {
        if(nWeapon == TRUE)
        {
          AddElemDamage(oBaseItem, IP_CONST_DAMAGETYPE_FIRE, nFire);
        }
        if(nArmor == TRUE)
        {
          AddElemResistance(oBaseItem, IP_CONST_DAMAGETYPE_FIRE, nFire);
        }
      }
      if(nNegative > 0)
      {
        if(nWeapon == TRUE)
        {
          AddElemDamage(oBaseItem, IP_CONST_DAMAGETYPE_NEGATIVE, nNegative);
        }
        if(nArmor == TRUE
          || GetBaseItemType(oBaseItem) == BASE_ITEM_AMULET
          || GetBaseItemType(oBaseItem) == BASE_ITEM_BELT)
        {
          AddElemResistance(oBaseItem, IP_CONST_DAMAGETYPE_NEGATIVE, nNegative);
        }
      }
      if(nSonic > 0)
      {
        if(nWeapon == TRUE)
        {
          AddElemDamage(oBaseItem, IP_CONST_DAMAGETYPE_SONIC, nSonic);
        }
        if(nArmor == TRUE)
        {
          AddElemResistance(oBaseItem, IP_CONST_DAMAGETYPE_SONIC, nSonic);
        }
      }

      if(nAC > 0)
      {
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_ARMOR)
        {
          //DR System is ON
          if(nDRSYS == 1 && GetACBase(oBaseItem) > 1)
          {
            AddArmorDR(oBaseItem,nDR);
          }
          else
          {
            AddArmorAC(oBaseItem,nAC);
          }
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BRACER)
        {
          AddArmorAC(oBaseItem,nAC);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_HELMET)
        {
          AddArmorAC(oBaseItem,nAC);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_CLOAK)
        {
          AddArmorAC(oBaseItem,nAC);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_TOWERSHIELD)
        {
          AddArmorAC(oBaseItem,nAC);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_LARGESHIELD)
        {
          AddArmorAC(oBaseItem,nAC);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_SMALLSHIELD)
        {
          AddArmorAC(oBaseItem,nAC);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_AMULET)
        {
          AddArmorAC(oBaseItem,nAC);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_RING)
        {
          AddArmorAC(oBaseItem,nAC);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BOOTS)
        {
          AddArmorAC(oBaseItem,nAC);
        }
      }
      if(nAB > 0 && nAB > nABBonus)
      {
        if(sBaseItem == "WEAPON" || sBaseItem == "GLOVES")
        {
          if(GetBaseItemType(oBaseItem) == BASE_ITEM_LONGBOW
            || GetBaseItemType(oBaseItem) == BASE_ITEM_SHORTBOW
            || GetBaseItemType(oBaseItem) == BASE_ITEM_SLING
            || GetBaseItemType(oBaseItem) == BASE_ITEM_LIGHTCROSSBOW
            || GetBaseItemType(oBaseItem) == BASE_ITEM_HEAVYCROSSBOW
            || GetBaseItemType(oBaseItem) == BASE_ITEM_GLOVES)
          {
            IPSafeAddItemProperty(oBaseItem, ItemPropertyAttackBonus(nAB), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
          }
          else
          {
            IPSafeAddItemProperty(oBaseItem, ItemPropertyEnhancementBonus(nAB), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
          }
        }
        if(sBaseItem == "AMMO")
        {
          if(GetBaseItemType(oBaseItem) == BASE_ITEM_ARROW)
          {
            IPSafeAddItemProperty(oBaseItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, nAB * IP_CONST_DAMAGEBONUS_1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
          }
          if(GetBaseItemType(oBaseItem) == BASE_ITEM_BOLT)
          {
            IPSafeAddItemProperty(oBaseItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, nAB * IP_CONST_DAMAGEBONUS_1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
          }
          if(GetBaseItemType(oBaseItem) == BASE_ITEM_BULLET)
          {
            IPSafeAddItemProperty(oBaseItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nAB * IP_CONST_DAMAGEBONUS_1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
          }
        }
      }
      if(nKeen > 0)
      {
        if(sBaseItem == "WEAPON")
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyKeen(), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
      }
      if(nSTR > 0)
      {
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_LONGBOW
            || GetBaseItemType(oBaseItem) == BASE_ITEM_SHORTBOW
            || GetBaseItemType(oBaseItem) == BASE_ITEM_SLING
            || GetBaseItemType(oBaseItem) == BASE_ITEM_LIGHTCROSSBOW
            || GetBaseItemType(oBaseItem) == BASE_ITEM_HEAVYCROSSBOW)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyMaxRangeStrengthMod(nSTR), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BRACER)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, nSTR), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_GLOVES)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, nSTR), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BELT)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, nSTR), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
      }
      if(nDEX > 0)
      {
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BOOTS)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, nDEX), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_GLOVES)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, nDEX), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_RING)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, nDEX), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
      }
      if(nCON > 0)
      {
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_AMULET)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, nCON), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BELT)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, nCON), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_BOOTS)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, nCON), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
      }
      if(nINT > 0)
      {
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_AMULET)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, nINT), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_HELMET)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, nINT), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_RING)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, nINT), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
      }
      if(nWIS > 0)
      {
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_AMULET)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, nWIS), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_HELMET)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, nWIS), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_RING)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, nWIS), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
      }
      if(nCHA > 0)
      {
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_ARMOR)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, nCHA), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_HELMET)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, nCHA), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_CLOAK)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, nCHA), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_AMULET)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, nCHA), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
        if(GetBaseItemType(oBaseItem) == BASE_ITEM_RING)
        {
          IPSafeAddItemProperty(oBaseItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, nCHA), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        }
      }
    }

//: APPLY ENCHANTMENTS TO ITEM
/******************************************************************************/

/******************************************************************************/
//: CLEANUP THE FORGE

    //Now we need to check the ILR (Item Level Restrictions) Settings for the new Item
    if(nILRSYS == 1 && GetLocalInt(oPC, "NOSKILL") != 1)
    {
      //Now we need the Equipable Item in the inventory
      object oBaseItem = GetItemPossessedBy(oTable,sBaseTag);

      int nHD = GetHitDice(oPC);
      int nGPMax = StringToInt(Get2DAString("itemvalue", "MAXSINGLEITEMVALUE", (nHD - 1)));
      int nCost = GetGoldPieceValue(oBaseItem);

      //Check for Greater than Allowed Cost
      if(nCost > nGPMax || nCost > nILRGMAX)
      {
        if(nCost > nGPMax)
        {
          SendMessageToPC(oPC,"You will need more experience to Enchant and then USE this item.");
          SendMessageToPC(oPC,"Please try again with less enhancement components.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
        }
        else if(nCost > nILRGMAX)
        {
          SendMessageToPC(oPC,"DM Module Settings forbid to Enchant this quality of item.");
          SendMessageToPC(oPC,"Please try again with less enhancement components.");
          SetLocalInt(oPC, "NOCLEANUP", 1);
        }

        //Now Destroy the New Item
        object oItem = GetFirstItemInInventory(oTable);
        while(GetIsObjectValid(oItem))
        {
          if(GetTag(oItem) == sBaseTag)
          {
            int nCheck = GetLocalInt(oItem,"NEWITEM");
            if(nCheck == 1) DestroyObject(oItem);
          }
          oItem = GetNextItemInInventory();
        }

        object oChest = GetObjectByTag(sCBackup,1);
        object oBackup = CopyItem(GetItemPossessedBy(oChest,sBaseTag), oTable, TRUE);
        DestroyObject(GetItemPossessedBy(oChest,sBaseTag));
      }
      else
      {
        //Now Destroy the Backup
        object oChest = GetObjectByTag(sCBackup,1);
        DestroyObject(GetItemPossessedBy(oChest,sBaseTag));

        //Now Destroy the Old Item
        object oItem = GetFirstItemInInventory(oTable);
        while(GetIsObjectValid(oItem))
        {
          if(GetTag(oItem) == sBaseTag)
          {
            int nCheck = GetLocalInt(oItem,"NEWITEM");
            if(nCheck == 0) DestroyObject(oItem);
          }
          oItem = GetNextItemInInventory();
        }

        oBaseItem = GetItemPossessedBy(oTable,sBaseTag);
        DeleteLocalInt(oBaseItem,"NEWITEM");
      }

      if(nCost <= nGPMax && nCost < nILRGMAX && nILRGOLD == 1)
      {
        TakeGoldFromCreature(nCost,oPC,TRUE);
      }
    }

    //We need to destroy all the components if the Player didn't have enough skill
    if(GetLocalInt(oPC, "NOSKILL") == 1)
    {
      object oItem = GetFirstItemInInventory(oTable);
      while(GetIsObjectValid(oItem))
      {
        if (GetTag(oItem) != sBaseTag)
        {
          DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory();
      }
      return;
    }

    //We check for no unnecessary cleanup
    else if(GetLocalInt(oPC,"NOCLEANUP") == 1) return;

    //We clean up the Table and allow effects to take place
    else
    {
      object oItem = GetFirstItemInInventory(oTable);
      while(GetIsObjectValid(oItem))
      {
        if (GetTag(oItem) != sBaseTag)
        {
          DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory();
      }
      SetLocalInt(oPC, "NOCLEANUP", 0);
    }

    //Now Take XP if Set to On
    int nXPReq = GetLocalInt(oMod,"XPREQ");
    if(nXPReq == 1)
    {
      int nXPCost = GetLocalInt(oMod,"XPCOST");
      int nCXP = GetXP(oPC);
      int nNXP = nCXP - nXPCost;
      SetXP(oPC,nNXP);

      SendMessageToPC(oPC,"You have lost "+IntToString(nXPCost)+"XP for this Successful Enchant.");
    }

    //Now Set To Stolen if Set to On
    int nStolen = GetLocalInt(oMod,"STOLEN");
    if(nStolen == 1)
    {
      oBaseItem = GetItemPossessedBy(oTable,sBaseTag);
      SetStolenFlag(oBaseItem,TRUE);
    }

//: CLEANUP THE FORGE
/******************************************************************************/

/******************************************************************************/
//: CLEAR ALL THE LOCALS AND VARIABLES

    //Lock for 1 Round
    SetLocked(oTable,TRUE);
    DelayCommand(6.0,AssignCommand(oTable,SetLocked(oTable,FALSE)));
    SendMessageToPC(oPC,"The Enchanting Table will be locked for 1 Round while processing.");

    if(GetLocalInt(oPC,"NOCLEANUP") != 1)
    {
      //Only apply some effects if we really enchanted something
      location lLoc = GetLocation(OBJECT_SELF);
      effect eFX1 = EffectVisualEffect(VFX_FNF_TIME_STOP);
      effect eFX2 = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);

      ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eFX1, lLoc, 3.0);
      ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eFX2, lLoc, 3.0);
    }

    //Clear All Variables To End
    DeleteLocalInt(oPC, "ITEMTOENCHANT");
    DeleteLocalInt(oPC, "NOSKILL");
    DeleteLocalInt(oPC, "NOCLEANUP");
    DeleteLocalString(oPC, "CRAFTBASE");
    DeleteLocalString(oPC, "CRAFTTAG");
    DeleteLocalInt(oPC, "ACIDFLASK");
    DeleteLocalInt(oPC, "COLDSTONE");
    DeleteLocalInt(oPC, "HOLYWATER");
    DeleteLocalInt(oPC, "QUARTZ");
    DeleteLocalInt(oPC, "ALCHEMISTFIRE");
    DeleteLocalInt(oPC, "SKELETON");
    DeleteLocalInt(oPC, "THUNDERSTONE");
    DeleteLocalInt(oPC, "DIAMOND");
    DeleteLocalInt(oPC, "DUSTYROSE");
    DeleteLocalInt(oPC, "MITHRIL");
    DeleteLocalInt(oPC, "PALEBLUE");
    DeleteLocalInt(oPC, "DEEPRED");
    DeleteLocalInt(oPC, "PINK");
    DeleteLocalInt(oPC, "SANDBLUE");
    DeleteLocalInt(oPC, "BLUE");
    DeleteLocalInt(oPC, "PANDGREEN");

//: CLEAR ALL THE LOCALS AND VARIABLES
/******************************************************************************/

}
