////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - HTF System - Water Source Trigger
//  ohtf_enwater
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Trigger On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC      = GetEnteringObject();
    object oTrigger = OBJECT_SELF;
    string sTName   = GetName(oTrigger);
    string sTrigger = GetTag(oTrigger);

    //You can add more types of Triggers by adding more -> || (sTName == "NAME HERE")
    if (sTName == "Lake")
    {
      if (GetIsPC(oPC)==TRUE)
      {
        SetLocalInt(oPC,"WSOURCE",TRUE);
        SetLocalString(oPC,"WSOURCE",sTrigger);
        SetLocalString(oPC,"WATERBODY",sTName);
        SendMessageToPC(oPC,"This is a Lake to do some fishing or fill my Canteen or Water Bucket.");
      }
    }

    if (sTName == "Stream")
    {
      if (GetIsPC(oPC)==TRUE)
      {
        SetLocalInt(oPC,"WSOURCE",TRUE);
        SetLocalString(oPC,"WSOURCE",sTrigger);
        SetLocalString(oPC,"WATERBODY",sTName);
        SendMessageToPC(oPC,"This is a Stream to do some fishing or fill my Canteen or Water Bucket.");
      }
    }

    if ((sTName == "Fountain")
        || (sTName == "Well"))
    {
      if (GetIsPC(oPC)==TRUE)
      {
        SetLocalInt(oPC,"WSOURCE",TRUE);
        SetLocalString(oPC,"WSOURCE",sTrigger);
        SendMessageToPC(oPC,"Looks like I can refill my Water Canteen or Water Bucket here.");
      }
    }

    if (sTName == "Salt Water")
    {
      if (GetIsPC(oPC)==TRUE)
      {
        SetLocalInt(oPC,"WSOURCE",TRUE);
        SetLocalString(oPC,"WSOURCE",sTrigger);
        SetLocalString(oPC,"WATERBODY",sTName);
        SendMessageToPC(oPC,"This is Salt Water you can fish from.");
      }
    }
}

