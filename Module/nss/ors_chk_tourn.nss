////////////////////////////////////////////////////////////////////////////////
//  Teleport to Tournament Waypoint
//  ors_chk_tourn
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in a Conversation
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC=GetPCSpeaker();

  //Tournament Arena
  object oT = GetObjectByTag("WP_TOURNAMENT");
  if(GetIsObjectValid(oT)) return TRUE;
  else return FALSE;
}
