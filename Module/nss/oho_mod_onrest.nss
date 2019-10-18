////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_mod_onrest
//  By Don Anderson
//  dandersonru@msn.com
//
//  Dismounts and Cleans Up Lingering Horse Effects.
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC  = GetLastPCRested();
  object oMod = GetModule();
  int nRestType = GetLastRestEventType();

  if(OHOPCRidingHorse(oPC) && nRestType == REST_EVENTTYPE_REST_CANCELLED)
  {
    if(GetIsPC(oPC))
    {
      SetSkinInt(oPC,"bX3_IS_MOUNTED",TRUE);
      SetLocalInt(oPC,"bX3_M_ARCHERY",TRUE);

      AssignCommand(oPC,SpeakString("Dismount!"));
      OHODismountHorse(oPC);
      return;
    }
  }
  else if(OHOPCRidingHorse(oPC) && nRestType == REST_EVENTTYPE_REST_CANCELLED)
  {
    if(GetIsPC(oPC))
    {
      //Remove Mounted Bioware Stuff
      HORSE_SupportOriginalSpeed(oPC);
      DelayCommand(0.4,HORSE_SupportRemoveMountedSkillDecreases(oPC));
      HORSE_SupportRemoveACBonus(oPC);
      HORSE_SupportRemoveHPBonus(oPC);

      effect eEffect = GetFirstEffect(oPC);
      while(GetIsEffectValid(eEffect))
      {
        if((GetEffectType(eEffect)==EFFECT_TYPE_ATTACK_DECREASE)
          && (GetEffectSubType(eEffect)==SUBTYPE_SUPERNATURAL)
          && (GetEffectDurationType(eEffect)==DURATION_TYPE_PERMANENT))
        {
          RemoveEffect(oPC,eEffect);
          break;
        }

        eEffect=GetNextEffect(oPC);
      }

      SetLocalInt(oPC,"bX3_M_ARCHERY",FALSE);
      SetSkinInt(oPC,"bX3_IS_MOUNTED",FALSE);
    }
  }
}
