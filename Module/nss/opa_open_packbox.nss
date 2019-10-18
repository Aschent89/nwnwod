////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_open_packbox
//  By Don Anderson
//  dandersonru@msn.com
//
//  Restores Pack Animal Box Inventory
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oPack = OBJECT_SELF;
  object oPC = GetLastOpenedBy();
  SendMessageToPC(oPC, "The Pack Box will be locked for 10secs after you close.");

  OPA_OpenPack(oPC,oPack);
}
