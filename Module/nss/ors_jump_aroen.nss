////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Jumping and Climbing
//  ors_jump_aroen
//  By Don Anderson
//  dandersonru@msn.com
//
//  Allows Climbing and Jumping in Outdoor Areas
//
//  Place this in the Area On Enter Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC    = GetEnteringObject();
  object oMod   = GetModule();
  object oArea  = GetArea(oPC);


  //Only Run For Players
  if(GetIsPC(oPC) == TRUE)
  {
    int nInterior = GetIsAreaInterior(oArea);

    if(nInterior == FALSE)
    {
      SetLocalInt(oPC,"ALLOWJUMP",1);
      SendMessageToPC(oPC,"This is an Outdoor Area. You can Climb or Jump using boots here.");
      return;
    }

    if(nInterior == TRUE)
    {
      SetLocalInt(oPC,"ALLOWJUMP",0);
      SendMessageToPC(oPC,"This is an Indoor Area. You can NOT Climb or Jump here.");
      return;
    }
  }
}
