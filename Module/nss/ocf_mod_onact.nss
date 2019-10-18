////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_mod_onact
//  by Don Anderson
//  dandersonru@msn.com
//
//  Place on the Module On Activate Item Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC          = GetItemActivator();
    string sPCU         = GetLocalString(oPC,"PCU");
    object oItem        = GetItemActivated();
    string sTag         = GetTag(oItem);
    string sResRef      = GetResRef(oItem);
    object oTarget      = GetItemActivatedTarget();
    location lTarget    = GetItemActivatedTargetLocation();
    int iHP             = GetMaxHitPoints(oPC) - GetCurrentHitPoints(oPC);

    int nTent = FALSE;
    if(sTag == "Tent") nTent = TRUE;
    if(sTag == "TentBW") nTent = TRUE;
    if(sTag == "TentRW") nTent = TRUE;
    if(sTag == "TentGW") nTent = TRUE;
    if(sTag == "TentYW") nTent = TRUE;

    //If not Camping Stuff Cancel
    if(sTag != "DryWood" && nTent == FALSE && sTag != "Bedroll") return;

    //Not a Natural Area
    if(GetIsAreaNatural(GetArea(oPC)) == FALSE)
    {
      SendMessageToPC(oPC, "You can not set up a Campfire Here.");
      return;
    }

    //Campfire Stuff
    object oCampfire = GetNearestObjectByTag("Campfire",oPC,1);
    object oCookSpit = GetNearestObjectByTag("CookSpit",oPC,1);
    object oCookPot = GetNearestObjectByTag("CookPot",oPC,1);
    object oFire = OBJECT_INVALID;
    if(GetIsObjectValid(oCampfire)) oFire = oCampfire;
    if(GetIsObjectValid(oCookSpit)) oFire = oCookSpit;
    if(GetIsObjectValid(oCookPot)) oFire = oCookPot;

    //No Fire....Cancel
    if(sTag != "DryWood" && GetIsObjectValid(oFire) == FALSE)
    {
      SendMessageToPC(oPC, "No Fire is near to set up your Camping Gear.");
      return;
    }

    //Campfire is less than 6M From Player
    if(GetDistanceBetween(oPC,oFire) < 6.0)
    {
      if(GetDistanceToObject(oFire) > 3.0)
      {
        SendMessageToPC(oPC, "You need to be closer to a Campfire to lay down your camping gear.");
        return;
      }

      //Target Location is farther than 4M From Campfire
      location lFire = GetLocation(oFire);
      if(GetDistanceBetweenLocations(lTarget,lFire) > 5.0)
      {
        SendMessageToPC(oPC, "You need to set your camping gear closer to Camp.");
        return;
      }
    }

/******************************************************************************/
//: BEDROLLS

    object oBedroll = GetNearestObjectByTag("Bedroll",oPC,1);
    if(sTag == "Bedroll" && GetDistanceToObject(oFire) <= 3.0)
    {
      if(GetIsObjectValid(oBedroll) == TRUE && GetDistanceToObject(oBedroll) >= 3.0)
      {
        //Create New Bedroll
        object oNewBedroll = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lTarget, FALSE);
        SetLocalString(oNewBedroll,"PCU",sPCU);
        SetLocalString(oNewBedroll,"RESREF",sResRef);
        DestroyObject(oItem);
        return;
      }

      if(GetIsObjectValid(oBedroll) == FALSE)
      {
        //Create New Bedroll
        object oNewBedroll = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lTarget, FALSE);
        SetLocalString(oNewBedroll,"PCU",sPCU);
        SetLocalString(oNewBedroll,"RESREF",sResRef);
        DestroyObject(oItem);
        return;
      }
    }

//: BEDROLLS
/******************************************************************************/

/******************************************************************************/
//: TENTS

    //Campfire is nearer than 3M (For Tents Here)
    object oTent = GetNearestObjectByTag("Tent",oPC,1);
    if(nTent == TRUE && GetDistanceToObject(oFire) <= 3.0)
    {
      if(GetIsObjectValid(oTent) == TRUE && GetDistanceToObject(oTent) >= 4.0)
      {
        //Create New Tent
        SetLocalInt(oPC,"CAMPING",1);
        object oNewTent = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lTarget, FALSE, "Tent");
        SetLocalString(oNewTent,"PCU",sPCU);
        SetLocalString(oNewTent,"RESREF",sResRef);
        DestroyObject(oItem);
        return;
      }

      if(GetIsObjectValid(oTent) == FALSE)
      {
        //Create New Tent
        SetLocalInt(oPC,"CAMPING",1);
        object oNewTent = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lTarget, FALSE, "Tent");
        SetLocalString(oNewTent,"PCU",sPCU);
        SetLocalString(oNewTent,"RESREF",sResRef);
        DestroyObject(oItem);
        return;
      }
    }

//: TENTS
/******************************************************************************/

/******************************************************************************/
//: DRY WOOD

    //Feeding the Fire
    if(GetIsObjectValid(oTarget) == TRUE)
    {
      if(sTag == "DryWood" && oTarget == oFire)
      {
        SetLocalInt(oFire,"LIFECYCLE",10);
        DestroyObject(oItem);
        return;
      }
    }

    //Checks to see if 1 of 3 torches are in the left hand
    //to ignite the dry wood
    if(sTag == "DryWood"
      && (GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)) == "Torch"
      || GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)) == "OpenLantern"
      || GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)) == "Lantern")
      && GetIsAreaNatural(GetArea(oPC)) == AREA_NATURAL)
    {
      //Checks to see if another Campfire is within 6M
      if(GetIsObjectValid(oFire) == TRUE && GetDistanceBetween(oPC,oFire) < 6.0)
      {
        SendMessageToPC(oPC, "You are placing a Campfire to close to an existing Campfire.");
        return;
      }

      object oSM = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_weathmark", lTarget);
      object oCF = CreateObject(OBJECT_TYPE_PLACEABLE, "campfire", lTarget);

      //Set Lighting
      effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20);
      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oCF));
      DelayCommand(1.5,RecomputeStaticLighting(GetArea(oPC)));
      DestroyObject(oItem);
      SetLocalInt(oCF,"LIFECYCLE",10);
      AssignCommand(oCF,ExecuteScript("ocf_lifecycle",oCF));
    }
    else if(sTag == "DryWood")
    {
      SendMessageToPC(oPC, "You need a Torch, Open Lantern, or Lantern in your hand to light the Dry Wood.");
    }

//: DRY WOOD
/******************************************************************************/
}
