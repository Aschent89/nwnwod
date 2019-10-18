////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_mod_onrest
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Module On Rest Event
//
//  This is the resting package for both the Camping and HTF Systems
//
////////////////////////////////////////////////////////////////////////////////

//Checks For A Player Riding a Horse
int OHOPCRidingHorse(object oPC);

void main()
{
    object oPC          = GetLastPCRested();
    object oMod         = GetModule();
    int nRestType       = GetLastRestEventType();

    //Cannot Rest While Mounted (Will Dismount A Player Automatically in  oho_mod_onrest)
    if(OHOPCRidingHorse(oPC) && nRestType == REST_EVENTTYPE_REST_STARTED)
    {
      AssignCommand(oPC, ClearAllActions());
      SendMessageToPC(oPC,"You are Riding and Horse and shall Dismount.");
      return;
    }

//:*****************************************************************************/
//: MENU EXECUTED BY REST BUTTON

    int nRMenu = GetLocalInt(oPC,"REST_MENU");
    int nRStart = GetLocalInt(oPC,"REST_START");

    //Is the Menu Already up?
    if(nRMenu == 1 && nRestType == REST_EVENTTYPE_REST_STARTED && nRStart == 0)
    {
      SetLocalInt(oPC,"REST_TYPE",1);
      SetLocalInt(oPC,"REST_MENU",1);

      //Near a Bedroll
      object oBedroll = GetNearestObjectByTag("Bedroll",oPC,1);
      if(GetIsObjectValid(oBedroll) == TRUE
        && GetDistanceBetween(oPC,oBedroll) < 3.0
        && GetObjectType(oBedroll) == OBJECT_TYPE_PLACEABLE)
      {
        SetLocalInt(oPC, "REST_ALLOWED", TRUE);
      }

      //Near a Tent
      object oTent = GetNearestObjectByTag("Tent",oPC,1);
      if(GetIsObjectValid(oTent) == TRUE
        && GetDistanceBetween(oPC,oTent) < 4.0
        && GetObjectType(oTent) == OBJECT_TYPE_PLACEABLE)
      {
        SetLocalInt(oPC, "REST_ALLOWED", TRUE);
      }

      AssignCommand(oPC, ClearAllActions());
      AssignCommand(oPC, ActionStartConversation(OBJECT_SELF,"orm_restmenu",TRUE,FALSE));
      return;
    }

    //1st Time in Menu
    if(nRMenu == 0 && nRestType == REST_EVENTTYPE_REST_STARTED)
    {
      SetLocalInt(oPC,"REST_TYPE",1);
      SetLocalInt(oPC,"REST_MENU",1);

      //Near a Bedroll
      object oBedroll = GetNearestObjectByTag("Bedroll",oPC,1);
      if(GetIsObjectValid(oBedroll) == TRUE
        && GetDistanceBetween(oPC,oBedroll) < 3.0
        && GetObjectType(oBedroll) == OBJECT_TYPE_PLACEABLE)
      {
        SetLocalInt(oPC, "REST_ALLOWED", TRUE);
      }

      //Near a Tent
      object oTent = GetNearestObjectByTag("Tent",oPC,1);
      if(GetIsObjectValid(oTent) == TRUE
        && GetDistanceBetween(oPC,oTent) < 4.0
        && GetObjectType(oTent) == OBJECT_TYPE_PLACEABLE)
      {
        SetLocalInt(oPC, "REST_ALLOWED", TRUE);
      }

      AssignCommand(oPC, ClearAllActions());
      AssignCommand(oPC, ActionStartConversation(OBJECT_SELF,"orm_restmenu",TRUE,FALSE));
      return;
    }

    //We have Started Resting From the Menu and have Cancelled
    if(nRStart == 1 && nRestType == REST_EVENTTYPE_REST_CANCELLED)
    {
      SetLocalInt(oPC,"REST_TYPE",2);
      ExecuteScript("ocf_rest_start",oPC);
    }

    //We have Started Resting From the Menu and have Finished
    if(nRStart == 1 && nRestType == REST_EVENTTYPE_REST_FINISHED)
    {
      SetLocalInt(oPC,"REST_TYPE",3);
      ExecuteScript("ocf_rest_start",oPC);
    }

//: MENU EXECUTED BY REST BUTTON
//:*****************************************************************************/
}

const int HORSE_PHENO_NORMAL_MOUNTED    = 3;
const int HORSE_PHENO_NORMAL_SHIELD     = 6;
const int HORSE_PHENO_LARGE_MOUNTED     = 5;
const int HORSE_PHENO_LARGE_SHIELD      = 8;

int OHOPCRidingHorse(object oPC)
{
  int nPheno = GetPhenoType(oPC);
  if(nPheno == HORSE_PHENO_NORMAL_MOUNTED) return TRUE;
  if(nPheno == HORSE_PHENO_NORMAL_SHIELD) return TRUE;
  if(nPheno == HORSE_PHENO_LARGE_MOUNTED) return TRUE;
  if(nPheno == HORSE_PHENO_LARGE_SHIELD) return TRUE;

  return FALSE;
}
