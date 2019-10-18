////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_area_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Disallows Riding a Horse in Interior Areas
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC    = GetEnteringObject();
  object oMod   = GetModule();
  object oArea  = GetArea(oPC);
  object oCityProper = GetNearestObjectByTag("CityProper",oPC);

  //No Riding in Specified Areas
  if(GetIsObjectValid(oCityProper))
  {
    //Now We Dismount if We Are Mounted
    if(OHOPCRidingHorse(oPC))
    {
      AssignCommand(oPC,SpeakString("Dismount!"));
      OHODismountHorse(oPC);
      SendMessageToPC(oPC,"You can NOT Ride a horse here.");

      if(GetIsPC(oPC))
      {
        //Remove Rally Point Tag
        SetLocalString(oPC, "OHO_RALLYPOINT", "");

        //Now we check to see if the Horse is Valid or not and create it again
        object oHorse = GetLocalObject(oPC,"OHO_OWNER");
        object oItem = GetItemPossessedBy(oPC,"HorseControl");
        string sHorse = GetLocalString(oItem, "OHO_ANIMALRESREF");
        int nHas = GetLocalInt(oItem,"OHO_ANIMALTOTAL");
        location lPC = GetLocation(oPC);
        if(sHorse != "" && nHas == 1 && GetIsObjectValid(oHorse) == FALSE) OHOHorseRecall(oPC,lPC);
      }
    }
  }
}
