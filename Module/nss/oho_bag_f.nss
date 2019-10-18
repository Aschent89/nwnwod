////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_bag_f
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

  object oBag = GetLocalObject(oHorse,"SADDLE_BAG");
  if(GetIsObjectValid(oBag) == FALSE)
  {
    return TRUE;
  }
  else return FALSE;
}
