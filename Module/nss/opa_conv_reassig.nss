////////////////////////////////////////////////////////////////////////////////
//
//  Conversation Pack Animals
//  opa_conv_reassig
//  by Don Anderson
//  dandersonru@msn.com
//
//  Reassigns the Pack Box to Another Pack Animal
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;
  ReassignBox(oPC, oAnimal);
}
