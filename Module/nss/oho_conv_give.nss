////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_conv_give
//  by Don Anderson
//  dandersonru@msn.com
//
//  Place the Saddle Bag on the Ground
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;
  OHOAccessBag(oPC, oHorse);
}