#include "vamp_txt_comp"

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

if (GetStringLowerCase(GetSubRace(oCaster))=="vampire")
  {
  // shapechange can have many spell ids.
  if (nSpell == 392 || nSpell == 393
      || nSpell == 394 || nSpell == 395 || nSpell == 396)
     nSpell = SPELL_SHAPECHANGE;

  switch (nSpell)
  {
     case SPELL_ALL_SPELLS:
         oComp = GetItemPossessedBy(oCaster, "FALLEN_VAMPIRE_GOOD_BLOOD");
    SendMessageToPC(oCaster,"You do not have the blood needed to cast this spell");
         sSpellId = "blood";
         break;


 return 0;
  }
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
    SendMessageToPC(oCaster,"You do not have the blood needed to cast this spell");
        ClearAllActions();
        return 1;
       }// End If
     else
       {
        if (nSpell == SPELL_SHAPECHANGE)
        {
           if (GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD, oCaster)) != "jadecirclet")
           {
    SendMessageToPC(oCaster,"You do not have the blood needed to cast this spell");
              return 1;
           }
           else
           {
             return 0;
           }
        }
        int iStack = GetNumStackedItems(oComp) - 1;
        DestroyObject(oComp);
//        if (iStack > 0)
//           DelayCommand(1.0, CreateMatComp(sSpellId, oCaster, iStack));
       }// End Else
    }// End If

  }
return 0;
}
