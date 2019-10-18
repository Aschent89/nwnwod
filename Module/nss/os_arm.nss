////////////////////////////////////////////////////////////////////////////////
//
//  Siege Arbalest Heavy - Initiates Load Sequence
//  os_arm
//  by Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "os_inc"

void main()
{
  object oSiege = OBJECT_SELF;
  string sSiege = GetName(oSiege);

  string sSiegeFaction = GetLocalString(oSiege,"OAI_FACTION");
  int nLoaded = GetLocalInt(oSiege,"LOADED");
  location lLoc = GetLocation(oSiege);

/*******************************************************************************/
//: CONTROL SWITCH

  //Find closest related Switch
  object oSwitch = OS_GetNearestSwitch(oSiege);
  if(!GetIsObjectValid(oSwitch)) return;

  string sFaction;
  object oTarget;
  object oAcquire;
  string sTarget;

  //Check for Active Fire Mode
  int nFMode = GetLocalInt(oSwitch,"FIREMODE");
  if(nFMode < 1)
  {
    AssignCommand(oSiege,SpeakString(sSiege + " standing down!"));
    SetLocalInt(oSiege,"LOADED",0);
    SetLocalInt(oSiege,"ACQUIRED",0);
    return;
  }

/*******************************************************************************/
//: AMMUNITION

  //Find Valid Ammo
  object oAmmo = OS_GetNearestAmmo(oSiege);
  if(GetIsObjectValid(oAmmo) && nLoaded == 0)
  {
    float fDist = GetDistanceToObject(oAmmo);
    if(fDist <= SIEGE_SUPPLY)
    {
      //Check for Available
      int nQty = GetLocalInt(oAmmo,"AMMOQTY");
      if(nQty > 0)
      {
        nQty--;
        SetLocalInt(oAmmo,"AMMOQTY",nQty);
        SetLocalInt(oSiege,"LOADED",1);
        SetLocalInt(oSiege,"ACQUIRED",0);
      }
      else
      {
        //Destroy Existing and Find Another
        DestroyObject(oAmmo,0.1);
        DelayCommand(1.0,ExecuteScript("os_arm",oSiege));
      }
    }
  }
  else
  {
    DelayCommand(1.0,SpeakString(sSiege + " standing down....no ammunition available!"));
    SetLocalInt(oSiege,"LOADED",0);
    SetLocalInt(oSiege,"ACQUIRED",0);
    return;
  }

/*******************************************************************************/
//: SIEGE ARMING

  //Now the ammunition is properly loaded and the firing sequence takes place
  if(GetLocalInt(oSiege,"LOADED") == 1)
  {
    //Check for Siege Weapons
    if(GetLocalInt(oSiege,"ACQUIRED") == 0)
    {
      oAcquire = OS_GetTargetSiege(oSiege);
    }

    //Look for Creatures
    if(GetLocalInt(oSiege,"ACQUIRED") == 0)
    {
      oAcquire = OS_GetTargetCreature(oSiege);
    }

    //Look for Doors
    if(GetLocalInt(oSiege,"ACQUIRED") == 0)
    {
      oAcquire = OS_GetTargetDoor(oSiege);
    }
  }

/*******************************************************************************/
//: SIEGE FIRING

  if(GetLocalInt(oSiege,"LOADED") == 1)
  {
    //Now we either stand down or range and face the target
    if(GetLocalInt(oSiege,"ACQUIRED") == 0)
    {
      AssignCommand(oSiege,DelayCommand(1.0,SpeakString(sSiege + " standing down....no valid targets!")));
      SetLocalInt(oSiege,"LOADED",0);
      return;
    }
    else
    {
      sTarget = GetName(oAcquire);
      float fDTarget = GetDistanceToObject(oAcquire);
      SetLocalFloat(oSiege,"RANGE",fDTarget);
      SetLocalObject(oSiege,"OS_ACQUIRED",oAcquire);

      AssignCommand(oSiege,OS_SetFacingObject(oAcquire));
    }

    //Get Range in Integer Format
    int nDTarget = FloatToInt(GetLocalFloat(oSiege,"RANGE"));

    //Get Load and Fire Time of Siege
    float fSec = OS_GetLoadTime(oSiege);

    //Now we start the Firing Process
    if(GetLocalInt(oSiege,"LOADED") == 1)
    {
      AssignCommand(oSiege,DelayCommand(1.0,SpeakString(sSiege + " has acquired "+ sTarget +" as a Target!")));
      AssignCommand(oSiege,DelayCommand(3.0,SpeakString("Range: "+ IntToString(nDTarget) +" Meters")));
      AssignCommand(oSiege,DelayCommand(5.0,SpeakString("Ammunition Received!")));

      //Loading Sounds
      string sTag = GetTag(oSiege);
      if(sTag == SIEGECANNON)
      {
        AssignCommand(oSiege,DelayCommand(fSec - 10.0,PlaySound("cb_pa_metalblunt")));
        AssignCommand(oSiege,DelayCommand(fSec -  8.5,PlaySound("cb_pa_other")));
        AssignCommand(oSiege,DelayCommand(fSec -  8.0,PlaySound("cb_pa_other")));
        AssignCommand(oSiege,DelayCommand(fSec -  7.5,PlaySound("cb_pa_other")));
      }
      else
      {
        AssignCommand(oSiege,DelayCommand(fSec - 10.0,PlaySound("as_cv_ropepully1")));
        AssignCommand(oSiege,DelayCommand(fSec - 8.0,PlaySound("as_cv_ropecreak2")));
      }

      AssignCommand(oSiege,DelayCommand(fSec - 6.0,SpeakString("Loaded!")));
      AssignCommand(oSiege,DelayCommand(fSec - 3.0,SpeakString("Ready!")));
      AssignCommand(oSiege,DelayCommand(fSec - 0.5,SpeakString("FIRE!")));
      AssignCommand(oSiege,DelayCommand(fSec, OS_SiegeFire(oSiege,oAcquire)));
      AssignCommand(oSiege,DelayCommand(fSec + 10.0,ExecuteScript("os_arm",oSiege)));
    }
  }
}
