////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_clse_bag
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
//  Saves Saddle Bag Inventory
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oBag = OBJECT_SELF;
  object oPC = GetLastClosedBy();

  OHO_CloseBag(oPC,oBag);
  DelayCommand(10.0,SetLocalInt(oPC,"OHO_TRANSFERRED",TRUE));
}
