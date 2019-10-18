////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_bag_pc
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
//  Checks for Saddle Bag on Animal.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;

  object oBagPC = GetLocalObject(oPC,"SADDLE_BAG");
  object oBagA = GetLocalObject(oHorse,"SADDLE_BAG");
  if(GetIsObjectValid(oBagPC) == TRUE && GetIsObjectValid(oBagA) == FALSE)
  {
    return TRUE;
  }
  else return FALSE;
}
