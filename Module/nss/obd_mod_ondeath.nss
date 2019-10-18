////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_mod_ondeath
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is the Module OnDeath Event
//
////////////////////////////////////////////////////////////////////////////////

#include "obd_include"

void main()
{
   object oDead = GetLastPlayerDied();
   object oKiller = GetLastHostileActor(oDead);
   string sDB = OBD_GetDBString();

   int nBleedStatus = NBDE_GetCampaignInt(sDB,"BLEED_STATUS",oDead);

   //If Instant death, Scaling, or Bleeding Have Not Been Set
   if(!(INSTANT_DEATH || SCALE_PERCENT == 1.0f || nBleedStatus))
   {
     int nHP = GetCurrentHitPoints(oDead);
     float fHP = IntToFloat(nHP);

     //In the Capture the Flag Arena
     object oCtF = GetNearestObjectByTag("WP_CTF_ARENA",oDead,1);
     if(GetIsObjectValid(oCtF))
     {
       ExecuteScript("ors_ctf_death",oDead);
     }

     //We Are Not WAY dead
     if(FloatToInt((SCALE_PERCENT * fHP) + 0.5f) > -10)
     {
       //Resurrect and Heal the Player (Still Negative HP)
       int nDamage = -FloatToInt((SCALE_PERCENT * fHP) - 1.5f);
       effect eDamage = EffectDamage(nDamage);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oDead);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oDead);

       //Set Local and Make this Persistent
       SetLocalInt(oDead, "BLEED_STATUS", BLEED_STATUS_INSTANT_DEATH);
       NBDE_SetCampaignInt(sDB,"BLEED_STATUS",BLEED_STATUS_INSTANT_DEATH,oDead);

       //Call the OnPlayerDying script
       SetLocalObject(OBJECT_SELF, "LAST_PLAYER_DYING", oDead);
       ExecuteScript("obd_mod_ondying", oDead);
       return;
     }
   }

   //Respawn Delay
   int nTimesDied = GetLocalInt(oDead, "PLAYER_DIED");
   float fDelay = 1.0;
   if(INSTANT_RESPAWN == FALSE) fDelay = ROUND + (ROUND * nTimesDied);

   //Drop the Back Pack
   if(DROP_BACKPACK == TRUE) PutItemsInPack(oDead);

   //Increment Times Died....No Persistence Necessary Here
   nTimesDied++;
   SetLocalInt(oDead, "PLAYER_DIED", nTimesDied);

   //Respawn During Combat
   if(RESPAWN_DURING_COMBAT == TRUE) DelayCommand(fDelay, ShowDeathGUI(oDead, nTimesDied));
   else DelayCommand(fDelay, CheckForCombat(oDead, nTimesDied));
}
