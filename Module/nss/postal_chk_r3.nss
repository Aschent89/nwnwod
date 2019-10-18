////////////////////////////////////////////////////////////////////////////////
//
//  Check Check for Postal Route
//  postal_chk_r3
//  By Don Anderson
//  dandersonru@msn.com
//
//  Check to See if the Speaker has a Postal Mail Pack
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oNPC = OBJECT_SELF;
  object oPC=GetPCSpeaker();

  string sRoute = GetLocalString(oNPC,"PostalRoute3");

  object oPostPack = GetItemPossessedBy(oPC,sRoute);
  if(GetIsObjectValid(oPostPack)) return TRUE;
  else return FALSE;
}
