////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realsitic Systems
//  default
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is the 'Hard Coded' Player Heartbeat.
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"
#include "obd_include"
#include "oho_inc"

void main()
{
  object oPC = OBJECT_SELF;
  string sDB = ORS_GetDBString();

  //Set Current HP's
  int nHPStatus = GetCurrentHitPoints(oPC);
  NBDE_SetCampaignInt(sDB,"HP",nHPStatus,oPC);

  //ORS Allegiance and Subraces
  string sPCSKIN = NBDE_GetCampaignString(sDB, "ORS_ALIGN_SKIN", oPC);
  object oOSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
  string sOSkin = GetResRef(oOSkin);

  if(sOSkin != sPCSKIN)
  {
    int nSkin = FALSE;

    //Within 10 Meters of Starting Location
    location lStart = GetStartingLocation();
    location lPC = GetLocation(oPC);
    float fStart = GetDistanceBetweenLocations(lStart,lPC);
    if(fStart < 0.0 || fStart > 10.0) nSkin = TRUE;

    //Already in Void and Not Near Start Location (Preparing to Jump)
    object oVoid = GetNearestObjectByTag("WP_VOID",oPC);
    if(!GetIsObjectValid(oVoid) && nSkin == TRUE)
    {
      ORS_Subrace(oPC);
    }
  }

  //Death System Forced Respawning
  int nRespawn = GetLocalInt(oPC,"OBD_FORCE_RESPAWN");
  if(nRespawn > 0)
  {
    RespawnForcedDelay(oPC);
  }

  //Respawn Portal Cooldown
  int nCooldown = GetLocalInt(oPC,"OBD_PORTAL_DEL_COUNT");
  if(nCooldown > 0)
  {
    RespawnPortalDelay(oPC);
  }

  //Standard Faction Resets
  SetStandardFactionReputation(STANDARD_FACTION_COMMONER,50,oPC);
  SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);
  SetStandardFactionReputation(STANDARD_FACTION_DEFENDER,100,oPC);
  SetStandardFactionReputation(STANDARD_FACTION_HOSTILE,0,oPC);

/*  //ORS Tracking
  ORS_Tracking(oPC);

  //Horse/Rider AC
  int nRoll;
  int bNoCombat=GetLocalInt(GetModule(),"X3_NO_MOUNTED_COMBAT_FEAT");
  if(!bNoCombat&&GetHasFeat(FEAT_MOUNTED_COMBAT,oPC) && HorseGetIsMounted(oPC))
  {
    nRoll=d20()+GetSkillRank(SKILL_RIDE,oPC);
    nRoll=nRoll-10;
    if(nRoll>4)
    {
      nRoll=nRoll/5;
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACIncrease(nRoll),oPC,7.0);
    }
    */
//  }
}
