////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_mod_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is the Client OnEnter Event
//
////////////////////////////////////////////////////////////////////////////////

#include "obd_include"

void main()
{
    object oPC          = GetEnteringObject();
    object oMod         = GetModule();
    object oTargetPerm  = GetWaypointByTag("WP_PERMDEATH");
    object oItem        = GetItemPossessedBy(oPC, "DeathDeed");
    string sDB          = OBD_GetDBString();

    //Don't go further if this is a DM
    if(GetIsDM(oPC) == TRUE || GetIsDMPossessed(oPC) == TRUE) return;

    //Don't go further if this is not a Player
    if(GetIsPC(oPC) == FALSE) return;

    //Binding Stone System
    int nDeathChoose = GetLocalInt(oMod,"DEATHCHOOSE");
    if(nDeathChoose != 1) return;

    //Set the Bleed Status to the Player When Enters
    int nBleedStatus = NBDE_GetCampaignInt(sDB,"BLEED_STATUS",oPC);
    SetLocalInt(oPC,"BLEED_STATUS",nBleedStatus);
    if(nBleedStatus > 0)
    {
      effect eDeath = EffectDeath(FALSE, FALSE);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
      SendMessageToAllDMs(GetName(oPC)+" Tried to Escape Death by Logging Off. Now BACK to Death!");
      SendMessageToPC(oPC,"You Tried to Escape Death by Logging Off. Now BACK to Death!");
      return;
    }

    location lTargetPerm = GetLocation(oTargetPerm);

    effect ePerm    = EffectVisualEffect(VFX_IMP_DEATH_L); // Permanent Death base respawn effect
    effect eFX1     = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER); // For Healing at Respawn Area
    effect eFX2     = EffectVisualEffect(VFX_IMP_HEALING_G); //For after Raise Dead effect at Bind Stone or Home
    effect eFX3     = EffectVisualEffect(VFX_IMP_RAISE_DEAD); //For Bind Stone/Home/Death Eternal effect
    effect eFX4     = EffectVisualEffect(VFX_IMP_UNSUMMON); // For leaving the dead corpse at respawn
    effect eFX5     = EffectVisualEffect(VFX_IMP_GOOD_HELP); // Permanent Death Effect
    effect eFX6     = EffectVisualEffect(VFX_IMP_EVIL_HELP); // Permanent Death Effect

    float fDelay = 1.5;
    int nClearCombatState;

    //Check for a Death Deed
    if(oItem != OBJECT_INVALID)
    {
      //Send to Death Eternal
      AssignCommand(oPC, ClearAllActions(TRUE));
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX4, oPC);
      DelayCommand(fDelay, AssignCommand(oPC, ActionJumpToLocation(lTargetPerm)));
      DelayCommand(fDelay + 2.0, SetPlotFlag(oPC, FALSE));
      DelayCommand(fDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
      DelayCommand(fDelay + 3.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, ePerm, lTargetPerm));
      DelayCommand(fDelay + 4.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX3,  lTargetPerm));
      DelayCommand(fDelay + 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 5.0));
      DelayCommand(fDelay + 6.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX1,  lTargetPerm));
      DelayCommand(fDelay + 7.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC));
      DelayCommand(fDelay + 8.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX2,  lTargetPerm));
      DelayCommand(fDelay + 9.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX5,  lTargetPerm));
      DelayCommand(fDelay + 10.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, eFX6,  lTargetPerm));
      return;
    }

    int nHPStatus = NBDE_GetCampaignInt(sDB,"HP",oPC);
    int nCurHP = GetCurrentHitPoints(oPC);
    int nMaxHP = GetMaxHitPoints(oPC);

    //Something happened to DB
    if(nHPStatus < 1)
    {
      NBDE_SetCampaignInt(sDB,"HP",nMaxHP,oPC);
    }

    //Now Set the DB HP to the Player
    else
    {
      int nHPTotal = (nMaxHP - nHPStatus);
      effect eDam = EffectDamage(nHPTotal);
      ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC,0.0);
    }
}
