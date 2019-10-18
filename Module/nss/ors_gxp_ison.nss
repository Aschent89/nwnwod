////////////////////////////////////////////////////////////////////////////////
//
//  Is Gold and XP On?
//  ors_gxp_ison
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from XP Giver Convo
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  int nGXP = GetLocalInt(OBJECT_SELF,"GXP");
  if(nGXP == 1) return TRUE;
  return FALSE;
}
