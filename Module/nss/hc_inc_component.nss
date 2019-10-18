// hcr3
// apparently due to a bug in 1.3 i have to check not only for if a pc but also
// if not a dm!
// sr6.1
// this script replaces the duplication in all spell scripts.
// it is called by wm_include

#include "hc_inc_crmatcomp"
#include "hc_text_comp"

int CheckComponents(int nSpell)
{

  // Declare major variables.
  object oCaster = OBJECT_SELF;
  object oRealMaster;
  object oMaster = GetMaster(oCaster);
  // check for components depending on spell cast
  object oComp;
  string sSpellmsg;
  string sSpellId;
  // shapechange can have many spell ids.
  if (nSpell == 392 || nSpell == 393
      || nSpell == 394 || nSpell == 395 || nSpell == 396)
     nSpell = SPELL_SHAPECHANGE;

  switch (nSpell){
     case SPELL_GREATER_STONESKIN:
         oComp = GetItemPossessedBy(oCaster, "diamonddust");
         sSpellmsg = s1;
         sSpellId = "tinydiamondpowde";
         break;
     case SPELL_ANIMATE_DEAD:
         oComp= GetItemPossessedBy(oCaster, "blackonyxgem");
         sSpellmsg = s2;
         sSpellId = "smallblackonyx";
         break;
     case SPELL_CREATE_GREATER_UNDEAD:
         oComp= GetItemPossessedBy(oCaster, "blackonyxgem");
         sSpellmsg = s2;
         sSpellId = "smallblackonyx";
         break;
     case SPELL_CREATE_UNDEAD:
         oComp= GetItemPossessedBy(oCaster, "blackonyxgem");
         sSpellmsg = s2;
         sSpellId = "smallblackonyx";
         break;
     case SPELL_CIRCLE_OF_DEATH:
         oComp = GetItemPossessedBy(oCaster, "codeathpearl");
         sSpellmsg = s3;
         sSpellId = "crushedblackpear";
         break;
     case SPELL_IDENTIFY:
         oComp = GetItemPossessedBy(oCaster, "pearlinfusion");
         sSpellmsg = s4;
         sSpellId = "pearlinfusion";
         break;
     case SPELL_MORDENKAINENS_SWORD:
         oComp = GetItemPossessedBy(oCaster, "minplatsword");
         sSpellmsg = s5;
         sSpellId = "minitureplatinum";
         break;
     case SPELL_RAISE_DEAD:
         oComp = GetItemPossessedBy(oCaster, "ressdiamond");
         sSpellmsg = s6;
         sSpellId = "smalldiamond";
         break;
     case SPELL_RESURRECTION:
         oComp = GetItemPossessedBy(oCaster, "ressdiamond");
         sSpellmsg = s6;
         sSpellId = "smalldiamond";
         break;
     case SPELL_RESTORATION:
         oComp = GetItemPossessedBy(oCaster, "diamonddust");
         sSpellmsg = s7;
         sSpellId = "tinydiamondpowde";
         break;
     case SPELL_SHAPECHANGE:
         oComp= GetItemPossessedBy(oCaster, "jadecirclet");
         sSpellmsg = s8;
         sSpellId = "";
         break;
     case SPELL_STONESKIN:
         oComp = GetItemPossessedBy(oCaster, "diamonddust");
         sSpellmsg = s7;
         sSpellId = "tinydiamondpowde";
         break;
     case SPELL_TRUE_SEEING:
         oComp = GetItemPossessedBy(oCaster, "mushointment");
         sSpellmsg = s9;
         sSpellId = "mushroomointment";
         break;

  default: return 0;
  }


  // Determine if using the Hench System or generic henchman.
  oRealMaster = GetLocalObject(oCaster, "REAL_MASTER");
  if (!GetIsObjectValid(oRealMaster))
     oRealMaster = oMaster;
  // hcr3
  // It is a PC casting this spell.
  if (GetIsPC(oCaster) &&
      !GetIsDM(oCaster) &&
      !GetIsDM(oRealMaster))
    {
     if (!GetIsObjectValid(oComp))
       {
        SendMessageToPC(oCaster, COMP + sSpellmsg);
        ClearAllActions();
        return 1;
       }// End If
     else
       {
        if (nSpell == SPELL_SHAPECHANGE)
        {
           if (GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD, oCaster)) != "jadecirclet")
           {
              SendMessageToPC(oCaster, s10);
              return 1;
           }
           else
           {
              return 0;
           }
        }
        int iStack = GetNumStackedItems(oComp) - 1;
        DestroyObject(oComp);
        if (iStack > 0)
           DelayCommand(1.0, CreateMatComp(sSpellId, oCaster, iStack));
       }// End Else
    }// End If

  // It is a henchman casting this spell.
  else if (!GetIsPC(oCaster) &&
           GetIsObjectValid(oRealMaster) && GetIsPC(oRealMaster) &&
           GetIsDM(oCaster) == FALSE && GetIsDM(oRealMaster) == FALSE &&
           oCaster ==  GetAssociate( ASSOCIATE_TYPE_HENCHMAN, GetMaster()))
    {
     if (!GetIsObjectValid(oComp))
       {
        SendMessageToPC(oRealMaster, GetName(oCaster) + HCOMP + sSpellmsg);
        ClearAllActions();
        return 1;
       }// End If
     else
       {
        if (nSpell == SPELL_SHAPECHANGE)
        {
            return 0;
        }
        int iStack = GetNumStackedItems(oComp) - 1;
        DestroyObject(oComp);
        if (iStack > 0)
           DelayCommand(1.0, CreateMatComp(sSpellId, oCaster, iStack));
       }// End Else
    }// End Else If
return 0;
}
