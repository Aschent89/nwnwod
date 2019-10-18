////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Siege System
//  os_mod_onact
//  by Don Anderson
//  dandersonru@msn.com
//
//  Place this in the Module Event - wrap_mod_onact
//
//  This Throws the Throwing Grenades at a Target.
//
//  Skill Discipline or Concentration (Whichever is higher)
//  DC40 is 100% Accuracy
//
////////////////////////////////////////////////////////////////////////////////

#include "os_inc"

void main()
{
    object oPC        = GetItemActivator();
    object oItem      = GetItemActivated();
    string sItem      = GetTag(oItem);
    string sResItem   = GetResRef(oItem);
    object oMod       = GetModule();
    object oArea      = GetArea(oPC);
    object oTarget    = GetItemActivatedTarget();
    location lTarget  = GetItemActivatedTargetLocation();
    string sLeft = GetStringLeft(sItem,7);

    int nTest = FALSE;
    if(sItem == "ITGrenadeFire") nTest = TRUE;
    if(sItem == "ITGrenadeAcid") nTest = TRUE;
    if(sItem == "ITGrenadeElectric") nTest = TRUE;
    if(sItem == "ITGrenadeShard") nTest = TRUE;
    if(sItem == "ITPistol") nTest = TRUE;
    if(sItem == "ITSiegeSwitch") nTest = TRUE;
    if(sItem == "ITSiegeKeg") nTest = TRUE;
    if(sItem == "ITSiegeStone") nTest = TRUE;
    if(sItem == "ITSiegeBarricade") nTest = TRUE;
    if(sItem == "ITSiegeArbalestLgt") nTest = TRUE;
    if(sItem == "ITSiegeArbalestHvy") nTest = TRUE;
    if(sItem == "ITSiegeBricole") nTest = TRUE;
    if(sItem == "ITSiegeCatapultLgt") nTest = TRUE;
    if(sItem == "ITSiegeCatapultHvy") nTest = TRUE;
    if(sItem == "ITSiegeCouillard") nTest = TRUE;
    if(sItem == "ITSiegeOnager") nTest = TRUE;
    if(sItem == "ITSiegePerriere") nTest = TRUE;
    if(sItem == "ITCatapultAcid") nTest = TRUE;
    if(sItem == "ITCatapultFire") nTest = TRUE;
    if(sItem == "ITCatapultElectric") nTest = TRUE;
    if(sItem == "ITOnagerCaltrops") nTest = TRUE;
    if(sItem == "ITOnagerOil") nTest = TRUE;
    if(sItem == "ITArbalestSpear") nTest = TRUE;
    if(sItem == "ITSiegeCannon") nTest = TRUE;
    if(sItem == "ITCannonBall") nTest = TRUE;

    //Not A Siege Item
    if(nTest == FALSE) return;

    if(oTarget == oPC)
    {
      SendMessageToPC(oPC,"You Cannot Target Yourself....Lesson Learned?");
      return;
    }

    location lOrigin = OS_Location(oPC,1.5,0.1);
    object oOrigin = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lOrigin);
    SetLocalObject(oPC,"OS_CURRENT_ORIGIN",oOrigin);
    DestroyObject(oOrigin,3.0);

    if(oTarget == OBJECT_INVALID)
    {
      object oTemp = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget);
      oTarget = oTemp;
      DestroyObject(oTemp,3.0);
    }

    //Players Faction and Rank
    string sPCFaction = GetLocalString(oPC,"OAI_FACTION");
    int nPCRank = 40;

    object oSiege;
    object oNew;

    //Nothing can happen if the Player in in a conversation
    int nConv = IsInConversation(oPC);
    if(nConv == TRUE)return;

/******************************************************************************/
//:: THROWN GRENADES AND PISTOL

    //Fire Grenades
    if(sItem == "ITGrenadeFire")
    {
      OS_FireGrenade(oPC, oTarget);
      DestroyObject(oItem);
      return;
    }

    //Acid Grenades
    if(sItem == "ITGrenadeAcid")
    {
      OS_AcidGrenade(oPC, oTarget);
      DestroyObject(oItem);
      return;
    }

    //Electric Grenades
    if(sItem == "ITGrenadeElectric")
    {
      OS_ElectricGrenade(oPC, oTarget);
      DestroyObject(oItem);
      return;
    }

    //Caltrops Grenades
    if(sItem == "ITGrenadeShard")
    {
      OS_CaltropGrenade(oPC, oTarget);
      DestroyObject(oItem);
      return;
    }

    //Rifle
    if(sItem == "ITPistol")
    {
      /*
      if(GetLocalInt(oPC,"OS_PISTOL_LOAD") > 0)
      {
        SendMessageToPC(oPC,"Your Pistol is Not Loaded Yet!");
        return;
      }
      */
      OS_PistolShot(oPC, oTarget);
      //SetLocalInt(oPC,"OS_PISTOL_LOAD",1);
      //DelayCommand(10.0,SetLocalInt(oPC,"OS_PISTOL_LOAD",0));
      //DelayCommand(10.0,SendMessageToPC(oPC,"Your Pistol is Loaded and Ready to Fire!"));
      return;
    }



//:: THROWN GRENADES
/******************************************************************************/

  /******************************************************************************/
//::SIEGE CONTROL SWITCH

    if(sItem == "ITSiegeSwitch" && nPCRank >= 4)
    {
      DestroyObject(oItem);
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegeswitch",lTarget);
      OS_SetGroundingFacing(oSiege,oPC);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

//::SIEGE CONTROL SWITCH
/******************************************************************************/

/******************************************************************************/
//::SIEGE KEG

    //The Siege Keg in inventory that is dropped on the ground is converted to the Useable Siege Keg
    if(sItem == "ITSiegeKeg" && nPCRank >= 2)
    {
      DestroyObject(oItem);
      CreateObject(OBJECT_TYPE_PLACEABLE,"siegekeg",lTarget);
      return;
    }

//::SIEGE KEG
/******************************************************************************/

/******************************************************************************/
//::SIEGE WEAPONS


    if(sLeft == "ITSiege" && sLeft != "ITSiegeStone" && nPCRank >= 4)
    {
      DestroyObject(oItem);

      //Siege Weapons must be used above ground and in Natural Settings
      if(!GetIsAreaAboveGround(oArea))
      {
        CreateItemOnObject(sResItem,oPC);
        return;
      }
      if(!GetIsAreaNatural(oArea))
      {
        CreateItemOnObject(sResItem,oPC);
        return;
      }

      oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 3.0, lTarget, TRUE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
      while(GetIsObjectValid(oTarget))
      {
        if(GetResRef(oTarget) != "plc_invisobj")
        {
          AssignCommand(oPC,ClearAllActions());
          SendMessageToPC(oPC,"You will need 3 meters of clear space to place Siege Weapons.");
          CreateItemOnObject(sResItem,oPC);
          return;
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 3.0, lTarget, TRUE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
      }

      //Siege Barricade
      if(sItem == "ITSiegeBarricade")
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegebarricade",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Arbalest - Light
      if(sItem == "ITSiegeArbalestLgt" && nPCRank >= 4)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegearbalestlgt",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Arbalest - Heavy
      if(sItem == "ITSiegeArbalestHvy" && nPCRank >= 6)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegearbalesthvy",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Bricole
      if(sItem == "ITSiegeBricole" && nPCRank >= 4)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegebricole",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Cannon
      if(sItem == "ITSiegeCannon" && nPCRank >= 4)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegecannon",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Catapult - Light
      if(sItem == "ITSiegeCatapultLgt" && nPCRank >= 4)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegecatapultlgt",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Catapult - Heavy
      if(sItem == "ITSiegeCatapultHvy" && nPCRank >= 6)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegecatapulthvy",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Couillard (Classed as Heavy Siege)
      if(sItem == "ITSiegeCouillard" && nPCRank >= 6)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegecouillard",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Onager (Classed as Light Siege)
      if(sItem == "ITSiegeOnager" && nPCRank >= 4)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegeonager",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }

      //Siege Perriere (Classed as Heavy Siege)
      if(sItem == "ITSiegePerriere" && nPCRank >= 6)
      {
        oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegeperriere",lTarget);
        OS_SetGroundingFacing(oSiege,oPC);
        SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
        SetLocalObject(oSiege,"OS_OWNER",oPC);
        return;
      }
    }

//::SIEGE WEAPONS
/******************************************************************************/

/******************************************************************************/
//::SIEGE SUPPLIES

    DestroyObject(oItem);

    //Acid Grenades Supply Barrel
    if(sItem == "ITCatapultAcid")
    {
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"acidgrenades",lTarget);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

    //Fire Grenades Supply Barrel
    if(sItem == "ITCatapultFire")
    {
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"firegrenades",lTarget);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

    //Fire Grenades Supply Barrel
    if(sItem == "ITCatapultElectric")
    {
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"elecgrenades",lTarget);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

    //Caltrops Grenades Supply Barrel
    if(sItem == "ITOnagerCaltrops")
    {
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"caltropsgrenades",lTarget);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

    //Oil Grenades Supply Barrel
    if(sItem == "ITOnagerOil")
    {
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"oilgrenades",lTarget);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

    //Siege Stones Supply
    if(sItem == "ITSiegeStone")
    {
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"siegestones",lTarget);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

    //Arbalest Spears Supply Rack
    if(sItem == "ITArbalestSpear")
    {
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"arbalestspears",lTarget);
      OS_SetGroundingFacing(oSiege,oPC);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

    //Cannnon Balls Supply
    if(sItem == "ITCannonBall")
    {
      oSiege = CreateObject(OBJECT_TYPE_PLACEABLE,"cannonballs",lTarget);
      SetLocalString(oSiege,"OAI_FACTION",sPCFaction);
      SetLocalObject(oSiege,"OS_OWNER",oPC);
      return;
    }

//::SIEGE SUPPLIES
/******************************************************************************/

}
