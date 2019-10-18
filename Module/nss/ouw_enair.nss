////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Underwater System - Air Pocket Trigger
//  ouw_enair
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Trigger On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();

    //Underwater Defined Area
    object oUWWP = GetNearestObjectByTag("Underwater",oPC);
    if(!GetIsObjectValid(oUWWP)) return;

    if(GetIsPC(oPC))
    {
      SetLocalInt(oPC,"AIRPOCKET",TRUE);

      object oUW = GetItemPossessedBy(oPC,"UnderWater");
      DestroyObject(oUW);
      SendMessageToPC(oPC,"You are now in an Air Pocket and can breath. It will take 1 Round to Recharge Your Lungs!!");

      DelayCommand(6.0,SendMessageToPC(oPC,"Your lungs are recharged and you can swim again."));

      SetLocalInt(oPC,"UNDERWATER_LOOP",0);
    }
}

