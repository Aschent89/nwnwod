////////////////////////////////////////////////////////////////////////////////
//  DM Player Qualified Room
//  ors_oe_dmacct
//  By Don Anderson
//  dandersonru@msn.com
//
//  Sends Non Qualified Players to Start Location
//  Place this script in the Trigger On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
    object oPC      = GetEnteringObject();
    object oTrigger = OBJECT_SELF;

    if(ORS_IsEnabledDM(oPC))
    {
      SendMessageToPC(oPC,"Welcome DM!");
      return;
    }
    else
    {
      location lStart = GetStartingLocation();
      float fDelay    = 1.0;
      effect eFX1     = EffectVisualEffect(VFX_IMP_UNSUMMON);
      effect eFX2     = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);

      AssignCommand(oPC,ClearAllActions(TRUE));

      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 10.0));
      DelayCommand(fDelay + 3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX1, oPC));
      DelayCommand(fDelay + 4.0, AssignCommand(oPC, JumpToLocation(lStart)));
      DelayCommand(fDelay + 6.0, AssignCommand(oPC, JumpToLocation(lStart)));
      DelayCommand(fDelay + 6.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX2, oPC));
    }
}

