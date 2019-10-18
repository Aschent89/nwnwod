////////////////////////////////////////////////////////////////////////////////
//
//  Removes Postal Route Pack
//  postal_rmv_r5
//  By Don Anderson
//  dandersonru@msn.com
//
//  Removes Postal Mail Pack
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oNPC = OBJECT_SELF;
  object oPC=GetPCSpeaker();

  string sRoute = GetLocalString(oNPC,"PostalRoute5");

  object oPostPack = GetItemPossessedBy(oPC,sRoute);
  DestroyObject(oPostPack);
}
