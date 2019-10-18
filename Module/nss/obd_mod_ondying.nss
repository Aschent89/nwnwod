////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_mod_ondying
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is the Module OnDying Event
//
////////////////////////////////////////////////////////////////////////////////

#include "obd_include"

void main()
{
   object oDying = GetLastPlayerDying();
   object oKiller = GetLastHostileActor(oDying);

   int nBleedStatus = GetLocalInt(oDying, "BLEED_STATUS");

   string sDB = OBD_GetDBString();

   //On occasion, when called from death, oDying will not be set, retrieve
   //from the var set there
   if(!GetIsObjectValid(oDying))
   {
     object oDead = GetLocalObject(OBJECT_SELF, "LAST_PLAYER_DYING");
     if(GetIsObjectValid(oDead))
     {
       oDying = oDead;
       SetLocalObject(OBJECT_SELF, "LAST_PLAYER_DYING", OBJECT_INVALID);
       if(GetCurrentHitPoints(oDying) > 0) return;
     }
     else return;
   }

   //Get our hit points
   int nHP = GetCurrentHitPoints(oDying);
   if (nHP > 0)
   {
      SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_CONSCIOUS);
      NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_CONSCIOUS,oDying);
      return;
   }

   //It should be noted: OnPlayerDying will NEVER be called if a single blow
   // or spell effect takes the player to -10 or lower hit points...
   if (nHP < -10)
   {
     if(nBleedStatus > BLEED_STATUS_CONSCIOUS && nBleedStatus < BLEED_STATUS_INSTANT_DEATH)
     {
       SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_DEAD);
       NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_DEAD,oDying);
       effect eDeath = EffectDeath(TRUE, FALSE);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oDying);
       return;
     }
   }

   //Already Bleeding
   if(nBleedStatus == BLEED_STATUS_BLEEDING) return;

   //Scale Damage
   if(nBleedStatus != BLEED_STATUS_INSTANT_DEATH && SCALE_PERCENT != 1.0f)
   {
      float fTemp = IntToFloat(nHP);
      int nHeal = FloatToInt((SCALE_PERCENT * fTemp) - fTemp + 0.5f);
      effect eHeal = EffectHeal(nHeal);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oDying);
   }

   //Set/Reset Our Bleeding Status and Prepare for Bleeding
   SetLocalInt(oDying, "BLEED_STATUS", BLEED_STATUS_BLEEDING);
   NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_BLEEDING,oDying);
   AssignCommand(oDying, ClearAllActions());
   SetLocalInt(oDying, "LAST_HP", GetCurrentHitPoints(oDying));
   effect ePara = EffectParalyze();
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oDying, ROUND);

   //Get nearest 20 enemy creatures and see if they are attacking me
   if(GetIsObjectValid(oKiller) == FALSE)
   {
     oKiller = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oDying);
   }

   int nTh = 1;
   object oProbe = oKiller;
   while (GetIsObjectValid(oProbe) && nTh < 20)
   {
     if(GetIsPC(oProbe) == FALSE)
     AssignCommand(oProbe, ClearMyAttacker(oDying));
     oProbe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oDying, nTh++);
   }

   //Make Sure Player has no Regeneration During Bleeding
   if(UNEQUIP_REGEN == FALSE) UnequipRegeneration(oDying);

   //Run Bleed - Let the Bleeding Begin
   DelayCommand(ROUND, Bleed(oDying));
}
