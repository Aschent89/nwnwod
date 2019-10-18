////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_pack_remove
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the On Death Event.
//
////////////////////////////////////////////////////////////////////////////////

#include "opa_inc"

void main()
{
  object oAnimal = OBJECT_SELF;

  string sPC = GetLocalString(oAnimal, "OPA_OWNER_NAME");
  string sPCU = GetLocalString(oAnimal, "OPA_OWNER_UNIQUE");
  string sCheck = "";

  //First Find Our PC
  int nPC = 0;
  object oPC = GetFirstPC();
  while (GetIsObjectValid(oPC) == TRUE && nPC < 100)
  {
    sCheck = GetName(oPC);
    if(sCheck == sPC) break;
    nPC = nPC++;
    oPC = GetNextPC();
  }

  //Drop the Pack Box
  AccessBox(oPC, oAnimal);

  //Remove this Animal from PC
  OPA_DismissPack(oPC, oAnimal);

  //Tell Player What the Animal Total is
  SendMessageToPC(oPC,"Your Pack Animal Has Died and has Dropped it's Pack Box.");
}
