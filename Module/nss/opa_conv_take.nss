////////////////////////////////////////////////////////////////////////////////
//
//  Conversation Pack Animals
//  opa_conv_take
//  by Don Anderson
//  dandersonru@msn.com
//
//  Return the Pack Box to the Pack Animal
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;
  DestroyBox(oAnimal);
  DeleteLocalObject(oPC,"PackBox");
  DeleteLocalInt(oPC,"OPA_TRANFERRED");
}
