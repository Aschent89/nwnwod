////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_open_bag
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
//  Restores Saddle Bag Inventory
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oBag = OBJECT_SELF;
  object oPC = GetLastOpenedBy();
  SendMessageToPC(oPC, "The Saddlebag will be locked for 20secs after you close.");

  OHO_OpenBag(oPC,oBag);
}
