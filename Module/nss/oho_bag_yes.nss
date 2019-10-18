////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_bag_yes
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
//  Checks for Saddle Bags on Horse.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;

  object oHC = GetItemPossessedBy(oPC,"HorseControl");
  int nBags = GetLocalInt(oHC,"OHO_HORSE_SADDLE_BAG");
  if(nBags == 1)
  {
    return TRUE;
  }
  else return FALSE;
}
