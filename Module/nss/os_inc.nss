////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Siege System Include File
//  os_inc
//  by Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "x0_i0_spells"
#include "x0_i0_position"

/******************************************************************************/
//::CONSTANTS

//Siege Weapon Types Tags
const string SIEGEARBALEST_LGT  = "SiegeArbalestLgt";//Light Spear Siege
const string SIEGEARBALEST_HVY  = "SiegeArbalestHvy";//Heavy Spear Siege
const string SIEGEBRICOLE       = "SiegeBricole";//Light Stone Siege
const string SIEGECANNON        = "SiegeCannon";//Heavy Iron Ball Siege
const string SIEGECATAPULT_LGT  = "SiegeCatapultLgt";//Fire and Acid Grenades
const string SIEGECATAPULT_HVY  = "SiegeCatapultHvy";//Fire and Acid Grenades
const string SIEGECOUILLARD     = "SiegeCouillard";//Heavy Stone Siege
const string SIEGEONAGER        = "SiegeOnager";//Field Spread Effects like Oil and Caltrops
const string SIEGEPERRIERE      = "SiegePerriere";//Medium Stone Siege

//Control Switch and Supply Distances
const float SIEGE_SWITCH        = 60.0;
const float SIEGE_SUPPLY        = 15.0;

//Siege Weapon Ranges (Max and Min)
const float MAXRANGE_SIEGEARBALEST_LGT  = 30.0;
const float MINRANGE_SIEGEARBALEST_LGT  =  0.0;
const float MAXRANGE_SIEGEARBALEST_HVY  = 50.0;
const float MINRANGE_SIEGEARBALEST_HVY  =  0.0;
const float MAXRANGE_SIEGEBRICOLE       = 60.0;
const float MINRANGE_SIEGEBRICOLE       = 20.0;
const float MAXRANGE_SIEGECANNON        = 50.0;
const float MINRANGE_SIEGECANNON        =  0.0;
const float MAXRANGE_SIEGECATAPULT_LGT  = 40.0;
const float MINRANGE_SIEGECATAPULT_LGT  = 15.0;
const float MAXRANGE_SIEGECATAPULT_HVY  = 60.0;
const float MINRANGE_SIEGECATAPULT_HVY  = 15.0;
const float MAXRANGE_SIEGECOUILLARD     = 90.0;
const float MINRANGE_SIEGECOUILLARD     = 20.0;
const float MAXRANGE_SIEGEONAGER        = 40.0;
const float MINRANGE_SIEGEONAGER        = 15.0;
const float MAXRANGE_SIEGEPERRIERE      = 75.0;
const float MINRANGE_SIEGEPERRIERE      = 20.0;

//Load and Fire Times(Complete Cycle)
const float TIME_SIEGEARBALEST_LGT      = 15.0;
const float TIME_SIEGEARBALEST_HVY      = 15.0;
const float TIME_SIEGEBRICOLE           = 30.0;
const float TIME_SIEGECANNON            = 20.0;
const float TIME_SIEGECATAPULT_LGT      = 30.0;
const float TIME_SIEGECATAPULT_HVY      = 20.0;
const float TIME_SIEGECOUILLARD         = 15.0;
const float TIME_SIEGEONAGER            = 25.0;
const float TIME_SIEGEPERRIERE          = 30.0;

//Ammunintion Types
const int KEG       = 1;    //Siege Keg
const int FIRE      = 2;    //Fire Grenade
const int ACID      = 3;    //Acid Grenade
const int ELECTRIC  = 4;    //Electric Grenade
const int CALTROPS  = 5;    //Onager Caltrops Spread
const int OIL       = 6;    //Onager Oil Grenade
const int STONE     = 7;    //Siege Stone
const int HURL_ROCK = 471;  //Siege Stone (This is the Spell.2da row for this spell effect)
const int SPEAR     = 8;    //Arbalest Spear
const int BOLT      = 794;  //Arbalest Spear (This is the Spell.2da row for this spell effect)
const int BALL      = 9;    //Cannon Ball

const string ITEM_ACID_GRENADE  = "ITCatapultAcid";
const string ITEM_FIRE_GRENADE  = "ITCatapultFire";
const string ITEM_ELEC_GRENADE  = "ITCatapultElectric";
const string ITEM_OIL_GRENADE   = "ITOnagerOil";
const string ITEM_CAL_GRENADE   = "ITOnagerCaltrops";
const string ITEM_SIEGE_STONE   = "ITSiegeStone";
const string ITEM_ARB_SPEAR     = "ITArbalestSpear";
const string ITEM_CANNON_BALL   = "ITCannonBall";
const string ITEM_THROWN_ACID   = "ITGrenadeAcid";
const string ITEM_THROWN_FIRE   = "ITGrenadeFire";
const string ITEM_THROWN_ELEC   = "ITGrenadeElectric";
const string ITEM_THROWN_SHARD  = "ITGrenadeShard";

//Blast Radius Per Ammunition Type
const float KEG_RADIUS      = 10.0;
const float FIRE_RADIUS     = 10.0;
const float ACID_RADIUS     = 10.0;
const float ELEC_RADIUS     = 10.0;
const float STONE_RADIUS    = 4.0;
const float SPEAR_RADIUS    = 3.0;
const float BALL_RADIUS     = 3.0;

//Skills  DC40 - Discipline or Concentration (which ever is higher)
const float SIEGE_ERRANT    = 0.05;//This is the Error over Distance for Accuracy
//NOTE: Oil, and Caltrops are Per the AOE Spells

//Bludgeoning/Piercing/Slashing Blast Modifiers
const int B_MODIFIER = 16;//DC vs. D20 to avoid damage from ground spray
const int P_MODIFIER = 16;//DC vs. D20 to avoid damage from ground spray
const int S_MODIFIER = 12;//DC vs. D20 to avoid damage from ground spray

//::CONSTANTS
/******************************************************************************/

/******************************************************************************/
//:: ARTILLERY FUNCTIONS

void OS_HighLightObject(object oTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efx,oTarget,2.0);
}

void OS_HighLightLocation(location lTarget)
{
  effect efx = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
  ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, efx, lTarget, 2.0f);
}

object OS_GetNearestSwitch(object oSiege)
{
  object oSwitch = GetNearestObjectByTag("SiegeSwitch",oSiege,1);
  float fSDist = GetDistanceToObject(oSwitch);
  if(fSDist > SIEGE_SWITCH) return OBJECT_INVALID;

  return oSwitch;
}

object OS_GetNearestAmmo(object oSiege)
{
  string sTag = GetTag(oSiege);

  string sAmmo = GetLocalString(oSiege,"AMMOTAG1");
  int nAmmo; object oAmmo;

  oAmmo = GetNearestObjectByTag(sAmmo,oSiege,1);
  if(GetIsObjectValid(oAmmo))
  {
    nAmmo = GetLocalInt(oAmmo,"AMMOTYPE");
    SetLocalInt(oSiege,"AMMOTYPE",nAmmo);

    return oAmmo;
  }

  //Catapults Have 3 Types of Ammo
  if(sTag == SIEGECATAPULT_LGT || sTag == SIEGECATAPULT_HVY)
  {
    sAmmo = GetLocalString(oSiege,"AMMOTAG2");

    oAmmo = GetNearestObjectByTag(sAmmo,oSiege,1);
    if(GetIsObjectValid(oAmmo))
    {
      nAmmo = GetLocalInt(oAmmo,"AMMOTYPE");
      SetLocalInt(oSiege,"AMMOTYPE",nAmmo);

      return oAmmo;
    }

    sAmmo = GetLocalString(oSiege,"AMMOTAG3");

    oAmmo = GetNearestObjectByTag(sAmmo,oSiege,1);
    if(GetIsObjectValid(oAmmo))
    {
      nAmmo = GetLocalInt(oAmmo,"AMMOTYPE");
      SetLocalInt(oSiege,"AMMOTYPE",nAmmo);

      return oAmmo;
    }
  }

  //Onagers Have 2 Types of Ammo
  if(sTag == SIEGEONAGER)
  {
    sAmmo = GetLocalString(oSiege,"AMMOTAG2");

    oAmmo = GetNearestObjectByTag(sAmmo,oSiege,1);
    if(GetIsObjectValid(oAmmo))
    {
      nAmmo = GetLocalInt(oAmmo,"AMMOTYPE");
      SetLocalInt(oSiege,"AMMOTYPE",nAmmo);

      return oAmmo;
    }
  }

  return OBJECT_INVALID;
}

float OS_GetMaximumDistance(object oSiege)
{
  float fMax = 90.0;

  string sTag = GetTag(oSiege);

  if(sTag == SIEGEARBALEST_LGT) fMax = MAXRANGE_SIEGEARBALEST_LGT;
  if(sTag == SIEGEARBALEST_HVY) fMax = MAXRANGE_SIEGEARBALEST_HVY;
  if(sTag == SIEGEBRICOLE) fMax = MAXRANGE_SIEGEBRICOLE;
  if(sTag == SIEGECANNON) fMax = MAXRANGE_SIEGECANNON;
  if(sTag == SIEGECATAPULT_LGT) fMax = MAXRANGE_SIEGECATAPULT_LGT;
  if(sTag == SIEGECATAPULT_HVY) fMax = MAXRANGE_SIEGECATAPULT_HVY;
  if(sTag == SIEGECOUILLARD) fMax = MAXRANGE_SIEGECOUILLARD;
  if(sTag == SIEGEONAGER) fMax = MAXRANGE_SIEGEONAGER;
  if(sTag == SIEGEPERRIERE) fMax = MAXRANGE_SIEGEPERRIERE;

  return fMax;
}

float OS_GetMinimumDistance(object oSiege)
{
  float fMin = 0.0;

  string sTag = GetTag(oSiege);

  if(sTag == SIEGEARBALEST_LGT) fMin = MINRANGE_SIEGEARBALEST_LGT;
  if(sTag == SIEGEARBALEST_HVY) fMin = MINRANGE_SIEGEARBALEST_HVY;
  if(sTag == SIEGEBRICOLE) fMin = MINRANGE_SIEGEBRICOLE;
  if(sTag == SIEGECANNON) fMin = MINRANGE_SIEGECANNON;
  if(sTag == SIEGECATAPULT_LGT) fMin = MINRANGE_SIEGECATAPULT_LGT;
  if(sTag == SIEGECATAPULT_HVY) fMin = MINRANGE_SIEGECATAPULT_HVY;
  if(sTag == SIEGECOUILLARD) fMin = MINRANGE_SIEGECOUILLARD;
  if(sTag == SIEGEONAGER) fMin = MINRANGE_SIEGEONAGER;
  if(sTag == SIEGEPERRIERE) fMin = MINRANGE_SIEGEPERRIERE;

  return fMin;
}

float OS_GetLoadTime(object oSiege)
{
  float fSec = 0.0;

  string sTag = GetTag(oSiege);

  if(sTag == SIEGEARBALEST_LGT) fSec = TIME_SIEGEARBALEST_LGT;
  if(sTag == SIEGEARBALEST_HVY) fSec = TIME_SIEGEARBALEST_HVY;
  if(sTag == SIEGEBRICOLE) fSec = TIME_SIEGEBRICOLE;
  if(sTag == SIEGECANNON) fSec = TIME_SIEGECANNON;
  if(sTag == SIEGECATAPULT_LGT) fSec = TIME_SIEGECATAPULT_LGT;
  if(sTag == SIEGECATAPULT_HVY) fSec = TIME_SIEGECATAPULT_HVY;
  if(sTag == SIEGECOUILLARD) fSec = TIME_SIEGECOUILLARD;
  if(sTag == SIEGEONAGER) fSec = TIME_SIEGEONAGER;
  if(sTag == SIEGEPERRIERE) fSec = TIME_SIEGEPERRIERE;

  return fSec;
}

float OS_GetError(object oSiege, float fRange)
{
  float fError = 0.0;

  float fMult = 3.0;

  string sTag = GetTag(oSiege);

  if(sTag == SIEGEARBALEST_LGT) fMult = IntToFloat(d3(1));
  if(sTag == SIEGEARBALEST_HVY) fMult = IntToFloat(d2(1));
  if(sTag == SIEGEBRICOLE) fMult = IntToFloat(d4(1));
  if(sTag == SIEGECANNON) fMult = IntToFloat(d2(1));
  if(sTag == SIEGECATAPULT_LGT) fMult = IntToFloat(d4(1));
  if(sTag == SIEGECATAPULT_HVY) fMult = IntToFloat(d4(1));
  if(sTag == SIEGECOUILLARD) fMult = IntToFloat(d2(1));
  if(sTag == SIEGEONAGER) fMult = IntToFloat(d4(1));
  if(sTag == SIEGEPERRIERE) fMult = IntToFloat(d3(1));

  fError = SIEGE_ERRANT * fRange * fMult;

  return fError;
}

float OS_GetImpactDelay(object oSiege)
{
  float fDiv = 20.0;

  string sTag = GetTag(oSiege);

  if(sTag == SIEGEARBALEST_LGT) fDiv = 25.0;
  if(sTag == SIEGEARBALEST_HVY) fDiv = 25.0;
  if(sTag == SIEGEBRICOLE) fDiv = 16.0;
  if(sTag == SIEGECANNON) fDiv = 1000.0;
  if(sTag == SIEGECATAPULT_LGT) fDiv = 18.0;
  if(sTag == SIEGECATAPULT_HVY) fDiv = 18.0;
  if(sTag == SIEGECOUILLARD) fDiv = 16.0;
  if(sTag == SIEGEONAGER) fDiv = 16.0;
  if(sTag == SIEGEPERRIERE) fDiv = 16.0;

  return fDiv;
}

int OS_GetImpactEffect(object oSiege)
{
  int nEff;

  int nAmmo = GetLocalInt(oSiege,"AMMOTYPE");

  if(nAmmo == FIRE) nEff = VFX_FNF_FIREBALL;
  if(nAmmo == ACID) nEff = VFX_FNF_GAS_EXPLOSION_ACID;
  if(nAmmo == ELECTRIC) nEff = VFX_FNF_ELECTRIC_EXPLOSION;
  if(nAmmo == CALTROPS) nEff = VFX_DUR_CALTROPS;
  if(nAmmo == OIL) nEff = VFX_FNF_GAS_EXPLOSION_GREASE;
  if(nAmmo == STONE) nEff = VFX_COM_CHUNK_STONE_MEDIUM;
  if(nAmmo == SPEAR) nEff = VFX_COM_CHUNK_STONE_SMALL;
  if(nAmmo == BALL) nEff = VFX_COM_CHUNK_STONE_MEDIUM;

  return nEff;
}

float OS_GetDamageRadius(object oSiege)
{
  float fRad = 10.0;

  int nAmmo = GetLocalInt(oSiege,"AMMOTYPE");

  if(nAmmo == STONE) fRad = 5.0;
  if(nAmmo == SPEAR) fRad = 3.0;
  if(nAmmo == BALL) fRad = 3.0;

  return fRad;
}

int OS_GetSpellEffect(object oSiege)
{
  int nEff;

  int nAmmo = GetLocalInt(oSiege,"AMMOTYPE");

  if(nAmmo == FIRE) nEff = SPELL_FIREBALL;
  if(nAmmo == ACID) nEff = SPELL_ACID_FOG;
  if(nAmmo == ELECTRIC) nEff = SPELL_SCINTILLATING_SPHERE;
  if(nAmmo == CALTROPS) nEff = HURL_ROCK;
  if(nAmmo == OIL) nEff = SPELL_GREASE;
  if(nAmmo == STONE) nEff = HURL_ROCK;
  if(nAmmo == SPEAR) nEff = SPELL_TRAP_ARROW;
  if(nAmmo == BALL) nEff = SPELL_TRAP_ARROW;

  return nEff;
}

int OS_GetIsSiege(object oSiege)
{
  int nSiege = GetLocalInt(oSiege,"SIEGE");

  if(nSiege == 1) return TRUE;

  return FALSE;
}

int OS_GetIsTargetDoor(object oDoor)
{
  int nDoor = GetLocalInt(oDoor,"SIEGE");

  if(nDoor == 1) return TRUE;

  return FALSE;
}

object OS_GetTargetCreature(object oSiege)
{
  float fMax = OS_GetMaximumDistance(oSiege);
  float fMin = OS_GetMinimumDistance(oSiege);
  location lLoc = GetLocation(oSiege);

  string sSelfFaction = GetLocalString(oSiege,"OAI_FACTION");
  string sFaction;
  object oTarget;
  object oAcquire = OBJECT_INVALID;
  string sTarget;
  float fSDist;
  int nNPCHP;

  //Quick Target
  oTarget = GetNearestObject(OBJECT_TYPE_CREATURE,oSiege,1);
  float fCheck = GetDistanceBetween(oSiege, oTarget);
  if(fCheck > fMin)
  {
    if(fCheck <= fMax)
    {
      //OK to Fire On?
      if(GetPlotFlag(oTarget) == FALSE)
      {
        sFaction = GetLocalString(oTarget,"OAI_FACTION");
        nNPCHP = GetCurrentHitPoints(oTarget);
        if(nNPCHP >= 1
          && sFaction != sSelfFaction
          && sFaction != "")
        {
          SetLocalInt(oSiege,"ACQUIRED",1);
          return oTarget;
        }
      }
    }
  }

  oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fMax, lLoc, TRUE, OBJECT_TYPE_CREATURE);
  while (GetIsObjectValid(oTarget))
  {
    location lType = GetLocation(oTarget);
    string sType = GetTag(oTarget);

    fSDist = GetDistanceToObject(oTarget);
    if(fSDist >= fMin)
    {
      //OK to Fire On?
      if(GetPlotFlag(oTarget) == FALSE)
      {
        sFaction = GetLocalString(oTarget,"OAI_FACTION");
        nNPCHP = GetCurrentHitPoints(oTarget);
        if(nNPCHP >= 1
          && sFaction != sSelfFaction
          && sFaction != "")
        {
          SetLocalInt(oSiege,"ACQUIRED",1);
          oAcquire = oTarget;
          break;//Acquired Target
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, fMax, lLoc, TRUE, OBJECT_TYPE_CREATURE);
  }

  return oAcquire;
}

object OS_GetTargetSiege(object oSiege)
{
  float fMax = OS_GetMaximumDistance(oSiege);
  float fMin = OS_GetMinimumDistance(oSiege);
  location lLoc = GetLocation(oSiege);

  string sSelfFaction = GetLocalString(oSiege,"OAI_FACTION");
  string sFaction;
  object oTarget;
  object oAcquire = OBJECT_INVALID;
  string sTarget;
  float fSDist;
  int nNPCHP;

  //Quick Target
  oTarget = GetNearestObject(OBJECT_TYPE_PLACEABLE,oSiege,1);
  float fCheck = GetDistanceBetween(oSiege, oTarget);
  if(fCheck > fMin)
  {
    if(fCheck <= fMax)
    {
      //OK to Fire On?
      if(GetPlotFlag(oTarget) == FALSE)
      {
        sFaction = GetLocalString(oTarget,"OAI_FACTION");
        nNPCHP = GetCurrentHitPoints(oTarget);
        if(nNPCHP >= 1
          && sFaction != sSelfFaction
          && sFaction != "")
        {
          SetLocalInt(oSiege,"ACQUIRED",1);
          return oTarget;
        }
      }
    }
  }

  oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fMax, lLoc, TRUE, OBJECT_TYPE_PLACEABLE);
  while (GetIsObjectValid(oTarget))
  {
    location lType = GetLocation(oTarget);
    string sType = GetTag(oTarget);

    fSDist = GetDistanceToObject(oTarget);
    if(fSDist >= fMin && OS_GetIsSiege(oTarget))
    {
      //OK to Fire On?
      if(GetPlotFlag(oTarget) == FALSE)
      {
        sFaction = GetLocalString(oTarget,"OAI_FACTION");
        nNPCHP = GetCurrentHitPoints(oTarget);
        if(nNPCHP >= 1
          && sFaction != sSelfFaction
          && sFaction != "")
        {
          SetLocalInt(oSiege,"ACQUIRED",1);
          oAcquire = oTarget;
          break;//Acquired Target
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, fMax, lLoc, TRUE, OBJECT_TYPE_PLACEABLE);
  }

  return oAcquire;
}

object OS_GetTargetDoor(object oSiege)
{
  float fMax = OS_GetMaximumDistance(oSiege);
  float fMin = OS_GetMinimumDistance(oSiege);
  location lLoc = GetLocation(oSiege);

  string sSelfFaction = GetLocalString(oSiege,"OAI_FACTION");
  string sFaction;
  object oTarget;
  object oAcquire = OBJECT_INVALID;
  string sTarget;
  float fSDist;
  int nNPCHP;

  //Quick Target
  oTarget = GetNearestObject(OBJECT_TYPE_DOOR,oSiege,1);
  float fCheck = GetDistanceBetween(oSiege, oTarget);
  if(fCheck > fMin)
  {
    if(fCheck <= fMax)
    {
      //OK to Fire On?
      if(GetPlotFlag(oTarget) == FALSE)
      {
        sFaction = GetLocalString(oTarget,"OAI_FACTION");
        nNPCHP = GetCurrentHitPoints(oTarget);
        if(nNPCHP >= 1
          && sFaction != sSelfFaction
          && sFaction != "")
        {
          SetLocalInt(oSiege,"ACQUIRED",1);
          return oTarget;
        }
      }
    }
  }

  oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fMax, lLoc, TRUE, OBJECT_TYPE_DOOR);
  while (GetIsObjectValid(oTarget))
  {
    location lType = GetLocation(oTarget);
    string sType = GetTag(oTarget);

    fSDist = GetDistanceToObject(oTarget);
    if(fSDist >= fMin && OS_GetIsTargetDoor(oTarget))
    {
      //OK to Fire On?
      if(GetPlotFlag(oTarget) == FALSE)
      {
        sFaction = GetLocalString(oTarget,"CONTROLLED");
        nNPCHP = GetCurrentHitPoints(oTarget);
        if(nNPCHP >= 1
          && sFaction != sSelfFaction
          && sFaction != "")
        {
          SetLocalInt(oSiege,"ACQUIRED",1);
          oAcquire = oTarget;
          break;//Acquired Target
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, fMax, lLoc, TRUE, OBJECT_TYPE_DOOR);
  }

  return oAcquire;
}

void OS_SmokingKeg(object oKeg)
{
  effect eSmoke = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,oKeg);
}

void OS_FireKeg(object oKeg)
{
  effect eFire = EffectVisualEffect(VFX_COM_HIT_FIRE);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFire,oKeg,3.0);
}

location OS_Location(object oPC, float fDist, float fHeight)
{
  float fDistance = -fDist;
  object oTarget = oPC;
  object oArea = GetArea(oTarget);
  vector vPosition = GetPosition(oTarget);
  vPosition.z += fHeight;
  float fOrientation = GetFacing(oTarget);
  vector vNewPos = AngleToVector(fOrientation);
  float vZ = vPosition.z;
  float vX = vPosition.x - fDistance * vNewPos.x;
  float vY = vPosition.y - fDistance * vNewPos.y;
  fOrientation = GetFacing(oTarget);
  vX = vPosition.x - fDistance * vNewPos.x;
  vY = vPosition.y - fDistance * vNewPos.y;
  vNewPos = AngleToVector(fOrientation);
  vZ = vPosition.z;
  vNewPos = Vector(vX, vY, vZ);
  return Location(oArea, vNewPos, fOrientation);
}

void OS_CreateFieldEffect(location lLoc)
{
  //Create a Scorchmark
  object oScorch = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_weathmark",lLoc);
  DelayCommand(60.0,DestroyObject(oScorch));

  //Create a Dust Plume
  object oPlume = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_dustplume",lLoc);
  DelayCommand(20.0,DestroyObject(oPlume));

  //Create a Small Flame
  object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamesmall",lLoc);
  DelayCommand(15.0,DestroyObject(oFlame));
}

void OS_SiegeLaunch(object oSiege, object oPC, location lLoc,float fImpactDelay, effect eImpact, effect eBump, int nSpell, float fRadius, int nAmmo)
{
  string sTag = GetTag(oSiege);
  if(sTag == SIEGECATAPULT_LGT || sTag == SIEGECATAPULT_HVY || sTag == SIEGEONAGER)
  {
    AssignCommand(oSiege,PlaySound("cb_sh_catapult"));
  }
  else if(sTag == SIEGECANNON)
  {
    AssignCommand(oSiege,PlaySound("bf_huge"));
  }
  else
  {
    AssignCommand(oSiege,PlaySound("cb_sh_ballista"));
  }

  if(sTag == SIEGEARBALEST_LGT || sTag == SIEGEARBALEST_HVY || sTag == SIEGECANNON)
  {
    AssignCommand(oSiege,ActionCastFakeSpellAtLocation(nSpell, lLoc, PROJECTILE_PATH_TYPE_HOMING));
  }
  else
  {
    AssignCommand(oSiege,ActionCastFakeSpellAtLocation(nSpell, lLoc, PROJECTILE_PATH_TYPE_BALLISTIC));
  }

  AssignCommand(oSiege,DelayCommand(fImpactDelay,OS_CreateFieldEffect(lLoc)));
  AssignCommand(oSiege,DelayCommand(fImpactDelay + 0.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc)));
  AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBump, lLoc)));
}

void OS_SiegeDamage(object oSiege,object oPC,location lLoc,float fImpactDelay, int nSpell, float fRadius,
                    effect eLDam,effect eBDam, effect ePDam,effect eSDam,effect eVis1,effect eVis2,effect eLin1)
{
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  while(GetIsObjectValid(oTarget))
  {
    int nType = GetObjectType(oTarget);
    string sType = GetTag(oTarget);

    //Check For Doors
    if(nType == OBJECT_TYPE_DOOR)
    {
      if (!GetPlotFlag(oTarget))
      {
        // Apply effects to the currently selected target.
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget)));
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLDam, oTarget)));
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oTarget)));
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oTarget)));
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oTarget)));
      }
    }
    //Check for other Placeables
    if(nType == OBJECT_TYPE_PLACEABLE)
    {
      if(!GetPlotFlag(oTarget))
      {
        // Apply effects to the currently selected target.
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget)));
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLDam, oTarget)));
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oTarget)));
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oTarget)));
        AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oTarget)));
      }
    }
    //Check for Creatures
    if(nType == OBJECT_TYPE_CREATURE)
    {
      AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget)));
      AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLin1, oTarget)));
      AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLDam, oTarget)));
      AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oTarget)));
      AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oTarget)));
      AssignCommand(oSiege,DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oTarget)));
      AssignCommand(oSiege,DelayCommand(fImpactDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 3.0)));

      SignalEvent(oTarget, EventSpellCastAt(oPC, nSpell));
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }
}

//Fire Grenade
void OS_FireBlast(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  //Launch
  AssignCommand(oSiege,OS_SiegeLaunch(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));

  int nLDam = d20(6)+20;//Primary Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eLDam = EffectDamage(nLDam, DAMAGE_TYPE_FIRE, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eVis2 = EffectVisualEffect(VFX_IMP_FLAME_M);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);

  //Damage
  AssignCommand(oSiege,OS_SiegeDamage(oSiege,oPC,lLoc,fImpactDelay,nSpell,fRadius,eLDam,eBDam,ePDam,eSDam,eVis1,eVis2,eLin1));
}

//Acid Grenade
void OS_AcidBlast(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  //Launch
  AssignCommand(oSiege,OS_SiegeLaunch(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));

  int nLDam = d20(6)+20;//Primary Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eLDam = EffectDamage(nLDam, DAMAGE_TYPE_ACID, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eVis2 = EffectVisualEffect(VFX_IMP_ACID_S);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);

  //Damage
  AssignCommand(oSiege,OS_SiegeDamage(oSiege,oPC,lLoc,fImpactDelay,nSpell,fRadius,eLDam,eBDam,ePDam,eSDam,eVis1,eVis2,eLin1));
}

//Electric Grenade
void OS_ElectricBlast(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  //Launch
  AssignCommand(oSiege,OS_SiegeLaunch(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));

  int nLDam = d20(6)+20;//Primary Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eLDam = EffectDamage(nLDam, DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eVis2 = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);

  //Damage
  AssignCommand(oSiege,OS_SiegeDamage(oSiege,oPC,lLoc,fImpactDelay,nSpell,fRadius,eLDam,eBDam,ePDam,eSDam,eVis1,eVis2,eLin1));
}

//Siege Stone
void OS_StoneBlast(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  //Launch
  AssignCommand(oSiege,OS_SiegeLaunch(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));

  int nLDam = d20(10)+80;//Primary Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eLDam = EffectDamage(nLDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);

  //Damage
  AssignCommand(oSiege,OS_SiegeDamage(oSiege,oPC,lLoc,fImpactDelay,nSpell,fRadius,eLDam,eBDam,ePDam,eSDam,eVis1,eVis2,eLin1));
}

//Oil Grenade
void OS_OilBlast(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  //Launch
  AssignCommand(oSiege,OS_SiegeLaunch(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));

  int nLDam = d10(6);//Primary Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eLDam = EffectDamage(nLDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_YELLOW_SMALL);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);

  //Damage
  AssignCommand(oSiege,OS_SiegeDamage(oSiege,oPC,lLoc,fImpactDelay,nSpell,fRadius,eLDam,eBDam,ePDam,eSDam,eVis1,eVis2,eLin1));

  //Grease Area
  object oAcquire = GetLocalObject(oSiege,"OS_ACQUIRED");
  effect eAOE = EffectAreaOfEffect(AOE_PER_GREASE);
  DelayCommand(fImpactDelay + 1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oAcquire,60.0));

  //Start Fire
  effect eFire = EffectAreaOfEffect(AOE_PER_FOGFIRE);
  DelayCommand(fImpactDelay + 10.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFire, oAcquire,60.0));
}

//Caltrop Grenade
void OS_CaltropSpread(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  //Launch
  AssignCommand(oSiege,OS_SiegeLaunch(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));

  int nLDam = d10(10);//Primary Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d20(10);//Piercing Spray Damage
  int nSDam = d20(2);//Slashing Spray Damage
  effect eLDam = EffectDamage(nLDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_STONE_SMALL);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);

  //Damage
  AssignCommand(oSiege,OS_SiegeDamage(oSiege,oPC,lLoc,fImpactDelay,nSpell,fRadius,eLDam,eBDam,ePDam,eSDam,eVis1,eVis2,eLin1));

  object oAcquire = GetLocalObject(oSiege,"OS_ACQUIRED");
  effect eFieldOfSharp = EffectVisualEffect(VFX_DUR_CALTROPS,TRUE);
  DelayCommand(fImpactDelay + 1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFieldOfSharp,oAcquire,3.0));
}

//Siege Arbalest Spear
void OS_SpearBlast(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  //Launch
  AssignCommand(oSiege,OS_SiegeLaunch(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));

  int nLDam = d20(6)+50;//Primary Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eLDam = EffectDamage(nLDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_STONE_SMALL);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);

  //Damage
  AssignCommand(oSiege,OS_SiegeDamage(oSiege,oPC,lLoc,fImpactDelay,nSpell,fRadius,eLDam,eBDam,ePDam,eSDam,eVis1,eVis2,eLin1));
}

//Cannon Ball
void OS_CannonBlast(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  //Launch
  AssignCommand(oSiege,OS_SiegeLaunch(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));

  int nAct = GetLocalInt(oSiege,"OS_ACTIVATED");
  if(nAct == 0)
  {
    DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    SetLocalInt(oSiege,"OS_ACTIVATED",1);
  }
  else
  {
    DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(oSiege,"OS_ACTIVATED",0);
  }

  int nLDam = d20(10)+100;//Primary Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eLDam = EffectDamage(nLDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);

  //Damage
  AssignCommand(oSiege,OS_SiegeDamage(oSiege,oPC,lLoc,fImpactDelay,nSpell,fRadius,eLDam,eBDam,ePDam,eSDam,eVis1,eVis2,eLin1));
}

void OS_SiegeGrenade(object oSiege, object oPC, location lLoc,float fImpactDelay,effect eImpact,effect eBump,int nSpell,float fRadius,int nAmmo)
{
  string sTag = GetTag(oSiege);

  if(sTag == SIEGEARBALEST_LGT || sTag == SIEGEARBALEST_HVY)
  {
    AssignCommand(oSiege,OS_SpearBlast(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
    return;
  }

  if(sTag == SIEGEBRICOLE || sTag == SIEGECOUILLARD || sTag == SIEGEPERRIERE)
  {
    AssignCommand(oSiege,OS_StoneBlast(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
    return;
  }

  if(sTag == SIEGECANNON)
  {
    AssignCommand(oSiege,OS_CannonBlast(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
    return;
  }

  if(sTag == SIEGECATAPULT_LGT || sTag == SIEGECATAPULT_HVY)
  {
    if(nAmmo == FIRE)
    {
      AssignCommand(oSiege,OS_FireBlast(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
      return;
    }

    if(nAmmo == ACID)
    {
      AssignCommand(oSiege,OS_AcidBlast(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
      return;
    }

    if(nAmmo == ELECTRIC)
    {
      AssignCommand(oSiege,OS_ElectricBlast(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
      return;
    }

    return;
  }

  if(sTag == SIEGEONAGER)
  {
    if(nAmmo == CALTROPS)
    {
      AssignCommand(oSiege,OS_CaltropSpread(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
      return;
    }

    if(nAmmo == OIL)
    {
      AssignCommand(oSiege,OS_OilBlast(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
      return;
    }

    return;
  }
}

//Used to turn the Siege Weapon to its current target
void OS_SetFacingObject(object oTarget)
{
  vector vFace = GetPosition(oTarget);
  SetFacingPoint(vFace);
}

void OS_SetGroundingFacing(object oSiege, object oPC)
{
  location lLoc = GetLocation(oPC);
  float fFace = GetFacing(oPC);
  //AssignCommand(oPC,ActionMoveAwayFromLocation(lLoc,TRUE,2.5));
  if(GetTag(oSiege) == SIEGECOUILLARD || GetTag(oSiege) == SIEGEPERRIERE || GetTag(oSiege) == SIEGEBRICOLE)
  {
    AssignCommand(oSiege,DelayCommand(3.5,SetFacing(fFace - 180.0)));
  }
  else AssignCommand(oSiege,DelayCommand(3.5,SetFacing(fFace)));
}

void OS_ActivateSwitch()
{
  DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  DelayCommand(2.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}

//Initiate Local Siege Weapons
void OS_InitiateSiege(object oSwitch, location lLoc)
{
  //Find all Light Arbalest within 60 Meters
  int nNth = 1;
  object oLArbalest = GetNearestObjectByTag(SIEGEARBALEST_LGT,oSwitch,nNth);
  while(oLArbalest != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oLArbalest);
    if(fDist <= 60.0) ExecuteScript("os_arm",oLArbalest);
    if(nNth <= 10)
    {
      nNth++;
      oLArbalest = GetNearestObjectByTag(SIEGEARBALEST_LGT,oSwitch,nNth);
    }
    else break;
  }

  //Find all Heavy Arbalest within 60 Meters
  nNth = 1;
  object oHArbalest = GetNearestObjectByTag(SIEGEARBALEST_HVY,oSwitch,nNth);
  while(oHArbalest != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oHArbalest);
    if(fDist <= 60.0) ExecuteScript("os_arm",oHArbalest);
    if(nNth <= 10)
    {
      nNth++;
      oHArbalest = GetNearestObjectByTag(SIEGEARBALEST_HVY,oSwitch,nNth);
    }
    else break;
  }

  //Find all Bricole within 60 Meters
  nNth = 1;
  object oBricole = GetNearestObjectByTag(SIEGEBRICOLE,oSwitch,nNth);
  while(oBricole != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oBricole);
    if(fDist <= 60.0) ExecuteScript("os_arm",oBricole);
    if(nNth <= 10)
    {
      nNth++;
      oBricole = GetNearestObjectByTag(SIEGEBRICOLE,oSwitch,nNth);
    }
    else break;
  }

  //Find all Cannon within 60 Meters
  nNth = 1;
  object oCannon = GetNearestObjectByTag(SIEGECANNON,oSwitch,nNth);
  while(oCannon != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oCannon);
    if(fDist <= 60.0) ExecuteScript("os_arm",oCannon);
    if(nNth <= 10)
    {
      nNth++;
      oCannon = GetNearestObjectByTag(SIEGECANNON,oSwitch,nNth);
    }
    else break;
  }

  //Find all Light Catapult within 60 Meters
  nNth = 1;
  object oLCatapult = GetNearestObjectByTag(SIEGECATAPULT_LGT,oSwitch,nNth);
  while(oLCatapult != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oLCatapult);
    if(fDist <= 60.0) ExecuteScript("os_arm",oLCatapult);
    if(nNth <= 10)
    {
      nNth++;
      oLCatapult = GetNearestObjectByTag(SIEGECATAPULT_LGT,oSwitch,nNth);
    }
    else break;
  }

  //Find all Heavy Catapult within 60 Meters
  nNth = 1;
  object oHCatapult = GetNearestObjectByTag(SIEGECATAPULT_HVY,oSwitch,nNth);
  while(oHCatapult != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oHCatapult);
    if(fDist <= 60.0) ExecuteScript("os_arm",oHCatapult);
    if(nNth <= 10)
    {
      nNth++;
      oHCatapult = GetNearestObjectByTag(SIEGECATAPULT_HVY,oSwitch,nNth);
    }
    else break;
  }

  //Find all Couillards within 60 Meters
  nNth = 1;
  object oCouillard = GetNearestObjectByTag(SIEGECOUILLARD,oSwitch,nNth);
  while(oCouillard != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oCouillard);
    if(fDist <= 60.0) ExecuteScript("os_arm",oCouillard);
    if(nNth <= 10)
    {
      nNth++;
      oCouillard = GetNearestObjectByTag(SIEGECOUILLARD,oSwitch,nNth);
    }
    else break;
  }

  //Find all Onagers within 60 Meters
  nNth = 1;
  object oOnager = GetNearestObjectByTag(SIEGEONAGER,oSwitch,nNth);
  while(oOnager != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oOnager);
    if(fDist <= 60.0) ExecuteScript("os_arm",oOnager);
    if(nNth <= 10)
    {
      nNth++;
      oOnager = GetNearestObjectByTag(SIEGEONAGER,oSwitch,nNth);
    }
    else break;
  }

  //Find all Perriere within 60 Meters
  nNth = 1;
  object oPerriere = GetNearestObjectByTag(SIEGEPERRIERE,oSwitch,nNth);
  while(oPerriere != OBJECT_INVALID)
  {
    float fDist = GetDistanceToObject(oPerriere);
    if(fDist <= 60.0) ExecuteScript("os_arm",oPerriere);
    if(nNth <= 10)
    {
      nNth++;
      oPerriere = GetNearestObjectByTag(SIEGEPERRIERE,oSwitch,nNth);
    }
    else break;
  }
}

void OS_SiegeFire(object oSiege, object oAcquire)
{
  string sTag = GetTag(oSiege);
  object oArea = GetArea(oSiege);
  object oPC = GetLocalObject(oSiege,"OS_OWNER");
  vector vCurrentPosition = GetPosition(oSiege);
  float fCurrentFacing = GetFacing(oSiege);

  //Calculate the target location.
  float fRange = GetLocalFloat(oSiege, "RANGE");

  int nRX = Random(2);
  int nRY = Random(2);
  int nRN = Random(2);

  //Positive Error
  if(nRN == 0) nRX = nRX;
  //Negative Error
  if(nRN == 1) nRX = nRX * (-1);
  //Positive Error
  if(nRN == 0) nRY = nRY;
  //Negative Error
  if(nRN == 1) nRY = nRY * (-1);

  //Total Range Error for Location Target
  float fError = OS_GetError(oSiege,fRange);

  location lLoc;

  //On Target
  if(fError <= 2.0)
  {
    lLoc = GetRandomLocation(oArea, oAcquire, 1.0);
    AssignCommand(oSiege, SpeakString("Projectile away and on target!"));
  }
  //A little off Target
  else
  {
    lLoc = GetRandomLocation(oArea, oAcquire, fError);
    AssignCommand(oSiege, SpeakString("Projectile away and a little off target!"));
  }

  float fDiv = OS_GetImpactDelay(oSiege);
  if(fDiv < 0.1) fDiv = 1000.0;
  float fImpactDelay = fRange/fDiv;

  effect eImpact;
  effect eBump;
  int nSpell;
  int nAmmo;
  int nImpact;
  float fRadius;

  //Siege is Loaded
  if(GetLocalInt(oSiege,"LOADED") == 1)
  {
    nAmmo = GetLocalInt(oSiege,"AMMOTYPE");
    nImpact = OS_GetImpactEffect(oSiege);

    eImpact = EffectVisualEffect(nImpact);
    eBump   = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    nSpell  = OS_GetSpellEffect(oSiege);
    fRadius = OS_GetDamageRadius(oSiege);
    AssignCommand(oSiege,OS_SiegeGrenade(oSiege,oPC,lLoc,fImpactDelay,eImpact,eBump,nSpell,fRadius,nAmmo));
    DeleteLocalInt(oSiege,"AMMOTYPE");
    SetLocalInt(oSiege,"LOADED",0);
  }
}

//:: ARTILLERY FUNCTIONS
/******************************************************************************/

/******************************************************************************/
//:: THROWN GRENADES AND PISTOL

//Fire Grenade
void OS_FireGrenade(object oPC, object oTarget)
{
  object oOrigin = GetLocalObject(oPC,"OS_CURRENT_ORIGIN");

  object oArea = GetArea(oPC);
  float fHeight = 1.5;
  float fDistance = 1.0;

  float fRange = GetDistanceBetween(oOrigin,oTarget);

  //Skill
  //As the Skill in Discipline or Concentration get higher....the Accuracy of the Thrown Grenades Become.
  int nSkill = 1;
  int nDisc = GetSkillRank(SKILL_DISCIPLINE,oPC);
  int nConc = GetSkillRank(SKILL_CONCENTRATION,oPC);
  nSkill = nDisc;
  if(nConc > nDisc) nSkill = nConc;
  nSkill/10;

  int nBase = 5;
  int nFinal = nBase - nSkill;

  float fMult = IntToFloat(nFinal);

  //Total Range Error for Location Target
  float fError = SIEGE_ERRANT * fMult;

  location lLoc;

  //On Target
  if(fError <= 2.0)
  {
    lLoc = GetRandomLocation(oArea, oTarget, 1.0);
    AssignCommand(oPC, SpeakString("Projectile away and on target!"));
  }
  //A little off Target
  else
  {
    lLoc = GetRandomLocation(oArea, oTarget, fError);
    AssignCommand(oPC, SpeakString("Projectile away and a little off target!"));
  }

  float fImpactDelay = fRange/18;

  effect eImpact = EffectVisualEffect(VFX_FNF_FIREBALL);
  effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
  int nThrow = HURL_ROCK;
  int nSpell = SPELL_FIREBALL;
  float fRadius = 10.0;

  AssignCommand(oOrigin,ActionCastFakeSpellAtLocation(nThrow, lLoc, PROJECTILE_PATH_TYPE_BALLISTIC));
  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
  DelayCommand(fImpactDelay,OS_CreateFieldEffect(lLoc));
  DelayCommand(fImpactDelay + 0.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc));
  DelayCommand(fImpactDelay + 1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBump, lLoc));

  DeleteLocalObject(oPC,"OS_CURRENT_ORIGIN");

  int nFDam = d10(6);//Fire Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eFDam = EffectDamage(nFDam, DAMAGE_TYPE_FIRE, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);
  effect eVis2 = EffectVisualEffect(VFX_IMP_FLAME_M);
  float fDelay = 0.5;

  object oCheck = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  while (GetIsObjectValid(oCheck))
  {
    int nType = GetObjectType(oCheck);
    string sType = GetTag(oCheck);

    //Check For Doors
    if(nType == OBJECT_TYPE_DOOR)
    {
      if (!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
        DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFDam, oCheck));
        DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
        DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      }
    }
    //Check for other Placeables
    if(nType == OBJECT_TYPE_PLACEABLE)
    {
      if(!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
        DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFDam, oCheck));
        DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
        DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      }
    }
    //Check for Creatures
    if(nType == OBJECT_TYPE_CREATURE)
    {
      DelayCommand(fImpactDelay + 1.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
      DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLin1, oCheck));
      DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFDam, oCheck));
      DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
      DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
      DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      DelayCommand(fImpactDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCheck, 3.0));

      SignalEvent(oCheck, EventSpellCastAt(oPC, nSpell));
    }
    oCheck = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }
}

//Acid Grenade
void OS_AcidGrenade(object oPC, object oTarget)
{
  object oOrigin = GetLocalObject(oPC,"OS_CURRENT_ORIGIN");

  object oArea = GetArea(oPC);
  float fHeight = 1.5;
  float fDistance = 1.0;

  float fRange = GetDistanceBetween(oOrigin,oTarget);

  //Skill
  //As the Skill in Discipline or Concentration get higher....the Accuracy of the Thrown Grenades Become.
  int nSkill = 1;
  int nDisc = GetSkillRank(SKILL_DISCIPLINE,oPC);
  int nConc = GetSkillRank(SKILL_CONCENTRATION,oPC);
  nSkill = nDisc;
  if(nConc > nDisc) nSkill = nConc;
  nSkill/10;

  int nBase = 5;
  int nFinal = nBase - nSkill;

  float fMult = IntToFloat(nFinal);

  //Total Range Error for Location Target
  float fError = SIEGE_ERRANT * fMult;

  location lLoc;

  //On Target
  if(fError <= 2.0)
  {
    lLoc = GetRandomLocation(oArea, oTarget, 1.0);
    AssignCommand(oPC, SpeakString("Projectile away and on target!"));
  }
  //A little off Target
  else
  {
    lLoc = GetRandomLocation(oArea, oTarget, fError);
    AssignCommand(oPC, SpeakString("Projectile away and a little off target!"));
  }

  float fImpactDelay = fRange/18;

  effect eImpact = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
  effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
  int nThrow = HURL_ROCK;
  int nSpell = SPELL_ACID_FOG;
  float fRadius = 10.0;

  AssignCommand(oOrigin,ActionCastFakeSpellAtLocation(nThrow, lLoc, PROJECTILE_PATH_TYPE_BALLISTIC));
  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
  DelayCommand(fImpactDelay,OS_CreateFieldEffect(lLoc));
  DelayCommand(fImpactDelay + 0.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc));
  DelayCommand(fImpactDelay + 1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBump, lLoc));

  DeleteLocalObject(oPC,"OS_CURRENT_ORIGIN");

  int nADam = d10(6);//Acid Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eADam = EffectDamage(nADam, DAMAGE_TYPE_ACID, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);
  effect eVis2 = EffectVisualEffect(VFX_IMP_ACID_S);

  float fDelay = 0.5;

  object oCheck = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  while (GetIsObjectValid(oCheck))
  {
    int nType = GetObjectType(oCheck);
    string sType = GetTag(oCheck);

    //Check For Doors
    if(nType == OBJECT_TYPE_DOOR)
    {
      if (!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
        DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eADam, oCheck));
        DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
        DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      }
    }
    //Check for other Placeables
    if(nType == OBJECT_TYPE_PLACEABLE)
    {
      if(!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
        DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eADam, oCheck));
        DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
        DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      }
    }
    //Check for Creatures
    if(nType == OBJECT_TYPE_CREATURE)
    {
      DelayCommand(fImpactDelay + 1.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
      DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLin1, oCheck));
      DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eADam, oCheck));
      DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
      DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
      DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      DelayCommand(fImpactDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCheck, 3.0));

      SignalEvent(oCheck, EventSpellCastAt(oPC, nSpell));
    }
    oCheck = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }
}

//Electric Grenade
void OS_ElectricGrenade(object oPC, object oTarget)
{
  object oOrigin = GetLocalObject(oPC,"OS_CURRENT_ORIGIN");

  object oArea = GetArea(oPC);
  float fHeight = 1.5;
  float fDistance = 1.0;

  float fRange = GetDistanceBetween(oOrigin,oTarget);

  //Skill
  //As the Skill in Discipline or Concentration get higher....the Accuracy of the Thrown Grenades Become.
  int nSkill = 1;
  int nDisc = GetSkillRank(SKILL_DISCIPLINE,oPC);
  int nConc = GetSkillRank(SKILL_CONCENTRATION,oPC);
  nSkill = nDisc;
  if(nConc > nDisc) nSkill = nConc;
  nSkill/10;

  int nBase = 5;
  int nFinal = nBase - nSkill;

  float fMult = IntToFloat(nFinal);

  //Total Range Error for Location Target
  float fError = SIEGE_ERRANT * fMult;

  location lLoc;

  //On Target
  if(fError <= 2.0)
  {
    lLoc = GetRandomLocation(oArea, oTarget, 1.0);
    AssignCommand(oPC, SpeakString("Projectile away and on target!"));
  }
  //A little off Target
  else
  {
    lLoc = GetRandomLocation(oArea, oTarget, fError);
    AssignCommand(oPC, SpeakString("Projectile away and a little off target!"));
  }

  float fImpactDelay = fRange/18;

  effect eImpact = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);
  effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
  int nThrow = HURL_ROCK;
  int nSpell = SPELL_SCINTILLATING_SPHERE;
  float fRadius = 10.0;

  AssignCommand(oOrigin,ActionCastFakeSpellAtLocation(nThrow, lLoc, PROJECTILE_PATH_TYPE_BALLISTIC));
  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
  DelayCommand(fImpactDelay,OS_CreateFieldEffect(lLoc));
  DelayCommand(fImpactDelay + 0.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc));
  DelayCommand(fImpactDelay + 1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBump, lLoc));

  DeleteLocalObject(oPC,"OS_CURRENT_ORIGIN");

  int nEDam = d10(6);//Electric Damage
  int nBDam = d10(1);//Bludgeoning Spray Damage
  int nPDam = d10(1);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eEDam = EffectDamage(nEDam, DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_PLUS_TWENTY);
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);
  effect eVis2 = EffectVisualEffect(VFX_IMP_LIGHTNING_S);

  float fDelay = 0.5;

  object oCheck = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  while (GetIsObjectValid(oCheck))
  {
    int nType = GetObjectType(oCheck);
    string sType = GetTag(oCheck);

    //Check For Doors
    if(nType == OBJECT_TYPE_DOOR)
    {
      if (!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
        DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEDam, oCheck));
        DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
        DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      }
    }
    //Check for other Placeables
    if(nType == OBJECT_TYPE_PLACEABLE)
    {
      if(!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
        DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEDam, oCheck));
        DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
        DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      }
    }
    //Check for Creatures
    if(nType == OBJECT_TYPE_CREATURE)
    {
      DelayCommand(fImpactDelay + 1.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oCheck));
      DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLin1, oCheck));
      DelayCommand(fImpactDelay + 1.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEDam, oCheck));
      DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
      DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
      DelayCommand(fImpactDelay + 1.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSDam, oCheck));
      DelayCommand(fImpactDelay + 2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oCheck, 3.0));

      SignalEvent(oCheck, EventSpellCastAt(oPC, nSpell));
    }
    oCheck = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }
}

//Caltrop Grenade
void OS_CaltropGrenade(object oPC, object oTarget)
{
  object oOrigin = GetLocalObject(oPC,"OS_CURRENT_ORIGIN");

  object oArea = GetArea(oPC);
  float fHeight = 1.5;
  float fDistance = 1.0;

  float fRange = GetDistanceBetween(oOrigin,oTarget);

  //Skill
  //As the Skill in Discipline or Concentration get higher....the Accuracy of the Thrown Grenades Become.
  int nSkill = 1;
  int nDisc = GetSkillRank(SKILL_DISCIPLINE,oPC);
  int nConc = GetSkillRank(SKILL_CONCENTRATION,oPC);
  nSkill = nDisc;
  if(nConc > nDisc) nSkill = nConc;
  nSkill/10;

  int nBase = 5;
  int nFinal = nBase - nSkill;

  float fMult = IntToFloat(nFinal);

  //Total Range Error for Location Target
  float fError = SIEGE_ERRANT * fMult;

  location lLoc;

  //On Target
  if(fError <= 2.0)
  {
    lLoc = GetRandomLocation(oArea, oTarget, 1.0);
    AssignCommand(oPC, SpeakString("Projectile away and on target!"));
  }
  //A little off Target
  else
  {
    lLoc = GetRandomLocation(oArea, oTarget, fError);
    AssignCommand(oPC, SpeakString("Projectile away and a little off target!"));
  }

  float fImpactDelay = fRange/18;

  effect eImpact = EffectVisualEffect(VFX_DUR_CALTROPS);
  effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
  int nThrow = HURL_ROCK;
  int nSpell = SPELL_GRENADE_CALTROPS;
  float fRadius = 10.0;

  effect eDmg = EffectAreaOfEffect(37, "x0_s3_calEN", "x0_s3_calHB", "");
  DelayCommand(fImpactDelay + 1.0,ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eDmg, lLoc));

  AssignCommand(oOrigin,ActionCastFakeSpellAtLocation(nThrow, lLoc, PROJECTILE_PATH_TYPE_BALLISTIC));
  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
  DelayCommand(fImpactDelay,OS_CreateFieldEffect(lLoc));
  DelayCommand(fImpactDelay + 0.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc));
  DelayCommand(fImpactDelay + 1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBump, lLoc));

  DeleteLocalObject(oPC,"OS_CURRENT_ORIGIN");

  int nBDam = d10(1);//Bludgeoning Damage
  int nPDam = d10(6);//Piercing Spray Damage
  int nSDam = d10(1);//Slashing Spray Damage
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eSDam = EffectDamage(nSDam, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);
  float fDelay = 0.5;

  //Caltrop Spread AOE
  object oVisual = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLoc);

  object oAOE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT, lLoc);
  if(GetIsObjectValid(oAOE) == TRUE)
  {
    SetLocalObject(oAOE, "X0_L_IMPACT", oVisual);
  }

  object oCheck = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  while (GetIsObjectValid(oCheck))
  {
    int nType = GetObjectType(oCheck);
    string sType = GetTag(oCheck);

    //Check For Doors
    if(nType == OBJECT_TYPE_DOOR)
    {
      if (!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
      }
    }
    //Check for other Placeables
    if(nType == OBJECT_TYPE_PLACEABLE)
    {
      if(!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
      }
    }
    //Check for Creatures
    if(nType == OBJECT_TYPE_CREATURE)
    {
      DelayCommand(fImpactDelay + 1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLin1, oCheck));
      DelayCommand(fImpactDelay + 1.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
      DelayCommand(fImpactDelay + 1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));

      SignalEvent(oCheck, EventSpellCastAt(oPC, nSpell));
    }
    oCheck = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }
}

//Pistol
void OS_PistolShot(object oPC, object oTarget)
{
  object oOrigin = GetLocalObject(oPC,"OS_CURRENT_ORIGIN");

  object oArea = GetArea(oPC);
  float fHeight = 1.5;
  float fDistance = 1.0;

  float fRange = GetDistanceBetween(oOrigin,oTarget);

  //Skill
  //As the Skill in Discipline or Concentration get higher....the Accuracy of the Thrown Grenades Become.
  int nSkill = 1;
  int nDisc = GetSkillRank(SKILL_DISCIPLINE,oPC);
  int nConc = GetSkillRank(SKILL_CONCENTRATION,oPC);
  nSkill = nDisc;
  if(nConc > nDisc) nSkill = nConc;
  nSkill/10;

  int nBase = 5;
  int nFinal = nBase - nSkill;

  float fMult = IntToFloat(nFinal);

  //Total Range Error for Location Target
  float fError = SIEGE_ERRANT * fMult;

  location lLoc;

  //On Target
  if(fError <= 2.0)
  {
    lLoc = GetRandomLocation(oArea, oTarget, 1.0);
    AssignCommand(oPC, SpeakString("Projectile away and on target!"));
  }
  //A little off Target
  else
  {
    lLoc = GetRandomLocation(oArea, oTarget, fError);
    AssignCommand(oPC, SpeakString("Projectile away and a little off target!"));
  }

  effect eArrow = EffectVisualEffect(357);
  effect eShot = EffectVisualEffect(773);
  effect eImpact = EffectVisualEffect(VFX_COM_CHUNK_STONE_SMALL);
  int nThrow = SPELL_TRAP_ARROW;
  int nSpell = SPELL_TRAP_ARROW;
  float fRadius = 2.5;

  location lShoot = OS_Location(oPC, fDistance, fHeight);

  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eArrow, lLoc);
  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
  DelayCommand(0.8,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShot, lShoot));
  DelayCommand(0.9,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc));

  DeleteLocalObject(oPC,"OS_CURRENT_ORIGIN");

  int nBDam = d4(2);//Bludgeoning Damage
  int nPDam = d10(3);//Piercing Damage
  if(fError <= 0.5)//Critical
  {
    nBDam = nBDam * 2;
    nPDam = nPDam * 2;
  }
  effect eBDam = EffectDamage(nBDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
  effect ePDam = EffectDamage(nPDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
  effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
  effect eLin1 = EffectLinkEffects(eVis1, ePDam);
  float fDelay = 0.5;

  object oCheck = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  while (GetIsObjectValid(oCheck))
  {
    int nType = GetObjectType(oCheck);
    string sType = GetTag(oCheck);

    //Check For Doors
    if(nType == OBJECT_TYPE_DOOR)
    {
      if (!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
      }
    }
    //Check for other Placeables
    if(nType == OBJECT_TYPE_PLACEABLE)
    {
      if(!GetPlotFlag(oCheck))
      {
        // Apply effects to the currently selected target.
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
        DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));
      }
    }
    //Check for Creatures
    if(nType == OBJECT_TYPE_CREATURE)
    {
      DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLin1, oCheck));
      DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBDam, oCheck));
      DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePDam, oCheck));

      SignalEvent(oCheck, EventSpellCastAt(oPC, nSpell));
    }
    oCheck = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }
}

//void main (){}
