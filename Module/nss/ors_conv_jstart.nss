////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Jump to Start Location
//  ors_conv_jstart
//  By Don Anderson
//
//  Called from a Conversation
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();

  //Rest Reset
  SetLocalInt(oPC,"REST_MENU",0);
  SetLocalInt(oPC, "REST_ALLOWED", FALSE);

  //Jump to Leader
  AssignCommand(oPC, ClearAllActions(TRUE));
  AssignCommand(oPC,DelayCommand(3.0,JumpToLocation(GetStartingLocation())));
}
