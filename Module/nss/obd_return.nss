////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_return
//  By Don Anderson
//  dandersonru@msn.com
//
//  This will return the Player to either
//  the last saved Binding Stone or the Home Location
//
////////////////////////////////////////////////////////////////////////////////

#include "obd_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oSoulRune = GetItemPossessedBy(oPC, "SoulRune");
    string sDB = OBD_GetDBString();

    //Remove a Life
    int nStack = GetItemStackSize(oSoulRune);
    if(nStack > 1) SetItemStackSize(oSoulRune,nStack--);
    else DestroyObject(oSoulRune);

    effect eFX1 = EffectVisualEffect(VFX_IMP_BREACH);
    effect eFX2 = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eFX3 = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
    effect eFX4 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
    effect eFX5 = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER); // For Healing at Respawn Area
    effect eFX6 = EffectVisualEffect(VFX_IMP_HEALING_G); //For after Raise Dead effect at Bind Stone or Home

    string sDestTagBS = NBDE_GetCampaignString(sDB,"BS_LASTBINDPOINT",oPC);
    object oSpawnPointBS = GetObjectByTag(sDestTagBS);

    float fDelay = 1.5;

    // Checks to see if the Bindpoint is valid
    if(GetIsObjectValid(oSpawnPointBS))
    {
      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX1, oPC));
      DelayCommand(fDelay + 1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX2, oPC));
      DelayCommand(fDelay + 2.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(oSpawnPointBS))));
      DelayCommand(fDelay + 3.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
      DelayCommand(fDelay + 4.0, ApplyEffectToObject (DURATION_TYPE_INSTANT, eFX3, oPC));
      DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
      DelayCommand(fDelay + 6.0, ApplyEffectToObject (DURATION_TYPE_INSTANT, eFX4, oPC));
      DelayCommand(fDelay + 7.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC));
    }
}
