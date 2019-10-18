////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_deadtree
//  By Don Anderson
//  dandersonru@msn.com
//
//  Dead Trees give Dry Wood
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oSelf = OBJECT_SELF;
  object oPC  = GetLastDamager();

  CreateObject(OBJECT_TYPE_ITEM, "dry_wood", GetLocation(oPC));
}
