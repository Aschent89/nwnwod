////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Jump Party Member to Leader
//  ors_conv_jlead
//  By Don Anderson
//
//  Called from the Rest Menu
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oLeader = GetFactionLeader(oPC);

  //In the King of Hill Arena
  object oKoH = GetNearestObjectByTag("WP_KOH_ARENA",oLeader,1);
  if(GetIsObjectValid(oKoH))
  {
    SendMessageToPC(oPC,"Your Leader is in the King of Hill Arena. You can not jump to him/her.");
    return;
  }

  //In the Capture the Flag Arena
  object oCtF = GetNearestObjectByTag("WP_CTF_ARENA",oLeader,1);
  if(GetIsObjectValid(oCtF))
  {
    SendMessageToPC(oPC,"Your Leader is in the Capture the Flag Arena. You can not jump to him/her.");
    return;
  }

  //Rest Reset
  SetLocalInt(oPC,"REST_MENU",0);
  SetLocalInt(oPC, "REST_ALLOWED", FALSE);

  //Jump to Leader
  AssignCommand(oPC, ClearAllActions());
  AssignCommand(oPC,DelayCommand(3.0,JumpToObject(oLeader)));
}
