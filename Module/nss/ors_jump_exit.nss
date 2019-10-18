///////////////////////////////////////////////////////
//  Olander's Realistic Systems - Jumping and Climbing
//  ors_jump_exit
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Trigger On Exit Event
//
///////////////////////////////////////////////////////

void main()
{
    object oPC = GetExitingObject();
    object oArea  = GetArea(oPC);

    if(GetIsPC(oPC) == TRUE)
    {
      int nInterior = GetIsAreaInterior(oArea);

      if(nInterior == FALSE)
      {
        SetLocalInt(oPC,"ALLOWJUMP",1);
        return;
      }

      if(nInterior == TRUE)
      {
        SetLocalInt(oPC,"ALLOWJUMP",0);
        SendMessageToPC(oPC,"You can NOT Climb or Jump using boots now.");
        return;
      }
    }
}
