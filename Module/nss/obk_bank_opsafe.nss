////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Banking
//  obk_bank_opsafe
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the OnOpen Event of the Bank Safe
//
////////////////////////////////////////////////////////////////////////////////

#include "obk_inc"

void main()
{
  object oSafe = OBJECT_SELF;
  object oPC = GetLastOpenedBy();
  SendMessageToPC(oPC, "The "+GetName(oSafe)+" will be locked for 20secs after you close.");

  OBK_OpenSafe(oPC,oSafe);
}
