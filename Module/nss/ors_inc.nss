////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems Main Include File
//  ors_inc
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"
#include "x3_inc_skin"
#include "x0_i0_assoc"
#include "x2_inc_itemprop"
#include "x0_i0_position"
//#include "oai_inc_weapstat"
#include "nbde_inc"

// Color Variables
string RED = "<cσ  >";
string BLUE = "<c  σ>";
string GRAY = "<c°°°>";
string GREEN = "<c σ >";
string WHITE = "<cσσσ>";
string CYAN = "<c σσ>";
string YELLOW = "<cσσ >";
string BLUISHG = "<c °°>";
string BLUISHR = "<c °σ>";

string ORS_GetDBString()
{
  object oMod = GetModule();
  string sDB = GetLocalString(oMod,"ORS_DATABASE");

  return sDB;
}

/******************************************************************************/
//:: OLANDER'S DM STUFF

/*
See the Sign in the DM Control Room for Info on Setup
*/

int ORS_IsEnabledDM(object oPC)
{
  object oDMA = GetObjectByTag("DMAccounts");

  string sPCAccount = GetPCPlayerName(oPC);
  int nVal = GetLocalInt(oDMA,sPCAccount);

  if(nVal == 1) return 1;

  return 0;
}

void ORS_DMStuff(object oPC)
{
  //If Account is Enabled Give the Key
  object oKey = GetItemPossessedBy(oPC,"Key_DMHallofGods");

  //The One Ring For All DM's
  object oOneRing = GetItemPossessedBy(oPC,"dmfi_onering");

  //DM Gear Reset Tool
  object oRTool = GetItemPossessedBy(oPC,"DMGearResetTool");

  if(ORS_IsEnabledDM(oPC))
  {
    if(!GetIsObjectValid(oKey))
    {
      CreateItemOnObject("key_dmhallofgods",oPC);
      SendMessageToPC(oPC,"Welcome DM! You received a Hall of Gods DM Key.");
    }

    if(GetIsObjectValid(oOneRing) == FALSE && GetIsDM(oPC) == TRUE)
    {
      CreateItemOnObject("dmfi_onering", oPC,1);
    }

    if(GetIsObjectValid(oRTool) == FALSE && GetIsDM(oPC) == TRUE)
    {
      CreateItemOnObject("dmgearresetto",oPC,1);
    }
  }
  else
  {
    //No Longer a DM
    if(GetIsObjectValid(oKey))
    {
      DestroyObject(oKey);
    }

    if(GetIsObjectValid(oOneRing))
    {
      DestroyObject(oOneRing);
    }

    if(GetIsObjectValid(oRTool))
    {
      DestroyObject(oRTool);
    }
  }
}

void ORS_DMKey(object oPC)
{
  //If Account is Enabled Give the Key
  object oKey = GetItemPossessedBy(oPC,"Key_DMHallofGods");
  if(ORS_IsEnabledDM(oPC))
  {
    if(!GetIsObjectValid(oKey))
    {
      CreateItemOnObject("key_dmhallofgods",oPC);
      SendMessageToPC(oPC,"Welcome DM! You received a Hall of Gods DM Key.");
    }
  }
  else
  {
    //No Longer a DM
    if(GetIsObjectValid(oKey))
    {
      DestroyObject(oKey);
    }
  }
}

/******************************************************************************/
//:: OLANDER'S TUTORIAL SETTER

/*
Where a Waypoint Named => TUTORIAL  is placed ALL items acquired by the player
will be tagged as Tutorial and WILL be Removed when Exiting the Area.
*/

int ORS_IsTutorialArea(object oPC)
{
  object oTut = GetNearestObjectByTag("TUTORIAL",oPC);
  if(GetIsObjectValid(oTut)) return 1;

  return 0;
}

int ORS_IsTutorialItem(object oItem)
{
  string sItem = GetTag(oItem);

  if(sItem == "SoulRune") return 0;

  return 1;
}

void ORS_SetTutorial(object oPC,object oItem)
{
  if(ORS_IsTutorialArea(oPC)) SetLocalInt(oItem,"TUTORIAL",1);
}

void ORS_RemoveTutorial(object oPC)
{
  int nTut;

  object oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem))
  {
    int nTut = GetLocalInt(oItem,"TUTORIAL");
    if(nTut == 1 && ORS_IsTutorialItem(oItem)) DestroyObject(oItem);

    oItem = GetNextItemInInventory(oPC);
  }
}

/******************************************************************************/
//:: OLANDER'S ILLEGAL ITEMS VALIDATOR

/*
Tags of Illegal Items MUST be Placed in the  ors_mod_onload
Please see that script for setting up your Illegal Items and Item Properties.
*/

void ORS_DestroyIllegalItem(object oPC, string sILLItem)
{
  string sItem;
  object oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem))
  {
    sItem = GetTag(oItem);
    if(sItem == sILLItem)
    {
      DestroyObject(oItem);
    }

    oItem = GetNextItemInInventory(oPC);
  }
}

void ORS_RemoveIllegalProp(object oItem, int nILLProp)
{
  if(GetItemHasItemProperty(oItem, nILLProp))
  {
    IPRemoveMatchingItemProperties(oItem,nILLProp,DURATION_TYPE_PERMANENT);
  }
}

void ORS_ValidateIllegalItems(object oPC)
{
  object oMod = GetModule();
  int nClean = FALSE;
  int nILLItemQTY = GetLocalInt(oMod,"ILLEGALITEMQTY");
  int nILLPropQTY = GetLocalInt(oMod,"ILLEGALPROPQTY");

  string sILLItem; int nILLProp;
  object oItem; int nLoop = 0; int nCheck = 1;

  //Illegal Items Loop
  nLoop = 1;
  while(nLoop <= nILLItemQTY && nCheck <= 999)
  {
    sILLItem = GetLocalString(oMod,"ILLEGALITEM"+IntToString(nLoop));
    if(sILLItem == "") break;
    ORS_DestroyIllegalItem(oPC, sILLItem);
    nLoop++;
  }

  //Illegal Properties
  nLoop = 1;
  oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem) && nLoop <= nILLPropQTY && nCheck <= 999)
  {
    nClean = GetLocalInt(oItem,"ORS_CLEANED");
    nILLProp = GetLocalInt(oMod,"ILLEGALPROP"+IntToString(nLoop));
    if(nClean == FALSE) ORS_RemoveIllegalProp(oItem, nILLProp);
    nLoop++;
    SetLocalInt(oItem,"ORS_CLEANED",TRUE);

    //Remove Temporary Effects on Items
    IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);

    oItem = GetNextItemInInventory(oPC);
  }
}

/******************************************************************************/
//:: OLANDER'S LIBRARY BOOKS

void ORS_LibraryBooks(object oPC)
{
  string sBook = "LibraryBook";

  //Check For Library Books in Inventory
  object oItem = GetFirstItemInInventory(oPC);
  string sItem;
  while(GetIsObjectValid(oItem))
  {
    sItem = GetTag(oItem);
    if(sItem == sBook) DestroyObject(oItem,0.1);
    oItem = GetNextItemInInventory(oPC);
  }
}

/******************************************************************************/
//:: OLANDER'S COLOR FLOAT TEXT

void ORS_FloatColorString(object oPC, string sFloat, string sColor)
{
  string sFinal = sColor + sFloat;
  FloatingTextStringOnCreature(sFinal, oPC, FALSE);
}

/******************************************************************************/
//:: OLANDER'S AMBIENT TRIGGER

void ORS_AmbientTrigger(object oPC, object oTrigger)
{
  location lLoc = GetLocation(oPC);

  //Slip and Fall
  int nSlip = GetLocalInt(oTrigger,"ORS_SLIP");
  if(nSlip == 1)
  {
    int nDam = d3(1);
    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 2.0);

    //Random Text
    int nRand = d4(1);
    string sSlip;
    string sSlip1 = "**Slipped and Fell....That Smells Like Dung**";
    string sSlip2 = "**Ankle Twisted on Rock....Where Did That Come From?**";
    string sSlip3 = "**Stumbles....Anybody Wacthing?**";
    string sSlip4 = "**Toe Trips on Slight Rise in Surface....You Feel Embarrassed**";
    if(nRand == 1) sSlip = sSlip1;
    if(nRand == 2) sSlip = sSlip2;
    if(nRand == 3) sSlip = sSlip3;
    if(nRand == 4) sSlip = sSlip4;

    FloatingTextStringOnCreature(sSlip, oPC, FALSE);
  }

  //Acid Fog
  int nAF = GetLocalInt(oTrigger,"ORS_ACID");
  int nAFA = GetLocalInt(oTrigger,"ORS_ACID_ACTIVE");
  if(nAF == 1 && nAFA == 0)
  {
    SetLocalInt(oTrigger,"ORS_ACID_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGACID);
    effect eImpact = EffectVisualEffect(257);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_ACID_ACTIVE",0)));
  }

  //Fog of Bewilderment
  int nFOB = GetLocalInt(oTrigger,"ORS_BEWILDERMENT");
  int nFOBA = GetLocalInt(oTrigger,"ORS_BEWILDERMENT_ACTIVE");
  if(nFOB == 1 && nFOBA == 0)
  {
    SetLocalInt(oTrigger,"ORS_BEWILDERMENT_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_FOG_OF_BEWILDERMENT);
    effect eImpact = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_BEWILDERMENT_ACTIVE",0)));
  }

  //Creeping Doom
  int nCD = GetLocalInt(oTrigger,"ORS_CREEPINGDOOM");
  int nCDA = GetLocalInt(oTrigger,"ORS_CREEPINGDOOM_ACTIVE");
  if(nCD == 1 && nCDA == 0)
  {
    SetLocalInt(oTrigger,"ORS_CREEPINGDOOM_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_CREEPING_DOOM);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(10));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(20),SetLocalInt(oTrigger,"ORS_CREEPINGDOOM_ACTIVE",0)));
  }

  //Darkness
  int nDK = GetLocalInt(oTrigger,"ORS_DARKNESS");
  int nDKA = GetLocalInt(oTrigger,"ORS_DARKNESS_ACTIVE");
  if(nDK == 1 && nDKA == 0)
  {
    SetLocalInt(oTrigger,"ORS_DARKNESS_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_DARKNESS);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(10));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(20),SetLocalInt(oTrigger,"ORS_DARKNESS_ACTIVE",0)));
  }

  //Entangle
  int nEN = GetLocalInt(oTrigger,"ORS_ENTANGLE");
  int nENA = GetLocalInt(oTrigger,"ORS_ENTANGLE_ACTIVE");
  if(nEN == 1 && nENA == 0)
  {
    SetLocalInt(oTrigger,"ORS_ENTANGLE_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_ENTANGLE_ACTIVE",0)));
  }

  //Fire Fog
  int nFF = GetLocalInt(oTrigger,"ORS_FIRE");
  int nFFA = GetLocalInt(oTrigger,"ORS_FIRE_ACTIVE");
  if(nFF == 1 && nFFA == 0)
  {
    SetLocalInt(oTrigger,"ORS_FIRE_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGFIRE);
    effect eImpact = EffectVisualEffect(260);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_FIRE_ACTIVE",0)));
  }

  //Ghoul Fog
  int nGF = GetLocalInt(oTrigger,"ORS_GHOUL");
  int nGFA = GetLocalInt(oTrigger,"ORS_GHOUL_ACTIVE");
  if(nGF == 1 && nGFA == 0)
  {
    SetLocalInt(oTrigger,"ORS_GHOUL_ACTIVE",1);
    effect eImpact = EffectVisualEffect(259);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGGHOUL);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_GHOUL_ACTIVE",0)));
  }

  //Grease
  int nGRS = GetLocalInt(oTrigger,"ORS_GREASE");
  int nGRSA = GetLocalInt(oTrigger,"ORS_GREASE_ACTIVE");
  if(nGRS == 1 && nGRSA == 0)
  {
    SetLocalInt(oTrigger,"ORS_GREASE_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_GREASE);
    effect eImpact = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_GREASE_ACTIVE",0)));
  }

  //Kaboom (Olander Sized Explosion =) )
  int nKAB = GetLocalInt(oTrigger,"ORS_KABOOM");
  int nKABA = GetLocalInt(oTrigger,"ORS_KABOOM_ACTIVE");
  if(nKAB == 1 && nKABA == 0)
  {
    SetLocalInt(oTrigger,"ORS_KABOOM_ACTIVE",1);

    float fRadius = 10.0;//Keg Blast Radius
    int nFireDam = d20(5)+20;//These things are Dangerous LOL
    int nConcDam = d10(5)+10;//Concussion Damage
    int nPierDam = d10(5)+10;//Piercing Spray Damage
    effect eFire = EffectDamage(nFireDam, DAMAGE_TYPE_FIRE, DAMAGE_POWER_PLUS_TWENTY);
    effect eConc = EffectDamage(nConcDam, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWENTY);
    effect ePierce = EffectDamage(nPierDam, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_PLUS_TWENTY);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    float fDelay = 0.5;

    //Make Explosion
    effect eBoom1 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom1, lLoc);
    effect eBoom2 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
    DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom2, lLoc));

    //Create a Scorchmark
    object oScorch = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_weathmark",lLoc);
    DelayCommand(60.0,DestroyObject(oScorch));

    //Create a Dust Plume
    object oPlume = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_dustplume",lLoc);
    DelayCommand(20.0,DestroyObject(oPlume));

    //Create a Small Flame
    object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamesmall",lLoc);
    DelayCommand(15.0,DestroyObject(oFlame));

    //Now we apply damage to things in the Blast Radius
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
       //Check For Doors
       if(GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
       {
         if (!GetPlotFlag(oTarget))
         {
           // Apply effects to the currently selected target.
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePierce, oTarget));
         }
       }
       //Check for other Placeables
       if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
       {
         if (!GetPlotFlag(oTarget))
         {
           // Apply effects to the currently selected target.
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePierce, oTarget));
         }
       }
       if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
       {
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eConc, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePierce, oTarget));
         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 3.0));
       }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(1),SetLocalInt(oTrigger,"ORS_KABOOM_ACTIVE",0)));
  }

  //Kill Fog (Cloud Kill)
  int nKF = GetLocalInt(oTrigger,"ORS_CLOUDKILL");
  int nKFA = GetLocalInt(oTrigger,"ORS_CLOUDKILL_ACTIVE");
  if(nKF == 1 && nKFA == 0)
  {
    SetLocalInt(oTrigger,"ORS_CLOUDKILL_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGKILL);
    effect eImpact = EffectVisualEffect(258);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_CLOUDKILL_ACTIVE",0)));
  }

  //Mind Fog
  int nMF = GetLocalInt(oTrigger,"ORS_MINDFOG");
  int nMFA = GetLocalInt(oTrigger,"ORS_MINDFOG_ACTIVE");
  if(nMF == 1 && nMFA == 0)
  {
    SetLocalInt(oTrigger,"ORS_MINDFOG_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGMIND);
    effect eImpact = EffectVisualEffect(262);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_MINDFOG_ACTIVE",0)));
  }

  //Stink Fog
  int nSF = GetLocalInt(oTrigger,"ORS_STINK");
  int nSFA = GetLocalInt(oTrigger,"ORS_STINK_ACTIVE");
  if(nSF == 1 && nSFA == 0)
  {
    SetLocalInt(oTrigger,"ORS_STINK_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGSTINK);
    effect eImpact = EffectVisualEffect(259);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_STINK_ACTIVE",0)));
  }

  //Stone Hold
  int nSH = GetLocalInt(oTrigger,"ORS_STONEHOLD");
  int nSHA = GetLocalInt(oTrigger,"ORS_STONEHOLD_ACTIVE");
  if(nSH == 1 && nSHA == 0)
  {
    SetLocalInt(oTrigger,"ORS_STONEHOLD_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_STONEHOLD);
    effect eImpact = EffectVisualEffect(259);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_STONEHOLD_ACTIVE",0)));
  }

  //Storm of Vengence
  int nSOV = GetLocalInt(oTrigger,"ORS_STORMOFVENG");
  int nSOVA = GetLocalInt(oTrigger,"ORS_STORMOFVENG_ACTIVE");
  if(nSOV == 1 && nSOVA == 0)
  {
    SetLocalInt(oTrigger,"ORS_STORMOFVENG_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_STORM);
    effect eImpact = EffectVisualEffect(VFX_FNF_STORM);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(10));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(20),SetLocalInt(oTrigger,"ORS_STORMOFVENG_ACTIVE",0)));
  }

  //Trog Stench
  int nTS = GetLocalInt(oTrigger,"ORS_TROG");
  int nTSA = GetLocalInt(oTrigger,"ORS_TROG_ACTIVE");
  if(nTS == 1 && nTSA == 0)
  {
    SetLocalInt(oTrigger,"ORS_TROG_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_MOB_TROGLODYTE_STENCH);
    effect eImpact = EffectVisualEffect(259);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_TROG_ACTIVE",0)));
  }

  //Tyrant Fog
  int nTF = GetLocalInt(oTrigger,"ORS_TYRANT");
  int nTFA = GetLocalInt(oTrigger,"ORS_TYRANT_ACTIVE");
  if(nTF == 1 && nTFA == 0)
  {
    SetLocalInt(oTrigger,"ORS_TYRANT_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_MOB_TYRANT_FOG);
    effect eImpact = EffectVisualEffect(259);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_TYRANT_ACTIVE",0)));
  }

  //Wall Blade (Blade Barrier)
  int nWB = GetLocalInt(oTrigger,"ORS_BLADEBARRIER");
  int nWBA = GetLocalInt(oTrigger,"ORS_BLADEBARRIER_ACTIVE");
  if(nWB == 1 && nWBA == 0)
  {
    SetLocalInt(oTrigger,"ORS_BLADEBARRIER_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLBLADE);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_BLADEBARRIER_ACTIVE",0)));
  }

  //Wall Fire
  int nWF = GetLocalInt(oTrigger,"ORS_WALLFIRE");
  int nWFA = GetLocalInt(oTrigger,"ORS_WALLFIRE_ACTIVE");
  if(nWF == 1 && nWFA == 0)
  {
    SetLocalInt(oTrigger,"ORS_WALLFIRE_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLFIRE);
    effect eImpact = EffectVisualEffect(260);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_WALLFIRE_ACTIVE",0)));
  }

  //Web
  int nWEB = GetLocalInt(oTrigger,"ORS_WEB");
  int nWEBA = GetLocalInt(oTrigger,"ORS_WEB_ACTIVE");
  if(nWEB == 1 && nWEBA == 0)
  {
    SetLocalInt(oTrigger,"ORS_WEB_ACTIVE",1);

    effect eAOE = EffectAreaOfEffect(AOE_PER_WEB);

    //Create the AOE object at the selected location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(5));
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_WEB_ACTIVE",0)));
  }

  //Float a Statement Above the Player's Head.  (Once Per Reload)
  int nFT = GetLocalInt(oTrigger,"ORS_FLOATTEXT");
  int nFTA = GetLocalInt(oTrigger,"ORS_TEXT_ACTIVE");
  if(nFT == 1 && nFTA == 0)
  {
    SetLocalInt(oTrigger,"ORS_TEXT_ACTIVE",1);

    string sText = GetLocalString(oTrigger,"ORS_TEXT");

    //Once Per Reload
    int nDoOnce = GetLocalInt(oPC, "DO_ONCE" + ObjectToString(oTrigger));
    if(nDoOnce == 1) return;
    SetLocalInt(oPC, "DO_ONCE" + ObjectToString(oTrigger), 1);

    FloatingTextStringOnCreature(GRAY+sText, oPC, FALSE);

    //Delay Meesages on other Party Members
    AssignCommand(oTrigger,DelayCommand(RoundsToSeconds(10),SetLocalInt(oTrigger,"ORS_TEXT_ACTIVE",0)));
  }
}

/******************************************************************************/
//:: OLANDER'S FIRST ENTER STRIP AND CONFIGURE PLAYER(Formerly  ofe_mod_onenter )

void ORS_NewPlayer(object oPC, int nNewXP)
{
  object oPC      = GetEnteringObject();
  object oMod     = GetModule();
  string sDB      = GetLocalString(oMod,"ORS_DATABASE");
  int nXP         = GetLocalInt(oMod,"STARTXP");
  int nPHBStrip   = GetLocalInt(oMod,"PHBSTRIP");
  int nGiveGold   = GetLocalInt(oMod,"GIVEGOLD");

  if(nNewXP < nXP && nNewXP <= 1000)
  {
    //We Destroy all the objects in the inventory
    object oItem = GetFirstItemInInventory(oPC);
    while (oItem != OBJECT_INVALID)
    {
      DestroyObject(oItem);
      oItem = GetNextItemInInventory(oPC);
    }
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_NECK, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BELT, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC), 0.0);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC), 0.0);

    //Now we give the Player the amount of XP above
    GiveXPToCreature(oPC, nXP);

    //Olander's Soul Rune System
    int nDeathChoose = GetLocalInt(oMod,"DEATHCHOOSE");
    if(nDeathChoose == 1)
    {
      //Give Soul Runes to Player
      int nSLifes = GetLocalInt(oMod,"LIVES");
      int i=1; object oSoulRune;

      //Give Rune Stones
      for(i;i <= nSLifes;i++)
      {
        oSoulRune = CreateItemOnObject("soulrune", oPC,1);
      }
    }

    //Give Gold for Starting Characters PHB Rules
    if(nPHBStrip == 1)
    {
      if(GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)) nGiveGold = d4(4)*10;
      else if(GetLevelByClass(CLASS_TYPE_BARD, oPC)) nGiveGold = d4(4)*10;
      else if(GetLevelByClass(CLASS_TYPE_CLERIC, oPC)) nGiveGold = d4(5)*10;
      else if(GetLevelByClass(CLASS_TYPE_DRUID, oPC)) nGiveGold = d4(2)*10;
      else if(GetLevelByClass(CLASS_TYPE_FIGHTER, oPC)) nGiveGold = d4(6)*10;
      else if(GetLevelByClass(CLASS_TYPE_MONK, oPC)) nGiveGold = d4(5);
      else if(GetLevelByClass(CLASS_TYPE_PALADIN, oPC)) nGiveGold = d4(6)*10;
      else if(GetLevelByClass(CLASS_TYPE_RANGER, oPC)) nGiveGold = d4(6)*10;
      else if(GetLevelByClass(CLASS_TYPE_ROGUE, oPC)) nGiveGold = d4(5)*10;
      else if(GetLevelByClass(CLASS_TYPE_SORCERER, oPC)) nGiveGold = d4(3)*10;
      else if(GetLevelByClass(CLASS_TYPE_WIZARD, oPC)) nGiveGold = d4(3)*10;
      else nGiveGold = d4(4)*10;
    }

    //Give Gold for Starting Characters Standard Amount
    if(nPHBStrip == 0  && nGiveGold == 0)
    {
      //Change Gold for Level 2 and Up
      if ((nXP >= 1000) && (nXP < 3000)) nGiveGold = 900;
      else if ((nXP >= 3000) && (nXP < 6000)) nGiveGold = 2700;
      else if ((nXP >= 6000) && (nXP < 10000)) nGiveGold = 5400;
      else if ((nXP >= 10000) && (nXP < 15000)) nGiveGold = 9000;
      else if ((nXP >= 15000) && (nXP < 21000)) nGiveGold = 13000;
      else if ((nXP >= 21000) && (nXP < 28000)) nGiveGold = 19000;
      else if ((nXP >= 28000) && (nXP < 36000)) nGiveGold = 27000;
      else if ((nXP >= 36000) && (nXP < 45000)) nGiveGold = 36000;
      else if ((nXP >= 45000) && (nXP < 55000)) nGiveGold = 49000;
      else if ((nXP >= 55000) && (nXP < 66000)) nGiveGold = 66000;
      else if ((nXP >= 66000) && (nXP < 78000)) nGiveGold = 88000;
      else if ((nXP >= 78000) && (nXP < 91000)) nGiveGold = 110000;
      else if ((nXP >= 91000) && (nXP < 105000)) nGiveGold = 150000;
      else if ((nXP >= 105000) && (nXP < 120000)) nGiveGold = 200000;
      else if ((nXP >= 120000) && (nXP < 136000)) nGiveGold = 260000;
      else if ((nXP >= 136000) && (nXP < 153000)) nGiveGold = 340000;
      else if ((nXP >= 153000) && (nXP < 171000)) nGiveGold = 440000;
      else if ((nXP >= 171000) && (nXP < 190000)) nGiveGold = 580000;
      else if (nXP >= 190000) nGiveGold = 760000;
    }

    //How much gold does the Player already have?
    int nGold = GetGold(oPC);

    //Too much Gold
    if (nGold > nGiveGold)
    {
      AssignCommand(oPC, TakeGoldFromCreature(nGold - nGiveGold, oPC, TRUE));
    }
    //Not enough Gold
    else if (nGold < nGiveGold)
    {
      GiveGoldToCreature(oPC, nGiveGold - nGold);
    }

    //Current Class Types
    int nClassType1 = GetClassByPosition(1,oPC);
    int nClassType2 = GetClassByPosition(2,oPC);
    int nClassType3 = GetClassByPosition(3,oPC);

    //Current Levels in Each Class
    int nClassLvl1 = GetLevelByClass(nClassType1,oPC);
    int nClassLvl2 = GetLevelByClass(nClassType2,oPC);
    int nClassLvl3 = GetLevelByClass(nClassType3,oPC);

    //Persistent Classes (For CCS Trainers)
    NBDE_SetCampaignInt(sDB, "CCS_CLASS1", nClassType1, oPC);
    NBDE_SetCampaignInt(sDB, "CCS_CLASS2", CLASS_TYPE_INVALID, oPC);
    NBDE_SetCampaignInt(sDB, "CCS_CLASS3", CLASS_TYPE_INVALID, oPC);

    NBDE_SetCampaignInt(sDB, "CCS_LEVEL1", nClassLvl1, oPC);
    NBDE_SetCampaignInt(sDB, "CCS_LEVEL2", 255, oPC);
    NBDE_SetCampaignInt(sDB, "CCS_LEVEL3", 255, oPC);

    //Now Give a PC Property Skin
    object oSkin = CreateItemOnObject("ors_pcskin",oPC);
    DelayCommand(12.0,AssignCommand(oPC,ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR)));
    SetLocalObject(oPC,"oX3_Skin",oSkin);

    //New Players go to The Void
    object oVoid = GetObjectByTag("WP_VOID");
    if(GetIsObjectValid(oVoid))
    {
      SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WILL_O_WISP);
      DelayCommand( 1.0,AssignCommand(oPC, SetCommandable(FALSE,oPC)));
      DelayCommand( 9.0,AssignCommand(oPC, SetCommandable(TRUE,oPC)));
      DelayCommand(11.0,AssignCommand(oPC, ActionJumpToLocation(GetLocation(oVoid))));
    }
  }
}

/******************************************************************************/
//:: OLANDER'S PLAYER CONTAINERS....ADVENTURING GEAR

void ORS_AdventureGear(object oPC)
{
  //PC Autofollow Widget
  object oAFW = GetItemPossessedBy(oPC,"dmfi_pc_follow");
  if(GetIsObjectValid(oAFW) == FALSE)
  {
    CreateItemOnObject("dmfi_pc_follow", oPC,1);
  }

  //PC Dicebag
  object oDiceBag = GetItemPossessedBy(oPC,"dmfi_pc_dicebag");
  if(GetIsObjectValid(oDiceBag) == FALSE)
  {
    CreateItemOnObject("dmfi_pc_dicebag", oPC,1);
  }

  //ORS Back Pack
  object oBP = GetItemPossessedBy(oPC,"ORS_BackPack");
  if(!GetIsObjectValid(oBP))
  {
    CreateItemOnObject("ors_backpack", oPC,1);
  }

  //ORS Food Pack
  object oFP = GetItemPossessedBy(oPC,"ORS_FoodPack");
  if(!GetIsObjectValid(oFP))
  {
    CreateItemOnObject("ors_foodpack", oPC,1);
  }

  //ORS Herb Box
  object oHB = GetItemPossessedBy(oPC,"ORS_HerbBox");
  if(!GetIsObjectValid(oHB))
  {
    CreateItemOnObject("ors_herbbox", oPC,1);
  }

  //ORS Gem Bag
  object oGB = GetItemPossessedBy(oPC,"ORS_GemBag");
  if(!GetIsObjectValid(oGB))
  {
    CreateItemOnObject("ors_gembag", oPC,1);
  }

  //ORS Prospecting Widget
  object oRP = GetItemPossessedBy(oPC,"ORS_Propector");
  if(!GetIsObjectValid(oRP))
  {
    CreateItemOnObject("ors_propector", oPC,1);
  }
}

/******************************************************************************/
//:: OLANDER'S ALLEGIANCE AND SUBRACES

void ORS_DestroyOldSkin(object oPC)
{
  object oMod = GetModule();
  string sDB = GetLocalString(oMod,"ORS_DATABASE");

  //Destroy the Old Skin
  object oOSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
  DestroyObject(oOSkin);

  object oItem = GetFirstItemInInventory(oPC);
  string sItem; string sResRef;
  while(GetIsObjectValid(oItem))
  {
    sItem = GetResRef(oItem);
    if(sItem == "ors_pcskin" || sItem == "x3_it_pchide")
    {
      DestroyObject(oItem);
    }

    //Subrace Skins
    string sPCSKIN = NBDE_GetCampaignString(sDB, "ORS_ALIGN_SKIN", oPC);
    if(sItem == sPCSKIN)
    {
      DestroyObject(oItem);
    }

    oItem = GetNextItemInInventory(oPC);
  }
}

void ORS_AddSubRaceSkin(object oPC, string sSubRace)
{
  object oRSkin = CreateItemOnObject(sSubRace,oPC);
  AssignCommand(oPC,ClearAllActions(TRUE));
  AssignCommand(oPC,SKIN_SupportEquipSkin(oRSkin));
  SetLocalObject(oPC,"oX3_Skin",oRSkin);
  SendMessageToPC(oPC,"Your Racial Skin was refreshed.");
}

void ORS_Subrace(object oPC)
{
  object oMod = GetModule();
  string sDB = GetLocalString(oMod,"ORS_DATABASE");

  //Allegiance
  int nReAlign = FALSE;
  int nORS_ALIGN = GetLocalInt(oMod,"ORS_ALIGN");
  int nPCALIGN = NBDE_GetCampaignInt(sDB, "ORS_ALIGN", oPC);

  //Check DB
  string sPCSKIN = NBDE_GetCampaignString(sDB, "ORS_ALIGN_SKIN", oPC);
  if(sPCSKIN == "") nReAlign = TRUE;

  //Remove Any Existing Skins
  ORS_DestroyOldSkin(oPC);

  //Add SubRace Skin
  if(nORS_ALIGN > 0 && nReAlign == FALSE)
  {
    //Check Alingment DB
    if(nPCALIGN < 1)
    {
      nReAlign = TRUE;
    }

    //Refresh Skin If DB is Ok
    if(sPCSKIN != "" && nReAlign == FALSE)
    {
      ORS_AddSubRaceSkin(oPC, sPCSKIN);
      return;
    }
    else nReAlign = TRUE;

    //Not Aligned? Reset the Player and Jump to Void
    if(nReAlign == TRUE)
    {
      AssignCommand(oPC,ClearAllActions(TRUE));

      //Now Update Player
      NBDE_SetCampaignInt(sDB, "ORS_ALIGN", 0, oPC);
      NBDE_SetCampaignString(sDB, "ORS_ALIGN_SKIN", "", oPC);
      SetSubRace(oPC, "");

      //Now Give a PC Property Skin
      object oORSSkin = CreateItemOnObject("ors_pcskin",oPC);
      AssignCommand(oPC,SKIN_SupportEquipSkin(oORSSkin));
      SetLocalObject(oPC,"oX3_Skin",oORSSkin);

      //Now Send to The Void
      object oVoid = GetObjectByTag("WP_VOID");
      if(GetIsObjectValid(oVoid))
      {
        SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WILL_O_WISP);
        DelayCommand( 1.0,AssignCommand(oPC, SetCommandable(FALSE,oPC)));
        DelayCommand( 9.0,AssignCommand(oPC, SetCommandable(TRUE,oPC)));
        DelayCommand(11.0,AssignCommand(oPC, ActionJumpToLocation(GetLocation(oVoid))));
      }

      SendMessageToPC(oPC,"Your Alignment was corrupted so you were reset. Please Align to your Race Again. Sorry for any inconveniences.");
    }
  }

  //Just a Skin
  else
  {
    //Now Give a PC Property Skin
    object oORSSkin = CreateItemOnObject("ors_pcskin",oPC);
    AssignCommand(oPC,SKIN_SupportEquipSkin(oORSSkin));
    SetLocalObject(oPC,"oX3_Skin",oORSSkin);
  }
}

/******************************************************************************/
//:: OLANDER and 9FIRE's Tracking Ambient Effect
 /*
string ORS_GetDirection(float fFacing)
{
  string sDirection = "";

  int nFacing = FloatToInt(fFacing);

  if((nFacing >= 359) && (nFacing <= 2)) sDirection = "To the Right";
  if((nFacing >= 3) && (nFacing <= 45)) sDirection = "To the Forward Right";
  if((nFacing >= 46) && (nFacing <= 87)) sDirection = "To the Forward Right";
  if((nFacing >= 8) && (nFacing <= 92)) sDirection = "Ahead";
  if((nFacing >= 93) && (nFacing <= 135)) sDirection = "To the Forward Left";
  if((nFacing >= 136) && (nFacing <= 177)) sDirection = "To the Forward Left";
  if((nFacing >= 178) && (nFacing <= 182)) sDirection = "To the Left";
  if((nFacing >= 183) && (nFacing <= 225)) sDirection = "From Behind to the Left";
  if((nFacing >= 226) && (nFacing <= 267)) sDirection = "From Behind to the Left";
  if((nFacing >= 268) && (nFacing <= 272)) sDirection = "From Behind";
  if((nFacing >= 273) && (nFacing <= 315)) sDirection = "From Behind to the Right";
  if((nFacing >= 316) && (nFacing <= 358)) sDirection = "From Behind to the Right";

  return sDirection;
}

string ORS_GetCreatureDescription(object oCreature)
{
  string sRace = "";

  if(GetRacialType(oCreature) == RACIAL_TYPE_ABERRATION) sRace = "an aberration";
  if(GetRacialType(oCreature) == RACIAL_TYPE_ALL) sRace = "a creature";
  if(GetRacialType(oCreature) == RACIAL_TYPE_ANIMAL) sRace = "an animal";
  if(GetRacialType(oCreature) == RACIAL_TYPE_BEAST) sRace = "a beast";
  if(GetRacialType(oCreature) == RACIAL_TYPE_CONSTRUCT) sRace = "a construct";
  if(GetRacialType(oCreature) == RACIAL_TYPE_DRAGON) sRace = "a dragon";
  if(GetRacialType(oCreature) == RACIAL_TYPE_DWARF) sRace = "a dwarf";
  if(GetRacialType(oCreature) == RACIAL_TYPE_ELEMENTAL) sRace = "an elemental";
  if(GetRacialType(oCreature) == RACIAL_TYPE_ELF) sRace = "an elf";
  if(GetRacialType(oCreature) == RACIAL_TYPE_FEY) sRace = "a fey";
  if(GetRacialType(oCreature) == RACIAL_TYPE_GIANT) sRace = "a giant";
  if(GetRacialType(oCreature) == RACIAL_TYPE_GNOME) sRace = "a goblin";
  if(GetRacialType(oCreature) == RACIAL_TYPE_HALFELF) sRace = "a half-elf";
  if(GetRacialType(oCreature) == RACIAL_TYPE_HALFLING) sRace = "a halfling";
  if(GetRacialType(oCreature) == RACIAL_TYPE_HALFORC) sRace = "an orc";
  if(GetRacialType(oCreature) == RACIAL_TYPE_HUMAN) sRace = "a human";
  if(GetRacialType(oCreature) == RACIAL_TYPE_HUMANOID_GOBLINOID) sRace = "a goblin";
  if(GetRacialType(oCreature) == RACIAL_TYPE_HUMANOID_MONSTROUS) sRace = "a monster";
  if(GetRacialType(oCreature) == RACIAL_TYPE_HUMANOID_ORC) sRace = "an orc";
  if(GetRacialType(oCreature) == RACIAL_TYPE_HUMANOID_REPTILIAN) sRace = "a reptilian creature";
  if((GetRacialType(oCreature) == RACIAL_TYPE_MAGICAL_BEAST)
&& (GetStringLeft(GetTag(oCreature), 5) != "Plant")) sRace = "a very unusual creature";
  if((GetRacialType(oCreature) == RACIAL_TYPE_MAGICAL_BEAST)
&& (GetStringLeft(GetTag(oCreature), 5) == "Plant")) sRace = "a sentient plantform";
  if(GetRacialType(oCreature) == RACIAL_TYPE_OUTSIDER) sRace = "an outsider";
  if(GetRacialType(oCreature) == RACIAL_TYPE_SHAPECHANGER) sRace = "a possible shapechanger";
  if(GetRacialType(oCreature) == RACIAL_TYPE_UNDEAD) sRace = "an undead";
  if(GetRacialType(oCreature) == RACIAL_TYPE_VERMIN) sRace = "a vermin";
  if(GetRacialType(oCreature) == RACIAL_TYPE_OOZE) sRace = "an ooze";

  return sRace;
}

int ORS_IsTracker(object oPC)
{
  int nCheck = FALSE;

  //Current Class Types
  int nClassType1 = GetClassByPosition(1,oPC);
  int nClassType2 = GetClassByPosition(2,oPC);
  int nClassType3 = GetClassByPosition(3,oPC);

  //Druids
  if(nClassType1 == CLASS_TYPE_DRUID) nCheck = TRUE;
  if(nClassType2 == CLASS_TYPE_DRUID) nCheck = TRUE;
  if(nClassType3 == CLASS_TYPE_DRUID) nCheck = TRUE;

  //Ranger
  if(nClassType1 == CLASS_TYPE_RANGER) nCheck = TRUE;
  if(nClassType2 == CLASS_TYPE_RANGER) nCheck = TRUE;
  if(nClassType3 == CLASS_TYPE_RANGER) nCheck = TRUE;

  //Skill Checks
  int nAnimal = GetSkillRank(SKILL_ANIMAL_EMPATHY,oPC,TRUE);
  if(nAnimal > 9) nCheck = TRUE;
  int nListen = GetSkillRank(SKILL_LISTEN,oPC,TRUE);
  if(nListen > 9) nCheck = TRUE;
  int nSearch = GetSkillRank(SKILL_SEARCH,oPC,TRUE);
  if(nSearch > 9) nCheck = TRUE;
  int nSpot = GetSkillRank(SKILL_SPOT,oPC,TRUE);
  if(nSpot > 9) nCheck = TRUE;

  return nCheck;
}

int ORS_IsInNaturalArea(object oArea)
{
  int nNat = FALSE;

  int nCheck = GetIsAreaNatural(oArea);
  if(nCheck == AREA_NATURAL) nNat = TRUE;

  return nNat;
}

int ORS_IsPrecipitating(object oArea)
{
  int nPre = FALSE;

  int nW = GetWeather(oArea);
  if(nW == WEATHER_RAIN || nW == WEATHER_SNOW) nPre = TRUE;

  return nPre;
}

void ORS_Tracking(object oPC)
{
  if(GetIsDM(oPC) || GetIsDMPossessed(oPC)) return;

  //Round Countdown to Next Check
  int nRounds = GetLocalInt(oPC,"ORS_TRACKING_TALLY");
  if(nRounds > 0)
  {
    nRounds = nRounds - 1;
    SetLocalInt(oPC,"ORS_TRACKING_TALLY",nRounds);
    return;
  }

  //Player in Combat
  if(GetIsInCombat(oPC)) return;

  object oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, oPC);

  //Invalid Creatures
  if(GetRacialType(oCreature) == RACIAL_TYPE_INVALID) return;

  float fDist = GetDistanceBetween(oCreature, oPC);
  object oArea = GetArea(oCreature);

  //Greater than 30M
  if(fDist > 30.0) return;

  //If Precipitating 20M Max
  if(ORS_IsPrecipitating(oArea))
  {
    if(fDist > 20.0) return;
  }

  int nDist = FloatToInt(fDist);
  int nDetect = FALSE;

  //Class Checks
  if(ORS_IsTracker(oPC))
  {
    //Random Timing Roll
    nRounds = d10(1);
    SetLocalInt(oPC,"ORS_TRACKING_TALLY",nRounds);

    //Send Messages
    float fFacing = GetFacing(oPC);
    float fDir = GetNormalizedDirection(fFacing);
    string sDir = ORS_GetDirection(fDir);
    string sRace = ORS_GetCreatureDescription(oCreature);
    SendMessageToPC(oPC,"It appears that "+sRace+" is "+IntToString(nDist)+"Meters "+sDir);
  }
}
*/
/******************************************************************************/
//:: PLAYERSTATS

void ORS_PCBirthday(object oPC)
{
  object oMod = GetModule();

  int nTime = GetCampaignInt("ORS_STATS", "PC_YEAR_START", oPC);
  if (nTime == 0)
  {
    int nAge = GetAge(oPC);
    int nYear = GetCalendarYear();
    int nBorn = nYear - nAge;
    int nMonth = GetCalendarMonth();
    int nDay = GetCalendarDay();
    int nHour = GetTimeHour();
    int nTotalHours = (nYear*8760) + (nMonth*720) + (nDay*24) + nHour;

    string sMonth;
    switch(nMonth)
    {
      case 1: sMonth = GetLocalString(oMod,"MONTH1"); break;
      case 2: sMonth = GetLocalString(oMod,"MONTH2"); break;
      case 3: sMonth = GetLocalString(oMod,"MONTH3"); break;
      case 4: sMonth = GetLocalString(oMod,"MONTH4"); break;
      case 5: sMonth = GetLocalString(oMod,"MONTH5"); break;
      case 6: sMonth = GetLocalString(oMod,"MONTH6"); break;
      case 7: sMonth = GetLocalString(oMod,"MONTH7"); break;
      case 8: sMonth = GetLocalString(oMod,"MONTH8"); break;
      case 9: sMonth = GetLocalString(oMod,"MONTH9"); break;
      case 10: sMonth = GetLocalString(oMod,"MONTH10"); break;
      case 11: sMonth = GetLocalString(oMod,"MONTH11"); break;
      case 12: sMonth = GetLocalString(oMod,"MONTH12"); break;
    }

    SetCampaignInt("ORS_STATS", "PC_YEAR_START", nBorn, oPC);
    SetCampaignString("ORS_STATS", "PC_MONTH_START", sMonth, oPC);
    SetCampaignInt("ORS_STATS", "PC_DAY_START", nDay, oPC);
    SetCampaignInt("ORS_STATS", "PC_START_HOURS", nTotalHours, oPC);
  }
}

string ORS_GetTotalDeaths(object oPC)
{
  object oItem; int nCount = 0; int nStack;

  oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem))
  {
    if(GetTag(oItem) == "SoulRune")
    {
      nStack = GetItemStackSize(oItem);
      if(nStack > 1) nCount = nCount + nStack;
      else nCount++;
    }

    oItem = GetNextItemInInventory(oPC);
  }

  int nSLives = GetLocalInt(GetModule(),"LIVES");
  int nTotalDeaths = nSLives - nCount;
  string sValue = "";
  if (nTotalDeaths == 0) sValue = "Never Died";
  else sValue = IntToString(nTotalDeaths);
  return sValue;
}

string ORS_GetTotalLifes(object oPC)
{
  object oItem; int nCount = 0; int nStack;

  oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem))
  {
    if(GetTag(oItem) == "SoulRune")
    {
      nStack = GetItemStackSize(oItem);
      if(nStack > 1) nCount = nCount + nStack;
      else nCount++;
    }

    oItem = GetNextItemInInventory(oPC);
  }

  int nTotalLifes = nCount;
  string sValue = "";
  if (nTotalLifes == 0) sValue = "No Lifes Left...Careful";
  else sValue = IntToString(nTotalLifes);
  return sValue;
}

void ORS_ValidateLifes(object oPC)
{
  int nSLives = GetLocalInt(GetModule(),"LIVES");
  object oItem; int nCount = 0; int nStack;

  oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem))
  {
    if(GetTag(oItem) == "SoulRune")
    {
      nStack = GetItemStackSize(oItem);
      if(nStack > 1) nCount = nCount + nStack;
      else nCount++;
    }

    oItem = GetNextItemInInventory(oPC);
  }

  if(nCount > nSLives)
  {
    object oSoulRune = GetItemPossessedBy(oPC,"SoulRune");
    int nStack = GetItemStackSize(oSoulRune);
    if(nStack > 1) SetItemStackSize(oSoulRune,nStack--);
    else DestroyObject(oSoulRune);
  }
}

/******************************************************************************/
//: ALIGNING FUNCTIONS

void AlignEvil(object oPC)
{
  object oMod = GetModule();

  //PvP Mode of Module
  int nPvPMode =  GetLocalInt(oMod,"PVP_MODE");

  //These are the Possible Allegiances for a Player
  object oEvil      = GetObjectByTag("FACTION_001");
  object oGood      = GetObjectByTag("FACTION_002");
  object oNeutral   = GetObjectByTag("FACTION_003");

  //Adjust Reputations
  object oSpecial   = GetObjectByTag("FACTION_1000");
  object oPackAnimal = GetObjectByTag("FACTION_1005");
  object oHorse     = GetObjectByTag("FACTION_1006");
  object oPet       = GetObjectByTag("FACTION_1007");
  AdjustReputation(oPC,oSpecial,50);
  AdjustReputation(oPC,oPackAnimal,50);
  AdjustReputation(oPC,oHorse,50);
  AdjustReputation(oPC,oPet,50);

  if(nPvPMode == 1)
  {
    AdjustReputation(oPC,oGood,-100);
    AdjustReputation(oPC,oEvil,100);
    AdjustReputation(oPC,oNeutral,50);

    SetLocalString(oPC,"OAI_FACTION","AXIS");
  }
  else
  {
    AdjustReputation(oPC,oGood,50);
    AdjustReputation(oPC,oEvil,100);
    AdjustReputation(oPC,oNeutral,50);

    SetLocalString(oPC,"OAI_FACTION","ALLY");
  }
}

void AlignGood(object oPC)
{
  object oMod = GetModule();

  //PvP Mode of Module
  int nPvPMode =  GetLocalInt(oMod,"PVP_MODE");

  //These are the Possible Allegiances for a Player
  object oEvil      = GetObjectByTag("FACTION_001");
  object oGood      = GetObjectByTag("FACTION_002");
  object oNeutral   = GetObjectByTag("FACTION_003");

  //Adjust Reputations
  object oSpecial   = GetObjectByTag("FACTION_1000");
  object oPackAnimal = GetObjectByTag("FACTION_1005");
  object oHorse     = GetObjectByTag("FACTION_1006");
  object oPet       = GetObjectByTag("FACTION_1007");
  AdjustReputation(oPC,oSpecial,50);
  AdjustReputation(oPC,oPackAnimal,50);
  AdjustReputation(oPC,oHorse,50);
  AdjustReputation(oPC,oPet,50);

  if(nPvPMode == 1)
  {
    AdjustReputation(oPC,oGood,100);
    AdjustReputation(oPC,oEvil,-100);
    AdjustReputation(oPC,oNeutral,50);

    SetLocalString(oPC,"OAI_FACTION","ALLY");
  }
  else
  {
    AdjustReputation(oPC,oGood,100);
    AdjustReputation(oPC,oEvil,50);
    AdjustReputation(oPC,oNeutral,50);

    SetLocalString(oPC,"OAI_FACTION","ALLY");
  }
}

void AlignNeutral(object oPC)
{
  object oMod = GetModule();

  //PvP Mode of Module
  int nPvPMode =  GetLocalInt(oMod,"PVP_MODE");

  //Neutrals Allowed
  int nNeutral = GetLocalInt(oMod,"NEUTRAL_ALLOW");

  //These are the Possible Allegiances for a Player
  object oEvil      = GetObjectByTag("FACTION_001");
  object oGood      = GetObjectByTag("FACTION_002");
  object oNeutral   = GetObjectByTag("FACTION_003");

  //Adjust Reputations
  object oSpecial   = GetObjectByTag("FACTION_1000");
  object oPackAnimal = GetObjectByTag("FACTION_1005");
  object oHorse     = GetObjectByTag("FACTION_1006");
  object oPet       = GetObjectByTag("FACTION_1007");
  AdjustReputation(oPC,oSpecial,50);
  AdjustReputation(oPC,oPackAnimal,50);
  AdjustReputation(oPC,oHorse,50);
  AdjustReputation(oPC,oPet,50);

  if(nPvPMode == 1)
  {
    if(nNeutral == 1)
    {
      AdjustReputation(oPC,oGood,50);
      AdjustReputation(oPC,oEvil,50);
      AdjustReputation(oPC,oNeutral,100);

      SetLocalString(oPC,"OAI_FACTION","NEUTRAL");
    }
    else
    {
      AdjustReputation(oPC,oGood,50);
      AdjustReputation(oPC,oEvil,50);
      AdjustReputation(oPC,oNeutral,100);

      SetLocalString(oPC,"OAI_FACTION","ALLY");
    }
  }
  else
  {
    AdjustReputation(oPC,oGood,50);
    AdjustReputation(oPC,oEvil,50);
    AdjustReputation(oPC,oNeutral,100);

    SetLocalString(oPC,"OAI_FACTION","ALLY");
  }
}

//This Resets Reputations With Specified Factions (OAI Faction Reps)
void ResetReputations(object oPC)
{
  //Now Set Alignment
  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
  {
    AlignEvil(oPC);
  }

  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
  {
    AlignGood(oPC);
  }

  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
  {
    AlignNeutral(oPC);
  }
}

/******************************************************************************/
//:: OLANDER'S AREA CLOCKS

void Gong()
{
   PlaySound("as_cv_bell2");
}

void LocalTime(object oClock,int nClicked = 0)
{
    object oMod = GetModule();

    //This is YOUR Module Minutes to Hour Setting
    int nMPH = GetLocalInt(oMod,"MPH");

    //Gong Setting
    int nGONG = GetLocalInt(oMod,"GONG");

    //Determine the Day and Time
    int nMinute     = GetTimeMinute();
    int nHour       = GetTimeHour();
    int nDay        = GetCalendarDay();
    int nMonth      = GetCalendarMonth();
    int nYear       = GetCalendarYear();

    string sMinute;
    string sDay;
    string sDay1 = "Sunday ";
    string sDay2 = "Monday ";
    string sDay3 = "Tuesday ";
    string sDay4 = "Wednesday ";
    string sDay5 = "Thursday ";
    string sDay6 = "Friday ";
    string sDay7 = "Saturday ";

    string sNth;
    string s1st  = "st ";
    string s2nd  = "nd ";
    string s3rd  = "rd ";
    string s4th  = "th ";

    if(nDay == 1) sNth = s1st;
    else if(nDay == 2) sNth = s2nd;
    else if(nDay == 3) sNth = s3rd;
    else sNth = s4th;

    string sMonth;
    string sMonth1  = GetLocalString(oMod,"MONTH1");
    string sMonth2  = GetLocalString(oMod,"MONTH2");
    string sMonth3  = GetLocalString(oMod,"MONTH3");
    string sMonth4  = GetLocalString(oMod,"MONTH4");
    string sMonth5  = GetLocalString(oMod,"MONTH5");
    string sMonth6  = GetLocalString(oMod,"MONTH6");
    string sMonth7  = GetLocalString(oMod,"MONTH7");
    string sMonth8  = GetLocalString(oMod,"MONTH8");
    string sMonth9  = GetLocalString(oMod,"MONTH9");
    string sMonth10 = GetLocalString(oMod,"MONTH10");
    string sMonth11 = GetLocalString(oMod,"MONTH11");
    string sMonth12 = GetLocalString(oMod,"MONTH12");

    string sDayOf = "Day Of ";

    //28 Day Cycle
    switch(nDay)
    {
      case 1: sDay = sDay1; break;
      case 2: sDay = sDay2; break;
      case 3: sDay = sDay3; break;
      case 4: sDay = sDay4; break;
      case 5: sDay = sDay5; break;
      case 6: sDay = sDay6; break;
      case 7: sDay = sDay7; break;
      case 8: sDay = sDay1; break;
      case 9: sDay = sDay2; break;
      case 10: sDay = sDay3; break;
      case 11: sDay = sDay4; break;
      case 12: sDay = sDay5; break;
      case 13: sDay = sDay6; break;
      case 14: sDay = sDay7; break;
      case 15: sDay = sDay1; break;
      case 16: sDay = sDay2; break;
      case 17: sDay = sDay3; break;
      case 18: sDay = sDay4; break;
      case 19: sDay = sDay5; break;
      case 20: sDay = sDay6; break;
      case 21: sDay = sDay7; break;
      case 22: sDay = sDay1; break;
      case 23: sDay = sDay2; break;
      case 24: sDay = sDay3; break;
      case 25: sDay = sDay4; break;
      case 26: sDay = sDay5; break;
      case 27: sDay = sDay6; break;
      case 28: sDay = sDay7; break;
    }

    //12 Month Cycle
    switch(nMonth)
    {
      case 1: sMonth = sMonth1; break;
      case 2: sMonth = sMonth2; break;
      case 3: sMonth = sMonth3; break;
      case 4: sMonth = sMonth4; break;
      case 5: sMonth = sMonth5; break;
      case 6: sMonth = sMonth6; break;
      case 7: sMonth = sMonth7; break;
      case 8: sMonth = sMonth8; break;
      case 9: sMonth = sMonth9; break;
      case 10: sMonth = sMonth10; break;
      case 11: sMonth = sMonth11; break;
      case 12: sMonth = sMonth12; break;
    }

    //Make Complete String
    string sComplete = sDay +"the "+ IntToString(nDay) + sNth + sDayOf + sMonth + "of Year " +IntToString(nYear);

    //If 2 Minutes per Hour only show Top and Bottom of Hours
    if(nMPH == 2)
    {
      //Set Top half of the hour
      if(nMinute == 0)
      {
        nMinute = 0;
        sMinute = IntToString(nMinute) + "0";

        //Gongs are ON
        if(nGONG == 1)
        {
          //Play 2 Gongs at the top of the hour
          Gong();
          DelayCommand(3.0,Gong());
        }
      }

      //Set Bottom half of the hour
      else if(nMinute == 1)
      {
        nMinute = 30;
        sMinute = IntToString(nMinute);

        //Gongs are ON
        if(nGONG == 1) Gong();
      }
    }

    //If More than 2 Minutes
    if(nMPH >= 4)
    {
      //Now we convert Minute Values to Proper Minutes
      int nMinCalc  = 60/nMPH;
      int nMConv    = nMinute * nMinCalc;//To Show the Minutes Properly
      int nTop      = 0;
      int nBottom   = 30;

      nMinute = nMConv;

      //Set Top of the Hour and Play 2 Gongs
      if(nMinute == 0)
      {
        nMinute = 0;
        sMinute = IntToString(nMinute) + "0";

        //Gongs are ON
        if(nGONG == 1)
        {
          //Play 2 Gongs at the top of the hour
          Gong();
          DelayCommand(3.0,Gong());
        }
      }

      //Set all other Minutes
      if(nMinute >= 1)
      {
        if(nMinute < 10)
        {
          sMinute = "0" +IntToString(nMinute);
        }
        else
        {
          sMinute = IntToString(nMinute);
        }
      }
      //Play 1 Gong at Bottom of Hour
      if(nMinute >= nBottom - 5 && nMinute <= nBottom + 5)
      {
        //Gongs are ON
        if(nGONG == 1) Gong();
      }
    }

    //Set AM or PM from 24 Hour Clock
    if (nHour == 0 && nClicked == 1)
    {
      nHour = 12;
      SpeakString(IntToString(nHour)+ ":" +(sMinute)+ " AM  " +sComplete);
    }
    if (nHour >= 1 && nHour <= 11 && nClicked == 1)
    {
      SpeakString(IntToString(nHour)+":"+(sMinute)+" AM  " +sComplete);
    }
    if (nHour == 12 && nClicked == 1)
    {
      nHour = 12;
      SpeakString(IntToString(nHour)+":"+(sMinute)+" PM  " +sComplete);
    }
    if (nHour > 12 && nHour <= 23 && nClicked == 1)
    {
      nHour = nHour - 12;
      SpeakString(IntToString(nHour)+":"+(sMinute)+" PM  " +sComplete);
    }
}

/******************************************************************************/
//::SPELL TRACKING

int AVGetIsSpellCaster(object oPC)
{
    int nCount, nClass;
    for(nCount=1; nCount<=3; nCount++)
    {
        nClass = GetClassByPosition(nCount, oPC);
        //Paladins and Rangers don't have spells at low level, but it's not
        //really worth the effort adding the extra level check
        switch(nClass) {
            case CLASS_TYPE_BARD:
            case CLASS_TYPE_CLERIC:
            case CLASS_TYPE_DRUID:
            case CLASS_TYPE_PALADIN:
            case CLASS_TYPE_RANGER:
            case CLASS_TYPE_SORCERER:
            case CLASS_TYPE_WIZARD: return TRUE;
        }
    }
    return FALSE;
}
string AVRemoveStringToken(string sString, string sSep="|")
{
    int nPos=FindSubString(sString, sSep);
    if (nPos<0) return "";
    int nStrLen=GetStringLength(sString);
    nStrLen -= nPos + 1;
    return GetStringRight(sString, nStrLen);
}
string AVAddStringToken(string sString, string sTag, string sValue, string sSpacer="#", string sSep="|")
{
    if (sString=="") return sTag + sSpacer + sValue;
    return sString + sSep + sTag + sSpacer + sValue;
}
string AVGetStringToken(string sString, string sSep="|")
{
    int nPos = FindSubString(sString, sSep);
    if(nPos < 0) return sString;
    return GetStringLeft(sString, nPos);
}
int AVGetTokenIntTag(string sToken, string sSpacer="#")
{
    int nPos = FindSubString(sToken, sSpacer);
    return StringToInt(GetStringLeft(sToken, nPos));
}
int AVGetTokenIntValue(string sToken, string sSpacer="#")
{
    int nPos = FindSubString(sToken, sSpacer)+1;
    int nLength = GetStringLength(sToken);
    return StringToInt(GetSubString(sToken, nPos, nLength-nPos));
}

void AVRestoreSpells(object oPC)
{
    string sID = GetLocalString(oPC, "PCU");
    string sSpells = GetLocalString(GetModule(), "AVSS"+sID);
    int nSpell, nQty, nKnown;
    string sSpell;
    //break off if nothing is recorded (all spells restored on server reload)
    if (sSpells == "") return;
    //First remove all spells not recorded (prevents an exploit where a player
    //can change spells before exiting to have a full compliment on return).
    for(nSpell=0; nSpell<550; nSpell++)
    {
        nKnown = GetHasSpell(nSpell, oPC);
        if(nKnown)
        {
            if(FindSubString(sSpells, IntToString(nSpell)+"#") == -1)
            {
                while(nKnown > 0)
                {
                    DecrementRemainingSpellUses(oPC, nSpell);
                    nKnown--;
                }
            }
        }
    }
    //Then decrement recorded spells to proper levels
    while(sSpells != "")
    {
        sSpell = AVGetStringToken(sSpells);
        nSpell = AVGetTokenIntTag(sSpell);
        nQty = AVGetTokenIntValue(sSpell);
        nKnown = GetHasSpell(nSpell, oPC);
        while(nKnown > nQty)
        {
            DecrementRemainingSpellUses(oPC, nSpell);
            nKnown--;
        }
        sSpells = AVRemoveStringToken(sSpells);
    }
    DeleteLocalString(GetModule(), "AVSS"+sID);
}

void AVSaveSpells(object oPC)
{
    object oMod = GetModule();
    string sID = GetLocalString(oPC, "PCU");
    string sSpells;
    int nSpell;
    int nQty;
    //Loop through spells (epic spells and spell-like abilities don't register
    //and are tracked automatically, so stop at 549 (SPELL_GLYPH_OF_WARDING)
    for (nSpell=0; nSpell<550; nSpell++)
    {
        nQty=GetHasSpell(nSpell, oPC);
        if(nQty > 0)
        {
            sSpells = AVAddStringToken(sSpells, IntToString(nSpell), IntToString(nQty));
        }
    }
    SetLocalString(oMod, "AVSS"+sID, sSpells);
}

void TimeStopDelay(object oCaster)
{
    int nDelay = GetLocalInt(GetModule(),"TIMESTOP_DEL");
    float fDelay = IntToFloat(nDelay);
    float Delay1 = fDelay * 0.25;
    string Message1 = IntToString(FloatToInt(Delay1));
    float Delay2 = fDelay * 0.50;
    string Message2 = IntToString(FloatToInt(Delay2));
    float Delay3 = fDelay * 0.75;
    string Message3 = IntToString(FloatToInt(Delay3));
    SetLocalInt(oCaster, "TIMESTOP_DELAY", 1);
    FloatingTextStringOnCreature("Time Stop Recastable In " + IntToString(nDelay) + " seconds", oCaster, FALSE);
    DelayCommand(Delay1, FloatingTextStringOnCreature("Time Stop Recastable In " + Message3 + " seconds", oCaster, FALSE));
    DelayCommand(Delay2, FloatingTextStringOnCreature("Time Stop Recastable In " + Message2 + " seconds", oCaster, FALSE));
    DelayCommand(Delay3, FloatingTextStringOnCreature("Time Stop Recastable In " + Message1 + " seconds", oCaster, FALSE));
    DelayCommand(fDelay, FloatingTextStringOnCreature("Time Stop Ready", oCaster, FALSE));
    DelayCommand(fDelay, DeleteLocalInt(oCaster, "TIMESTOP_DELAY"));
}

void GSStopDelay(object oCaster)
{
    int nDelay = GetLocalInt(GetModule(),"GSANCTUARY_DEL");//In Rounds
    float fDelay = IntToFloat(nDelay);
    float Delay1 = fDelay * 0.25;
    string Message1 = IntToString(FloatToInt(Delay1));
    float Delay2 = fDelay * 0.50;
    string Message2 = IntToString(FloatToInt(Delay2));
    float Delay3 = fDelay * 0.75;
    string Message3 = IntToString(FloatToInt(Delay3));
    SetLocalInt(oCaster, "GSANCTUARY_DELAY", 1);
    SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + IntToString(nDelay) + " seconds");
    DelayCommand(Delay1, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message3 + " seconds"));
    DelayCommand(Delay2, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message2 + " seconds"));
    DelayCommand(Delay3, SendMessageToPC(oCaster,"Greater Sanctuary Recastable In " + Message1 + " seconds"));
    DelayCommand(fDelay, SendMessageToPC(oCaster,"Greater Sanctuary Ready"));
    DelayCommand(fDelay, DeleteLocalInt(oCaster, "GSANCTUARY_DELAY"));
}

//::SPELL TRACKING
/******************************************************************************/

/******************************************************************************/
//::PLAYER TRAINERS & LEVEL CONTROL

int ORS_GetHasClass(object oCreature, int nClassType)
{
    int nClassType1 = GetClassByPosition(1,oCreature);
    int nClassType2 = GetClassByPosition(2,oCreature);
    int nClassType3 = GetClassByPosition(3,oCreature);

    if(nClassType1 > 1) return TRUE;
    if(nClassType2 > 1) return TRUE;
    if(nClassType3 > 1) return TRUE;

    return FALSE;
}

int ORS_GetIsPrestigeClass(int nClassType)
{
    switch(nClassType)
    {
      case CLASS_TYPE_ARCANE_ARCHER: return TRUE;
      case CLASS_TYPE_ASSASSIN: return TRUE;
      case CLASS_TYPE_BLACKGUARD: return TRUE;
      case CLASS_TYPE_DIVINECHAMPION: return TRUE;
      case CLASS_TYPE_DRAGONDISCIPLE: return TRUE;
      case CLASS_TYPE_DWARVENDEFENDER: return TRUE;
      case CLASS_TYPE_EYE_OF_GRUUMSH: return TRUE;
      case CLASS_TYPE_HARPER: return TRUE;
      case CLASS_TYPE_PALEMASTER: return TRUE;
      case CLASS_TYPE_PURPLE_DRAGON_KNIGHT: return TRUE;
      case CLASS_TYPE_SHADOWDANCER: return TRUE;
      case CLASS_TYPE_SHIFTER: return TRUE;
      case CLASS_TYPE_SHOU_DISCIPLE: return TRUE;
      case CLASS_TYPE_WEAPON_MASTER: return TRUE;
    }

    return FALSE;
}

//::PLAYER TRAINERS & LEVEL CONTROL
/******************************************************************************/

int IsEnemyInRange(object oPC, float fRange)
{
  return FALSE;

  object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oPC,1,CREATURE_TYPE_IS_ALIVE,TRUE,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
  float fDist = GetDistanceBetween(oPC, oEnemy);

  if(fDist <= fRange) return TRUE;
  return FALSE;

}

int GetRestrictedInventorySlot(object oItem)
{
    int nType = GetBaseItemType(oItem);

    int nRet = -1;
    switch (nType)
    {
        case BASE_ITEM_AMULET:      nRet = INVENTORY_SLOT_NECK;  break;
        case BASE_ITEM_BELT:        nRet = INVENTORY_SLOT_BELT;  break;
        case BASE_ITEM_BOOTS:       nRet = INVENTORY_SLOT_BOOTS; break;
        case BASE_ITEM_CLOAK:       nRet = INVENTORY_SLOT_CLOAK; break;
        case BASE_ITEM_BRACER:
        case BASE_ITEM_GLOVES:      nRet = INVENTORY_SLOT_ARMS;  break;
        case BASE_ITEM_HELMET:      nRet = INVENTORY_SLOT_HEAD;  break;
        case BASE_ITEM_LARGESHIELD:
        case BASE_ITEM_SMALLSHIELD:
        case BASE_ITEM_TOWERSHIELD: nRet = INVENTORY_SLOT_LEFTHAND; break;
    }
    return nRet;
}
/*
int GetWasWeaponUnequippedInMelee(object oPC, object oItem)
{
  if(IsMeleeWeapon(oItem) || IsRangedWeapon(oItem))
  {
    if(GetIsInCombat(oPC))
    {
      if(IsEnemyInRange(oPC, 5.0)) return TRUE;
      else return FALSE;
    }
    else return FALSE;
  }

  return FALSE;
}

int GetIsOkayToUnequip(object oPC, object oItem)
{
  int nSlot = GetRestrictedInventorySlot(oItem);

  //SE Stop Swap v1.3 Fix
  // is the slot locked?
  // NOTE: if we are trying to unequip something from a locked slot then it
  // is the system doing the unequipping
  if(GetLocalInt(oPC, "ORS_UNEQUIPPED_" + IntToString(nSlot))) return TRUE;

  if(GetIsInCombat(oPC))
  {
    if(IsEnemyInRange(oPC, 5.0)) return TRUE;
    else return FALSE;
  }

  return TRUE;
}

 */
void StepBackwards(object oPC)
{
  float fDir = GetFacing(oPC);
  float fAngleOpposite = GetOppositeDirection(fDir);
  location lLoc = GenerateNewLocation(oPC,DISTANCE_SHORT,fAngleOpposite,fDir);

  AssignCommand(oPC, ClearAllActions());
  AssignCommand(oPC, ActionMoveToLocation(lLoc, TRUE));
}

void JumpAssociates(object oPC)
{
  location lLoc = GetLocation(oPC);
  int nNth = 1;
  object oHench = GetHenchman(oPC, nNth);

  object oFam = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
  if(GetIsObjectValid(oFam))
  {
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oFam))
    {
     AssignCommand(oFam, JumpToLocation(lLoc));
    }
  }

  object oAni = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
  if(GetIsObjectValid(oAni))
  {
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oAni))
    {
     AssignCommand(oAni, JumpToLocation(lLoc));
    }
  }

  object oSum = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
  if(GetIsObjectValid(oSum))
  {
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oSum))
    {
     AssignCommand(oSum, JumpToLocation(lLoc));
    }
  }

  object oDom = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
  if(GetIsObjectValid(oDom))
  {
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oDom))
    {
     AssignCommand(oDom, JumpToLocation(lLoc));
    }
  }

  while(oHench != OBJECT_INVALID)
  {
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oHench))
    {
      AssignCommand(oHench, JumpToLocation(lLoc));

      object oFam = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oHench);
      if(GetIsObjectValid(oFam)) AssignCommand(oFam, JumpToLocation(lLoc));

      object oAni = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oHench);
      if(GetIsObjectValid(oAni)) AssignCommand(oAni, JumpToLocation(lLoc));

      object oSum = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oHench);
      if(GetIsObjectValid(oSum)) AssignCommand(oSum, JumpToLocation(lLoc));

      object oDom = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
      if(GetIsObjectValid(oDom)) AssignCommand(oDom, JumpToLocation(lLoc));

    }
    oHench = GetHenchman(oPC, nNth++);
  }
}

/******************************************************************************/
//:: OLANDER'S REALISTIC BANDAGES

int DCHeal(object oTarget)
{
    //This Sets up how difficult the wounds are to heal -> i.e. Under 15% you have been cut to ribbons and tougher to
    //Heal with Bandages......This helps keep a Cleric around for Spell Healing.
    //NOTE: The more skill points in Healing result in better Healing Skill.....Duh =)
    int nCurHP = GetCurrentHitPoints(oTarget);
    int nMaxHP = GetMaxHitPoints(oTarget);
    int nDC = 5; //Initial DC as a %
    int nPerc = (nCurHP * 100) / nMaxHP;
    if (nPerc < 75) nDC = 10; //if percentage of health is less than 75%
    if (nPerc < 50) nDC = 15; //if percentage of health is less than 50%
    if (nPerc < 35) nDC = 20; //if percentage of health is less than 35%
    if (nPerc < 15) nDC = 30; //if percentage of health is less than 15%
    return nDC;
}

/******************************************************************************/
//::TRAPS

void ORS_CreateFieldEffect(location lLoc)
{
    //Create a Scorchmark
    object oScorch = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_weathmark",lLoc);
    DelayCommand(60.0,DestroyObject(oScorch));

    //Create a Dust Plume
    object oPlume = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_dustplume",lLoc);
    DelayCommand(20.0,DestroyObject(oPlume));

    //Create a Small Flame
    object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamemedium",lLoc);
    DelayCommand(15.0,DestroyObject(oFlame));
}

//void main(){}
