///////////////////////////////////////////////////////
//  Olander's Realistic Systems - HTF System - Water Source Trigger
//  ohtf_exwater
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Trigger On Exit Event
//
///////////////////////////////////////////////////////

void main()
{
    object oPC = GetExitingObject();

    if (GetIsPC(oPC)==TRUE)
    {
      SetLocalInt(oPC,"WSOURCE",FALSE);
      SetLocalString(oPC,"WSOURCE","");
      SetLocalString(oPC,"WATERBODY","");
    }
}
