////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_bag_t
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
//  Checks for Saddle Bag on Ground.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;

  object oBag = GetLocalObject(oHorse,"SADDLE_BAG");
  int nTransferred = GetLocalInt(oPC,"OHO_TRANSFERRED");
  if(GetIsObjectValid(oBag) == TRUE && nTransferred == TRUE)
  {
    return TRUE;
  }
  else return FALSE;
}
