////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_conv_take
//  by Don Anderson
//  dandersonru@msn.com
//
//  Return the Saddle Bag to the Horse
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;
  OHODestroyBag(oHorse);
  DeleteLocalObject(oPC,"SADDLE_BAG");
  DeleteLocalInt(oPC,"OHO_TRANFERRED");
}
