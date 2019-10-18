////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_clse_packbox
//  By Don Anderson
//  dandersonru@msn.com
//
//  Saves Pack Animal Box Inventory
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oPack = OBJECT_SELF;
  object oPC = GetLastClosedBy();

  OPA_ClosePack(oPC,oPack);
  DelayCommand(10.0,SetLocalInt(oPC,"OPA_TRANSFERRED",TRUE));
}
